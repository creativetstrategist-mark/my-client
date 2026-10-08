# northernknife-ugc

UGC scripting for **NorthernKnife** (https://northernknife.com/) —
hand-forged, Viking-inspired knives.

This repo **feeds the Gen 2 system**: the `UGC Creator Library` in Notion and
its `🎬 Creator Script Library`. A script written here lands as a **row in
that database**, with a long form, a short form, three hooks and a b-roll
package drawn from the shared shot library. This repo is the drafting and
review surface; Notion is where creators get assigned and work gets tracked.

Sibling to `my-client` (the daily TrendTrack → Notion ad-brief routine). Same
brand, different deliverable, and **a different rulebook** — `CLAUDE.md` lists
the four `my-client` rules that do not hold here.

## Start here

- `CLAUDE.md` — the unit of work, the three product guards, the inherited
  rules that don't apply.
- `brand-pack/05-process/ugc-script-process.md` — the authoritative spec.
- `brand-pack/05-process/notion-integration.md` — what to read, what to write.
- `brand-pack/START-HERE.md` — full reading order.

Delivered scripts are mirrored to `ugc-scripts/<SCRIPT-ID>.md`. There is no
dedup log — the Creator Script Library is the ledger.

## Status

The process spec, integration map and product guards were read from the live
workspace on **2026-10-08** and are current. The persona/avatar and
brand-voice docs are **stubs** marked `TODO(brand-pack)`; STEVE and DARIEN in
particular are names and nothing more. Don't invent brand facts to fill them.

Two live defects are documented in Section I of the process doc — most b-roll
IDs on existing script rows are archived, and the shot library is mid-migration
to Trybe packs. Re-resolve any b-roll package before a creator is sent it.
