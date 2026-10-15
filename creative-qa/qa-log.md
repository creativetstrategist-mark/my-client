# Creative QA ledger

Dedup record for the creative QA routine. **One row per cut that got a full QA
pass, whether or not its Notion Status moved.** Those two are deliberately
separate things:

- a **row** records that the QA ran and what was posted, so no later run ever
  re-QAs or re-comments the same cut;
- the **Status** records that the hand-off to the editor completed, which is a
  different event and sometimes does not happen.

Tying them together was a bug. A cut whose Slack thread could not be found got
its comments but no row, so every later cue re-QA'd it, ran into its own
comments, and reported a clash forever — while the editor was never told.

## The dedup key

**`Creative ID` + `Version QA'd`**, where `Version QA'd` is the Frame.io **file
id plus that file's `updated_at`**.

The id alone is not enough. Deliveries are often loose files rather than version
stacks (NK604's are), so an editor who re-uploads in place keeps the same file id
and only `updated_at` moves. For a true version stack, use the version's own id
and its `updated_at`.

- same creative, same id **and** same `updated_at` → **skip the QA**
- same creative, newer `updated_at`, or a new id → the editor re-delivered →
  **QA it again**
- not listed → QA it

## The `Pending` column

What still has to happen for that cut. `—` means nothing is outstanding.

`slack` means the QA is done and the comments are posted, but the thread reply,
the 🔁 and the Status move are not. A later run must **not** re-QA it and must
**not** re-post its comments: it retries only the outstanding steps, then clears
the column and moves Status to `2nd QA`.

## Rows seeded as `manual`

Cuts Zoro QA'd by hand before this routine existed. Their file ids and
`updated_at` were never recorded, so the version key cannot match them. For
those only, read the file's comments first: if a **completed** `[QA n/N · …]`
list is already there, skip the cut and report the clash rather than posting
again.

| Date | Creative ID | Editor | Version QA'd (file id + updated_at) | Verdict | Fixes posted | Slack thread | Pending | Run |
|---|---|---|---|---|---|---|---|---|
| 2026-10 | NK586 | Naveed | not recorded | not ready (clipping at +0.8 dBTP, rushed ending) | manual | — | — | manual |
| 2026-10 | NK583 | Anas | not recorded | not ready (H1/H3 files swapped, naming cut off) | manual | — | — | manual |
| 2026-10 | NK544 | Renniel | not recorded | not ready (H2 filed under H3) | manual | — | — | manual |
| 2026-10 | NK549 | Anas | not recorded | not ready (LOKI wearing FREE sticker at 0:58) | manual | — | — | manual |
| 2026-10 | NK517 | Umar | not recorded | not ready (−26.5 LUFS, "Full tang" caption) | manual | — | — | manual |
