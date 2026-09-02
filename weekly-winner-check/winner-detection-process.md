# Weekly Creative Winner Detection

Runs every Monday. Reads the last complete Sun–Sat week from Triple Whale,
identifies winning **video** creatives per market, and tags the matching brief
page in the Notion "Evergreen Video" database.

## Winner criteria (set by Mark, 2026-09-02)

A creative is a winner in a market when **all** of these hold:

| Rule | Value |
|---|---|
| Attribution model | **First Click** (the strong signal — not Triple Attribution) |
| Spend | **>= 1,000 in that store's local currency** (not USD-normalised) |
| First-Click ROAS | **>= 2.0** |
| Ad type | **video only** (`ad_type = 'video'`) |
| Window | Last complete Sunday–Saturday week |
| Strategist | **Mark, Andy or Claude only** — see below |

The spend bar is deliberately local-currency. Note the asymmetry this creates:
A$1,000 is roughly US$650 and £1,000 is roughly US$1,270, so the AU bar is the
easiest to clear and the UK bar the hardest. This is intended — do not
"correct" it without Mark saying so.

## Strategist filter (Mark / Andy / Claude only)

Only track creatives whose strategist is **Mark**, **Andy** or **Claude**.
Skip anything by Mauro, Callum, or the static-series owners (Nazmul, Zyrille).

**Read the strategist from the Notion `Strategist` property, not from the ad
name.** The strategist IS in the ad name — it is the 11th underscore-delimited
segment — but parsing it there is unreliable for two proven reasons:

1. **Meta truncates long ad names.** NK284, the strongest cross-market winner
   in the 2026-08-23 week, arrives as a 96-character name with only 8
   segments, ending mid-avatar at `JOHN - KNIFE COLLECTO`. The strategist
   field is simply not in the string. Filtering on the name would have
   silently dropped a UK + AU winner.
2. **Segment positions shift between naming series.** The `Z###` static series
   carries an extra date segment near the front, so its 11th segment is the
   category (`New`), not the strategist. Any fixed-index parse is wrong for
   at least one series.

So: match the `NK###` code to its Notion page first, then filter on that
page's `Strategist` select — a controlled field whose only values are Mark,
Andy, Mauro, Claude, Callum.

**Fallback.** For a winning code with no Notion page, fall back to a token
match against the ad name: treat it as in-scope if `Mark`, `Andy` or `Claude`
appears as a complete underscore-delimited segment. Match whole segments only,
never a substring. If the name is truncated and carries no strategist segment,
report it as "strategist unknown" rather than assuming it is out of scope.

## Markets in scope

Only these three stores. DE and CA are connected but **out of scope**.

| Market | shopId | Currency | Timezone |
|---|---|---|---|
| US | `northernknife.myshopify.com` | USD | America/Denver |
| UK | `northernknifeuk.myshopify.com` | GBP | Europe/London |
| AU | `6yei85-8h.myshopify.com` | AUD | Australia/Sydney |

Out of scope: `29d2e7-5f.myshopify.com` (DE, EUR),
`eg32ei-1g.myshopify.com` (CA, CAD).

**Query each store separately.** Passing several shopIds to a Triple Whale data
tool returns one blended figure across them, which would sum USD + GBP + AUD
into a meaningless number.

## The query

Run once per market, substituting the shopId and the week's dates:

```sql
SELECT splitByChar('_', any(ad_name))[1] AS nk_code,
       creative_id,
       any(ad_name)   AS sample_ad_name,
       SUM(spend)     AS total_spend,
       SUM(order_revenue) AS total_rev,
       COALESCE(SUM(order_revenue) / NULLIF(SUM(spend), 0), 0) AS fc_roas
FROM pixel_joined_tvf() AS pj
WHERE event_date >= '<SUNDAY>' AND event_date <= '<SATURDAY>'
  AND model = 'First Click'
  AND lower(ad_type) = 'video'
  AND creative_id != ''
GROUP BY creative_id
HAVING SUM(spend) >= 1000
   AND COALESCE(SUM(order_revenue) / NULLIF(SUM(spend), 0), 0) >= 2
ORDER BY SUM(spend) DESC
```

