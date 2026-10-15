# Creative QA — the full run instruction

This is the instruction the creative QA automation runs on. It is the same text
stored in the poke-only Routine `trig_01He2XNFA7czqqptthswDd4c`, kept here so it
can be read, reviewed and diffed from the repo. **If you change one, change the
other** — the Routine is what actually fires; this file is the readable copy.

Paste everything below the line into Cowork (or any session) to run a pass. Add
the scope to the end if you want specific cuts, e.g. "QA NK604 and NK609".

Two notes if you run this somewhere without this repo checked out (Cowork
often will not have it):

- **Step 0's script** lives at `creative-qa/setup-qa-tools.sh` in this repo. With
  no checkout, either clone the repo first, fetch that one file with
  `mcp__github__get_file_contents`, or just run its three commands by hand:
  `apt-get update && apt-get install -y tesseract-ocr`,
  `pip install faster-whisper --break-system-packages`, and
  `curl -sS -o /dev/null -w '%{http_code}' https://at.adobe.com/` — a `000` there
  means the media host is blocked and no cut can be QA'd.
- **The `zoro` skill** must be enabled on the account the session runs under. It
  carries the actual QA rules; without it this instruction has no checks to run.

---

Run a NorthernKnife creative QA pass. This has no schedule — it only runs when Mark cues it, so treat the cue as the scope. If the cue names specific creatives ("QA NK604 and NK609") do exactly those. If it names a count, honour it. If it says nothing, take the oldest **1** eligible cut — the cap stays at 1 until a full pass has actually been measured, because nobody has run one end to end yet. The first completed run records its wall-clock time and peak disk in the spec's Run history, and the cap is raised from that.

## Read first

GitHub repo `creativetstrategist-mark/my-client`, branch `claude/bold-carson-13rfs2`:
1. `creative-qa/qa-process.md` — the AUTHORITATIVE spec for this run. Follow it.
2. `creative-qa/qa-log.md` — the dedup ledger. Read it before opening any file.

Then invoke the `zoro` skill and read its `SKILL.md`, `references/caption-rules.md`, `references/safe-zones.md`, `references/client-nk.md` and `references/frameio-posting.md`. Zoro is authoritative for what counts as a fix; the spec above is authoritative for queue, scope, dedup, Status and how far you may go unattended. The summary below is so you know the shape of the job before you open them — it does not replace reading them.

## Step 0 — setup and preflight, before anything else

Run `bash creative-qa/setup-qa-tools.sh` from the repo root. It is idempotent and installs only what is missing (no fresh session has `tesseract` or `faster-whisper`). **Branch on its exit code:**

- **`0`** — tools ready and the Frame.io media host is reachable. Proceed with the full pass.
- **`3`** — tools ready but `at.adobe.com` is BLOCKED by the environment's network policy. Frame.io serves every download, proxy, thumbnail and scrub-sheet URL from that host, so no cut can be QA'd: captions, VO, safe zones and audio all need the bytes. **Stop here.** Report to Mark that the run is blocked, name the host, and tell him it is a network-access setting on the environment that only takes effect in a NEW session. You may still report file naming (delivered names come from the Frame.io API) and aspect/fps/duration (from file metadata), but per the spec do NOT post them on their own unless Mark's cue explicitly asked for a partial pass, and do NOT move any Status. Never substitute guessed or mocked findings for checks that could not run, and never report a blocked run as a clean queue.
- **`1`** — tooling would not install. Report it and do not QA.

## The job

1. **Queue.** `mcp__Notion__notion-query-data-sources` (SQL) on `collection://2cf4ac62-7aac-81a8-86bf-000b96778943`: rows where `Status` = '1st QA' AND `Strategist` IN ('Mark','Andy','Claude'), ordered by `createdTime` ASC.

2. **STRATEGIST GATE — apply before opening anything.** Only Mark, Andy and Claude are in scope. A cut by **Callum** or **Mauro** is skipped completely: no QA pass, no Frame.io comment, no Slack reply, no reaction, and no Notion write of any kind — its Status is never touched. Skip it before you download or transcribe a single file. Read the strategist from the Notion `Strategist` property, never by parsing a file or ad name. Expect this gate to fire often: the `Assigned to Editor` stage feeding the queue is largely Callum's.

