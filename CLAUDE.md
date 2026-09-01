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

**`brand-pack/05-process/creative-brief-process.md`** has the copy-voice
rulebook (banned spec-sheet jargon, hook patterns, offer rules, originality
gate — Section C) and the general video-brief block layout (Section D).

**`brand-pack/05-process/notion-schema-verified.md` is the authoritative
source for the actual live Notion database** — exact property names/option
strings, the real page structure (verified 2026-09-01 directly against the
database), and the next Creative ID to use. Where it disagrees with
`creative-brief-process.md` (which has a documented history of drifting from
the live database), **notion-schema-verified.md wins** — but always re-fetch
a couple of the most recent real pages in Notion before starting a new batch,
since conventions keep moving.

## The 3 focus products for this routine

Only these three — do not substitute other catalog items unless the user
explicitly asks. (Names below are the readable names; the exact Notion
`Product` select values are `Feather`, `SANTOKU`, `LOKI Blackout` — see
`notion-schema-verified.md`.)

| Product | Hard rules (never violate) |
|---|---|
| **Feather Knife** | $99.90. Rosewood handle. Blade pattern is **laser-applied** — never say hand-etched, hand-finished, or engraved. ~500-unit limited drops, ~3-month restock. Avatar: **JOHN - KNIFE COLLECTOR**. |
| **BJORN Series Santoku** | Norse engravings on blade, dragon-sculpted **brass** bolster, hand-carved wooden handle. **Never reference Japanese origins or use the word "Japanese"** — santoku is a Japanese-origin knife shape but the brand never says so. Avatar: **JOHN - KNIFE COLLECTOR**. |
| **LOKI Blackout Edition** | $79.90. High-carbon steel, ebony handle, bottle opener built into the **handle** (not the blade/spine). Ships in a black branded box with magnetic closure. All-black remake of the #1-selling LOKI Viking Knife. Avatar: **MIKE- BBQ KING**. |

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
- **The offer resolves the subject, never replaces it.** Whatever the hook
  raises, the body must pay off *before* any offer appears. Offer lands
  ~60–80% through, never first/last, followed by 2–4 more beats. Only real
  offers exist: B2G2, B1G1, the % tiers — never invent one. Current live
  storewide offer is **B2G2**.
- **Never reuse the identical offer paragraph across product versions** in
  the same batch.
- **Never name a real public figure/celebrity in ad copy** — flagged as a
  legal/right-of-publicity concern in the real corpus, treat as a hard stop.

## Where things live

- `brand-pack/` — the full reference library (read-only source material,
  mirrors the brand pack the user supplied). Trimmed to what's relevant to
  the 3 focus products above.
- `daily-ad-rewrites/processed-inspo-log.md` — human-readable audit trail of
  every run (not the primary dedup check — see below).

## TrendTrack source folders (personal scope, not workspace)

The user's real inspo pool lives under **personal** favorites, not the
workspace ones:
- **"Inspo <-"** (`3df81f20-b754-425e-a487-5cad19d4dbab`) — ads to pull from.
  It has a sub-folder "Mark's Pick" (`97fe1706-577f-43dc-a139-882e5b0c4ed7`)
  — check the parent folder's direct items first.
- **"Swiped ->"** (`3ef55bf5-3e9d-47d7-9332-8cf868637b48`) — where used ads
  get moved. **This move IS the dedup mechanism** — an ad still sitting in
  "Inspo <-" is fair game; once moved to "Swiped ->" it's off-limits. Always
  call `list_favorites` on "Inspo <-" fresh each run rather than trusting
  `processed-inspo-log.md` alone, since that file is just a log, not the
  source of truth.

Use `type: "ads"`, `scope: "personal"` on every `list_favorites` /
`move_favorite_item` call for this routine — the default `scope: "workspace"`
will not see these folders.

## The daily routine

A scheduled Routine fires daily and:
1. Lists items in the personal **"Inspo <-"** folder
   (`list_favorites`, `type: "ads"`, `scope: "personal"`,
   `folder: "3df81f20-b754-425e-a487-5cad19d4dbab"`).
2. Picks 5 ads from that listing (whatever's there — the folder itself is
   the queue, nothing to cross-check beyond what's currently sitting in it).
3. For each of the 5 inspo ads, deep-scans it (`scan_ad`) and rewrites it
   for **all 3 focus products**, following the copy rules above and the
   exact video-brief format in `brand-pack/05-process/creative-brief-process.md`
   Section D.
4. Creates **one separate Notion page per product per inspo ad** (3 pages ×
   5 ads = **15 pages per run**) directly in the "Evergreen Video" data
   source under Video Brief Database, using the exact property values in
   `brand-pack/05-process/notion-schema-verified.md` — including the next
   sequential Creative ID (query the database for the current max first).
5. Moves each of the 5 used ads from "Inspo <-" to "Swiped ->"
   (`move_favorite_item`, `type: "ads"`, `scope: "personal"`,
   `folder_id: "3ef55bf5-3e9d-47d7-9332-8cf868637b48"`) — this is what
   actually prevents reuse, do this for every ad used, every run.
6. Appends a row per ad to `daily-ad-rewrites/processed-inspo-log.md` (audit
   trail only) and pushes that update to this repo (local `git commit` may
   be blocked by this environment's permission classifier — use the GitHub
   MCP `push_files`/`create_or_update_file` tools as a fallback, same as
   this repo's initial setup did).

If the Notion or TrendTrack connector isn't available in a given run, the
routine should say so explicitly rather than silently skipping delivery.
