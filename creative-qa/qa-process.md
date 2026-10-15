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
| Add 🔁 to that thread's parent message | **Yes** |
| Move the Notion **Status** from `1st QA` to `2nd QA` | **Yes** — last step, and only on the outcomes below |
| Any other Notion write (property, page body, a different Status) | **Never** |
| Post **review items** (judgment calls) anywhere | **Never** — they go to Mark in the run report only |
| Delete or resolve an existing comment | **Never** without Mark saying so |

The editor/review split is Zoro's core rule and it still holds here: an editor
reads every comment as a required change, so a taste note posted as a fix
costs a revision round. Review items are reported to Mark and nowhere else.

### When Status moves (set by Mark, 2026-10-15)

`1st QA` → `2nd QA` is the **only** Status transition this run may make, and the
**only** Notion write of any kind. It goes last, after the comments, the reply
and the 🔁 have all actually landed.

| Outcome | Frame.io | Slack reply | 🔁 | Status |
|---|---|---|---|---|
| Fixes found, posted, thread found | comments | yes | yes | → **`2nd QA`** |
| **Clean — no fixes at all** | nothing | nothing | nothing | → **`2nd QA`** |
| Fixes posted but **no Slack thread** found | comments | — | — | stays `1st QA` |
| **Partial pass** (Mark asked for one) | labelled comments | yes | yes | stays `1st QA` |
| Blocked, no files, or tooling failed | nothing | nothing | nothing | stays `1st QA` |
| Out of scope (Callum / Mauro) | nothing | nothing | nothing | **untouched** |

A clean cut moves because it had a full, successful QA — it simply had nothing
to fix. It is the one outcome with no Frame.io or Slack trace at all, so the
Status change is the only signal it was ever looked at. Without it a clean cut
strands: nothing posted, a ledger row written so the next run skips it, and
nobody told it passed.

A cut stays at `1st QA` whenever the hand-off did not actually complete. No
thread means the editor was never told, so the work is not with them yet. A
partial pass means the cut has not really been QA'd. Both are visible on the
board as still needing attention, which is the point. A cut left at `1st QA`
after its comments posted still gets its ledger row, with `Pending` = `slack`.

**The exact call.** `Status` is a Notion *status*-type property, not a select, so
it takes the option name as a plain string:

```
mcp__Notion__notion-update-page
  page_id:     <the brief page's id>
  command:     "update_properties"
  properties:  { "Status": "2nd QA" }
  allow_async: false
```

Pass `allow_async: false` deliberately — page updates default to async, and the
ledger row written straight afterwards must not record a move that has not
actually landed. Verified against the tool schema on 2026-10-15; `2nd QA` was
confirmed present in the live Status options before wiring it up.

## Never post a partial fix list

The `[QA n/N]` numbering asserts that the list is complete. An editor who gets
`[QA 1/1 · File naming]` reads it as "rename this and the cut is good to go".

So if **any** check could not run — the media would not download, a transcription
failed, OCR produced nothing usable — post nothing to Frame.io, reply nothing on
Slack, add no 🔁, leave Status at `1st QA`, and write no ledger row. Report to Mark what did run, what
could not, and why. A partial list is worse than no list: it costs a revision
round and it tells the editor the unchecked parts passed.

