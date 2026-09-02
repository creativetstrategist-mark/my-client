# NorthernKnife — Daily Ad-Rewriting Routine

This repo powers a daily automated job: pull winning ad inspiration from
TrendTrack, rewrite it for NorthernKnife's three current focus products, and
publish the results as production-ready briefs in Notion.

Brand: NorthernKnife (https://northernknife.com/) — hand-forged,
Viking-inspired knives.

## Read this first

`brand-pack/START-HERE.md` is the entry point to the full creative reference
library (brand voice, personas, approved copy, real winning briefs, and
the exact Notion brief process). Read it before writing any ad copy — most
of the hard rules below are pulled from there but the source docs have more
depth and more examples.

**The single most important file is `brand-pack/05-process/creative-brief-process.md`.**
Section D/D0 defines the *exact* live Notion video-brief template (block by
block, including the HOOK/BODY table columns) — this is authoritative for
how a page in the Video Brief Database must be structured. Section C is the
copy-voice rulebook (banned spec-sheet jargon, hook patterns, offer rules,
originality gate). Read the current example page in the actual Notion
database too, since Andy edits the live template faster than this doc gets
updated — the doc itself has a documented history of drifting from Notion
(see its Section C.7).

## The 3 focus products for this routine

Only these three — do not substitute other catalog items unless the user
explicitly asks:

| Product | Hard rules (never violate) |
|---|---|
| **Feather Knife** | $99.90. Rosewood handle. Blade pattern is **laser-applied** — never say hand-etched, hand-finished, or engraved. ~500-unit limited drops, ~3-month restock. Persona fit: **JOHN** (collector). |
| **BJORN Series Santoku** | Norse engravings on blade, dragon-sculpted **brass** bolster, hand-carved wooden handle. **Never reference Japanese origins or use the word "Japanese"** — santoku is a Japanese-origin knife shape but the brand never says so. Persona fit: **JOHN**. |
| **LOKI Blackout Edition** | $79.90. High-carbon steel, ebony handle, bottle opener built into the **handle** (not the blade/spine). Ships in a black branded box with magnetic closure. All-black remake of the #1-selling LOKI Viking Knife. Persona fit: **MIKE** (BBQ/grill self-buyer), **SARAH** (gift framing), general/deal-led for **VANCE**. |

Full detail: `brand-pack/01-brand/product-catalog.md`. Persona docs:
`brand-pack/02-personas/`.

## Universal copy rules (apply to every rewrite, every product)

- **No spec-sheet jargon, ever**: no alloy codes, HRC/Rockwell numbers,
  "edge retention," "blade geometry," mm/gram specs. Say the plain material
  + the consequence ("hand-forged high-carbon steel… holds that edge").
  Full banned list and substitution table: process doc Section C.1.
- **The mechanic transfers, the words never do.** Take the inspo ad's
  structure (hook type, pacing, beat order) — every sentence gets rewritten
  fresh. No verbatim source language, not even for an identical beat.
  Run the originality-gate logic described in process doc Section F
  mentally if no script is available to run it against.
- **The offer resolves the subject, never replaces it.** Whatever the hook
  raises, the body must pay off *before* any offer appears. Offer lands
  ~60–80% through, never first/last, followed by 2–4 more beats. Only real
  offers exist: B2G2, B1G1, the % tiers — never invent one.
- **Never reuse the identical offer paragraph across product versions** in
  the same batch.

## Where things live

- `brand-pack/` — the full reference library (read-only source material,
  mirrors the brand pack the user supplied). Trimmed to what's relevant to
  the 3 focus products above — the source pack the user uploaded also
  covers the rolling sharpener line and 4 other knife personas/products
  which are out of scope for this routine.
- `daily-ad-rewrites/processed-inspo-log.md` — dedup ledger. Every TrendTrack
  ad used by the daily routine gets logged here (ad id/URL, date used, which
  products it was adapted for). **Check this before picking new inspo ads**
  so the routine doesn't reuse the same source twice in a row.

## The daily routine

A scheduled Routine fires daily (see the trigger created for this repo) and:
1. Searches the TrendTrack "inspo" favorites folder for ad inspiration.
2. Picks 5 ads not already in `daily-ad-rewrites/processed-inspo-log.md`.
3. Rewrites each of the 5 for **all 3 focus products** (15 briefs/day),
   following the exact Notion video-brief template in the process doc.
4. Creates one new page per brief directly in the Notion "Video Brief
   Database" (Andy also calls it the "Evergreen Video" database), matching
   the existing page structure/properties exactly.
5. Appends the day's ad ids to the dedup log and commits/pushes that log
   update to this repo.

If the Notion connector isn't available in a given run, the routine should
say so explicitly rather than silently skipping delivery.

## The weekly winner check

A separate scheduled Routine fires every Monday and tags winning creatives in
the same Notion "Evergreen Video" database that the daily routine writes to.

Full spec: `weekly-winner-check/winner-detection-process.md` — read it before
running or changing this routine.

In short: pull the last complete Sun–Sat week from Triple Whale for the US, UK
and AU stores (separately — never blended, the currencies differ), find **video**
creatives with **>= 1,000 local-currency spend** and **First-Click ROAS >= 2.0**,
parse the `NK###` code out of the ad name, and append the matching
`US Winner` / `UK Winner` / `AU Winner` tag to that brief page's `Test Results`.
Only creatives whose strategist is **Mark, Andy or Claude** are tracked.

Four things that are easy to get wrong:

- **First Click, not Triple Attribution.** The shop default is Triple
  Attribution; this routine must set `model = 'First Click'` explicitly.
- **The Notion `Creative ID` is not the Triple Whale `creative_id`.** Join on
  the `NK###` prefix parsed from `ad_name`, not on the platform creative id.
- **Append, never overwrite** `Test Results`, and never write `High Potential`
  or `Loser` — those two options stay manual for the team.
- **Read the strategist from Notion's `Strategist` property, not the ad name.**
  The strategist is nominally the 11th segment of the ad name, but Meta
  truncates long names (NK284 arrives cut off at 96 chars with no strategist
  in it) and segment positions shift between naming series.

If the Triple Whale or Notion connector isn't available in a given run, say so
explicitly rather than reporting zero winners.
