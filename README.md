# NorthernKnife — daily ad-rewriting routine

Daily automated job: pull winning ad inspiration from TrendTrack, rewrite it for
NorthernKnife's three focus products, and publish the results as
production-ready briefs in the Notion Video Brief Database.

Brand: [NorthernKnife](https://northernknife.com/) — hand-forged,
Viking-inspired knives.

## Layout

```
brand-pack/                       creative reference library
  START-HERE.md                   entry point — read this first
  01-brand/product-catalog.md     the 3 focus products + never-violate rules
  02-personas/                    JOHN, MIKE, SARAH, VANCE
  03-copy/approved-copy.md        house proof stack, offer language, hooks
  04-winning-briefs/              two real briefs + the winners index
  05-process/                     THE most important file (see below)
daily-ad-rewrites/
  processed-inspo-log.md          dedup ledger — check before picking inspo
CLAUDE.md                         operating instructions for the routine
```

**Start at `brand-pack/START-HERE.md`.** The single most important file is
`brand-pack/05-process/creative-brief-process.md` — Section C is the copy-voice
rulebook, Section D/D0 is the exact live Notion brief template, Section F is the
originality gate.

## Two standing rules

1. **Where a document conflicts with the real shipped ad corpus, the corpus
   wins.** The known conflicts are catalogued in the process doc §C.6.
2. **The live Notion template beats the transcription in §D.** It is edited
   faster than this repo. Diff before every batch; drift history is §C.7.

## Provenance

The library was transcribed from the live Notion workspace **NK Creative
Strategy Lab** on 2026-09-10. Every file records its Notion source IDs at the
bottom so a stale page can be re-pulled.
