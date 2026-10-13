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

- `editor-assignment/editor-assignment-process.md` — spec for the
  "Ready to edit" → Slack handoff play (see below), which runs on demand rather
  than on a schedule. Holds the verified editor→Slack channel/member-ID mapping,
  and the message format. **Read it at the start of every run**, and edit it to
  change the behaviour.

## The editor-assignment play (on demand)

When a brief in the Notion "Evergreen Video" database reaches **`Ready to edit`**,
it gets handed to its editor in that editor's own Slack channel
(`#11-<editor>-editing`), and the page is flipped to **`Assigned to Editor`** so
it leaves the queue.

**This runs on demand, not on a schedule.** Mark gives a go signal and the sweep
runs then, in a live session holding the Notion and Slack connectors. There is no
cron and no trigger — nothing happens to a brief unless Mark asks. A go signal
means every brief currently in `Ready to edit` that is not Callum's and not
malformed, unless he scopes it narrower.

Full spec — the verified editor→Slack mapping, the message format, the edge-case
table: `editor-assignment/editor-assignment-process.md`. Read it before running
or changing anything, and **re-query at the start of every run** rather than
reusing a brief list from earlier in a conversation.

Four rules worth knowing without opening the spec:

- **Never touch work with `Callum` as Strategist** — standing instruction from
  Mark (2026-10-13). No post, no status change, no triage. Filtered in the query.
- **Never guess an editor.** A brief in `Ready to edit` with a blank `Editor`
  goes to Mark's channel as needing an owner and keeps its status. The
  editor-assignment rules in `notion-schema-verified.md` govern brief *creation*
  only — reusing them here would paper over a real gap.
- **Post first, then flip**, and never flip a page that was not successfully
  posted. A draft is not a post. The safe failure is a brief that stays in
  `Ready to edit`.
- **Bold is `**two asterisks**`.** The Slack tools take standard Markdown and
  convert it, so a single `*` sends italic — the opposite of what an existing
  Slack message's raw source looks like. This broke the first live test.
- **Links must be `https://app.notion.com/p/<id>`.** The query's `url` column
  omits the `/p/` and the resulting link does not work.
- **Each brief must be published to the web, with editing allowed, before it is
  posted** — several editors are not Notion users, and they write `Delivery Link`
  back onto the page. Per page, by hand: Notion has no API for this, so nothing
  can automate or even verify it. Publish it in the same action as moving the
  brief to `Ready to edit`. An unpublished page and a bad link look identical
  from Slack, so check this first when an editor reports a dead link.

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
