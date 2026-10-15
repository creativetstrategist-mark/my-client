# Creative QA ledger

Dedup record for the creative QA routine. One row per cut actually QA'd.
See `qa-process.md` for why this file exists rather than relying on the Notion
Status: the routine is forbidden from moving Status off `1st QA`, so the queue
never drains on its own and a run without this ledger would re-post the fix
list to the editor on every cue.

**The key is `Creative ID` + `Version QA'd`** (the Frame.io version id of the
file that was checked, per hook):

- same creative, same version → skip
- same creative, newer version (editor re-delivered) → QA again
- not listed → QA it

Rows seeded as `manual` are cuts Zoro QA'd by hand before this routine existed.
Their version ids were not recorded, so the version key cannot match them.
For those, read the file's comments first: if `[QA n/N · …]` comments are
already on it, skip the cut and report the clash rather than posting again.

| Date | Creative ID | Editor | Version QA'd | Verdict | Fixes posted | Slack thread | Run |
|---|---|---|---|---|---|---|---|
| 2026-10 | NK586 | Naveed | not recorded | not ready (clipping at +0.8 dBTP, rushed ending) | manual | — | manual |
| 2026-10 | NK583 | Anas | not recorded | not ready (H1/H3 files swapped, naming cut off) | manual | — | manual |
| 2026-10 | NK544 | Renniel | not recorded | not ready (H2 filed under H3) | manual | — | manual |
| 2026-10 | NK549 | Anas | not recorded | not ready (LOKI wearing FREE sticker at 0:58) | manual | — | manual |
| 2026-10 | NK517 | Umar | not recorded | not ready (−26.5 LUFS, "Full tang" caption) | manual | — | manual |
