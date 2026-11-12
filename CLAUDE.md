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

## Winner iterations (on demand, on Mark's command)

A separate play turns one of **our own** winning ads into new briefs. **It is on
demand, not an automation**: no Routine, no schedule. Mark decides which winners
get iterated and names the creative IDs (`Iterate NK284`, `Iterate NK284,
NK222`). The play never picks a winner itself. If a command arrives with no ID,
ask for one.

**Every winner always gets both types**, and **both go to the editor who cut the
source.** **The strategist on every iteration is Mark**, and names say
**Iteration 1 / Iteration 2**, never "Rewrite" or "Reskin". Pages follow the **live brief template's
structure** (video block, 3-column HOOK / BODY / CTA tables, no extra
callouts). An event in the command (`Iterate NK222 Black Friday`) makes both
briefs event versions: spec §8.3.
Products and editors in the command (`Iterate NKEOFY005 for Feather, Blackout,
Santoku; Hammad, Naveed, Hasnain`) mean one **product version** per product instead:
the winner's script with only its product-fact lines changed, no visuals, the
cut as the guide: spec §8.4.

Full spec: `winner-iterations/iteration-process.md`. Read it before running or
changing this play. A paste-in version for sessions not on this branch is
`winner-iterations/run-instruction.md`, and the dedup ledger is
`winner-iterations/iteration-log.md`.

| | Iteration 1 (`Ite-Script`) | Iteration 2 (`Ite-Reskin`) |
|---|---|---|
| Locked | The footage, clip for clip | The script, word for word, and its VO track |
| New | Every hook and body line | Every visual, none similar to the source |
| Editor | The source's editor | The source's editor |

Five things that are easy to get wrong:

- **Pull, don't guess.** The brief comes from Notion (`Creative ID` match, else
  workspace search). The cut comes from the page's `Delivery Link`, else a
  Frame.io search where the name's **first `_` segment equals the ID**
  (`NK485_VID_Why NK184…` is not NK184). No brief or no cut means stop that ID
  and ask.
- **The source page is read-only.** Never write to it.
- **Never instruct generating on Higgsfield** (too expensive). Iteration 2 pages
  leave the Visual column empty and tell the editor to cut the same script over
  different real footage, no source clip in any form: spec §4.2.
- **"Not similar" is a gate, not a vibe.** Iteration 2 uses no source clip in any
  form, differs on 3 of 4 axes (setting, subject, framing, action) in every row,
  and changes the whole cut's format device and grade.
- **The locked Iteration 2 script changes only through the fix list** in spec §4.3:
  product-fact errors, "Japanese", prices, "Free returns", and the 147,000
  customer count. Each change is marked `Changed:` so only that line is
  re-recorded.
- **New pages stop at `Ready for visuals`.** This play never messages an editor.
  The editor-assignment play does that after a human moves the page on.
