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
| **Creative ID** | text | Next sequential `NK###` — query the current max (see below) before each run and continue from there. As of 2026-09-01 the highest is **NK396**. |
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
| **Editor** | select | **LEAVE BLANK.** Standing instruction as of 2026-09-01 — Andy assigns the editor himself. Never auto-pick one. |
| **Date** | date | **LEAVE BLANK.** Standing instruction as of 2026-09-01 — do not fill it. |
| **Delivery Link, Claude WR, Test Results, German 🇩🇪, German Version 🇩🇪** | — | Leave blank/unset — filled in later in production, not by this routine. |

### Batch name / File naming strings

The Batch name and File naming tables follow `…_Offer_Category_Strategist_Editor_LandingPage`, so with the standing defaults they read:

`NK###_<Concept Name>_Generalist_<Product>_AI VO_<AVATAR>_B2G2_New_Mark_EDITOR_PDP`

Note `New` (matching the Net New category) and the literal `EDITOR` placeholder in the editor slot — it keeps the slot's position visible for whoever fills it in. In the filename strings the avatar is written with spaces around the dash (`MIKE - BBQ KING`), which differs from the `Avatar` property's own option string (`MIKE- BBQ KING`) — that inconsistency is in the real corpus, not a typo.

## Getting the next Creative ID before each run

Query the data source for the current max before assigning IDs for a new batch:
```sql
SELECT "Creative ID" FROM "collection://2cf4ac62-7aac-81a8-86bf-000b96778943"
ORDER BY "Creative ID" DESC LIMIT 5
```
`Creative ID` is stored as plain text (`NK123` style), not a number — sorting as text works at this range, but eyeball the top few results rather than trusting a single row blindly (older 2-digit IDs like "NK23" would sort oddly against "NK381" as pure text — check that the top result is actually the highest, not just first alphabetically).

## AD INSPO block format

Real pages use a `<video src=""></video>` placeholder block (the actual video gets embedded manually in Notion later). **Standing instruction as of 2026-09-01: every concept must carry the TrendTrack shareable link for its inspo ad in the AD INSPO section.** Generate it with `mcp__TrendTrack_MCP__create_ad_share_link` (pass the ad's `id`, e.g. `facebook_1046120557939181`), which returns a `shareUrl` like `https://app.trendtrack.io/share/ads/hatori-knives-fs5en9`. That tool returns the existing link if one already exists, so it's safe to call repeatedly. Put it directly under the video placeholder:

```
### AD INSPO
<video src=""></video>
[TrendTrack inspo: <Advertiser> — "<source hook>"](https://app.trendtrack.io/share/ads/<slug>)
```

Underneath, include the full persona-notice callout (💡 gray background) for that page's Avatar, worded close to this verbatim standing text:

> **JOHN - KNIFE COLLECTOR** — Rarity + craftsmanship are his trigger. Hard production limits and "no restock, no waitlist" activate him; discount-first hooks and countdown timers repel him. No deal or discount language at all in his copy — scarcity is framed as manufacturing complexity, never a deadline.

> **MIKE - BBQ KING** — View it as Sarah's husband. He's the man who cooks, grills, view him like Amir — big beard, big muscle, looks like a Viking. Harder marketing is fair game, deeper/darker ElevenLabs voice, rock or hard rock music. No gift framing — outdoor, grill, Viking-heritage angle.

## Real example pages worth reading before writing a new batch

- `NK382`–`NK396` (2026-09-01) — the first full run under the current standing defaults: 5 concepts × 3 products, blank Editor/Date, Net New, TrendTrack share links in AD INSPO.
- `NK370/371/372` ("Three Return Forms") — an earlier clean 3-page batch from the team.
- Fetch any of these directly in Notion (`notion-fetch`) to see current formatting before starting a new batch — conventions drift, and a fresh read beats trusting this doc blindly (same caution `creative-brief-process.md` itself gives about its own staleness).
