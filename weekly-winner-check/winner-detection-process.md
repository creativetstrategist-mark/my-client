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

The spend bar is deliberately local-currency. Note the asymmetry this creates:
A$1,000 is roughly US$650 and £1,000 is roughly US$1,270, so the AU bar is the
easiest to clear and the UK bar the hardest. This is intended — do not
"correct" it without Mark saying so.

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

| Market | Code | Concept | Spend | FC ROAS | Action |
|---|---|---|---|---|---|
| US | NK184 | What if \| CTA \| Feather | $26,035 | 2.65 | tagged US Winner |
| US | NK222 | Return Feather Lunatic | $23,108 | 2.10 | tagged US Winner |
| UK | NK284 | Big Brain Return His Knife – Santoku | £3,323 | 2.05 | tagged UK Winner |
| AU | NK284 | Big Brain Return His Knife – Santoku | A$6,732 | 2.83 | tagged AU Winner |
| AU | NKEOFY005 | EOFY / Worth it | A$3,353 | 3.74 | **no Notion page** |
| AU | NK184 | What if \| CTA \| Feather | A$1,568 | 2.73 | tagged AU Winner |
| AU | NK272 | NK168 – Green Screen | A$1,102 | 2.48 | tagged AU Winner |

NK284 (Santoku) cleared the bar in two markets; NK184 (Feather) in two.
NKEOFY005 was the strongest AU performer by ROAS but has no brief page.