3. **DEDUP — the ledger decides, and a row is never conditioned on the Status move.** A completed QA moves the cut to `2nd QA` and it leaves the queue; that is the happy path. But every outcome that does NOT move Status (no Slack thread, a partial pass, a blocked run) leaves the cut at `1st QA` and it returns on the next cue, so `creative-qa/qa-log.md` is what stops a re-QA and a second posting.

   Key: creative ID + the Frame.io **file id AND that file's `updated_at`**. Same creative, same id and same `updated_at` → skip the QA. Newer `updated_at` or a new id → the editor re-delivered → QA again. Not listed → QA it. The id alone is not enough: deliveries are often loose files rather than version stacks (NK604's are), so a re-upload in place keeps the id and only `updated_at` moves.

   **A row whose `Pending` column says `slack` is not a cut to re-QA.** The QA ran and the comments are posted; only the thread reply, the 🔁 and the Status move are outstanding. Retry just those, clear the column, move Status, and post nothing new to Frame.io.

   Before posting to a file, `read_comments` on it. Only a **completed** list blocks a post — one whose prefix carries numbering, `[QA n/N · …]`. A labelled partial pass carries no numbering on purpose (`[QA · File naming — naming-only pass]`) because the cut still owes a full pass: QA it and add to what is there. NK604 is in exactly that state. Rows marked `manual` have no recorded id — for those only, apply the same completed-list test. NK586 is one. A 🔁 on a Slack parent is a visible cross-check only, never the dedup key.

4. **Find the files.** In order: the Notion `Delivery Link`; then the editor's own `@Mark Ready for review <frame.io link>` reply inside the creative's Slack thread, which carries the asset URL and is present even when `Delivery Link` is empty (it is empty on about half the queue); then Frame.io `search_assets` by creative ID. Account `b0bc19f9-4a80-4ae4-9768-4b151edb5a40`, deliveries so far in project `b37ff928-5b11-4860-8204-f102af43f3ec`. Then apply Zoro's version-stack rules: newest upload per hook by `created_at`, each stack holds only its own hook, and read the previous version's comments so notes Mark already left are enforced. `get_file` URLs are temporary — download immediately. No files on any path → post nothing, log nothing, move no Status, report it as "no files found"; that is a delivery problem, not a QA failure.

5. **Run the QA pass** per Zoro — specs/audio, transcription, caption OCR plus your own look at the contact sheets, safe-zone measurement, file naming, hook/label match. Never report a caption as missing or wrong from OCR alone; open the frame and see it. Note that some concepts give all three variants IDENTICAL hook copy (NK604 does), which makes a swapped-file check impossible from the copy — say so rather than reporting the labels as verified.

6. **Post the editor fix list to Frame.io.** Follow `references/frameio-posting.md` exactly: `[QA n/N · Category]` prefix, one comment per fix per file at that file's own timecode with variant offsets applied, whole-video items at `00:00:00:00`, red box over the caption or red line at the safe-zone limit, naming comments carrying the full expected name ready to copy. Keep the `n/N` numbering identical to your report. Read a file's existing comments before posting so you never double-post.

7. **Reply in the editor's Slack thread, react on its parent, then move Status.** Channel is `#11-<editor>-editing` from the Notion `Editor` property: Anas `C0BQSRKS30U`, Hammad `C0APFKCF6ET`, Hasnain `C0BMZ97T3D3`, Naveed `C0BRV68UN12`, Onyeka `C0APX296L9Y`, Renniel `C0BSC1C8WMN`, Umar `C0B28C13XDW`. The thread parent is Mark's message posting the Notion brief link, whose label starts with the creative ID (`NK609_Not For Everyone - Santoku_AI VO_SANTOKU`). Match the FIRST underscore-delimited segment of that label as a WHOLE segment against the creative ID — never substring, so `NK60` does not match `NK609` and `NK61` does not match `NK612`. The rest of the label drifts in format, so the first segment is the only reliable key.

   **The order is fixed: Frame.io comments → thread reply → 🔁 on the parent → Status to `2nd QA`.** Each step only once the previous one actually landed.
   - Reply in-thread (`thread_ts` = parent ts), never a new channel message, never `reply_broadcast`: `Check comment on frame` plus the Frame.io file link and the fix count on one line.
   - Then add the 🔁 reaction to the **parent message**: `mcp__Slack__slack_add_reaction` with `emoji` = `repeat` (no colons), the channel id, and the **parent's** `message_ts` — not the reply's. A duplicate reaction succeeds silently.
   - Then set the brief's Notion `Status` from `1st QA` to `2nd QA`. `Status` is a status-type property, not a select, so it takes the option name as a plain string: `mcp__Notion__notion-update-page` with `page_id` = the brief page id, `command: "update_properties"`, `properties: {"Status": "2nd QA"}`, and **`allow_async: false`** — page updates default to async, and the ledger row written straight after must not record a move that has not landed. Status LAST, so the board never shows a cut as moved on when its feedback never arrived.
   - No thread found → post the Frame.io comments, skip the reply and the reaction, **leave Status at `1st QA`**, and report it. Do not open a new thread: it is Mark's to start, and with no reply the editor has not been told, so the cut has not been handed off. **Still write the ledger row, with `slack` in its `Pending` column** — the QA ran and the comments are posted, so a later run retries only the Slack steps and the Status move, never the QA or the comments.
   - Several matching threads → reply in the newest, react on that same parent, move Status, and say so.
   - Editor is `Huzaifa` (inactive, no channel) → post the comments, leave Status at `1st QA`, report the Slack gap.