Two ClickHouse gotchas, both hit during setup:

- Do not alias an aggregate to its own column name (`SUM(spend) AS spend`) —
  ClickHouse resolves the alias back into the aggregate and errors with
  "Aggregate function found inside another aggregate function".
- Repeat the full expression in `HAVING`; don't lean on the SELECT alias.

## Joining Triple Whale to Notion

**The Triple Whale `creative_id` is NOT the Notion `Creative ID`.**

- Triple Whale `creative_id` = a Meta-assigned number, e.g. `2481606815586330`.
- Notion `Creative ID` = your internal code, e.g. `NK184`.

The bridge is the **ad naming convention**: the internal code is the first
underscore-delimited segment of `ad_name`.

```
NK184_VID_What if CTA Feather_3D_Generalist_Feather_AI VO_JOHN...
^^^^^ this is the Notion Creative ID
```

Prefix series seen in the wild: `NK###` (the main video series), `NKFD###`
(Father's Day), `NKEOFY###` (EOFY), plus `N###` and `Z###` for the static/image
series. Only `NK###` reliably has brief pages in Notion.

This means the routine depends on editors naming ads to convention. An ad named
off-pattern silently drops out of the report. Log every unmatched code.

## Writing to Notion

Database: **Evergreen Video**
`collection://2cf4ac62-7aac-81a8-86bf-000b96778943`
(path: NK Creative Strategy Lab / Video Brief Database / Evergreen Video)

Match the parsed code against the `Creative ID` text property, then set
`Test Results` (a **multi-select**).

Rules, as decided by Mark:

0. **Strategist gate first.** Only tag pages whose `Strategist` is Mark, Andy
   or Claude. Skip everything else before writing anything.
1. **Winners only.** Apply only `US Winner`, `UK Winner`, `AU Winner`.
   Never write `High Potential` or `Loser` — those stay manual for the team.
2. **Append, never remove.** Read the page's existing `Test Results` first and
   union the new tags into it. A creative that won US in an earlier week keeps
   `US Winner` even if it fades later. Never clear a tag a human set.
3. **Report unmatched, never create.** If a winning code has no page in the
   database, list it in the run summary. Do not auto-create rows.

## Run summary

Each run should report, per market: the winners tagged (code, concept, spend,
ROAS), any winning codes with no Notion page, and any pages already carrying
the tag (no-ops). If the Triple Whale or Notion connector is unavailable, say
so explicitly rather than silently reporting zero winners.

## Run history

### 2026-09-02 — week of Sun 2026-08-23 to Sat 2026-08-29

| Market | Code | Concept | Strategist | Spend | FC ROAS | Action |
|---|---|---|---|---|---|---|
| US | NK184 | What if \| CTA \| Feather | Andy | $26,035 | 2.65 | tagged US Winner |
| US | NK222 | Return Feather Lunatic | Andy | $23,108 | 2.10 | tagged US Winner |
| UK | NK284 | Big Brain Return His Knife – Santoku | Andy | £3,323 | 2.05 | tagged UK Winner |
| AU | NK284 | Big Brain Return His Knife – Santoku | Andy | A$6,732 | 2.83 | tagged AU Winner |
| AU | NKEOFY005 | EOFY / Worth it | Mark (from ad name) | A$3,353 | 3.74 | **no Notion page** |
| AU | NK184 | What if \| CTA \| Feather | Andy | A$1,568 | 2.73 | tagged AU Winner |
| AU | NK272 | NK168 – Green Screen | Andy | A$1,102 | 2.48 | tagged AU Winner |

NK284 (Santoku) cleared the bar in two markets; NK184 (Feather) in two.
NKEOFY005 was the strongest AU performer by ROAS but has no brief page.

The Mark/Andy/Claude strategist filter was added after this run and changes
nothing for it — all four tagged winners are Andy's, and NKEOFY005 is Mark's.
No tags were removed.
