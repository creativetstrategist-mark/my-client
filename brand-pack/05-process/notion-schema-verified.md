# Notion "Evergreen Video" database — verified live schema

*Verified directly against the live database on 2026-09-01 (`notion-fetch` on the data source + `notion-query-data-sources` SQL against real rows). This supersedes anything in `creative-brief-process.md` Section D that conflicts with it — that doc is a good process reference but its exact page-layout claim (one page, multiple product sections) is stale. Real current practice, confirmed by the newest live rows (NK367 through NK381, all dated 2026-08-29 through 2026-08-31), is below.*

Database location: **NK Creative Strategy Lab / Video Brief Database / Evergreen Video**
Data source: `collection://2cf4ac62-7aac-81a8-86bf-000b96778943`

## ⚠️ Real page structure: ONE PAGE PER PRODUCT, not one page with 3 sections

Every real batch in the live database (e.g. "Why We Are Taking Over" = NK379/380/381, "Taking Over" = NK376/377/378, "Three Return Forms" = NK370/371/372) is **3 separate Notion pages** — one per product — not a single page with 3 headed sections as `creative-brief-process.md`'s "Multi-product draft briefs" note describes. Each page has:
- Its own **Concept Name** (identical root name across the 3 pages of a batch, e.g. "Why We Are Taking Over" for all 3 — suffix it per product, e.g. "Back On The Shelf - Feather" / "Back On The Shelf - Santoku", when the plain name alone would be ambiguous across three otherwise-identical pages).
- Its own **sequential Creative ID** (3 consecutive numbers per batch, e.g. NK379/NK380/NK381).
- Its own full page body: Batch name table, File naming table, AD INSPO, persona-notice callout, GENERAL INSTRUCTION, GLOSSARY, Creative Brief Instruction, HOOK table, BODY table — all repeated per page, not shared.

**This routine creates 3 pages per inspo ad (one per product) → 15 pages per daily run (5 inspo ads × 3 products).**

## Exact property values to set (verified against live schema + Andy's standing instructions)

| Property | Type | Value this routine always sets |
|---|---|---|
| **Concept Name** | title | The batch/concept name (short, punchy — matches the page title) |
| **Creative ID** | text | Next sequential `NK###` — query the current max (see below) before each run and continue from there. As of 2026-09-02 the highest is **NK399** (NK397–399 were added by the team, not by this routine — which is exactly why the max gets re-queried every run instead of continuing from the last log row). |
| **Product** | select | Exactly one of: `Feather` · `SANTOKU` · `LOKI Blackout` — these are the literal option strings, not "Feather Knife" / "BJORN Series Santoku" / "LOKI Blackout Edition." |
| **Avatar** | select | `JOHN - KNIFE COLLECTOR` for Feather or SANTOKU pages · `MIKE- BBQ KING` for LOKI Blackout pages (note the real option string has no space before the dash: `MIKE- BBQ KING`, not `MIKE - BBQ KING`). Standing instruction — do not vary. |
| **Status** | status | `Ready for visuals` (the real option is plural "visuals" — not "Ready for visual"). |
| **Strategist** | select | `Mark`. Do not use "Claude" even though that's also a valid option other strategists use. |
| **Format** | select | `VID` |
| **Content** | text (not a select) | `AI VO` |
| **Category** | select | `Net New` — **standing instruction as of 2026-09-01: every concept this routine creates is tagged Net New**, even though it's adapted from a swipe. (The `Adaptation` option exists and older rows NK259-263 use it, but do not use it here.) |
| **Offer** | select | `B2G2` — the default offer on every script. |
| **Landing Page** | select | `6 Reasons - Santoku` for SANTOKU pages · `6 Reasons - General` for Feather and LOKI Blackout pages. |
| **Specialty** | text | `Generalist` |
| **Editor** | select | **Assign per the editor-assignment rules below** (standing instruction as of 2026-09-02, superseding the earlier "leave blank" rule). Valid option strings: `Umar` · `Hammad` · `Onyeka` · `Hasnain` · `Anas` · `Renniel` · `Naveed` · `Huzaifa` — but **`Huzaifa` is not on the active roster, never assign it**. |
| **Date** | date | **LEAVE BLANK.** Standing instruction as of 2026-09-01 — do not fill it. |
| **Delivery Link, Claude WR, Test Results, German 🇩🇪, German Version 🇩🇪** | — | Leave blank/unset — filled in later in production, not by this routine. |

### Batch name / File naming strings

The Batch name and File naming tables follow `…_Offer_Category_Strategist_Editor_LandingPage`, so with the standing defaults they read:

`NK###_<Concept Name>_Generalist_<Product>_AI VO_<AVATAR>_B2G2_New_Mark_<Editor>_PDP`

Note `New` (matching the Net New category). The editor slot now carries the **actual assigned editor name** (e.g. `…_Mark_Hasnain_PDP`) — the old literal `EDITOR` placeholder was only there while the Editor property was being left blank. In the filename strings the avatar is written with spaces around the dash (`MIKE - BBQ KING`), which differs from the `Avatar` property's own option string (`MIKE- BBQ KING`) — that inconsistency is in the real corpus, not a typo.

## Getting the next Creative ID before each run

Query the data source for the current max before assigning IDs for a new batch:
```sql
SELECT "Creative ID" FROM "collection://2cf4ac62-7aac-81a8-86bf-000b96778943"
ORDER BY "Creative ID" DESC LIMIT 5
```
`Creative ID` is stored as plain text (`NK123` style), not a number — sorting as text works at this range, but eyeball the top few results rather than trusting a single row blindly (older 2-digit IDs like "NK23" would sort oddly against "NK381" as pure text — check that the top result is actually the highest, not just first alphabetically).

