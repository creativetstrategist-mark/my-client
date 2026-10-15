# Creative QA — Frame.io comments from the Notion "1st QA" queue

Fired **on Mark's cue** (no schedule). Takes the cuts sitting at Status
`1st QA` in the Notion "Evergreen Video" database, runs the full Zoro QA pass
on the delivered Frame.io files, posts the editor fix list as Frame.io
comments, and drops a one-line pointer in the editor's own Slack thread.

The QA rules themselves are **not** in this file. The `zoro` skill is
authoritative for what counts as a fix: read its `SKILL.md`,
`references/caption-rules.md`, `references/safe-zones.md`,
`references/client-nk.md` and `references/frameio-posting.md` at the start of
every run. This file covers only what the skill cannot know: where the queue
is, which cuts are already done, and how far the run may go unattended.

## Autonomy (set by Mark, 2026-10-15)

| Action | Unattended? |
|---|---|
| Post the **editor fix list** as Frame.io comments | **Yes** — this is the deliverable |
| Reply `Check comment on frame` in the editor's Slack thread | **Yes** |
| Change the Notion **Status** | **Never.** Mark moves the board by hand |
| Post **review items** (judgment calls) anywhere | **Never** — they go to Mark in the run report only |
| Delete or resolve an existing comment | **Never** without Mark saying so |

The editor/review split is Zoro's core rule and it still holds here: an editor
reads every comment as a required change, so a taste note posted as a fix
costs a revision round. Review items are reported to Mark and nowhere else.

## The dedup ledger — read this before touching the queue

**Status is not the dedup key, and cannot be.** The run is forbidden from
moving Status, so a cut stays at `1st QA` after it has been QA'd. A run that
trusted Status alone would re-QA the same cuts on every cue and post the fix
list to the editor a second and third time.

`creative-qa/qa-log.md` is the ledger. One row per cut actually QA'd, keyed on
**creative ID + the Frame.io version id that was QA'd**:

- Same creative ID, same version id already in the log → **skip**, silently.
- Same creative ID, **newer** version id (the editor re-delivered) → **QA it
  again**. That is the point of keying on version rather than creative.
- Not in the log → QA it.

Belt and braces, because the ledger can lag a crashed run: before posting to a
file, `read_comments` on it and skip posting if comments with a
`[QA n/N · …]` prefix are already there. Report the clash instead.

## The queue

```sql
SELECT "Creative ID", "Concept Name", "Editor", "Strategist", "Product",
       "Delivery Link", createdTime, url
FROM "collection://2cf4ac62-7aac-81a8-86bf-000b96778943"
WHERE "Status" = '1st QA'
  AND "Strategist" IN ('Mark', 'Andy', 'Claude')
ORDER BY createdTime ASC
```

Oldest first, so the backlog drains in delivery order.

**Strategist gate — apply it before anything else (set by Mark, 2026-10-15).**
Only cuts whose Notion `Strategist` is **Mark**, **Andy** or **Claude** are in
scope. A cut by **Callum** or **Mauro** is skipped completely: no QA pass, no
Frame.io comment, no Slack reply, and no write of any kind against its Notion
page. Skip it before opening a single file — not after QA'ing it and deciding
not to post — so an out-of-scope cut never costs a download or a transcription.

This matters more than the current queue suggests. Every cut at `1st QA` today
is Mark's or Andy's, but the `Assigned to Editor` stage behind it is largely
Callum's, so Callum's work will reach `1st QA` in volume as editors deliver.
Read the strategist from the Notion `Strategist` property — never by parsing
the ad or file name, which truncates and shifts segments between naming series.

Report the strategist per cut, and name the out-of-scope cuts you skipped, so
Mark can see the gate is doing what he expects.

Unless Mark's cue names specific creatives or a count, QA **3 cuts** per run. A
full pass is heavy — download three hook files, transcribe, OCR frames, measure
caption boxes — and three is what fits one session comfortably. If the cue
names creatives ("QA NK604 and NK609"), do exactly those and ignore the cap.

## Finding the delivered files

Three paths, in this order. Do not stop at the first that returns *something* —
stop at the first that returns a file you have confirmed belongs to this
creative.

1. **Notion `Delivery Link`** on the brief page. Populated on roughly half the
   queue, so it cannot be the only path.
2. **The editor's own Slack reply.** In the creative's thread (see below) the
   editor posts `@Mark Ready for review <frame.io link>`. That link carries the
   asset id and is present even when Notion's `Delivery Link` is empty — often
   the fastest correct answer.