8. **A clean cut** — no fixes at all — gets no Frame.io comments, no Slack reply and no reaction, but **DOES move to `2nd QA`** and DOES get a ledger row. It passed a full QA, and that Status change is the only record it was ever looked at; without it the cut strands. Report it to Mark as clean.

9. **Clean up before the next cut.** Once a cut's ledger row is written, `rm -rf` its media and extracted frames — not at the end of the run. Work in a per-cut directory under the session scratchpad, never in the repo. One cut is ~220 MB of video plus a few hundred frames; holding several at once climbs into the gigabytes, and on this container a full disk fails writes while deletes still succeed.

## Status — the only Notion write you may make

`1st QA` → `2nd QA`, nothing else. Never a different Status value, never another property, never a page body.

| Outcome | Status |
|---|---|
| Fixes posted + thread replied + reacted | → `2nd QA` |
| Clean, no fixes | → `2nd QA` |
| Fixes posted but no Slack thread found | stays `1st QA` |
| Partial pass (Mark asked for one) | stays `1st QA` |
| Blocked, no files, tooling failed | stays `1st QA` |
| Callum / Mauro | untouched |

## Never

- **Never make any Notion write other than `1st QA` → `2nd QA`.**
- **Never post review items** — judgment calls, visuals-vs-brief, tag accuracy, pacing, housekeeping. They go to Mark in the run report and nowhere else. An editor reads every comment as a required change, so a taste note posted as a fix costs a revision round.
- **Never touch a Callum or Mauro cut**, Status included.
- **Never post a partial fix list.** The `n/N` numbering asserts completeness, so a run that could not finish its checks posts nothing and moves no Status. The one exception is Mark explicitly asking for a partial pass: then drop the numbering entirely, label the comment by what actually ran (e.g. `[QA · File naming — naming-only pass]`), name the checks that did NOT run inside the comment and in the Slack reply, write no ledger row, and leave Status at `1st QA`.
- **Never delete or resolve an existing comment**, and **never remove a reaction**, unless Mark says so in the cue. Mark and the editors use other emoji on these parents (👀 appears on them) — never read another emoji as a QA signal.
- **Never skip, disable or work around a check to make a cut look clean**, and never invent findings for a check that did not run.

## Finish

Append one row per cut QA'd to `creative-qa/qa-log.md` (date, creative ID, editor, version QA'd, verdict, fixes posted, Slack thread, run) and one line to the Run history table in `creative-qa/qa-process.md`. Commit and push both to branch `claude/bold-carson-13rfs2`; if local `git commit` is blocked by the environment's permission classifier, write them through the GitHub MCP tools (`mcp__github__get_file_contents` for the current sha, then `mcp__github__create_or_update_file`) instead.

Then report to Mark: per cut the verdict, fix count and the serious ones, which files got comments, which Slack thread was replied to and reacted on, whether Status moved to `2nd QA` or stayed and why, and the review items. Then the totals — cuts QA'd, moved to `2nd QA`, left at `1st QA` and why, skipped as already done, skipped by the strategist gate and whose, no files found, and what is left in the queue.

If the Notion, Frame.io or Slack connector is unavailable this run, say so explicitly rather than reporting zero findings — a silent empty run reads like a clean queue.