## AD INSPO block format

**Standing instruction as of 2026-09-01: the TrendTrack shareable link must be EMBEDDED IN THE VIDEO BLOCK itself** — as the `src` of the `<video>` block under the `### AD INSPO` heading. Do **not** leave an empty `<video src=""></video>` placeholder with the link sitting on a separate line beneath it.

Generate the link with `mcp__TrendTrack_MCP__create_ad_share_link` (pass the ad's `id`, e.g. `facebook_1046120557939181`), which returns a `shareUrl` like `https://app.trendtrack.io/share/ads/hatori-knives-fs5en9`. That tool returns the existing link if one already exists, so it's safe to call repeatedly.

The block, with the advertiser + source hook as the video caption:

```
### AD INSPO
<video src="https://app.trendtrack.io/share/ads/<slug>"><Advertiser> — "<source hook>"</video>
```

Underneath, include the full persona-notice callout (💡 gray background) for that page's Avatar, worded close to this verbatim standing text:

> **JOHN - KNIFE COLLECTOR** — Rarity + craftsmanship are his trigger. Hard production limits and "no restock, no waitlist" activate him; discount-first hooks and countdown timers repel him. No deal or discount language at all in his copy — scarcity is framed as manufacturing complexity, never a deadline.

> **MIKE - BBQ KING** — View it as Sarah's husband. He's the man who cooks, grills, view him like Amir — big beard, big muscle, looks like a Viking. Harder marketing is fair game, deeper/darker ElevenLabs voice, rock or hard rock music. No gift framing — outdoor, grill, Viking-heritage angle.

## Editor assignment rules (standing instruction as of 2026-09-02)

**This supersedes the earlier "leave the Editor blank" instruction.** The
routine now picks the editor itself, using the rules below. NK382–NK396 (the
2026-09-01 batch) were created under the old rule and still have a blank
Editor — they are not retro-assigned unless the user asks.

### Active roster — 7 editors

`Umar` · `Hammad` · `Onyeka` · `Hasnain` · `Anas` · `Naveed` · `Renniel`

`Huzaifa` is still a live option string in the Notion `Editor` property but is
**not on the active roster — never assign it.** (The user wrote "Ana"; the real
Notion option is **`Anas`**, which is what to select.)

### Estimating script length (there is no runtime field in a brief)

Briefs deliberately carry no timestamps, runtime, or word counts, so length is
inferred from the **spoken VO word count** — the HOOK (count the single longest
hook variant, not all of them) plus every BODY beat's copy. At a ~150 wpm AI VO
read:

**80 seconds ≈ 200 spoken words.** Over ~200 words ⇒ treat the script as
**long**; at or under ⇒ **short**.

### What counts as "AI-generation-clip heavy"

A script whose visuals lean mostly on generated footage rather than existing
product/UGC assets — imagined environments, forge/foundry cinematics,
character or actor scenes, historical or Viking-heritage imagery, anything not
shootable from the existing asset library. A script that is mostly product
b-roll, hands-on demo, or repurposed UGC is **not** AI-heavy.

### The rules

| # | Rule |
|---|---|
| 1 | **Long script (> ~200 words / over 80s)** → assign randomly among **Umar, Hasnain, Anas, Naveed** only. |
| 2 | **Short script (≤ ~200 words / under 80s)** → assign randomly among any of the 7 active editors. |
| 3 | **Never assign Hammad or Onyeka** to anything over 80 seconds. (This is the same constraint as rule 1, stated from the other side — it is a hard block, not a preference.) |
| 4 | **AI-generation-clip-heavy script** → prefer **Anas** or **Renniel**. |
| 5 | **One concept, three editors.** The 3 product scripts generated from a single inspo concept must go to 3 *different* editors, even though the products differ. Across a 5-concept run an editor may of course appear in several concepts — the constraint is within a concept, not across the run. |

### Conflict precedence (these rules can collide — resolve in this order)

1. **Duration beats specialization.** Rule 1/3 is a hard capacity constraint;
   rule 4 is a preference. A long AI-heavy script goes to **Anas** (the only
   editor in both sets); if Anas is already taken by another product in the
   same concept, fall back to Umar / Hasnain / Naveed and drop the AI-heavy
   preference. **Renniel never gets a script over 80 seconds** on the strength
   of rule 4 alone.
2. **Rule 5 beats rule 4.** If all 3 products of one concept come out AI-heavy,
   only Anas and Renniel qualify under rule 4 but three distinct editors are
   required: give Anas and Renniel the two most AI-dependent scripts, send the
   third to any editor its own duration allows, and **note the substitution in
   the run summary**.
3. Within whatever set survives, pick **randomly** — do not always land on the
   same name. Spread the load across a run.

## Real example pages worth reading before writing a new batch

- `NK382`–`NK396` (2026-09-01) — the first full run under the current standing defaults: 5 concepts × 3 products, blank Editor/Date, Net New, TrendTrack share link embedded in the AD INSPO video block.
- `NK370/371/372` ("Three Return Forms") — an earlier clean 3-page batch from the team.
- Fetch any of these directly in Notion (`notion-fetch`) to see current formatting before starting a new batch — conventions drift, and a fresh read beats trusting this doc blindly (same caution `creative-brief-process.md` itself gives about its own staleness).