The checks that survive a media failure are naming (delivered names come from
the Frame.io API, not the file) and aspect ratio, frame rate and duration (from
the file's metadata). They are worth reporting to Mark. They are not worth
posting on their own, because between them they cover none of what the QA is
actually for.

**The one exception is Mark asking for a partial pass.** He can override this,
and did on 2026-10-15 for NK604's naming fix while the media host was blocked.
When he does:

- **Drop the `n/N` numbering entirely.** It is the numbering that lies, not the
  fix. Label the comment `[QA · <Category> — <what ran>-only pass]`.
- **Name the checks that did not run, inside the comment**, so the editor cannot
  read it as the complete list, and say the same in the Slack reply.
- **Still write no ledger row, and leave Status at `1st QA`.** The creative has
  not had a full QA, so it must come back round for one. The reaction, the
  posted comments and the board position are not a record that it passed.

## Environment requirement: egress to Frame.io's media host

Every download, proxy, thumbnail and scrub-sheet URL Frame.io hands back is on
**`at.adobe.com`**. If the environment's network policy denies that host, the
CONNECT fails with a gateway 403 and **no cut can be QA'd at all** — captions,
VO, safe zones and audio all need the bytes.

This bit on 2026-10-15, the first real run. It is a network-policy setting, not
a code problem: the host has to be allowed for the environment the Routine
fires in. A run that hits it must say so plainly rather than reporting a clean
queue, and must not substitute guessed findings for checks it could not run.
**Step 0 of every run: `bash creative-qa/setup-qa-tools.sh`.** It is idempotent,
installs only what is missing, and its exit code decides whether the run can go
ahead at all:

| Exit | Meaning | What the run does |
|---|---|---|
| `0` | tools ready, media host reachable | run the full Zoro pass |
| `3` | tools ready, media host **blocked** | report the block. Post nothing on naming alone unless Mark has asked for a partial pass |
| `1` | tooling would not install | report it, do not QA |

It installs `tesseract` and `faster-whisper`, which no fresh session has, and
checks `ffmpeg`/`ffprobe`, which ship with the image. Note `tesseract` needs
`apt-get update` first — on this image a bare `apt-get install tesseract-ocr`
reports "Unable to locate package".

Running it first also means a blocked run costs seconds instead of a wasted
pass: the preflight fails before any brief is read or any file is opened.

## The dedup ledger — read this before touching the queue

**A ledger row and a Status move are separate events. Never condition one on
the other.** A row says the QA ran and what was posted. Status says the hand-off
to the editor completed. Most of the time both happen; when only one does, the
row is still written.

Conditioning the row on the Status move was a bug, and it is worth stating so it
does not come back: a cut whose Slack thread could not be found got its comments
but no row, so every later cue re-QA'd it, ran into its own comments, reported a
clash, and did that forever — while the editor was never told. Write the row,
mark what is outstanding, and retry only that.

Status still drains the happy path: a completed QA moves the cut to `2nd QA` and
it leaves the `1st QA` queue. But Status cannot tell a re-delivery from a repeat,
and every stay-put outcome returns on the next cue, so the ledger decides.

`creative-qa/qa-log.md` is the ledger. One row per cut that got a full QA,
keyed on **creative ID + the Frame.io file id _and_ that file's `updated_at`**:

- Same creative, same id **and** same `updated_at` → **skip the QA**.
- Same creative, **newer `updated_at` or a new id** → the editor re-delivered
  → **QA it again**.
- Not in the log → QA it.

The id alone is not enough: deliveries are often loose files rather than version
stacks (NK604's are), so an editor who re-uploads in place keeps the same file id
and only `updated_at` moves. For a true version stack, use the version's own id
and its `updated_at`.

**A row with `slack` in its `Pending` column is not a cut to re-QA.** It means
the QA ran and the comments are posted, but the thread reply, the 🔁 and the
Status move are outstanding — usually because no thread existed at the time.
Retry only those outstanding steps, clear the column, move Status, and post
nothing new to Frame.io.

Belt and braces, because the ledger can lag a crashed run: before posting to a
file, `read_comments` on it. Only a **completed** fix list blocks a post — one
whose prefix carries the numbering, `[QA n/N · …]`. Skip that cut and report the
clash.

**A labelled partial pass never blocks a later full QA.** Those comments carry no
numbering on purpose (`[QA · File naming — naming-only pass]`) precisely because
the cut still owes a full pass: QA it and add to what is already there. Matching
on a bare `[QA` prefix would lock such a cut out of the full pass it is waiting
for. NK604 is in exactly that state now, and the rule — not a hard-coded
exception for it — is what has to get it right.

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

**The cap is 1 cut per run until a full pass has actually been measured.** If
the cue names creatives ("QA NK604 and NK609"), do exactly those and ignore the
cap; if it names a count, honour it.

A full pass per cut is three ~72 MB downloads, three CPU whisper transcriptions
and roughly 115 OCR frames per file — about 350 tesseract calls for one creative.
Nobody has run it end to end yet, so any larger cap is a guess. The first
completed run must record its wall-clock time and peak disk in the Run history
below; the cap is then raised from that measurement, not from an estimate.

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

**The reaction.** Once the reply is in the thread, add a 🔁 reaction to the
**parent message** — `slack_add_reaction` with the emoji name `repeat` (no
colons), the channel id, and the *parent's* `message_ts`, not the reply's.

The reaction goes on last, after the comments and the reply, so it means one
thing only: this creative has been QA'd and the fixes are waiting on Frame.io.
That makes it a visible cross-check on the ledger — a parent carrying 🔁 should
have a matching row in `qa-log.md`. It is a cross-check, not the dedup key:
`qa-log.md` stays authoritative, because a reaction cannot tell you *which
version* was QA'd, and a re-delivered cut needs QA'ing again under a 🔁 that is
already there. Adding a duplicate reaction succeeds silently, so a repeat run
costs nothing. Editors and Mark already use other reactions on these parents
(👀 appears on them), so never read another emoji as a QA signal and never
remove one.

Rules:
- Always a **threaded reply** (`thread_ts` = the parent's ts). Never a new
  channel message, and never `reply_broadcast`.
- Order is fixed: **Frame.io comments → thread reply → 🔁 on the parent →
  Status to `2nd QA`.** Each step only after the previous one actually landed:
  post to Slack only once the comments are on the file — a pointer to comments
  that are not there wastes the editor's trip — react only once the reply has
  landed, and move Status only once the 🔁 is on. Status last means the board
  never shows a cut as moved on when its feedback never arrived.
- **No thread found** for that creative in that editor's channel → post the
  Frame.io comments, skip both the reply and the reaction, **leave Status at
  `1st QA`**, and report it. Do not open a new thread: the thread is Mark's to
  start. With no parent there is nothing to react to, and with no reply the
  editor has not been told, so the cut has not been handed off. **Still write
  the ledger row, with `slack` in its `Pending` column** — the QA did run and the
  comments are posted, so a later run must retry only the Slack steps and the
  Status move, never the QA or the comments.
- **More than one** matching thread → reply in the newest, react on that same
  parent, and say so in the report.
- **No fixes found** (the cut is clean) → post nothing to Frame.io, nothing to
  Slack, and no reaction — but **do move Status to `2nd QA`** and write the
  ledger row. It passed a full QA, and that Status change is the only record of
  it. Report it to Mark as clean.

## Posting to Frame.io

Follow `references/frameio-posting.md` in the `zoro` skill exactly — comment
format `[QA n/N · Category]`, one comment per fix per file at that file's own
timecode with the variant offsets applied, whole-video items pinned at
`00:00:00:00`, red box over the caption or red line at the safe-zone limit,
naming comments carrying the full expected name ready to copy.

Keep the `n/N` numbering identical to the numbering in the run report so Mark
and the editor are reading the same list.

## Disk and cleanup

Delete each cut's downloaded media and extracted frames **as soon as that cut is
logged**, before starting the next one — not at the end of the run. One cut is
~220 MB of video plus a few hundred extracted frames; a run that holds several
at once climbs into the gigabytes for no reason, and on this container a full
disk fails writes while deletes still succeed.

Work in a per-cut directory under the session scratchpad, never in the repo, and
`rm -rf` it once the ledger row is written. If the run dies mid-cut, the next run
starts from the ledger, so nothing is lost by deleting early.

## Report back to Mark

Per cut: the verdict (ready / not ready), the fix count and the serious ones,
which files got comments, the Slack thread replied to and whether the 🔁 landed
on its parent, and the review items —
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
| 2026-10-15 | `QA NK604` | 0 full (naming only) | 3 | 0 | 0 | 0 | `at.adobe.com` denied by egress policy, so no media — no caption, VO, safe-zone or audio checks. Naming ran from API metadata: all 3 files truncated to 7 of 30 fields. Mark overrode the partial-list rule, so the naming fix went to H1/H2/H3 labelled naming-only, plus thread reply and 🔁. No ledger row — NK604 still owes a full QA. |