3. **Frame.io `search_assets`** with the creative ID, as the `zoro` skill
   describes. Account `b0bc19f9-4a80-4ae4-9768-4b151edb5a40`; deliveries so far
   all sit in project `b37ff928-5b11-4860-8204-f102af43f3ec`.

Then apply Zoro's version-stack rules: QA the newest upload per hook by
`created_at`, check each stack holds only its own hook, and read the previous
version's comments so notes Mark already left are enforced in the new cut.

If no files turn up on any of the three paths, that cut is **not** a QA
failure — the editor has moved the brief to `1st QA` without delivering, or
delivered somewhere unexpected. Post nothing, log nothing, and name it in the
run report as "no files found".

## The Slack thread

One channel per editor, keyed off the brief's Notion `Editor` property:

| Editor | Channel | ID |
|---|---|---|
| Anas | `#11-anas-editing` | `C0BQSRKS30U` |
| Hammad | `#11-hammad-editing` | `C0APFKCF6ET` |
| Hasnain | `#11-hasnain-editing` | `C0BMZ97T3D3` |
| Naveed | `#11-naveed-editing` | `C0BRV68UN12` |
| Onyeka | `#11-onyeka-editing` | `C0APX296L9Y` |
| Renniel | `#11-renniel-editing` | `C0BSC1C8WMN` |
| Umar | `#11-umar-editing` | `C0B28C13XDW` |

`Huzaifa` is still a selectable Editor in Notion but is not active and has no
channel. If a cut is assigned to Huzaifa, post the Frame.io comments and report
the Slack gap rather than guessing a channel.

**Finding the right thread.** The thread parent is Mark's message posting the
Notion brief link, whose link label starts with the creative ID:

```
NK609_Not For Everyone - Santoku_AI VO_SANTOKU
NK586_Why It Sells Out_AI-VO_BJORN Santoku
```

Match on the **first underscore-delimited segment of the link label, as a whole
segment**, against the creative ID. Never substring-match: `NK60` must not
match `NK609`, and `NK61` must not match `NK612`. The rest of the label drifts
in format (`AI VO` vs `AI-VO`, product suffix present or not), so the first
segment is the only reliable key. Search the editor's channel for the creative
ID to locate it.

**The reply.** In that thread, as a threaded reply:

```
Check comment on frame
```

Add the Frame.io file link and the fix count on the same line so the editor
knows what they are opening and how much is waiting. Keep it to one line — the
fixes themselves live in the Frame.io comments, not in Slack.

Rules:
- Always a **threaded reply** (`thread_ts` = the parent's ts). Never a new
  channel message, and never `reply_broadcast`.
- Post to Slack **only after** the Frame.io comments are actually on the file.
  A pointer to comments that are not there wastes the editor's trip.
- **No thread found** for that creative in that editor's channel → post the
  Frame.io comments, skip Slack, and report it. Do not open a new thread: the
  thread is Mark's to start.
- **More than one** matching thread → reply in the newest and say so in the
  report.
- **No fixes found** (the cut is clean) → post nothing to Frame.io and nothing
  to Slack. A clean cut is reported to Mark, who moves the board.

## Posting to Frame.io

Follow `references/frameio-posting.md` in the `zoro` skill exactly — comment
format `[QA n/N · Category]`, one comment per fix per file at that file's own
timecode with the variant offsets applied, whole-video items pinned at
`00:00:00:00`, red box over the caption or red line at the safe-zone limit,
naming comments carrying the full expected name ready to copy.

Keep the `n/N` numbering identical to the numbering in the run report so Mark
and the editor are reading the same list.

## Report back to Mark

Per cut: the verdict (ready / not ready), the fix count and the serious ones,
which files got comments, the Slack thread replied to, and the review items —
review items go **here only**. Then the run totals: cuts QA'd, cuts skipped as
already done, cuts skipped by the strategist gate (with whose they were), cuts
with no files found, and what is left in the queue.

If the Notion, Frame.io or Slack connector is unavailable for a run, say so
explicitly rather than reporting zero findings — a silent empty run reads like
a clean queue.

## Run history

Appended by each run, newest last. Keep it to one line per run; the per-cut
detail belongs in `qa-log.md`.

| Date | Cue | Cuts QA'd | Fixes posted | Skipped (done) | Out of scope | No files | Notes |
|---|---|---|---|---|---|---|---|
