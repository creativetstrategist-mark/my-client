# Editor assignment on "Ready to edit" → Slack

*Verified directly against live systems on 2026-10-13: `notion-fetch` on the
Evergreen Video data source, a real `Status = 'Ready to edit'` query returning 15
rows, the live Slack channel list, and the real member IDs of all 7 active
editors. Design decisions confirmed by Mark on 2026-10-13 — see "Decisions on
record".*

Notion database: **NK Creative Strategy Lab / Video Brief Database / Evergreen Video**
Data source: `collection://2cf4ac62-7aac-81a8-86bf-000b96778943`

## What this routine does

When a brief page reaches **`Ready to edit`**, post it into that brief's
editor's own Slack channel so the editor is told it is theirs, then move the page
to **`Assigned to Editor`** so it leaves the queue.

It runs **on demand, when Mark gives a go signal** — not on a schedule. See "How
this runs" below.

This job is **already being done by hand** — Mark and Callum post brief links
into the `#11-<editor>-editing` channels manually (see the message-format section;
the format below is copied from what they already send, not invented). The
routine automates that handoff, it does not introduce a new convention.

## 🚫 Hard rule: never touch Callum's work

**Standing instruction from Mark, 2026-10-13: never touch work that has `Callum`
as Strategist.** **Restated unprompted on 2026-10-27**, mid-run, in stronger
terms: *"Never ever touch any task with callum as strategist."*

**Callum is the only exclusion. Everything else — `Andy`, `Mark`, `Mauro`,
`Claude` — is in scope.**

### 📝 The 24-hour narrowing, and why the rule reads this way again

On **2026-11-23** Mark said: *"Never touch callum or Andy's output only from
Mark"*. The scope was narrowed to an allowlist of one, the query was changed to
`"Strategist" = 'Mark'`, and the first run under it (2026-11-24) assigned
**nothing** — 15 briefs in the queue, none of Mark's.

**On 2026-11-24 he corrected it**: *"Andy is fine since I also manage that only
callum's work will never be touch"* — Mark manages Andy's output too, so Andy's
briefs are his to route. Reverted to the Callum-only rule the same day.

Two things worth keeping from the episode:

- **The reason Callum is excluded is ownership, not quality.** He is a member of
  every editor channel and does his own handoffs, so his briefs are already
  routed. Andy's are not — Mark manages them, and this play is how they move.
  That is the distinction, and it is now explicit rather than inferred.
- **One zero-assignment run was the cost of the ambiguity.** The go signal of
  2026-11-24 found 7 of Andy's briefs in the queue and assigned none of them;
  they went out later the same day once the scope was corrected. Nothing was
  lost, but it is the reason this section now states the *reason* for the
  exclusion rather than just the name.

### ✅ Settled 2026-11-24: it covers reading and reporting, not just writing

Asked whether reading one of his pages and naming it in a report counted as
touching it, Mark answered: *"This is our hard rule never touch Callum's work"*.
**No reads, and no naming his briefs as findings** — not even to flag one as
untouched. The only things that remain are reading the `Strategist` value itself
(the filter needs it) and counting his rows in this play's own bookkeeping.
Full detail, including the duplicate-ID case: *What "never touch" covers* below.

**Do not look for the edge of this rule.** It has been restated three times, and
the one time it was treated as having a readable boundary, the boundary was
wrong.

Any page with `Strategist = Callum` is out of scope for this routine
completely:

- do **not** post it to an editor,
- do **not** post it to the fallback channel,
- do **not** change its `Status`,
- do **not** edit the page,
- do **not** flag it for triage. **Restated unprompted on 2026-10-27, mid-run, in stronger
terms: *"Never ever touch any task with callum as strategist."*** He volunteered
it while a run was in flight and nothing had gone wrong, so treat it as the
rule he most wants held, not as a correction of something. It has now been
stated twice, two weeks apart.


**His rows can arrive in bulk and they can arrive with a blank `Editor`.**
That combination — his work, no editor set — is exactly the case where the
blank-editor rule would normally send a brief to Mark's fallback channel, and it
is the case this rule overrides. Take no action on any of them, including no
fallback post. **A queue with nothing in scope is a drained queue for this
play's purposes: report it as "nothing in scope" and stop there** — no count,
no IDs, no families, nothing about what is in it.

Filter on `Strategist` in the detection query itself so his page is never
even a candidate. This rule outranks every other rule in this doc, including the
blank-editor handling below. Note that Callum is a member of every editor channel and does
these handoffs himself — his briefs are his to route.

**✅ Confirmed directly on 2026-11-11.** The rows that sat in `Ready to edit`
the previous evening with a blank `Editor` were all `Assigned to Editor` by the
next morning, **with editors filled in**. Nobody from this play touched them. That is
first-hand evidence for the rule's premise rather than an assumption: leaving his
work alone does not leave it stranded.

## How this runs: on demand, on Mark's go signal

**Mark's decision, 2026-10-13: there is no scheduled Routine.** He does not have
scheduled Routines set up and does not want one here — he gives a go signal and
the sweep runs then, in a live session that already holds the Notion and Slack
connectors.

So there is no cron, no trigger, and nothing fires on its own. Nothing happens
to a brief until Mark asks. That has real consequences worth stating plainly:

- **No brief is ever announced without Mark knowing**, because he started the
  run. That is why there is no suppression list: the go-live baseline existed
  only to stop a *scheduled* first run blasting a six-day backlog at seven
  editors, which cannot happen when Mark starts every run. It was discharged on
  2026-10-13. Do not reintroduce one — a stale suppression list would silently
  skip a brief that legitimately returned to `Ready to edit` after a revision.
- **Nothing is picked up between go signals.** A brief that hits `Ready to edit`
  an hour after a run waits for the next one. That is the accepted trade for not
  having a scheduler; it is not a bug to work around with a self-scheduled
  wakeup.
- **A run is only as current as its query.** Always re-query at the start of a
  run. Never work from a brief list captured earlier in the conversation — other
  people move statuses and assign editors in Notion continuously.

### What "go" means

Unless Mark says otherwise, a go signal means: **every brief currently in
`Ready to edit` that is not Callum's and not malformed.** Report what you are
about to do and how many, then do it.

If he scopes it ("just the new ones", "only Hasnain's", "just NK612"), honour
the narrower scope and say which briefs you therefore skipped, so nothing is
silently left waiting.

### ⚠️ Slack sends need a permission decision each run

Direct Slack writes are refused by the Claude Code auto-mode classifier
(`[External System Writes]`, verified 2026-10-13). Two ways through, and Mark
picks:

1. **He allows the Slack write** — approve the prompt, or allowlist
   `mcp__Slack__slack_send_message`. Then a go signal runs start to finish
   unattended.
2. **Drafts** — `slack_send_message_draft` is not blocked. Each brief becomes a
   draft in the right channel that Mark sends with one click. Safe, but it is
   one click per brief, which for a batch of ten is most of the work.

Note a draft is **not** a post: do not flip a page's status for a draft. Flip it
only once Mark confirms the message actually went out. The safe failure is a
brief that stays in `Ready to edit`.


## 🚫 Prerequisite: editor access to the brief pages

### Current state: `Evergreen Video` is shared publicly

**Mark enabled public access on the `Evergreen Video` database on 2026-10-13**
(`2cf4ac627aac807bbd7ce549323ebde4`). Because Notion share settings inherit
downward, that covers **every brief row in it, including every brief the daily
routine creates in future** — so there is nothing to do per brief. This replaced
an earlier per-page plan, which would have meant up to 15 manual toggles a day.

### Why access was needed at all

`notion-get-users` showed **not one of the 7 active editors was a Notion user** —
no `umar@`, `hammad@`, `onyeka@`, `hasnain@`, `anas@`, `naveed2@` or `renniel@`.
The workspace held only Bryan Valeza, Callum, Damien Reymond, Kel, Mark, Nigel,
the Northern Knife account and bots (NK Automation, NK Bridge, Notion MCP,
Zapier). So brief links failed for the editors however well formed, and they
could not write `Delivery Link` back onto the page.

### ⚠️ Two things nobody has confirmed yet

**1. Is editing enabled, or is the share read-only?** Notion's "Share to web" has
a separate **"Allow editing"** toggle. Public *read* access is enough to open a
brief, but **`Delivery Link` is a page property and filling it in is a write** —
so if editing is off, editors can read their briefs and still cannot do the one
thing they are meant to do with the page. Check the toggle.

**2. Does it actually work from outside?** Verify in a **private/incognito
window, logged out**: open a brief, confirm you can read it *and* change a
property.

### ⚠️ Nothing automated can verify this — it is a human check only

Both facts above have to be checked by hand, because:

- **The Notion connector exposes no sharing or permission tool**, and a page's
  published state is not readable through it. There is no API for share-to-web at
  all, so Zapier and Notion's own automations are equally blind to it.
- **An authenticated session cannot tell the difference.** Every link opens for
  Mark whether or not the page is published, so testing from a logged-in browser
  proves nothing.
- **This environment cannot test it either** — DNS to `notion.so` and
  `app.notion.com` is blocked by the egress policy (verified 2026-10-13), so even
  an anonymous fetch from here is impossible.

So **an unpublished page, a read-only share and a malformed URL are
indistinguishable from Slack.** When an editor reports a brief they cannot open
or cannot edit, check in this order: the incognito test, then the "Allow editing"
toggle, then the `/p/` URL form.

### The lower-risk alternative, still recommended

Public sharing means anyone with the link can read and — if editing is on —
silently change a brief, with no account and no audit trail. A forwarded Slack
message or a screenshot is enough.

**Notion guests remove that without costing anything.** Guests are free (even the
free plan allows 10; paid plans 100+) and are invited **by email, so not already
being a Notion user is no barrier** — each gets a free account on accepting.
Invite all 7 on the `Video Brief Database` page
(`2cf4ac627aac80bb9f71e0542c06ef30`) with **`Can edit`**:

| Editor (Notion `Editor` option) | Invite by email |
|---|---|
| `Umar` | `umar@nebula-studio.co` |
| `Hammad` | `hammad@nebula-studio.co` |
| `Onyeka` | `onyeka@nebula-studio.co` |
| `Hasnain` | `hasnain@nebula-studio.co` |
| `Anas` | `anas@nebula-studio.co` ⚠️ not the `zoomberry.work` account |
| `Naveed` | `naveed2@nebula-studio.co` (the `2` is part of the real address) |
| `Renniel` | `renniel@nebula-studio.co` |

Emails from their Slack accounts, verified 2026-10-13. `Huzaifa` is off the
active roster and gets no invite.

Guests also fix the verification gap: **`notion-get-users` can confirm all 7
appear**, which is something no public share can offer. A guest shows up only
once they *accept*, so a missing name may mean an unaccepted invite.

Note Notion has no per-row permissions either way — all editors can see and edit
every brief in the database, not only their own.

## ⚠️ Exact option strings (do not paraphrase)

| Thing | Exact live string | Common wrong guess |
|---|---|---|
| Trigger status | `Ready to edit` | ~~`Ready to Edit`~~ — lowercase `e` on "edit" |
| Post-notify status | `Assigned to Editor` | ~~`Assigned to editor`~~ — capital `E` here |
| `Status` property type | `status` (not `select`) | — |
| `Editor` property type | `select` — bare first-name strings, **not** Notion person objects | — |

Because `Editor` is a select of bare first names, it carries no email and no
Notion user identity. The Slack destination has to come from the mapping table
below; it cannot be derived from Notion.

**The `Status` option list grew on 2026-10-19.** It now reads, in order:
`Not started` · `In progress` · `Ready for visuals` · `Ready to edit` ·
`Pending` · `Cancelled` · `Failed to import` · `Assigned to Editor` ·
**`1st QA`** · **`2nd QA`** · `Revision needed` · `Ready to Upload` ·
`Uploaded on Drive`. The two QA stages are new and `Assigned to Editor` moved
earlier in the order. **Neither string this play depends on changed**, so the
play is unaffected — but the post-editor workflow has gained two stages, which
someone decided outside this spec. Re-read the live option list rather than
trusting this one if a status write ever fails.

## Detection query

```sql
SELECT "Creative ID", "Concept Name", "Product", "Content", "Editor",
       "Status", "Strategist", "Format", "Offer", url, createdTime
FROM "collection://2cf4ac62-7aac-81a8-86bf-000b96778943"
WHERE "Status" = 'Ready to edit'
  AND ("Strategist" IS NULL OR "Strategist" != 'Callum')
ORDER BY createdTime ASC
```

Bind values as `?` parameters rather than inlining them. Sort **ascending** so
the longest-waiting brief is announced first.

### 🚨 The SQL/rows query allowance can run out mid-day — use the saved view, with a cross-check

On 2026-11-11 the opening query failed with **`usage_limit_reached`**: the
workspace's Query Data Source allowance for **SQL and rows mode** was spent, and
the error said it resets within 60 minutes. **View mode still worked.** This will
recur, so here is the fallback, in order:

1. **Fetch the database** (`2cf4ac627aac807bbd7ce549323ebde4`) to list its saved
   views. `fetch` is a different operation and is not covered by that allowance.
2. **Use the `Ready to Edit` view: `view://3b84ac62-7aac-801a-8a3a-000c79fafc7e`.**
   Its saved filter is exactly `Status is "Ready to edit"`, and view mode returns
   **all properties**, not just the view's `displayProperties` — so `Creative ID`,
   `Editor`, `Strategist` and `url` all come back and the run can proceed normally.

**⚠️ But that view has a blind spot you must cover.** It is a **board grouped by
`Editor` with `hideEmptyGroups: true`**, so **a brief with a blank `Editor` is
hidden from it entirely**. That is precisely the case the blank-editor rule exists
for, so the view alone is not a safe detection query. On 2026-11-11 it returned 6
rows and silently omitted a dozen out-of-scope rows that all had a blank `Editor`.

3. **Cross-check with the `In Progress` table view**
   (`view://2fe4ac62-7aac-8072-8273-000c75d5dd3e`). It is a *table*, so it cannot
   hide rows for an unset grouping property, and its filter already includes
   `Ready to edit`. It returns far more than you need and **its result will exceed
   the tool output limit**, so do not read it inline: the error saves the full
   result to a file, and `python3 -I` with `json.loads` over that file filters it
   to `Status == "Ready to edit"` in one step. Sorted by `Creative ID` descending,
   its first page of 100 spanned NK835 down to NK689, which covered everything
   plausible.

Together the two give a complete read: the board covers every Creative ID but
hides blank-`Editor` rows; the table covers every editor but only the top 100 IDs.
If they disagree, trust the union and investigate.

**⚠️ Update, 2026-11-24 — the blind spot did not reproduce, so keep the
cross-check anyway.** The allowance ran out a second time and the same fallback
was used. This time **the board returned blank-`Editor` rows**: the out-of-scope rows
and NK989–991, none of which has an `Editor`. The table cross-check agreed
exactly — **20 rows, same IDs, both reads**. So the `hideEmptyGroups` behaviour
is **not reliable in either direction**: it hid 12 rows on 2026-11-11 and hid
none on 2026-11-24. Do not conclude from one clean run that the board is safe.
**Run both every time the fallback is used**, and note that the table's output
still exceeds the tool limit, so filter the saved file with `python3 -I` as
described above.

### ⚠️ Re-run this query at the END of the run too, not just the start

The closing query is not only a confirmation that the queue drained. **A brief
can enter `Ready to edit` while the run is in flight**, and the same go signal
covers it. On 2026-10-26 (second run that day) the opening query returned 7
actionable briefs; the closing query returned **NK708 "Ladies This Year -
Blackout"** as well. NK708 was created 2026-10-25, *earlier* than briefs the
opening query did return, so it was not a sort or pagination miss — its status
was moved to `Ready to edit` during the ~25 minutes the run took.

**Mark himself was the one moving it.** He said so in the same session: *"Renniel
can handle now so I assigned some task to him."* So the mid-run arrival is not
only an Andy-writes-live hazard — Mark loads the queue during a run too, as
editor capacity frees up. Do not assume the opening query is the whole batch, and
do not guess who changed a brief: the first read attributed NK708 to Andy and was
wrong.

So the closing query has two jobs: confirm the briefs just posted have left the
queue, and pick up anything that arrived mid-run. Gate and assign the new
arrivals in the same run rather than leaving them for the next go signal — they
were in `Ready to edit` when Mark said go, by the time anyone looked.

Expect the closing query to show only out-of-scope rows and nothing else.
Anything in scope is either a brief that failed to flip (check it) or a mid-run
arrival (assign it).

**Get the page ID from the query, never by construction.** NK708's ID was
guessed on the first attempt at fetching it and the fetch 404'd. The `url`
column in the detection query is the only source for it — add the `/p/` and use
that.

## 🛑 A hold instruction in the brief body overrides its own `Ready to edit` status

**Observed 2026-10-27 on NK680 "A Knife - Feather (Street Interview)".** Its
`Status` was `Ready to edit` — the status this whole play keys on — while its
Creative Brief Instruction said, in bold:

> **Script still in progress. Do not shoot or cut until Status moves.**

The page contradicts itself. Posting it would have told Renniel to start work the
brief explicitly forbids, and flipping it to `Assigned to Editor` would have been
worse than useless: the note's own condition is *"until Status moves"*, so the
flip would have appeared to satisfy the hold without the script being finished.

**Rule: do not post and do not flip. Leave it in `Ready to edit` and report it.**
This is the same safe-failure principle as the editor mismatch — the harmless
outcome is a brief that waits, and the harmful one is an editor cutting a script
that is still being written. It does not need Mark's go signal to be re-run later;
the next run picks it up once the body no longer says to hold, or once Mark says
to send it anyway.

**How the hold ends: Mark says so, explicitly, naming the brief.** On 2026-11-04,
after NK680 had been held and reported on three consecutive runs, Mark wrote
*"Assign the NK680 to editor."* The page was re-read first and was **still
unchanged** — `page_last_edited_at` 2026-10-27, script note intact — so this was
a knowing override, not a lifted hold, and that distinction is what made it
actionable: he had seen the flag three times and named the brief anyway.

Two things that are **not** the end of a hold: a general go signal ("assign task
due on friday" does not reach a held brief), and an availability note about its
editor (see the capacity-signal rule above — that was the same brief, the same
day). It takes the brief named, or the note gone from the page.

**When released under override, tell the editor the note is superseded.** The
brief still says *"Do not shoot or cut until Status moves"*, and Renniel would
open it and read a direct contradiction of having just been handed it. Flipping
the status does satisfy the note's literal condition, but he should not have to
work that out. The thread reply sent was: the line is superseded, Mark has
cleared it, check with him or Andy before shooting if anything in the script
reads unfinished. Send that instead of the usual bare due-date reply, or
alongside it.

**What counts as a hold:** an instruction in the brief telling the editor not to
start, not to shoot, not to cut, or to wait for something. Read the Creative
Brief Instruction block for one on every run — it sits above the HOOK table, in
the same place as the other shoot directions, and is easy to skim past. It will
not be in any property.

## 🧭 "X can do a task now" is a capacity signal — it is not a hold-lift and not a reassignment

**Observed 2026-11-04.** Mark wrote, twice, mid-run: *"Renniel can do task now so you
can send any task assignment to him."* At that moment the only brief with
`Editor = Renniel` was **NK680, held since 2026-10-27** because its body says
*"Script still in progress. Do not shoot or cut until Status moves."*

Two different things were being confused, and both answers are no:

1. **It does not lift the hold.** NK680 is blocked because Andy has not finished
   the script, not because Renniel was busy. Freeing the editor does not finish
   the script. The page was unchanged in the intervening week
   (`page_last_edited_at` still 2026-10-27), which confirms it.
2. **It does not authorise moving someone else's brief to him.** The other
   briefs in that batch were Hammad's, Umar's and Onyeka's — and the editor name
   is baked into the Batch name and every File naming row. Sending Hammad's brief
   to Renniel would have Renniel naming every delivered file `_Hammad_`. That is
   exactly the failure the pre-send gate exists to prevent, and it is the half of
   the mismatch Mark called out on 2026-10-13 as the worse one.

**So: say what the capacity signal can and cannot do, and ask.** Report which
briefs are actually his, why a held one is still held, and that moving a brief to
him needs the `Editor` property and the naming strings changed first — by Mark or
Andy, in Notion, not by this play. Do not reroute on a verbal availability note,
and do not treat it as new information about a script.

This generalises to any editor: an availability message changes who *could* take
work, never what the page says.

## 🚦 Pre-send gate: the naming convention's editor must match the `Editor` property

**Mark's standing instruction, 2026-10-13. Applies to every batch from now on.**

Before posting a brief and before flipping its status, confirm the editor baked
into the page's **naming-convention strings** is the same person as the `Editor`
property. If they disagree, **stop on that brief** — see below.

### Why this matters

The editor's name is written into the `Batch name` row and into every
`File naming` row (`H1`, `H2`, `H3`). Those strings are what the editor names
their delivered files with. So a mismatch does real damage either way:

- Route by the `Editor` property → the right person gets it and names every file
  with **someone else's name**, which breaks the downstream file convention and
  any reporting that parses it.
- Route by the naming string → the **wrong person** gets the brief, and the
  `Editor` property that everything else reads from is wrong.

Neither is recoverable after the fact without a re-edit, which is why this is a
blocking gate rather than a warning.

### How to read the editor out of the string

Example (NK601, verified live 2026-10-13):

```
NK601_VID_AI-VO_Worth The Money_H1_A_LOKI Blackout_MIKE_B2G2_Adapt_Andy_Hammad_6r-Blackout_10.08.26_…
                                                                     ^^^^  ^^^^^^
                                                                 Strategist  Editor
```

**Anchor on the `Strategist` property value, and take the next underscore
segment.** That is far more robust than a fixed index: the editor happens to sit
at position 12 in every page checked so far, but concept names vary in length and
naming series have historically shifted segment positions (see the strategist
parsing warning in `weekly-winner-check/winner-detection-process.md`).

Then **validate the candidate against the 8 valid `Editor` option strings**
(`Hasnain` · `Renniel` · `Umar` · `Hammad` · `Onyeka` · `Anas` · `Naveed` ·
`Huzaifa`). Anything else means the parse went wrong, not that a new editor
exists.

Check **the `Batch name` row and all three `File naming` rows**. They can
disagree with each other as well as with the property — a hook variant edited by
hand is an easy place for a stale name to survive.

### On any mismatch: stop on that brief

- **Do not post it.** Do not flip its status.
- **Do not pick a winner.** The `Editor` property is not automatically right, and
  neither is the string. Only Mark can say which was intended.
- **Report it to Mark** with the Creative ID, both names, and which rows
  disagree.
- Carry on with the rest of the batch — one bad brief does not hold up the
  others.

Treat an editor segment you cannot locate, or one that is not a valid option
string, exactly the same way: stop and report. Never post a brief whose editor
you could not verify.

### 🚨 First real gate failure: an unreplaced `EDITOR` placeholder (NK795, 2026-11-09)

The gate ran from 2026-10-13 and passed every brief — roughly a hundred of them —
until **NK795 "Lucky Day Mastermind Black Friday (NK401 x NK222) - Blackout"**.
Its `Editor` property said `Anas`, its Batch name said `Andy_Anas`, its H2 and H3
file-naming rows said `Andy_Anas`, and its **H1 row said `Andy_EDITOR`** — the
template placeholder, never substituted.

**A placeholder is a gate failure, even though it names nobody.** It is tempting
to wave through, because there is no competing name and therefore no doubt about
who the editor is: three of four strings and the property all say Anas. But the
gate exists to stop a bad string reaching the file names, and `EDITOR` is a bad
string. Posted as-is, Anas delivers `NK795_..._Andy_EDITOR_6r-General_...` into
Frame.io and the Drive, and somebody has to find it later. So it was held: not
posted, not flipped, left in `Ready to edit`.

**What to do with one.** Report it and say plainly that the correct value is not
in doubt — that is what makes it different from a two-names-disagree mismatch,
where guessing is genuinely unsafe. Do not fix it unilaterally (the standing rule
is to leave the strategist's page alone), but do offer the fix, because it is a
single token and the brief is otherwise ready. **Mark's answer on 2026-11-09 was
"fix and assign"**, so: edit that one row, **re-read the page to confirm all four
strings now match**, then post, thread and flip as normal. The re-read is worth
the call on a brief that just failed the gate.

**Watch for the sibling pattern.** NK795's three sister briefs (NK793, NK794 and
NK792) all had their editor slots filled correctly, so this was one row in one
brief rather than a batch-wide template problem. Still, when a placeholder turns
up, check the rest of that batch before assuming it is isolated — these briefs
are built from one template and the same slot can go unfilled more than once.

### ⚠️ Only the editor slot is checked

The body strings use abbreviated forms and **already drift from the properties in
other slots** — this is normal and must not be "fixed" or treated as a mismatch:

| Slot | Batch name | Property |
|---|---|---|
| Category | `Adapt` | `Net New` |
| Avatar | `MIKE` | `MIKE- BBQ KING` |
| Product | `BJORN Santoku` | `LOKI Blackout` / `SANTOKU` |
| Landing page | `6r-Blackout` | `6 Reasons - General` |

Mark asked for the **editor** check specifically. Do not widen it.

### Cost of this gate

The naming strings live in the page **body**, not in a property, so this requires
a **full page fetch per brief** — the detection query cannot see them. At 15
briefs a batch that is 15 page reads, each returning the whole brief. That is the
price of the check; do not skip it to save calls, and do not try to infer the
editor from anything cheaper.

### Verified: all 11 of the 2026-10-13 batch match

Swept on Mark's request after the gate was written. Every brief's Batch name and
all three File naming rows agree with the `Editor` property:

| Brief | String (`…_Strategist_Editor_…`) | `Editor` property |
|---|---|---|
| NK584 | `Mark_Onyeka` | Onyeka ✅ |
| NK599 | `Andy_Umar` | Umar ✅ |
| NK601 | `Andy_Hammad` | Hammad ✅ |
| NK603 | `Mark_Anas` | Anas ✅ |
| NK604 | `Mark_Hammad` | Hammad ✅ |
| NK606 | `Mark_Hasnain` | Hasnain ✅ |
| NK607 | `Mark_Naveed` | Naveed ✅ |
| NK609 | `Mark_Hammad` | Hammad ✅ |
| NK610 | `Mark_Onyeka` | Onyeka ✅ |
| NK612 | `Mark_Hasnain` | Hasnain ✅ |
| NK613 | `Mark_Hammad` | Hammad ✅ |

So the gate found no editor mismatches in this batch — but see below for what it
did find.

### 💡 The gate reads the whole brief anyway, so look at the copy too

The check needs a full page fetch, which means the script is in front of you for
free. The 2026-10-13 sweep caught a product-accuracy error no editor check would
have:

- **NK599 says "copper bolster" twice.** The BJORN Santoku's bolster is
  **brass** (`brand-pack/01-brand/product-catalog.md`, and CLAUDE.md's hard
  rules). NK603, NK606 and NK609 all say brass correctly, so it is an isolated
  slip, not a changed fact. Reported to Mark; it was already with Umar.
- **NK599 also says "Rosewood handle"** for the Santoku. Rosewood is the
  **Feather's** handle; the Santoku is "hand-carved wooden" and the other three
  Santoku cuts name no wood. Likely a Feather attribute leaking across.

Both are `Strategist = Andy` briefs, written outside the daily routine's own
voice checks.

The 2026-10-19 sweep of 7 Santoku briefs found the brass fix holding — every
brief that names the metal says brass — but two more copy issues:

- **NK650 says "those \$300 Japanese knives."** CLAUDE.md's Santoku rule is
  absolute: *never reference Japanese origins or use the word "Japanese."* This
  is a competitor comparison rather than a claim about our own knife, which is
  probably why it slipped through, but the rule has no such exception, and
  NK656/NK662 both carry it as an explicit hard refusal. `Strategist = Andy`.
- **NK647 and NK650 both say "rosewood handle"** for the Santoku — the same
  Feather attribute that leaked into NK599 above. Two of seven, so this is
  drifting rather than isolated. Both `Strategist = Andy`.

Posted and flipped anyway: the gate is the editor slot only, and nothing here
stops an editor cutting the video. Flagged to Mark instead.

**Invented numbers are worth flagging too, and Mark acts on them.** NK646 said
"three times the control of a normal handle" — a multiplier with nothing behind
it, and pseudo-spec of the kind C.1 bans. Mark had it changed to "That's control
you don't get from a normal handle": same comparison beat, no fabricated figure.
So when reading the copy, watch for a quantified claim that is not one of the
real company facts (the \$ prices, 100,000 customers, 5,000+ five-star reviews,
the 30 days, the Feather's ~500-unit runs and ~3-month restock).

**If a fix lands on a brief already handed out, tell the editor in its thread.**
A silent script change wastes whatever they have already voiced. One line naming
the new wording, in the existing thread — not a new channel post.

**A cross-reference list inside a brief is a claim to check, not a work order.**
NK657 and NK663 both state that "black right through" appears in NK607, NK610,
NK613 and NK622. On 2026-10-20 Mark asked for all four fixed. Three carried it
— NK607 as "all the way through — blade, ebony handle, the whole knife", NK613
and NK622 as the literal phrase. **NK610 did not**: it says "Same steel, same
build, same everything. The finish is the only thing that changed", which is the
careful version. Had the list been taken at face value, NK610 would have been
edited for a line it does not contain. Read the page before acting on another
page's claim about it.

**The play is not limited to the 3 focus products.** On 2026-10-21 three
**Rolling Knife Sharpener** briefs came through (NK664/665/666, `DANA - KNIFE
SHARPENER`, `6 Reasons - Sharpener`, offer `40% + Free Gifts`). CLAUDE.md scopes
the *daily rewriting routine* to the Feather, Santoku and Blackout — that is
about which briefs get **written**, not which get **handed to an editor**. Any
brief in `Ready to edit` that is not Callum's and not malformed gets assigned,
whatever the product. Assigned, and flagged to Mark as the first time.

**⚠️ The copy check is weaker outside the 3 focus products.** On those briefs
the read is internal consistency only — say so rather than implying the same
level of check.

**⚠️⚠️ And `brand-pack/` is not in this repo at all.** CLAUDE.md calls
`brand-pack/START-HERE.md` the entry point and
`brand-pack/05-process/creative-brief-process.md` "the single most important
file", with Section C as the copy-voice rulebook and Section D/D0 as the
authoritative Notion template. **Neither path exists in the working tree.** It
was committed once (`1abce45`) and is gone from HEAD. So every copy check in
this play actually runs against two things only: CLAUDE.md's own summary table
of hard rules, and `brand-accuracy/santoku-bolster-discrepancy.md`. The banned
spec-jargon list, the substitution table, the hook patterns and the originality
gate are all cited by CLAUDE.md but not readable here. Report a copy read as
based on CLAUDE.md, not on the brand pack, and raise the missing directory with
Mark rather than quietly working around it.

**A pipe in the `Concept Name` is safe in the link.** NK653 and NK654 are
`3 Months to Make | Feather (NK133)` and `What if | CTA | Feather (NK184)`.
Slack's `<url|label>` takes everything after the **first** pipe as the label, so
the internal pipes stay literal and the link still works — verified by reading
`#11-onyeka-editing` back after sending. Send them as they are; do not escape or
strip the pipes.

**`Content` is not always `AI VO`.** NK658/659/660 are `B-Roll`, and the link
text takes `Content` straight from the property, so it reads `..._B-Roll_...`
with no special handling. A B-Roll brief carries no script, so there is nothing
to copy-check on one — say that rather than implying a clean read.

**Five values seen so far**, all passed through verbatim into the link label and
none needing special handling: `AI VO`, `B-Roll` (NK658/659/660), `Street
Interview` (NK680), `AI VO ASMR` (2026-11-04) and `AI VO Whisper` (NK765,
2026-11-05). Treat a new value as normal, not as a malformed row.

**Check how widespread a line is before calling it a violation.** On
2026-10-20 NK637's lineup beat was flagged for "Sixty-seven layers of Damascus
steel and a hammer finish" as a banned material count. Mark had it fixed, and
only then did a sweep show the same figure in **9 other briefs, every one
`Uploaded on Drive`** — NK088, NK116, NK238, NK307/308/309, NK316/317/318,
across Mark's and Claude's briefs since June. That is not a slip, it is the
ODIN line's established descriptor, which makes it a question for the
strategist rather than a finding. **Frequency is the test**: NK646's "three
times the control" appeared once and was invented; this appeared 10 times over
5 months. Sweep the corpus first, and when reporting, say how many briefs carry
it and how many are produced.

**Keyword search cannot prove the absence of a phrase.** Notion's search is
keyword, not exact-phrase, and it matches stop words, so a sweep for a wording
returns mostly noise and cannot confirm a clean corpus. Same limit as the copper
sweep. Say what was checked, not that nothing remains.

**⚠️ "Japanese" is all over the sharpener line, and CLAUDE.md bans the word.**
On 2026-10-27 six Rolling Knife Sharpener briefs came through and **four of them
use it**: NK691, NK692 (twice), NK694 and NK695, always in the same beat —
*"fifteen degrees for Japanese knives, twenty for Western"* — plus NK692's
*"It works on every knife you own. Japanese, Western, …"*. Two more reach for
the same register without the word: NK693's *"a literal samurai sword"* and
NK695's *"samurai-sword sharp"*.

Why this is a question and not a clean finding:

- CLAUDE.md states the rule inside the **BJORN Santoku** row — *"Never reference
  Japanese origins or use the word 'Japanese'"* — and gives the reason as
  "santoku is a Japanese-origin knife shape but the brand never says so". So the
  rule's *purpose* is plainly about not calling **our** knives Japanese.
- Every sharpener use is about **the customer's own knives**, as a sharpening-angle
  convention. None of them claims an NK product is Japanese.
- But the second clause as written — "or use the word" — is unconditional, and
  these are about to be filmed.
- **Frequency says it is the line's established copy**, not a slip: 4 of 6 briefs,
  one concept family, consistent phrasing.
- **And yet the compliant alternative already exists in the same batch**: NK688
  says *"holds the knife at 15 or 20 degrees"* and never names a nationality.
  That asymmetry is the argument for fixing it — the house already has a neutral
  form.

**This needs Mark's ruling, not a unilateral fix.** Either the ban is
product-scoped (then the sharpener copy is fine as written and this stops being
raised every run), or it is literal (then 5 lines across 4 briefs need NK688's
wording before filming, and the shipped sharpener corpus should be swept). Do
not rewrite them in the meantime, and do not keep re-flagging it run after run
once he has ruled — record the ruling here.

**🔑 2026-11-09, the strongest evidence yet, and it points at "literal":
Andy now writes the ban into his own briefs, word for word.** NK790 and NK794
both carry the instruction *"Never say 'etched', 'Japanese' or 'Japan'"* in their
Creative Brief Instruction block. He is not treating it as a paraphrase of a
positioning preference — he is naming the two strings.

Read it precisely, though: both are **Santoku** briefs, where nobody disputes the
ban applies. So this does not by itself settle whether the *sharpener* line's
angle convention is covered. What it does establish is that (a) the author of the
sharpener copy treats the word itself, not just the claim, as the thing to avoid,
and (b) there is now a written in-brief form of the rule to point at when asking.
That makes the ask easier: show Mark NK790's line and ask whether it should extend
to the sharpener briefs, where nine instances are still live.

**Updated count, 2026-11-09: thirteen instances across twelve briefs.** The
second sharpener run that day added four more — NK796, NK798, NK799 and NK806 all
carry *"fifteen degrees for Japanese knives, twenty for Western"*. NK767, NK797
and NK807 do not use the beat at all (NK807 uses the four-grit framing instead),
which keeps showing that the line is skippable without losing the ad. The running
total is now large enough that a ruling saves more work than it costs.

**Updated count, 2026-11-05: nine instances across eight briefs.** Five more
sharpener briefs came through and **four of them carry the same beat** — NK762,
NK763, NK764 and NK766 all say *"fifteen degrees for Japanese knives, twenty for
Western"*. **NK765 is the exception and uses NK688's neutral form** (*"15 or 20
degrees"*), which it inherited from NK688 directly. So the split is now 8 briefs
using the word against 2 avoiding it, across two separate batches a week apart,
and the neutral form keeps appearing in exactly the briefs derived from NK688.
This strengthens both readings at once — it is unmistakably the line's house copy,
and the house already has a compliant version of it. Still Mark's ruling.

**Watch: Andy's standing production rules land in the editor channels, not here.**
On 2026-10-27 at 15:54 he posted to `#11-umar-editing` with `@channel`:
*"do not use any footage from Trybe creators on your ads ever"*. Nothing in that
day's briefs referenced Trybe, so there was no conflict, but a brief that
specifies footage from a banned source is now worth flagging. Reading the channel
back after posting is the only way this play sees such a notice.

**⚠️ A factual claim about the real world is a different class of flag.**
NK670 "Laughed Off Shark Tank" (2026-10-27) is a founder-story brief whose three
hooks and body all turn on **"the sharks laughed him off Shark Tank"**. That is a
specific, checkable claim about an appearance on a named television programme,
not a voice or material question, and it carries advertising-claim and
platform-policy risk that no amount of copy judgement settles.

Two things pull in opposite directions, and both belong in the report:

- The reference ad it follows beat for beat is **Hatori's own Shark Tank founder
  story**. CLAUDE.md's rule is that *the mechanic transfers, the words never do* —
  and a biography beat is not a mechanic. A Shark Tank appearance carried over
  from the reference would be exactly the failure that rule exists to prevent.
- But **the brief's `Strategist` is Andy and the founder in the story is Andy**.
  The person who wrote it is the person it is about, which is the strongest
  possible authority for a claim about his own history.

So do not call it fabricated and do not call it verified. Report that it cannot
be checked from here, name why it is worth checking anyway, and let Mark confirm.
The same treatment applies to the brief's other unverifiable specifics: *"more
than five thousand five-star reviews"*, and the accusations that competitors
*"paid for reviews calling hand-forged a gimmick"* and *"leaned on shops to keep
it off the shelf"* — the latter are claims about named-by-implication third
parties in a paid ad.

**The house already has a clean solution to the "etched" problem.** NK680 carries
a production note: **"Never say how the pattern gets on the blade."** That is the
compliant way to handle the Feather's laser-applied pattern — say nothing about
how it is applied rather than reaching for a verb. Worth proposing as the standing
answer the next time an "etched" flag comes up.

**⚠️ "Etched" is not confined to unproduced briefs — it is in shipped winners, and
on 2026-11-05 it reached a new placement.** NK782 (a re-cut of **NK184**, a US+AU
winner) and NK787 (a re-cut of **NK133**) both say the Feather's pattern is
*"etched"*, because both source winners do. NK569 flagged the NK184 line as
non-compliant on 2026-09-14; NK653 and NK654 inherited it on 2026-10-26; now the
same line is being carried onto **AppLovin**. The pattern is **laser-applied** —
a CLAUDE.md hard rule by name. This has the same shape as the weight claim and
rosewood-on-Santoku: fixing the re-cuts one at a time does not help, because
every future re-cut inherits the winner's VO. The decision Mark actually has to
make is about the source winners. NK771's *"Never say how the Feather's pattern
is made"* is the clean answer whenever one is wanted.

**📌 The NK579 weight claim is systemic in the Feather corpus, not a recurring slip.**
Running count of briefs carrying it, all Andy's, all caught by this play:
NK645 (2026-10-21), NK653 (10-26), NK687 (10-26), NK679 (11-04, **fixed on
Mark's instruction**), NK720 (11-04), NK724 (11-04). That is six in three weeks,
and two of them surfaced in the same hour Mark ordered the NK679 fix. The wording
drifts — *"the lightest knife in the range"*, *"the lightest knife you'll ever
hold"*, *"the lightest knife we make"*, *"the lightest, sharpest knife he will
ever hold"* — so a sweep must search **`lightest`**, not a phrase. Stop treating
each one as a fresh discovery: report it as the known systemic line, name the
count, and ask whether to fix the whole set in one pass rather than brief by
brief.

**The NK679 fix, for reuse:** *"Rosewood, not plastic. The lightest knife in the
range, and it holds its edge for years instead of months."* → *"Rosewood, not
plastic. And it holds its edge for years instead of months."* Drop the weight
clause, keep the edge-retention clause, which already uses CLAUDE.md's approved
*holds that edge* phrasing. Same shape as the NK599 and NK637 fixes: remove the
banned claim, leave the sentence standing.

**✅ Andy has adopted the "never say how the pattern is made" solution.** NK771's
Creative Brief Instruction states it as a rule — *"Never say how the Feather's
pattern is made"* — alongside *"No review counts on screen"* and *"Offer visuals
show four knives, never a Buy 1 Get 1 screen"*. NK680 carried the same note as a
per-row direction. **NK771 also names the bolster as brass** (*"a dragon sculpted
into the brass bolster"*), the first brief in this play's history to get the
material explicitly right. Cite NK771 as the model when reporting the others:
the house knows the compliant form, it is just not applied evenly. **But the same
batch also carried the opposite**: NK724 reproduces NK654's *"no two are ever
exactly the same. Because no two hands hammer the same way"* word for word, which
attributes the laser-applied pattern to hand-work. Both postures, one batch, one
strategist.

**The customer count has two live values.** NK720 says *"Over a hundred thousand
people"*; NK775, in the same batch and both Black Friday, says *"over 147,000
people cook with Northern Knife"*. Every earlier brief says a hundred thousand.
Either 147,000 is the current figure and the rest are stale, or it is invented —
this is a question for Mark, not a finding, but it cannot be both.

**An offer percentage that is not a real tier is a hard flag.** NK731 says
*"Buy 2 Get 2 Free, up to 67% off"*. The `Offer` property's own option list is
`B2G1, B2G2, 64%OFF, 56%OFF, NA, B1G1, 40% + Free Gifts` — **there is no 67%
tier**; the nearest real one is 64%. CLAUDE.md's rule is that only real offers
exist and none may be invented, and here the schema itself enumerates what is
real, so this is checkable rather than a judgement call. Check any percentage in
copy against that option list.

**📌 Rosewood-on-Santoku is now systemic too, and worse than the weight claim.**
On 2026-11-04 five Santoku briefs came through and **all five** give the Santoku
a rosewood handle: NK721, NK725, NK770, NK773, NK776. Five of five. The catalog
gives rosewood to the **Feather** and calls the Santoku's handle "hand-carved
wooden", naming no wood; the house pattern (NK603/606/609) is "carved by hand"
with nothing after it. Earlier unproduced instances: NK698 and NK709
(2026-10-27). That is **seven unproduced briefs** against the ~7 shipped ones
already recorded in `brand-accuracy/santoku-bolster-discrepancy.md`.

**It is in the production direction, not just the VO.** NK770's Creative Brief
Instruction says *"Show the engravings, the dragon on the bolster and the
rosewood handle"*; NK776 repeats it in its persona note **and** its instruction
**and** its body. So the editor is told to shoot a rosewood handle on a knife
that does not have one. Checking only the Copy column misses this — read the
instruction block and the persona note too.

**The mechanism is visible: Santoku briefs are derived from the Feather ones by
find-and-replace.** NK720 (Feather) says *"High-carbon steel, full tang, rosewood
handle"* — correct. NK721 (Santoku) reuses the sentence verbatim, where it is
wrong. NK721 also leaves a stray *"then the Feather"* in a Visual cell. Handle
and bolster materials are exactly what does not survive that copy, so when a
sibling pair appears, diff the product beats specifically.

**Brass is winning, but not uniformly.** Of the same five, **four say brass**
(NK725, NK770, NK773, NK776) and **one says copper** (NK721). NK771 said brass
too. So the copper error is no longer the default — it is now the exception, and
worth reporting as progress alongside the flag.

**📺 AppLovin is a new placement and it carries a hard format spec.** On
2026-11-05 five briefs came through for **AppLovin** (NK782, NK783, NK785, NK786,
NK787) and the format is tighter than anything else in the corpus: **strictly
under 60 seconds**, **9:16 at 1080x1920**, and every one is a **re-cut of an
already-shipped winner** rather than a new script. The briefs state the runtime
as a requirement, and one records a rejection — **NK146 was turned down at 61
seconds**, one second over. So on an AppLovin brief the runtime is pass/fail, not
guidance. Read the brief's own runtime note before posting rather than assuming
the editor will catch it, and expect the copy flags on these to be inherited from
the source winner rather than newly written (see the "etched" note above).

**Three smaller findings from the 2026-11-05 batches, none of them gate failures:**

- **"Batman" has become the Blackout's standard descriptor.** NK769 and NK777
  both reach for it for the all-black LOKI. It is a trademarked character name
  used as a comparison rather than a product claim, and its consistency across
  two briefs makes it house copy rather than a slip — worth one line to Mark as
  a legal and tone call, not a copy fix.
- **The AppLovin briefs carry a generic three-persona template that contradicts
  their own `Avatar` property.** Each names MIKE, SARAH and VANCE in the body
  template while the page's `Avatar` property names a single persona. The editor
  works from the page, so they see both; it reads like a template header that was
  never trimmed per brief.
- **NK769 contains unhandled profanity in the VO** — no bleep, mute or
  on-screen-text instruction anywhere in the brief, where every other brief that
  reaches for strong language says how to treat it. That leaves Hammad to decide,
  which is the wrong person to be deciding it.

**🔑 The most useful finding so far: Andy now writes a rule block into his briefs,
and what it covers is now clean while what it omits still slips.** As of
2026-11-09 most briefs carry an explicit instruction list — *"Dragon on the
Santoku only, never on the Tiger Cleaver"*, *"Never say 'etched', 'Japanese' or
'Japan'"*, *"No review count or star rating on screen"*, *"No 'free returns'
anywhere"*, *"Offer visuals show four knives, never a Buy 1 Get 1 screen"*. In the
15-brief run that day, **every rule on that list held**. Not one brief said
"etched"; not one said "Japanese" outside the sharpener line; dragon placement was
correct everywhere.

**The two errors that persist are exactly the two the block does not name:** the
Santoku's **handle material** and its **bolster metal**. NK790 said *"copper
bolster"* twice, and NK794 said *"a rosewood handle"* twice — both in briefs whose
own rule block bans "etched" and "Japanese". So this is no longer a story about
Andy not knowing the rules. It is a gap in a checklist that otherwise works.

**The recommendation, and it is cheap:** ask Andy to add two lines to his standard
block — *"The Santoku's bolster is brass, never copper"* and *"The Santoku's handle
is hand-carved wood — never rosewood, which is the Feather's"*. On the evidence of
this run those two lines would close both long-running systemic errors at the
source, which is better than this play catching them brief by brief forever.

**Good news in the same run: the find-and-replace mechanism is being addressed.**
NK791, NK792, NK794 and NK795 each carry an explicit *"Sister briefs: ... Same
idea, different words, do not copy their lines"* warning, and the sibling briefs
genuinely do differ. **NK790 (Santoku) and NK791 (Feather) are the first
Feather/Santoku sibling pair with no rosewood leak** — NK791 says "a rosewood
handle fitted by hand" correctly and NK790 does not mention a handle at all. Also
worth citing: **NK793 annotates every deviation from its source winner** in the
Note column (*"Changed: opener is in the handle"*, *"Changed: no dragon, no bolster
on this knife"*, *"Changed: Black Friday, customer count added, 'free returns'
removed"*). That is the practice that would have prevented the AppLovin "etched"
inheritance.

**✅ The customer count is settled at 147,000.** The 2026-11-04 fork (100,000 vs
147,000) resolves: **seven briefs on 2026-11-09 all say 147,000**, five of them
with an explicit on-screen instruction *"Super: OVER 147,000 CUSTOMERS"*. A figure
Andy directs onto the screen as a super is the approved one. Treat 100,000 as the
superseded figure and stop raising the fork.

**🔎 "Lifetime warranty" is a new recurring claim worth one question.** It appears
in **all seven** Lucky Day / Return Box briefs on 2026-11-09, rendered as an
on-screen badge beside the 30-day money-back and free-shipping badges, and phrased
variously (*"Lifetime warranty on all four"*, *"Every one covered for the lifetime
of the knife"*). The 30-day return is long-established; a lifetime warranty is not
something this play had seen before. Its consistency says it is a real company
term rather than an invented one, so this is a confirm-once question, not a flag —
but it is a warranty promise going on screen, so it is worth confirming once.

**🚨 Profanity in a hook, not just a body (NK779).** Its H2 reads *"This guy is a
fucking bollocks"*, with no bleep, mute or on-screen-text instruction anywhere in
the brief. This is the NK769 problem escalated: in a hook it is the first three
seconds of a Meta ad, which is a platform-policy exposure rather than a taste
question. H1 also calls the customer *"this dummy"*. Hammad gets it, and he hit
the same gap on NK769 — so he is now twice the person left deciding how to handle
strong language. Raise it as needing a standing rule, not a per-brief judgement.

**🔁 The real-b-roll vs Higgsfield contradiction recurs (NK779).** Its instruction
says *"Real b-roll only from the Frame.io library"* while its first body row says
*"Generate image of box of blackout box with the note"* with the Note *"use
higgsfield"*. That is the **third and fourth** instance after NK679 and NK778 on
2026-11-04 — and all of them are Hammad's. The editor cannot satisfy both.

**⚠️ A production-time claim that distorts a documented fact (NK793).** It says
the Feather is *"Three months in the workshop, one blacksmith per blade"*.
CLAUDE.md documents a **~3-month restock cycle** and ~500-unit drops — an interval
between drops, not the time one knife spends being made. The brief turns a supply
fact into a craft claim. Worth a line because it is the kind of detail that reads
as a specific, checkable boast.

**📌 The UGC "Husband Obsession" set (NK800–NK805) is the weakest work this play
has seen, and the problems are template-level.** Six briefs, two creators (Briana,
Tina) × three products, one shared script:

- **An invented multiplier in all six**: *"they are five times sharper than average
  knives"*. This is precisely the NK646 *"three times the control"* class that Mark
  ordered fixed on 2026-10-20. Six briefs, one fix.
- **Santoku attributes on the Feather (NK800, NK804)**: both say the Feather has
  *"a dragon sculpted into the bolster, a hand-carved handle"*. That is the BJORN
  Santoku's spec. **This is the leak running the other way** — every previous case
  was Feather→Santoku (rosewood); here the Santoku version is the template and its
  features were left on the Feather cuts. NK801/NK803 (Blackout) *did* get a correct
  swap (*"full tang handle, unique finger loop technology"*), so the Feather pair is
  the miss.
- **The identical offer paragraph across product versions in one batch**, which
  CLAUDE.md bans by name. NK800, NK802, NK804 and NK805 all close with the same
  words, down to *"So you can get the Bjorn Santoku completely for free"* — which on
  NK802 and NK805 offers the Santoku free on a brief whose hero product *is* the
  Santoku.
- **The offer is the last beat with nothing after it.** All six are `Off-Late` and
  the offer is item #3 of a 3-item listicle. CLAUDE.md's rule is that the offer
  lands ~60–80% through, never last, followed by 2–4 more beats.
- **The address flips mid-ad.** The hooks speak to the wife (*"why your husband
  will be obsessed"*); the body then speaks to the husband (*"Cutting through your
  wife's watch?"*). `Avatar` is SARAH throughout.
- Softer: *"This is the most versatile knife money can buy"* and *"He will never
  need to buy another knife again"* are unfalsifiable superlatives, and all six
  carry `Specialty` = **"Genralist"** (misspelled) and no `Date` value.

Because these six share one script, **the whole set is one editing pass for Andy,
not six.** That is the useful framing for the report.

**⚠️ A footage source that does not exist yet (NK792, NK795).** Both point the
editor at *"NK168 and NK779 folders"* for Blackout b-roll — but **NK779 was
assigned in this same run** and has not been cut. NK792 is **Fahad's first brief**,
so the one person least able to know that a named folder is empty is the one being
sent to it. Worth a line whenever a brief cites a sibling still in production.

**✅ Correction worth carrying forward: "new editor" meant new to this play, not
new to the team.** On 2026-11-09 Waheed and Fahad were described in the first
report as brand-new, and an onboarding gap was raised on that basis. **NK807's own
red callout contradicts it**: *"rebuild the whole video as an AI mashup like all
the other ads you've done for us"*, addressed to Waheed by name. So Andy treats
him as an experienced hand with prior delivered work; what was new was his
appearance in the `Editor` property and his Slack channel. Do not infer a person's
tenure from their absence from the mapping table — the table tracks this play's
coverage, not the roster.

**⚠️ The sharpener's own stage architecture is described two different ways inside
one batch.** In the 2026-11-09 sharpener run, NK796, NK798, NK799 and NK806 all
describe **a two-sided diamond roller (#400 and #1000) plus ceramic and jade
polishing discs**. **NK807 describes four discs and labels them #400, #1000,
#6000 and #10000** — grit numbers in place of the ceramic/jade naming — and adds a
Visual annotation mapping grit to physical disc position (*"#400 is the 2nd disc,
#1000 is the 1st disc"*) that runs against its own VO line *"Start with the 400
diamond disc"*. The two accounts may be reconcilable (ceramic ≈ #6000, jade ≈
#10000), but **no brief reconciles them**, and one editor now holds both. Flag it
as a question for Andy: which naming does the product actually ship with, and
which should be on screen. A new-to-the-play editor has no basis to choose.

**⚠️ Day-bound urgency on `Evergreen` inventory — three briefs, one batch.** The
batch-name field reads `Evergreen` (not a dated campaign) on NK797, NK799 and
NK806, yet each carries a deadline or stock claim that is only true on one day:

- **NK797** supers **"ENDS TONIGHT 🚨"** on all three hooks and closes *"the sale
  ends tonight, so don't sleep on it."*
- **NK799** twice makes the free discs conditional on *"if you order today"*.
- **NK806** has the narrator say *"I checked their site yesterday and it's almost
  gone again"* — a stock level asserted as a fact he personally verified.

An evergreen ad runs for weeks, so each of these is false on most days it serves.
That is an advertising-claim exposure rather than a voice question, and it is
visible from the brief's own metadata, which is what makes it worth raising:
the `Evergreen` tag and the copy contradict each other on the same page. Worth
asking Mark whether these should run dated, or whether the urgency lines should
go.

**⚠️ NK797's "Triple Discount" counts a warranty as a discount.** Its three
"discounts" are 40% off (a real discount), the two free discs (a gift — the
`Offer` property calls the whole thing `40% + Free Gifts`), and *"your third
discount is the lifetime warranty"*. A warranty is not a price reduction, so the
offer is described as three discounts when the property itself names two
components. Same family as the NK731 "up to 67% off" flag: the copy overstates
the offer structure relative to the `Offer` property.

**⚠️ Category disparagement stated as fact (NK806).** *"Pull-through sharpeners
don't work, they ruin your knife."* That is a flat factual claim about a
competing product category, stronger than NK692's *"Regular sharpeners stop at
#1000 grit"* and in the same class. NK799 shows the softer form in the same batch
(*"the pull-through sharpener chewed them up"* as the customer's own experience),
which is the version to point at if a fix is wanted.

**🔁 The overstock premise is borrowed, not invented — which changes the flag.**
NK665 was flagged on 2026-10-21 for inventing an overstock reason for a discount.
NK796 reveals the lineage: it is an iteration of **NK383**, which is itself built
from a **Hatori Knives** ad whose line was *"We over-ordered. Badly."* So the
premise is a competitor's mechanic carried across, and CLAUDE.md's rule is that
the mechanic transfers but a business-fact premise is not a mechanic — the same
reasoning as the NK670 Shark Tank flag. The question for Mark is not "did someone
make this up" but "is the warehouse actually overstocked", because the ad asserts
it as fact three times.

**🔑🔑 The "10 Hooks" format multiplies every copy flag by ten, and it is the new
reason the locked-winner question has to be answered.** On 2026-11-10 four briefs
arrived in a shape this play had not seen: **NK808, NK809, NK810, NK811 each carry
10 hook lines against one LOCKED body**, with the instruction *"Body: do not change
a word"* and *"Deliver 10 files, H1 to H10"*. Forty deliverables from four briefs.
All four gate-passed with exact H1–H10 file-naming rows, which is a real
improvement on NK702/NK703 — the mechanics are right. The problem is what the
locked bodies contain:

- **The NK184 body (NK808, NK809) says *"A full feather etched from tip to
  handle"*** and *"no two are ever exactly the same. Because no two hands hammer
  the same way"*. Both are the banned attribution: the pattern is laser-applied.
  **20 deliverables.** "Etched" also appears in the Visual direction (*"Macro of
  the etched feather"*), so it is in the shot list as well as the VO.
- **The NK168 body (NK810, NK811) says *"Free returns, free shipping"*** — the
  exact phrase NK793/NK794/NK795 banned by name a day earlier (*"No 'free returns'
  anywhere"*) — and *"100,000 customers"*, the figure superseded by 147,000.
  **20 deliverables.**

Two useful details for the decision. **The NK168 body is clean on "etched"**: it
calls the Feather *"our sculpted, hand-forged blade"*, which is a compliant
alternative sitting in a shipped winner. So the two locked winners have different
defects, and one already demonstrates the fix for the other. And **the new hook
lines add claims of their own**: NK808's H4 (*"tell which blacksmith made your
knife just by looking at it"*) and NK809's H7 (*"built by one man, with one hammer.
And nobody has made another one like it since"*) both reinforce the hand-made
pattern error that the body states, so fixing the body alone would leave the hooks
contradicting it.

**Why this changes the priority.** Until now "etched in a shipped winner" cost one
ad per re-cut. The 10-hook format makes the locked body a template that stamps the
defect ten times per brief, indefinitely, on `Evergreen`. Report it that way: not
"another etched flag" but "the locked bodies need a one-time fix before the next
10-hook brief, and there will be more".

**📌 Where "up to 67% off" comes from, and why it is worse than a typo.** NK731 was
flagged on 2026-11-04 for an offer percentage that is not one of the `Offer`
property's real tiers (64% and 56%). The 2026-11-10 Multi batch explains it:
**NK728 "Six Seven - Black Friday" is built entirely on the "six seven" meme**, and
its own AD INSPO says so — *"built around the 'six seven' meme (67% off)"* — while a
hook line reads *"Our brain-rotted intern told us if we put Sixxx Sevenn percent
off for Black Friday it would work."* So **67% was picked for the meme, not
calculated from a price.** It now appears in **six briefs** (NK731, NK726, NK727,
NK728, NK729, NK730), and three of them instruct a **"67%" super on screen**. A
discount percentage chosen for its meme value and supered on screen is a different
class of problem from a copy slip; it is the single most repeated unverified number
in the corpus. NK728 even jokes about the Damascus layer count matching (*"Sixx
Seveenn again. Coincidence? Yes, it's just the steel name"*).

**✅ Andy already has a profanity-handling template — which is what makes the
unhandled cases omissions rather than policy.** NK722 H1 (*"BLACK FRIDAY IS LIVE,
BITCHE\$%!"*) and NK727 H3 (*"...BITCHESS"*) both carry an explicit Note — *"Bleep
the word, censor it on screen"* — and both briefs repeat it in the Creative Brief
Instruction (*"The profanity in H1 is bleeped and censored on screen"*). That is
the handled form, and it is the thing to point at.

**🚨 Against that template, NK810's H7 is the worst unhandled line in the corpus:
*"NorthernKnife, you can suck my balls."*** It is a customer voice note in a
**hook**, on an `Evergreen` brief set to **`Mkt-All`**, with detailed production
direction for that hook (second voice, phone-memo quality, waveform on screen) and
**no censor instruction at all**. The running list is now NK769, NK779, NK796 and
NK810, against handled instances in NK722 and NK727 — so the gap is not that Andy
does not do it, it is that it is not systematic. Useful for triage: **H7 is 1 of
10 hooks**, so the fix is one line and the other nine are unaffected.

**🕐 A brief that sits in the queue decays, and this batch proves it.** NK722–NK730
were written 28–30 Oct and sat for 11–13 days. They carry the facts of that date:
**NK730 says "more than a hundred thousand people"** where the 9 Nov briefs say
147,000, and **NK722 is the batch's only "copper bolster"** while NK723, NK726,
NK727 and NK728 all say brass. So when a stale brief surfaces, expect its figures
to be a version behind, and check the recurring numbers against the newest briefs
rather than assuming a fresh error. This also means **a long queue wait is itself a
copy risk**, worth saying to Mark when a batch has been waiting.

**⚠️ The Multi set disagrees with itself about whether Black Friday has started.**
NK722 opens *"BLACK FRIDAY IS LIVE"* and NK726 *"BLACK FRIDAY is on"*, while NK727
answers the objection *"I'll wait until Black Friday"* and NK728 says *"we'll be
sold out before Black Friday even gets here"*, and NK730's whole premise is *"Our
Black Friday sale is live a month early"*. Four editors are cutting these at once,
so contradictory claims will run simultaneously. Not a copy error in any single
brief — a set-level inconsistency only visible across the batch, which is exactly
what this play is positioned to catch.

**📌 The Damascus layer count is back, seven times.** "Sixty-seven layers" appears
in NK722, NK723, NK726, NK727, NK728, NK729 and NK730. Mark had it removed from
NK637 on 2026-10-21, and the sweep then found it in 9 shipped briefs, leaving the
question open: banned brand-wide, or approved ODIN copy. **It has since been
written into seven more briefs**, so the open question is actively costing work.
NK728 treats it as the product's name (*"it's just the steel name"*), which is the
argument for approving it.

**⚠️ A gender threat escalated past what Mark cleared.** On 2026-10-20 Mark let
NK644's *"you need a new wife"* stand, explicitly as a one-off and not a standing
ruling. **NK722 and NK728 both now say *"tell her if she doesn't come home with one
of these, you're leaving"***, which is a step beyond. Both cite the same R2B8 top
spender. Worth raising as the escalation it is — and note that **NK723 and NK729,
the SARAH-persona briefs from the same family, carry no threat at all**, so the
mechanic demonstrably works without it. The threat tracks the VANCE persona.

**📝 Smaller, from the same run:** NK722 has **4 hooks but only 3 file-naming rows
and an instruction to "ship all three"**, where NK727 in the same batch has 4 hooks
and 4 matching rows — so NK722's fourth hook is an orphan (out of gate scope, but
the editor has to guess). The Visual cells repeatedly say **"bottle opener tip"**
(NK704, NK722, NK726, NK727, NK728) while every VO correctly says *handle* —
ambiguous shot direction on a hard product rule. **NK727 and NK730 state the
three-month figure correctly as *batch* production time**, which is the phrasing to
point at against NK793's *"three months in the workshop"*. NK810/NK811 name an
**"ODIN Chef Knife"**, which is not in the `Product` option list. And three briefs
(NK723, NK729, NK730) have `Category` = "Iteration" with the `Iteration` checkbox
unticked — harmless alone, but it breaks any filter built on either field.

**🔑 Correction to the 2026-11-09 recommendation: the Santoku handle rule must say
"name no wood", not "never rosewood".** Yesterday's note proposed adding *"never
rosewood, which is the Feather's"* to Andy's rule block. **NK813 and NK816 show
why that would not have worked: both call the Santoku's handle *ebony*** — twice
each, in the VO and in the production direction. Ebony is the **LOKI Blackout's**
handle. So the Santoku's handle slot does not attract rosewood specifically; it
attracts whichever other product's wood is nearest to hand. The catalog names no
wood for it ("hand-carved wooden"), and the clean briefs (NK790, NK792) name none
either. **The rule line should therefore be: *the BJORN Santoku's handle is
hand-carved wood — name no wood at all*.** That covers rosewood, ebony and the next
one. Running tally of wrong woods on the Santoku: rosewood in NK698, NK709, NK721,
NK725, NK770, NK773, NK776, NK794 and NK780; **ebony in NK813 and NK816**.

**✅ Andy has written the answer to the false-urgency problem himself — quote it
back to him.** The 2026-11-09 flag was three sharpener briefs putting a one-day
deadline on `Evergreen` inventory. **NK813 does the opposite, explicitly**:

> *"And to everyone who hasn't bought yet, here's the truth. This price isn't
> going anywhere before Christmas. The sale runs right up to it. **We're not going
> to pretend it ends sooner to rush you.**"*

and then pivots to the scarcity that is actually true:

> *"The knives are what's running out... **The sale will still be live. The shelf
> won't.**"*

That is the model answer, in the brand's own voice, by the same author. When
raising NK797/NK799/NK806, show them NK813 rather than proposing wording.

**⚠️ A named third-party product is destroyed on camera, and the footage already
exists.** NK813 and NK816 both use a Frame.io clip of the Santoku **cutting
through an Apple Watch**, and in NK816 it is the hero proof beat: *"Wasn't sure if
it was sharp. Tried it on **her** Apple Watch. It's sharp."* Two separate problems
worth separating when you report it: a trademarked product shown being destroyed
in a paid ad, and — on a brief whose `Avatar` is SARAH, the wife who is the buyer —
the gag being that he ruined *her* property. The same "cut the wife's watch" joke
is in the NK800–805 UGC set, so it is recurring, and the clip's existence means it
will keep being reached for.

**🚩 NK816 carries both halves of the gender-line escalation in one brief.** Its H2
is *"if your wife doesn't get you this for Christmas, you need a new wife"* — the
NK644 line **verbatim**, which Mark cleared on 2026-10-20 explicitly as a one-off
and not a standing ruling — and its close is *"tell her you're leaving if she
doesn't get you one of these"*, the escalation also in NK722 and NK728. So the
2026-11-10 count is three briefs with the leaving threat, one of which also revives
the cleared line. The sharpest framing for Mark: **NK816's `Avatar` is SARAH**, so
an ad built for the wife persona instructs men to threaten to leave her.

**🔁 Briefs are now citing footage from briefs that have not been cut — second
instance.** NK816's footage note says to build it *"mostly from the Tina and Briana
creator footage, the Husband Obsession Santoku shoots (NK805 Tina, NK802
Briana)"* — both assigned on 2026-11-09 and unproduced. NK792 and NK795 did the
same with NK779 the day before. It is becoming a pattern as the corpus
cross-references itself, and it lands hardest on whoever is newest. Worth one line
whenever a brief names a sibling still in production.

**🚨🚨 The gender ultimatum has moved into the hooks, and it is the thing to settle
first.** The trajectory is now documented across four weeks and it goes one
direction only:

| | Where it sits | Brief |
|---|---|---|
| 2026-10-20 | **body** — *"you need a new wife"* | NK644 (Mark cleared it, explicitly as a one-off and **not** a standing ruling) |
| 2026-11-10 | **close** — *"tell her... you're leaving"* | NK722, NK728 |
| 2026-11-10 | **H2 + close** — the cleared line revived, plus the escalation | NK816 |
| 2026-11-11 | **H2 + H3 + close** | **NK817** |

**NK817 is the furthest it has gone.** Its H2 is *"if she asks what you want for
Christmas and you don't say this, you're not a real man"*; its **H3 is *"Send this
to your wife. Tell her: Christmas, done. If you don't get me this, I'm leaving."***;
its close is *"tell her you're moving out if there isn't one under the tree."* So
the ultimatum is now the ad's **opening line**, on `Mkt-All`, on a brief whose
`Avatar` is **SARAH — the wife**. An ad built for the wife persona opens by telling
men to threaten to leave her.

**The pattern that makes this easy to act on: it tracks the male narrator
perfectly.** Every brief carrying the ultimatum is male-VO (`Voice-AI-M`), and
**every female-VO brief in the same two concept families is clean** — NK812, NK814
and NK815 carry no ultimatum at all and lose nothing for it. NK815 is the direct
counterpart to NK817, same concept, same offer, female narrator, no threat. So
this is not "the mechanic needs it"; it is a register that attaches to one voice
choice. One ruling on the male-VO variants would cover it.

**⚠️ "Etched" is no longer only inherited — Andy is now typing it into new briefs.**
Yesterday's note said the fix was about the locked source winners. **NK815,
written 2026-11-10 from scratch, says *"a full feather etched from tip to
handle"*** — NK184's exact wording, in a brief with no locked body. So fixing the
winners is necessary but not sufficient: the phrase has entered the active
vocabulary. Counter-evidence worth having: **NK689 adapts the same NK184 script to
the sharpener and drops the feather content entirely**, so the script is
adaptable without carrying the word.

**🔁 The Apple Watch gag hardened from a joke into a proof beat — and the dates
show it.** Earliest instance, **NK690 (24 Oct), declines it**: *"Your wife's Apple
Watch? Okay, maybe not that one."* The newest, **NK816 and NK817 (10 Nov), perform
it**: *"Tried it on her Apple Watch. It's sharp."* NK813 uses it too. Four briefs,
and a dedicated Frame.io clip of the knife cutting the watch now exists, so it
will keep being reached for. Two separate problems: a trademarked product
destroyed in a paid ad, and — on SARAH-avatar briefs — the gag being that he ruined
*her* property. **NK817 also cites two different clip IDs for the same beat** (one
in the Visual cell, another in the Note), so the editor cannot tell which.

**✅ Correction to a prediction I made: the ebony error has no sibling source.** The
2026-11-10 note suggested NK813/NK816's *"ebony handle"* on the Santoku might have
leaked from a Blackout sibling, where ebony is correct. **It did not** — NK814 and
NK817, both LOKI Blackout briefs from the same families, **never mention ebony at
all**. So it is a straight misremembering, not a find-and-replace artifact. That
reinforces rather than weakens the recommendation: the rule has to be *name no
wood on the Santoku*, because the wrong wood is not arriving from a predictable
place.

**📌 The sharpener's time-to-sharp now has four different values.** Consolidating,
because it is no longer worth reporting one at a time: *"about a minute"*
(NK692), *"a few minutes"* (NK691, NK694, NK695, NK767, NK796), *"under five
minutes"* (NK688, NK807, NK690), and now **"In a minute" / "Sixty seconds"**
(NK689) — the most aggressive yet, and NK689 and NK690 were written the same day
with different answers. One number needs picking.

**⚠️ NK690 invents a pricing mistake as its premise.** The whole ad says the offer
is an error NK is honouring: *"Our new intern just ticked the wrong box, and the
wrong offer went live"*, *"They were meant to be sold on their own"*, *"we're
letting it slide"*, *"Once this batch is gone, the discs go back to being paid. No
exceptions."* But the free discs are the **standing, official offer** — the `Offer`
property is `40% + Free Gifts` and it appears that way in NK767, NK796–799, NK806
and NK807. So the ad invents an accident about a promotion that is simply normal.
Same family as the NK665/NK383 overstock premise, but a fake *accident* rather
than a fake deadline — and this one also promises a withdrawal that is not real.

**⚠️ NK689 escalates the industry-conspiracy framing into its hook.** H3 is *"What
if the knife industry made dull knives on purpose"*, and the body adds *"the knife
industry knew that, and built a business on you not knowing it"* and *"they made
fixing it hard on purpose"*. That is an intentional-deception allegation about a
whole industry, stronger than NK184's *"has been lying to us"*, and it is the
first thing the viewer hears.

**⚠️ A food-safety claim about competitors (NK815).** *"No coating, no paint,
nothing to flake off into the food. Just forged steel. Safe for the whole
family."* The structural beat is inherited from the HexClad reference, but the
specific implication — that other knives shed coating into food — is a new safety
assertion about competing products. Different class from a voice flag.

**This is not a licence to rewrite copy.** Flag what you see to Mark and leave
the page alone — the brief is the strategist's work. But a hard product rule
broken in a brief that is about to be filmed is worth one line in the run
summary, and the hard rules are in CLAUDE.md and the product catalog.

## ✅ `Waheed` and `Fahad` — resolved 2026-11-09

The gap opened on 2026-11-04, when the `Editor` option list grew from 8 names to
10 and neither new name had a channel. It closed on 2026-11-09, the first run in
which either appeared as a brief's `Editor`: Mark mentioned mid-run that "we have
2 new editors", and both channels were found to exist with this session already a
member of them. They are in the mapping table below.

| Editor | Channel | Channel ID |
|---|---|---|
| `Waheed` | `#11-waheed-editing` | `C0CEJBP4MQC` |
| `Fahad` | `#11-fahad-editing` | `C0CENMTDF9C` |

**How they were verified, which is the method to reuse.** `slack_list_user_channels`
with `name_prefix: "11-"` returns every `#11-*` channel this session can see, with
IDs — 17 of them, including the two new ones. That is a direct read, not an
inference from the naming pattern, so it satisfies the "never guess a channel"
rule. Note that **`slack_search_channels` found nothing** for `editing` or `11`
(semantic search is disabled on this account and these channels are private), so
the search tool is not the way to do this — use the list tool.

Both posts landed first time, which confirms write access as well as membership.

**That listing also shows five `#11-*-editing` channels with no `Editor` option**
(`jason`, `khizra`, `shafaq`, `saad`, plus `andy-editing-trial`) and two archived
ones (`ahmad`, `sviatoslav`). So the channel list is not a roster — it runs ahead
of and behind the Notion option list in both directions. Do not infer that a
channel's existence means that person is an assignable editor, and keep driving
assignment off the `Editor` property.

**The rule that still stands:** if a *future* new name appears with no channel in
that listing, do not guess one. Send the brief to Mark's fallback channel as
needing a channel confirmed and leave its status alone.

## ✅ `Ali` and `Abdul` — resolved 2026-11-23, and the reason verification is not a formality

The gap opened on 2026-11-23, when the `Editor` option list grew from 11 names to
13. Flagged the same day, before either name reached a brief.

| Editor | Channel | Channel ID |
|---|---|---|
| `Ali` | `#11-ali-editing` | `C0CJ8LNCDLP` |
| `Abdul` | `#11-abdul-editing` | `C0CJTPM5E4U` |

Both verified by `slack_list_user_channels` with `name_prefix: "11-"`, the method
the Waheed/Fahad section sets out. This session is already a member of both.

### 🚨 Mark supplied two IDs and neither was right

Asked for the mapping, Mark gave **`C0D4MN8PQR1` for Ali and `C0D5RT2WXY3` for
Abdul**. The listing shows the channels exist, with exactly the expected names —
**but at different IDs**. Neither of the supplied strings appears anywhere in the
workspace listing, active or archived.

Two things made it worth checking rather than writing straight into the table:

- **Every real channel ID in this workspace begins `C09`, `C0A`, `C0B` or `C0C`.**
  Both supplied IDs begin `C0D`, outside the range the workspace has issued.
- **Their shape reads as placeholder text** — `MN8PQR1` and `RT2WXY3` are
  keyboard-adjacent runs, not the random mix real IDs have (`C0CJ8LNCDLP`,
  `C0CJTPM5E4U`).

So the supplied values were not used. **The channels in the table above are the
listed ones.**

### Why this matters more than it looks

A wrong channel ID is the one error in this play that **fails silently in the
worst direction**. The post succeeds — Slack accepts any channel this session can
write to — the brief flips to `Assigned to Editor`, and it leaves the queue. The
editor never sees it, nobody is waiting on a missing message, and the brief looks
done. Compare the documented failure modes: a blank editor, a name/property
mismatch and a malformed row all **stop** the brief, which is recoverable. A
wrong ID *completes* it, wrongly.

**That is the whole reason the never-guess rule exists, and this is the first time
it caught something.** It also extends the rule, because the rule as written only
covered guessing:

> **A channel ID is verified against a live listing before use, whatever its
> source — including Mark.** Not because the source is unreliable, but because an
> ID is 11 characters with no redundancy: a typo, a stale copy or a value from
> another workspace all look exactly like a valid one, and the failure is
> invisible. Verification costs one tool call.

If a supplied ID and the listing disagree, **the listing wins and the difference
is reported** — the supplied value may be a channel in another workspace, or the
person may be reading from somewhere this play cannot see, and that is worth
knowing either way.

### Current state of the channel list

The 2026-11-23 listing shows **17 active `#11-*` channels and 2 archived**. Six
active ones still have no `Editor` option (`jason`, `khizra`, `shafaq`, `saad`,
`andy-editing-trial`, and `mark` itself as the fallback), and `Huzaifa` remains an
`Editor` option with no channel and off the roster. The two lists still run ahead
of and behind each other in both directions, so **assignment keeps driving off the
`Editor` property**, never off the channel list.

## Editor → Slack mapping (verified live 2026-10-13)

Channel IDs are used rather than `#names` because a renamed channel keeps its
ID. Member IDs are recorded for the optional `@`-mention (see "Message format" —
off by default, since Mark's own posts carry none); a plain `@firstname` string
does not reliably notify, so the ID is the thing to keep.

| Editor (Notion option) | Slack channel | Channel ID | Member ID for @-mention | Account used |
|---|---|---|---|---|
| `Umar` | `#11-umar-editing` | `C0B28C13XDW` | `U0B17QTTMRR` | umar@nebula-studio.co |
| `Hammad` | `#11-hammad-editing` | `C0APFKCF6ET` | `U0ADU723N7M` | hammad@nebula-studio.co |
| `Onyeka` | `#11-onyeka-editing` | `C0APX296L9Y` | `U0AQV2XKK5X` | onyeka@nebula-studio.co |
| `Hasnain` | `#11-hasnain-editing` | `C0BMZ97T3D3` | `U0BMUAWCEG5` | hasnain@nebula-studio.co |
| `Anas` | `#11-anas-editing` | `C0BQSRKS30U` | `U0BRQ3YNNB1` | anas@nebula-studio.co ⚠️ |
| `Naveed` | `#11-naveed-editing` | `C0BRV68UN12` | `U0BS68YP8MU` | naveed2@nebula-studio.co |
| `Renniel` | `#11-renniel-editing` | `C0BSC1C8WMN` | `U0BUKU9GDM5` | renniel@nebula-studio.co ⚠️ |
| `Waheed` | `#11-waheed-editing` | `C0CEJBP4MQC` | — not looked up — | — (verified 2026-11-09) |
| `Fahad` | `#11-fahad-editing` | `C0CENMTDF9C` | — not looked up — | — (verified 2026-11-09) |
| `Ali` | `#11-ali-editing` | `C0CJ8LNCDLP` | — not looked up — | — (verified 2026-11-23) |
| `Abdul` | `#11-abdul-editing` | `C0CJTPM5E4U` | — not looked up — | — (verified 2026-11-23) |
| ~~`Huzaifa`~~ | — none — | — | — | ~~off roster, never assign~~ — **✅ removed from the `Editor` property 2026-11-23; the edge case can no longer occur** |
| _fallback (exceptions)_ | `#11-mark` | `C09QUL7S3GA` | `U0A127WHE9M` (Mark) | — |

### ⚠️ Two editors have duplicate Slack accounts

Both were resolved by checking who actually talks in that editor's own channel,
not by guessing from the name:

- **Anas** — two accounts exist: `Anas` / `anas@zoomberry.work` / `U0BQHRXQKJP`,
  and `Muhammad Anas` / `anas@nebula-studio.co` / `U0BRQ3YNNB1`. **Use
  `U0BRQ3YNNB1`** — that is the account posting "you can assign me new tasks" in
  `#11-anas-editing` (2026-09-28, 2026-10-02, 2026-10-12). The `zoomberry.work`
  account is a different person or an old external account; never mention it.
- **Renniel** — two accounts exist: `Renniel` / `renniel@nebula-studio.co` /
  `U0BUKU9GDM5`, and `Renniel Anenias` / `aneniasrenniel40@gmail.com` /
  `U0BRFMN7KKQ`. **Use `U0BUKU9GDM5`** — both Mark and Andy mention that ID in
  `#11-renniel-editing`, and Renniel replies from the nebula-studio address. The
  gmail account appears to predate onboarding.

If either editor stops responding to mentions, re-check this before assuming
they are ignoring the brief.

### Editor channels are not private to the editor

Each `#11-<editor>-editing` channel also contains Andy, Damien, Callum and Nigel
alongside Mark and the editor. Posts are management-visible by design — that is
the existing convention, not a leak. Do not post anything into them you would
not want the whole team to read.

There are also `#11-jason-editing`, `#11-khizra-editing`, `#11-shafaq-editing`,
`#11-saad-editing` and `#11-andy-editing-trial` channels for people who are **not**
options in the Notion `Editor` property. They are outside this routine. Never
post to a channel just because its name resembles an editor's — only the eight
rows in the table above are valid destinations.

## Message format

**Standing instruction from Mark, 2026-10-13: copy the way he already messages.**
Do not invent a format, and do not add fields he does not send.

Mark's real messages are a single **bold linked line** — nothing else. The link
text is the brief's identity; the link target is that brief's own Notion page:

```
**<PAGE_URL|NK###_Concept Name_Content_Product>**
```

A real example, built from live row NK612:

```
**<https://app.notion.com/p/3f84ac627aac819683b3d3321994ea35|NK612_4 Ways To Get It Wrong - Santoku_AI VO_SANTOKU>**
```

…which renders in Slack as one bold clickable line:
**NK612_4 Ways To Get It Wrong - Santoku_AI VO_SANTOKU**

### ⚠️ Use `**double asterisks**` for bold, not Slack's single `*`

**This is the one thing most likely to be got wrong, and it was got wrong on the
first live test (2026-10-13).**

The Slack MCP tools (`slack_send_message`, `slack_send_message_draft`) take
**standard Markdown**, not Slack's native mrkdwn, and convert it on the way out.
So the asterisk convention is the opposite of what a Slack message's raw source
looks like:

| You write | Slack receives | Renders as |
|---|---|---|
| `*text*` | `_text_` | *italic* ❌ |
| `**text**` | `*text*` | **bold** ✅ |

Reading an existing Slack message shows `*<url\|label>*` — single asterisks —
because that is Slack's *stored* mrkdwn. Copying that into the tool produces
italic. Both renders are visible in `#11-onyeka-editing` from the first test:
the 05:32 message is italic (written `*…*`), the 05:34 one is correctly bold
(written `**…**`).

The `<url|label>` masked-link syntax **does** pass straight through and needs no
conversion — only the bold markers differ. Do not "fix" the link syntax to
Markdown's `[label](url)`; the `<url|label>` form is verified working.

Verified against his own posts in the editor channels, e.g.
`NK581_Wish You Had Two_AI-VO_LOKI Blackout` in `#11-hasnain-editing` and
`NK583_Stop Sawing_UGC_BJORN Santoku` in `#11-anas-editing`.

### Building the link text

Four fields joined by underscores, each taken **verbatim from that page's own
properties** — never retyped from memory, never translated into a friendlier
name:

| Slot | Source property | Example |
|---|---|---|
| `NK###` | `Creative ID` | `NK612` |
| Concept Name | `Concept Name` (title) | `4 Ways To Get It Wrong - Santoku` |
| Content | `Content` | `AI VO` · `UGC` · `Mashup` |
| Product | `Product` | `SANTOKU` · `LOKI Blackout` · `Feather` |

The real corpus is **inconsistent** in two places, and that is fine — do not try
to normalise it, and do not treat the variation as a bug to fix:

- `Content` appears as both `AI VO` and `AI-VO` in hand-typed messages.
- `Product` appears as both the Notion option (`SANTOKU`) and the friendly name
  (`BJORN Santoku`).

Taking both verbatim from the properties keeps every message traceable back to
its row, which is what matters. Pick the property value, not the prettier one.

### The embedded link

The whole point of the message is that the link goes to **that specific brief's
page**:

### ⚠️ The SQL `url` column is NOT a usable link — add `/p/`

**Got this wrong on the 2026-10-13 backlog run; all 10 links were malformed.**

The detection query's `url` column returns a form with **no `/p/` segment**:

| Source | Form |
|---|---|
| SQL `url` column | `https://app.notion.com/3f84ac62…` ❌ |
| `notion-fetch` canonical `url` | `https://app.notion.com/p/3f84ac62…` ✅ |
| Mark's hand-posted "Copy link" | `https://app.notion.com/p/northernknife/<slug>-<id>?v=…&source=copy_link` ✅ |

Both Mark's and Callum's working links carry `/p/`. **Take the 32-hex page id
from the query's `url` and emit `https://app.notion.com/p/<id>`.** That is
deterministic and needs no extra fetch per page. The `?v=…&source=copy_link`
tail is not needed — it is masked behind the link text anyway.

- Use **that row's own** id. Never reuse the URL from a neighbouring row — the
  three products of one concept are three separate pages with near-identical
  titles, so a copy-paste slip sends an editor to the wrong brief's script with
  nothing in the message looking wrong.
- Never paste the SQL `url` value straight into a message.
- Always use Slack's `<url|label>` masked-link syntax so the line renders as the
  brief's name. A bare pasted URL is not the house format.

### Optional: @-mention the editor

Mark's own messages carry **no** `@`-mention — the channel has one editor in it,
so the post is already unambiguous. Callum's Claude-sent messages do add one
(`<@U0BMUAWCEG5|Hasnain Sami> *<…>*`).

**Default: no mention**, matching Mark. The tradeoff is that without one the
editor relies on their channel notification settings rather than a direct ping.
If briefs start getting missed, prefix the member ID from the mapping table:

```
<@U0BMUAWCEG5> **<https://app.notion.com/p/3f84ac627aac819683b3d3321994ea35|NK612_4 Ways To Get It Wrong - Santoku_AI VO_SANTOKU>**
```

That is a one-line change here and takes effect on the routine's next run.

### ⚠️ A sent message cannot be edited or deleted from here

The Slack connector exposes **no `chat.update` and no `chat.delete`** — only send,
draft, schedule, react, canvas and list tools (checked 2026-10-13). So a mistake
in a posted message can only ever be corrected by **adding** another message.
Mark has to delete anything himself in the Slack app.

Two consequences that have already bitten:

- **Get the message right before sending.** There is no undo. The `**bold**` rule
  and the `/p/` URL rule above are the two things that have gone wrong so far,
  and each one cost a round of corrective messages.
- **Deleting a parent message deletes its thread replies.** If a correction is
  posted as a thread reply under a bad message, deleting the bad message destroys
  the correction too. To end up with one clean message per brief: **post a fresh
  standalone message first, then delete the bad parent** — never the other way
  round.

When a correction is posted in-thread, use `reply_broadcast: true` so it also
shows in the channel; a bare thread reply is easy for an editor to miss.

### Correcting a bad message: ask Mark to edit it

**The best fix is not a new message at all.** Mark can edit his own messages in
the Slack app, and **an edit does not re-notify anyone** — so editing leaves one
correct message per brief with no extra pings, which beats both deleting and
reposting. This play cannot do it (no `chat.update`), so the correction is: tell
Mark exactly what to change, as small an edit as possible.

For the 2026-10-13 `/p/` mistake that was literally inserting `p/` after
`app.notion.com/` in 10 messages.

Order of preference when a bad message is already out:

1. **Mark edits the message** — silent, one message per brief. Preferred.
2. **Thread reply with `reply_broadcast: true`** — if it needs fixing now and
   Mark is not around.
3. **Fresh standalone message, then Mark deletes the bad parent** — last resort;
   it is the noisiest, and the ordering matters because deleting a parent takes
   its thread replies with it.

Note a thread reply can be deleted safely on its own — removing a reply does not
affect its parent. So a correction posted in-thread can be tidied up after Mark
edits the original.

One gotcha if Mark pastes a replacement rather than editing in place: **`**bold**`
is converted on the API side, so typing it directly into Slack renders literal
asterisks.** When composing in the Slack app, Slack's own single-asterisk
`*bold*` is what works. The two syntaxes are not interchangeable between the tool
and the app — see the bold section above.

### Everything else

- **Never invent a deadline, runtime, or priority.** The brief carries no
  due-date field — the daily routine deliberately leaves `Date` blank — so any
  urgency language would be fabricated. A deadline **Mark states for that
  batch** is not invented and does go out — as a thread reply, see below.
- **One message per brief.** Never batch several briefs into one message; each
  needs its own link for the editor to work from, which is how it is done today.
- **Nothing else in the message.** No greeting, no summary of the script, no
  "let me know if you have questions". The editor opens the page for the script;
  the Slack message is a pointer, not a copy of the brief. Adding anything extra
  would make it read as a bot post rather than the handoff they already know.
- **The `*Sent using* @Claude` footer is added by Slack itself**, not by the
  message. Every message sent through the Claude connector carries it — Callum's
  Claude-sent handoffs have it too. Do not try to add it, and do not try to
  suppress it; it cannot be removed from the message text. Messages Mark posts
  by hand in the Slack app have no footer, so a footer is simply how the team
  can tell an automated handoff from a manual one.

### A deadline Mark supplies goes in a thread reply, not the message

Added 2026-10-19, when Mark followed the batch with *"Add thread on each slack
message with 'Due on Wednesday'"*.

The parent message stays exactly as specified above — one bold masked link,
nothing else. The deadline goes **underneath it as a plain thread reply**:

```
Due on Wednesday
```

- **Thread reply, not broadcast.** No `reply_broadcast`. The channel already
  shows the parent; broadcasting the due date would double every handoff in the
  channel feed.
- **No bold, no prefix, no emoji.** It is a note under a pointer, not a second
  announcement.
- **One reply per brief**, on that brief's own parent message — the same
  one-message-per-brief rule as the parent.

**⚠️ The weekday is per batch, not a standing value.** It was Wednesday on
2026-10-19 and Thursday on 2026-10-20. Never carry the previous run's string
forward, and never infer a deadline from the brief's `Date` property — that is
the brief's creation date, not a due date.

**The go signal now carries the day.** On 2026-10-20 Mark wrote *"assign now,
then due is on thursday"* — one instruction. So: **if the go signal names a day,
thread it. If it does not, ask**, since two runs in a row have carried one and
its absence is more likely an omission than a decision. Do not invent one.

### 🛑 A brief edit does NOT get a thread note — standing instruction, 2026-11-17

Mark, verbatim: *"Whenever there's update on script or visual no need to message
on the thread since they will just see it inside notion"*.

**So when a brief's script or Visual column is corrected, change the page and
stop there.** No thread reply, no ping, nothing in the editor's channel. The
editors work from the live Notion page, so the page *is* the notification; a
thread note only duplicates it.

**This retires the NK646/NK679 precedent** of noting each fix in the editor's
thread, which had been followed as recently as the two edit rounds earlier the
same day (NK914 + the four opener-tip pages, then NK851/867/873/894 — eleven
notes across nine threads). Those notes were not wrong under the old practice;
they are simply no longer wanted. **Do not re-derive the old behaviour from
those sections** — they are kept as a record of what was done, and each now
says so.

What still gets a thread reply:

| | Thread reply? |
|---|---|
| The due day Mark names with the go signal | **Yes** — see the rule above |
| An extra instruction Mark supplies for named briefs (e.g. *"prioritize NK855–859"*) | **Yes** — 2026-11-12 precedent |
| A script or Visual correction made to the page | **No** — this rule |
| A brief held back from the sweep (gate failure, blank editor, malformed) | **No** — that is reported to Mark, and the brief is not posted at all |

The distinction is who needs to act on it. A due day and a priority flag are
information the editor cannot get from the page. A corrected line is already on
the page they are about to open.


## After posting: flip the status

Immediately after a successful post, set that page's `Status` to
`Assigned to Editor` with `notion-update-page`.

This **is** the dedup mechanism — there is no separate ledger. A brief leaves
`Ready to edit` the moment it is announced, so the next sweep cannot pick it up
again.

Ordering matters: **post first, then flip.** If the flip fails, the brief gets
announced twice — noisy but harmless. Reversed, a failed post would silently
lose the assignment altogether. Never flip a page that was not successfully
posted.

## Edge cases (every one below was observed in the live data on 2026-10-13)

| Case | What to do |
|---|---|
| **`Strategist = Callum`** | Out of scope entirely. No post, no flip, no page edit, no triage — and no opening the page, and no naming it as a finding anywhere, not even as untouched (settled 2026-11-24). Drop it at the query and move on; a count is the most that goes in a report. See the hard rule at the top — it wins over everything else in this table. Callum is the **only** excluded strategist. |
| **`Editor` is blank** (and strategist is not Callum) | Do **not** guess, and do **not** apply the daily routine's editor-assignment rules — those govern brief *creation*, and silently picking someone here would hide a real gap. Post to the fallback channel for Mark saying it needs an owner, and **leave `Status` as `Ready to edit`** so it stays queued until a human assigns it. |
| **Mark re-assigns a brief that is already posted and flipped** | Four steps, in order: change the `Editor` property; fix the editor segment in the Batch name **and every** File naming row; post the link and the due day in the **new** editor's channel; and **tell the previous editor in their own thread not to start it**. Leave `Status` at `Assigned to Editor` — it is still assigned, just to someone else. See the section below for why the previous-editor note is required. |
| **No `Creative ID`** / malformed row | Skip, leave the status alone, name it in the run summary. Never post it to an editor. Observed live: one row whose Concept Name is a raw `next.frame.io` URL, with no Creative ID, Product, Editor or Format. |
| **`Editor = Huzaifa`** (off roster) | Fallback channel for Mark. No flip. |
| **Editor not in the mapping table** | Fallback channel for Mark, naming the editor and the missing mapping. No flip. Never post into a channel guessed from the editor's name. |
| **Slack post fails** (channel gone, not a member, API error) | No flip. Report it. Do not retry into a different channel. |
| **Naming-convention editor ≠ `Editor` property** | No post, no flip, no guessing which is right. Report the Creative ID, both names and which rows disagree. See the pre-send gate above. |

In every "no flip" case the brief deliberately stays in `Ready to edit` and
resurfaces next sweep. That repetition is intended — it is a standing reminder of
an unresolved gap. Report these each run rather than suppressing them.

## Go-live baseline — discharged 2026-10-13 (historical record)

**This list is spent. Runs from now on need no baseline at all — do not
reintroduce one.**

These 15 pages were already sitting in `Ready to edit` when the play was built.
Mark first chose to suppress them so a scheduled first run could not blast a
six-day backlog at seven editors; he then moved to the on-demand model and said
"go, clear the 10", and all 11 non-Callum briefs were posted and flipped on
2026-10-13.

Everything still in `Ready to edit` from this list is now covered by a **standing
rule** rather than by this table — the out-of-scope briefs by the hard rule at
the top, the malformed row by the no-`Creative ID` rule. So a suppression list is no
longer load-bearing, and keeping one would be a footgun: it would silently skip a
brief that legitimately came back round to `Ready to edit` after a revision.

Kept below purely as the record of what was waiting and what was done with it.

| Creative ID | Concept Name | Product | Editor | Page ID | Note |
|---|---|---|---|---|---|
| NK612 | 4 Ways To Get It Wrong - Santoku | SANTOKU | Hasnain | `3f84ac627aac819683b3d3321994ea35` | ✅ **done 2026-10-13** |
| NK613 | 4 Ways To Get It Wrong - Blackout | LOKI Blackout | Hammad | `3f84ac627aac8143867df6b2ebddf550` | ✅ **done 2026-10-13** |
| NK610 | Not For Everyone - Blackout | LOKI Blackout | Onyeka | `3f84ac627aac81019a8ee65490c885cd` | ✅ **done 2026-10-13** |
| NK609 | Not For Everyone - Santoku | SANTOKU | Hammad | `3f84ac627aac81cb9fa8d2f20a54361e` | ✅ **done 2026-10-13** |
| NK607 | Didn't Buy It Myself - Blackout | LOKI Blackout | Naveed | `3f84ac627aac814687cef0e2b375115f` | ✅ **done 2026-10-13** |
| NK606 | Didn't Buy It Myself - Santoku | SANTOKU | Hasnain | `3f84ac627aac81cf8acfdfca6daff7eb` | ✅ **done 2026-10-13** |
| NK603 | Too Nice To Use - Santoku | SANTOKU | Anas | `3f84ac627aac81999628eb6c75815e6d` | ✅ **done 2026-10-13** |
| NK604 | Too Nice To Use - Blackout | LOKI Blackout | Hammad | `3f84ac627aac81c3bc04e80ef68f3721` | ✅ **done 2026-10-13** |
| NK599 | Worth The Money - Santoku | SANTOKU | Umar | `3f34ac627aac814c8515e16be8ea2927` | ✅ **done 2026-10-13** |
| NK601 | Worth The Money - Blackout | LOKI Blackout | Hammad | `3f34ac627aac81db86cde95e400d0828` | ✅ **done 2026-10-13** |
| NK584 | Stop Sawing - Blackout | LOKI Blackout | Onyeka | `3f24ac627aac813ba030fb35ba42fc15` | ✅ **done 2026-10-13** — posted to `#11-onyeka-editing` and flipped to `Assigned to Editor` during the first live test. No longer in `Ready to edit`, so it cannot resurface. |
| _(none)_ | _(raw frame.io URL — malformed)_ | — | _(none)_ | `3e94ac627aac80d7be8df2fc97539316` | malformed row |

**All 11 non-Callum briefs above are done** — NK584 during the first live test,
then the remaining 10 on Mark's "go, clear the 10". Each was posted to its
editor's channel and flipped to `Assigned to Editor`, verified by re-query:
`Ready to edit` went from 15 rows to 4 (the out-of-scope briefs plus the
malformed row). To hand any of them to the
routine instead, delete its row from this table and set its `Status` back to
`Ready to edit`.

## Decisions on record (Mark, 2026-10-13)

| Question | Decision |
|---|---|
| How to reach Slack | **Slack connector.** Not an incoming webhook — connector traffic is not subject to the environment's egress policy, resolves real user mentions, and stores no secret in the environment. |
| Where assignments land | **One shared channel per editor** (`#11-<editor>-editing`) — not a single team channel, not DMs. |
| Dedup | **Flip `Status` to `Assigned to Editor`** after posting. No repo ledger. |
| Pre-existing backlog | Initially **suppressed** to avoid a scheduled first run blasting seven editors. Superseded the same day: on the on-demand model Mark said "go, clear the 10", and all 11 non-Callum briefs were posted and flipped. **No suppression list going forward.** |
| Callum's work | **Never touch it.** See the hard rule at the top. |
| Editor verification | **Blocking pre-send gate**: the editor in the Batch name / File naming rows must match the `Editor` property, or the brief is skipped and reported. Neither side is assumed correct. |
| Scheduling | **None.** No cron, no trigger. Mark gives a go signal and the sweep runs then. The trigger built on 2026-10-13 was deleted. |
| Editor access to briefs | **Public share on the `Evergreen Video` database**, enabled by Mark 2026-10-13. None of the 7 editors was a Notion user. Inherits to all brief rows, so no per-brief work. Two things still unconfirmed: whether "Allow editing" is on (required for `Delivery Link`), and whether it works from a logged-out browser — neither is checkable by any API. Free Notion guests remain the recommended alternative. |

## Appendix: environment facts worth keeping

- **Raw `curl` to Slack does not work** from the cloud environment —
  `slack.com:443` returns 403 at the egress gateway (verified 2026-10-13). The
  connector is the only route. A webhook rewrite would need `hooks.slack.com`
  added under the environment's Allowed domains.
- **Direct Slack sends are refused by the auto-mode classifier.** See "Slack
  sends need a permission decision each run" above — this is the live friction,
  not a theoretical one.

## Appendix: if this is ever put on a schedule

Not currently wanted (Mark runs it on demand), but the groundwork is done, so
here is what a future scheduler would need to know.

**A Routine created with the `create_trigger` MCP tool cannot carry connectors
on this organization — verified the hard way on 2026-10-13:**

- Passing `connectors: ["Notion", "Slack"]` is rejected outright —
  *"the connectors parameter is not available for this organization."*
- Creating it without that parameter succeeds but warns that the trigger stores
  no MCP connectors.
- Firing such a trigger confirmed it: the fired session's init reported
  `mcp_servers: []`, and the run itself reported `mcp__Notion__*`,
  `mcp__Slack__*` **and** `mcp__github__*` all unavailable. It correctly posted
  nothing and changed no statuses.

So a scheduled version has to be created in the **claude.ai Routines UI** with
**Notion, Slack and GitHub** all attached — GitHub included, because the routine
reads this spec from the repo at run time. The trigger built and tested on
2026-10-13 (`trig_01X5NCbaMaYWJpq8yb8XoxAD`) was **deleted** once Mark said he
runs this on demand.

A scheduled version would also hit the Slack permission question differently: a
Routine session runs under its own permissions, so whether it can send directly
rather than only draft needs checking on the first live run.

Hourly would be the practical floor, so an editor could wait up to an hour.
Notion's own database automation (Evergreen Video → Automations → "When Status
is set to Ready to edit → send Slack notification") fires on the edit itself and
is the better tool if instant matters — at the cost of the per-editor routing,
the Callum exclusion, the roster validation and the status flip.

### The prompt, if it is ever scheduled

```
Sweep the NorthernKnife "Evergreen Video" Notion database for briefs that have
reached "Ready to edit" and hand each one to its editor in Slack.

## Read the spec first — it is authoritative

Read `editor-assignment/editor-assignment-process.md` from the GitHub repo
`creativetstrategist-mark/my-client` using `mcp__github__get_file_contents`. Try
branch `main` first; if the file is not there, read it from branch
`claude/gallant-hypatia-ohcfam`.

That file holds the exact option strings, the verified editor-to-Slack channel
and member-ID mapping, the message format, the edge-case table, and the go-live
edge-case table. Follow it exactly — it is kept more current than this prompt,
so where they disagree, the file wins. Do not proceed from this summary alone;
the mapping table is only in the file.

## The job

1. Query data source collection://2cf4ac62-7aac-81a8-86bf-000b96778943 for
   Status = 'Ready to edit' (exact string — lowercase "edit"), excluding
   Strategist = 'Callum' in the query itself, oldest first.
2. Drop any page with no Creative ID (a malformed row). There is no suppression
   list to consult — the go-live baseline was discharged on 2026-10-13 and must
   not be reintroduced.
3. For each remaining page, look up its Editor in the spec's mapping table and
   post the spec's message format into that editor's channel. One message per
   brief. Match Mark's existing format exactly — a single bold masked link:

       **<PAGE_URL|NK###_Concept Name_Content_Product>**

   Bold is TWO asterisks. The Slack tools take standard Markdown and convert
   it outbound, so `*x*` sends italic and `**x**` sends bold — the opposite of
   what an existing Slack message's raw source looks like, so do not copy the
   single-asterisk form you see when reading a channel. The `<url|label>` link
   form does pass through untouched; leave it as is.

   Build the four label fields verbatim from that page's own properties, and
   target the url the query returned for that row. No @-mention unless the
   spec says to add one, no greeting, no summary of the script, no extra
   fields. (The "Sent using @Claude" footer is appended by Slack itself — you
   neither add nor suppress it.)
4. Only after a post succeeds, set that page's Status to "Assigned to Editor".
   Post first, then flip — never the other way round, and never flip a page
   that was not successfully posted.
5. Handle exceptions per the spec's edge-case table: blank editor, off-roster
   editor (Huzaifa), unmapped editor, or a failed post all go to the fallback
   channel for Mark and LEAVE the status untouched. Never guess an editor, and
   never post into a channel guessed from an editor's name.

## Hard rules

- Never touch work with Strategist = Callum — standing instruction from Mark;
  Callum is the only exclusion, because he routes his own briefs
  (2026-10-13). No post, no status change, no triage, not even a flag. Filter it
  in the query.
- Never invent a deadline, runtime, or priority in a message. The brief carries
  no due-date field, so any urgency language would be fabricated.
- Never post a malformed row (no Creative ID).

## Report

Briefs posted (Creative ID -> editor -> channel), anything routed to the
fallback channel and why, and malformed rows skipped. If there was nothing to
do, say so in one line — do not pad the report.

If the Notion or Slack connector is unavailable this run, say so explicitly
rather than reporting zero assignments. If you could not read the spec file,
stop and report that rather than working from this prompt's summary.
```


## 🚨🚨 Both open-question lines became named concepts, went on camera, and were fast-tracked (2026-11-12)

The two copy lines that have been sitting unruled the longest stopped being
stray sentences inside other concepts. On 2026-11-12 each one **is** a concept,
with its own Creative ID family, and Mark asked for all five briefs to be
prioritised for a pre-weekend launch — i.e. they are the fastest-moving work in
the queue, not the slowest.

| | Concept | Briefs | Where the line sits |
|---|---|---|---|
| Profanity | **NK Suck My Balls (R14B2)** | NK857 | all 3 hooks |
| Gender ultimatum | **New Wife Santa (R2B8)** | NK855, NK856, NK858, NK859 | 3 of 3 hooks (NK855/859), 3 of 6 (NK856/858) |

All five are `Content` = `UGC`, `Face-Talking`, `Voice-Creator-M` — **a real
named creator (Ryan Kirby) saying the lines to camera**, not an AI voice over
b-roll. That is a different exposure profile from every earlier instance:
a creator's face and name are attached to the delivery.

**NK857's three hooks, verbatim and uncensored:**

- *"Northern Knife, you can suck my balls"*
- *"Northern Knife, fuck off"*
- *"Northern Knife, you absolute bastards"*

There is **no censor instruction anywhere in the brief** — no bleep, no mute, no
on-screen cover. This is the exact line flagged in NK810's H7 on 2026-11-10 as
the strongest unhandled language in the corpus; it has now been promoted from
one hook among ten to the concept's title and ID. The contrast with house
practice is sharp: **NK722 H1 and NK727 H3 carry an explicit template** —
*"Bleep the word, censor it on screen"* — for materially milder words. So the
capability exists and was not applied here.

**NK855/856/858/859's line:** *"If your wife didn't get you this gift, you need
a new wife."* Mark cleared the NK644 version on 2026-10-20 **explicitly as a
one-off and not a standing ruling**. Since then it has moved body → close → hook
(trajectory table above) and is now the concept's premise and name.

### 🔑 Root cause found: the ultimatum line lives in the persona boilerplate

This is the finding that changes what the fix looks like. All five briefs carry
the same pasted persona block, and under **MIKE** it reads, verbatim:

> *"For him we can do more hard marketing 'Ïf you're wife didn't get you this
> gift, you need a new wife'"*

The line is **not** being re-invented by a writer each time — it is template
text, quoted as an example of the register MIKE accepts, and it is pasted into
every brief that uses that persona. That explains the three-week spread, why it
tracks the male narrator perfectly, and why it keeps escalating: each writer
reads it as approved house copy because it arrives inside the brand's own
guidance block.

**It is therefore a one-place fix.** Editing that sentence out of the persona
template stops the line at source, for every future brief, without touching any
individual script. Nothing else found in this play has had that property.

### Same five briefs, other flags

- **"It's three times sharper than those other bullshit knives I was using"** —
  in all five. Two problems in one sentence: an invented multiplier of the
  NK646 class Mark ordered fixed on 2026-10-20, and more uncensored profanity.
- **A garbled persona block** naming SARAH, "MIKE - GRILL MASTER",
  "DON - OPPORTUNIST" *and* "DON | The Hunter" (two contradictory DONs), plus
  COLE — while the `Avatar` property is `VANCE- The Opportunist`, whom the block
  never mentions. The editor is given five personas and not told which applies.
- **NK856/858 say "100,000 customers"**; 147,000 is the current figure and the
  same day's briefs use it.
- **NK858 names an "ODIN Chef Knife"**, which is not a `Product` option — but it
  correctly says the Feather is made *"about five hundred at a time"*.
- **NK857 says "up to 64% off"** — a real tier, correctly used.

## 🎯 Mark's own briefs are the compliance model, and they fix by instruction rather than by correction (NK862–864)

NK862/863/864 are the **first briefs with `Strategist` = `Mark` to come through
this play**. They are the best-constructed briefs the play has seen, and they
matter beyond their own quality because they demonstrate a mechanism.

**Every rule this play has been flagging for weeks appears in them as an explicit
`Do not:` line in the brief itself:**

| Brief | The `Do not:` line |
|---|---|
| NK862 (Feather) | *Never "etched", "engraved" or "hand-finished" for the feather pattern. No price on screen.* |
| NK863 (Blackout) | *The bottle opener is in the handle, never the blade or the spine.* |
| NK864 (Santoku) | *Never "Japanese" or "Japan". The bolster is brass. **No wood species for the handle.*** |
| all three | *Black Friday: the offer is BUY 2 GET 2 FREE, nothing else. No end date, no countdown, no extra % off, **no "up to" figures**.* |

Three open items are answered in practice by that table:

1. **The Santoku handle rule.** The open question was how to word it. Mark's own
   wording is **"No wood species for the handle"** — the *name no wood at all*
   form this spec argued for, not "never rosewood". Use his words.
2. **The "up to 67% off" question.** Mark's briefs ban "up to" figures outright,
   in the same batch in which three of Andy's use "up to 67% off". That is as
   close to a ruling as the data can get without him saying so.
3. **The Apple Watch clip.** NK862/863/864 all swap the source's *"your favorite
   lipstick"* → *"your Apple Watch"*, each annotated **"Mark:"**. The destruction
   gag is his own call, authored deliberately, not a flag — this closes that item.

**The portable finding: the `Do not:` line is the fix.** Andy's briefs in the
same queue break rules that Mark's briefs pre-empt with one sentence of brief
text. The rules already exist in CLAUDE.md; what Mark adds is restating them
where the writer and editor actually read. Recommend it for every brief.

**Also worth copying: NK862–864 annotate every changed line as a diff** — the
`Note` column gives the source line, the new line, and the reason
(*"(no finger loop on the Feather; rosewood handle)"*). No other brief in the
corpus is traceable that way, and it is what makes the product swaps verifiable
instead of trusted.

**One flag against them:** all three say the blade *"is five times sharper than
average knives"*, carried over unchanged from the NKEOFY005 winner and not
marked Changed. Combined with NK855–859's *"three times sharper"*, **the same
day's queue carries two different invented multipliers**, and the 5× is in
Mark's own briefs — so the NK646-class fix he ordered has not reached the
source winners the iterations are built from.

## 📺 "up to 67% off" reaches nine briefs, and is now contradicted inside its own batch

NK840, NK841 and NK842 each carry *"Buy two, get two free deal, plus lifetime
warranty and up to 67% off your order"*, taking the count to **nine** (NK731,
the NK728 family, NK840, NK841, NK842). Against real tiers of 64% and 56%.

What is new is that the contradiction is now internal: **the same queue contains
Andy's three briefs using "up to 67% off" and Mark's three briefs banning
"up to" figures by name.** Nothing further needs establishing — it needs a
decision.

The three `Better Call` briefs share two more claims worth a ruling:

- **"the number one Christmas gift in 2025"** — a specific, checkable superlative
  about a past year, in all three.
- **"still guaranteed to last forever"** alongside the explicit *"lifetime
  warranty"* — the warranty item remains unconfirmed.

**Good discipline in the same three, worth saying:** the source NKFD071 was a
tariff-crisis ad, and all three briefs instruct **"Nothing about tariffs
anywhere, on screen or in the VO"**, twice each. That is Andy stripping a premise
that no longer applies rather than letting it ride — the same care NK772 and
NK771 showed.

**Product accuracy across the three:** NK840 correct (rosewood handle, 147,000
customers) but says *"that feather etched from the tip to the handle"* — "etched"
again, newly written, in the same batch as Mark's brief banning the word.
**NK842 is clean** — blacked out tip-to-handle, the finger loop (the correct
Blackout attribute per NK801/NK803), no bolster-material claim.
**NK841 gives the Santoku a "carved ebony handle"** — the handle-wood error for
the third time in ebony (after NK813, NK816) and a third wood overall after
rosewood. Exactly what NK864's *"No wood species for the handle"* prevents.

## 🚨🚨 The two strategists are now writing opposite rules into the same queue, on the same day (2026-11-16)

This is the most important structural finding this play has produced, and it
replaces the way earlier runs framed copy flags. Up to now a flag was "a brief
says something the brand pack forbids". On 2026-11-16 the queue held **17
briefs**, and the same rule was *written down as a hard instruction* by one
strategist and *broken* by the other, repeatedly, in sibling briefs of the same
concept, created within hours of each other.

The rules are no longer the issue. **The issue is that Mark's briefs carry them
and Andy's do not.**

| Rule | Mark writes it | Andy's briefs in the same queue |
|---|---|---|
| Never "etched" on the Feather | NK847 `Do not: Never "etched"`; NK848 + NK861 **re-record it out of the locked NK184/NK326 VO**; NK907 *"No etched, no engraved, no hand-finished, no 'burned in'"* | **10 instances across 5 briefs** — NK865 ×4, NK871 ×2, NK880 ×2, NK849 ×1, NK840 ×1 |
| The bottle opener is in the **handle** | NK909 red callout: *"Not the blade, not the spine... do not let a visual show the bottle meeting the steel"*; NK844 re-records *"notched into the blade"* → *"built into the handle"* | ~~**6 instances of "on the back"** — NK867 ×3, NK873, NK894, NK851~~ — **✅ all 6 fixed in Notion 2026-11-17 on Mark's instruction** (see the second edit round below). The *rule-travel* finding stands; only these instances are gone. |
| No "up to" figures | NK843, NK844, NK847, NK848, NK861, NK862–864 all state it | **"up to 67% off" in 18 briefs** — this run added NK840/841/842, NK852, NK865, NK871, NK873, NK880, NK894, NK849, NK851 |
| No price, in any market | NK907, NK909: *"No price, in any market. US, UK and AU run this"* | NK871 + NK873: *"for less than 200 bucks"* on `Mkt-All` |
| Never manufactured urgency | NK907, NK909: *"Never invent an end date, a clock, a countdown graphic or a 'hurry'"*; NK909 adds *"no scarcity on this page"* | NK849 (7 hooks) + NK851 (7 hooks) are **built entirely on unverifiable stock scarcity**; NK852 plays a fake sell-out then re-asserts it |
| "Most viral knife of 2026" is cut | NK907: *"It is in the NK184 script; it is not in the product facts, and it dates badly in November. Do not put it back"* | Survives in NK848 and NK861 — **Mark's own two briefs**, same day |
| Free returns | NK844: *Changed: "Free returns." → cut* | NK907 and NK909 both say *"free returns"* — **also Mark's own**, same day |

**What to do with this.** The fix is not another round of copy notes. It is to
move Mark's `Do not:` block into the brief template so every brief carries it
regardless of author. He has already written every line that is needed; they
just do not travel to Andy's briefs. Two of the rows above show the rules do not
even travel reliably between Mark's *own* briefs, which is the same argument.

### 🔑 Root cause found for the bottle-opener error

NK909's red callout explains six runs of this error in one sentence:

> *"The **LOKI Reaper** is the one with the opener in the blade — do not mix them
> up."*

There are two products, one with the opener in the blade and one in the handle.
"On the back" is not carelessness, it is the wrong product's fact. That is the
same shape as the ultimatum line living in the persona boilerplate: a one-place
cause, not a writing habit.

### 🔑 And for the pattern-uniqueness compound

NK907 settles the sentence this spec has flagged since NK654 (*"no two are ever
exactly the same. Because no two hands hammer the same way"*):

> *"The variation answer is **the handle, not the blade**. Rosewood grain and
> hammer marks vary. The feather does not. Do not let a visual imply 2 blades
> have different feathers."*

NK907's B5 executes it correctly. **NK848 and NK861 still carry the old
sentence** (not marked Changed), and **NK865 asks the editor to shoot the
forbidden proof**: *"two Feathers side by side showing the different etching"*.
NK871 and NK880 carry the compound too. So: rule written, three briefs fixed,
five still wrong.

## ✅ Three open items are now answered by Mark's own briefs

- **The Santoku handle rule.** NK864's wording is **"No wood species for the
  handle"** — the *name no wood* form. Adopt his words. (NK895 still says
  *"carved ebony handle"* on the Santoku: 4th ebony instance after NK813,
  NK816, NK841.)
- **Who the bestseller is.** NK909: *"The **LOKI Viking** is the bestseller, not
  the Blackout. Do not promote the Blackout itself to '#1'."* This confirms the
  NK895 flag — it calls the **Feather** *"Our best seller"*.
- **"Black right through".** NK909: *"not a verified fact — do not use it. It
  appears in several shipped briefs and is still with the strategist."* That is
  NK657's own in-brief question (logged 2026-10-20), now formally open with a
  verified-facts list beside it: *all-black, high-carbon steel, ebony handle,
  opener in the handle, black box with magnetic closure*.
- **The Apple Watch clip closes** (recorded 2026-11-12): Mark authored the swap.

## 🚨 The customer count forked inside one strategist, one day

Four of Mark's briefs, all 2026-11-16: **NK843 and NK847 say 147,000**; **NK907
and NK909 say 100,000**. Andy's NK849, NK851, NK880 and NK894 all say 147,000.
147,000 is the figure 8 of 12 briefs use and the one NK909 pairs with
"lifetime warranty", so it is almost certainly current — but this is no longer
an old-vs-new drift, it is two numbers written the same morning by the same
person, and one line in the brief template would end it.

## 🚨 Two concepts assert the brand lied to its customers, and two deny it

- **NK880 (Umar) and NK894 (Anas)** are a "public apology" concept whose hook
  SUPER reads **"NorthernKnife just admitted they lied to over 147,000
  customers"**, with a full-screen *"A PUBLIC APOLOGY FROM NORTHERNKNIFE"* card.
  The "lie" resolves to *"We said we couldn't drop the price any further."*
  NK881 (Santoku, Hammad) is named as a third sibling upstream, so the set is
  3 cuts × 3 hooks = **9 assets** carrying that line. On Meta a hook is viewable
  on its own, out of context.
- **NK849 and NK851**, in the same queue, promise the opposite: *"There will be
  no extension, no second round, and no secret discount after Black Friday"* and
  *"No restock, no secret code, no next round."*

So the queue simultaneously claims the brand secretly dropped the price and
promises it never will. Both are Andy's. This is a positioning call for Mark,
not a copy nit.

## ⚠️ "Real b-roll only. No AI clips." against AI clips in the Visual column — 7 instances in one day

The contradiction first logged on 2026-11-04 (NK679, NK778) is now the dominant
production flag:

| Brief | The brief says | The Visual column says |
|---|---|---|
| NK852 | *"Real b-roll only... No AI clips."* | *"B-roll clip of AI employees at the warehouse"* |
| NK849 | same | *"Generate a clip of shelves at the warehouse"*, *"AI employees working at the warehouse"* |
| NK851 | same | *"Generate a clip of an empty shell shelf"*, *"AI employees at the warehouse"* |
| NK880 | same | *"Video clip of an AI brand owner of NK at the warehouse"* |
| NK894 | same | *"AI brand owner talking at the warehouse"*, *"AI knife factory"* |

**NK880 and NK894 are the serious ones**: a synthetic brand owner delivering a
public apology on the company's behalf. Everything else here is a warehouse
establishing shot.

## 📌 Smaller findings from this run

- **A `Mark` option was added to the `Editor` property** (the schema now ends
  `..."Waheed", "Fahad", "Mark"`). No brief used it this run. If one ever does,
  the mapping has no editor channel for Mark — the `#11-mark` fallback
  (`C09QUL7S3GA`) is the sane target, but it is a fallback, not a roster entry,
  so raise it rather than assuming.
- **NK873 → Fahad is the first brief either new editor has received** through
  this play. `C0CENMTDF9C` accepted the post and the thread reply, so the
  2026-11-09 channel verification holds in practice as well as on paper.
- **NK848 and NK861 ship three identical hooks.** Both say *"What if a knife
  could be more than a knife."* for H1, H2 and H3, with empty Visual columns and
  identical file-naming rows. Two editors therefore produce 6 deliverables with
  nothing to compare at the hook level. The briefs intend a *visual* test
  (*"the Visual column is left open on purpose"*), which is legitimate — but
  NK861's *"H2 is the winning hook"* and NK848's *"H3 is the winning hook"* are
  then meaningless. Say it is a visual test, or differentiate the hooks.
- **NK851 misattributes two Feather facts to the Blackout**: *"Every batch takes
  three months to make"* (NK909: *"No 500-unit batch and no 3-month restock —
  those are Feather facts"*) and *"that finger loop grip no other knife has"*
  (the LOKI Viking has it; the Blackout is its remake).
- **NK894 says the Santoku has a "copper dragon"** — brass. The NK721 error,
  recurring, and the subject of `brand-accuracy/santoku-bolster-discrepancy.md`.
- **"Japanese" is back on Feather and Blackout briefs**: NK871 and NK873 both
  say *"Forget spending $1000 on an overpriced Japanese blade"*, and NK873's
  Visual asks for *"a $1,000 overpriced Japanese blade (grayed out)"*.
- **`Src-HexClad` on NK865 and NK867** instructs *"the caption appears exactly
  like theirs, with 'lifetime warranty' and the red text"* — copying a named
  competitor's branded caption treatment, on the same claim they market. Closer
  to the line than any previous inspo use; a call for Mark.
- **The lifetime warranty is now load-bearing.** NK865/NK867's three hooks are
  *"Spoiler alert, their knives come with a lifetime warranty, so I won't need
  to"* — the concept collapses if it is not real or not lifetime. NK865, NK880,
  NK894 and NK895 all add *"even the free ones"*. NK895/NK880/NK894 reference a
  **lifetime warranty badge** asset, which is some evidence it is real. This
  needs confirming, not noting.
- **Mark's briefs annotate the offer position** (*"OFFER — lands here, ~62% in"*)
  and the originality threshold (*"the originality gate fails on 6 shared
  words"*). Both are new and both are worth copying into the template.
- **NK843's premise is a customer-service exception**: an employee says *"look,
  I'm not supposed to do this"* and grants a special arrangement. It resolves
  warmly, but it promises an outcome support may be asked to honour.
- **"3 months in the workshop, one blacksmith per blade"** recurs in NK844
  (after NK793). NK847 has the correct form: *"runs of a few hundred, and when a
  run is gone, the next one is months out. The forge sets the pace, not us."*
- **"Northern Knife" as two words** in NK907 B2 and NK909 B1, both on-VO.
- **"Batman"** as the Blackout's descriptor returns in NK873 (after NK769,
  NK777) — three briefs, so house copy rather than a slip.
- Typos in Visual cells that name no real thing: NK895 *"Beetlecliff"*, NK880
  *"Bevel clip"*, NK873 *"Barrel clip"*, NK849 *"Broll clip uphand fold"*.

## 🛑 The most serious concept this play has routed: "Chinese Spy" (NK917/918/919, 2026-11-17)

Three briefs, one concept, all three focus products, all Andy, all `Mkt-All`
(US, UK and AU). All three passed the editor gate and were posted and flipped
per the editor-slot-only rule. **This entry exists because the gate passing is
not the same as the concept being safe, and this one is different in kind from
every flag filed before it.**

Previous brand-risk flags — the gender ultimatum (NK644, NK816/817, NK855–859),
the profanity (NK769, NK810, NK857), the "we lied" apology (NK880, NK894) —
were **tone and positioning** calls: offensive or off-brand to some viewers,
reputational, reversible, and squarely Mark's to make. This one contains three
things that are not tone calls.

### 1. Fabricated conduct attached to real, identifiable people

The concept hooks on a real news story: a Chinese national accused of spending
two years getting close to Nvidia's CEO. It then invents that **the same woman
also targeted NorthernKnife**, and states it as fact in the narrator's voice:

- NK917 H2 VO: *"Nvidia's CEO got a Chinese spy. So did ours."*
- NK917 body: *"Same girl. She had a double life. Nvidia during the week. Us on
  the weekends."*
- NK918 H1 VO: *"A Chinese spy spent two years **seducing** the Nvidia CEO for
  chips."*
- All three hooks in NK917 and NK919 open with *"True story."* or equivalent.

Each brief carries a guard rail — *"Never name the Nvidia CEO or the real woman.
'The Nvidia CEO' and 'a Chinese spy' only"* — **and each brief then breaks its
own rule in the Visual column**, instructing the editor to show or generate the
real CEO:

| Brief | Its own rule | Its Visual cells |
|---|---|---|
| NK917 | *"No photo of the CEO, no name on screen"* | H2: *"Show an image of Nvidia CEO together with a Chinese spy"* |
| NK918 | same | H1: *"Show an image of the Nvidia CEO together with the Chinese Spy"*; H3: *"Generate clips of Nvidia CEO having a dinner with a Chinese spy"*; B1: *"Generate a clip of Nvidia CEO together with Chinese Spy walking at the red carpet"* |
| NK919 | same | H2: *"Show an image of Nvidia CEO together with a Chinese spy"* |

Not naming a company's CEO does not de-identify them when the company is named
in the VO. And the woman in the source story is a real identifiable individual
being depicted, in a paid knife ad, as having seduced a second company's
executive — conduct for which there is no basis.

### 2. An instruction to AI-generate sexualised imagery specified by ethnicity

This appears **verbatim in two briefs**, NK917 and NK919, going to two different
editors (Hammad, Onyeka):

> *"Generate image of a gorgeous Chinese lady. But censored her face. Just show
> a hot sexy body."*

That is production direction, not copy. It asks an editor to synthesise a
faceless sexualised body, specified by nationality, standing in for a real woman
accused of a crime.

### 3. A country-of-origin disparagement line in the CTA

NK919's offer beat:

> *"If you want one, and not the Chinese one, it's now easier than ever..."*

Each brief's own rule says *"No politics, no China jokes beyond the spy line."*
This is beyond the spy line — it is "don't buy Chinese" in the commercial heart
of the ad, and the spy premise frames it.

### The payoff also rests on a product claim that is not true

Setting all of the above aside, the concept's punchline is that the secret
cannot be stolen because it is not written down:

> NK917: *"There's no file. No formula... It's a guy... The feather design runs
> the whole length of the steel **because he puts it there, one at a time.**"*

The Feather's pattern is **laser-applied**. So the ad's entire resolution
attributes the pattern to the blacksmith's hand. This is the NK654 hand-hammer
error promoted from a stray sentence to the load-bearing beat — it cannot be
fixed with a word swap, because removing it removes the payoff. NK918 does the
same for the Santoku: *"Every engraving. Every scale on that dragon. All of it
done the slow way, by a man."*

### Recommendation

**Pull the concept before anyone cuts it.** Nothing has been produced yet: the
editors have the standard bold link and `Due on Thursday` and nothing else, so
the cost of pulling now is zero. If the mechanic is worth keeping, it survives
without any of the above — the "there is no file, it is a blacksmith" idea works
with an unnamed competitor, no real third party, no generated person, and a
truthful account of how the pattern is applied.

If Mark wants them stopped, flipping the three pages back to `Ready to edit` or
`Pending` and posting one line in each editor's thread is a two-minute job.

## 🚨 Three of Mark's own rules, written 2026-11-16, broken 2026-11-17

NK919 breaks three rules from NK909's red callout, one day later:

| NK909 rule (16 Nov) | NK919 (17 Nov) |
|---|---|
| *"The LOKI Viking is the bestseller, not the Blackout. Do not promote the Blackout itself to '#1'."* | *"The LOKI Blackout. **Our best seller**, blacked out."* |
| *"The bottle opener is built into the HANDLE. Not the blade, not the spine... do not let a visual show the bottle meeting the steel."* | Visual: *"showing the blade and handle and **bottle opener tip**"* |
| (the finger loop is the Viking's grip, in the handle) | *"**Finger hole in the blade**"* |

This is the strongest possible evidence for the finding filed yesterday: the
rules exist, they are written down, and they do not travel to Andy's briefs. One
day's gap, same product, same week.

**The ebony count is now 8.** NK917, NK918 (×2) and NK919 all say *"carved
ebony handle"* on the BJORN Santoku, five days after NK864 established the
wording *"No wood species for the handle"*.

## 📌 Other findings from this run

- **A production error that will cost a re-cut: NK919's Feather block tells
  Onyeka to show the Tiger Cleaver.** The Visual cell reads *"Montage clip of
  Tiger Cleaver"* while the VO describes the Feather ("feather design the whole
  length of the steel, rosewood handle"), and the next block repeats the same
  Visual cell for the actual Tiger Cleaver. Two beats, one clip, wrong knife on
  one of them.
- **The synthetic CEO is now a standing asset.** All three briefs say *"Our AI
  CEO reference was the guy in a black jacket. You can check it in the AI
  Animated Clips folder."* After the "AI brand owner" delivering the public
  apology in NK880/NK894, the brand has a persistent fictional founder with a
  biography — married, wife owns a Feather, *"MARRIED. AND LOYAL."* as a SUPER.
  Worth a deliberate decision rather than drift.
- **"No AI clips" vs AI clips reaches 9 instances.** All three briefs state
  *"Real b-roll only from the Frame.io library... No AI clips"* and NK917 adds
  *"(no faces, no AI clips)"*, while between them fourteen Visual cells say
  *"Generate..."* or *"Generate on Higgsfield"*. NK919 compounds it with the VO
  line *"No AI, no machine, comes close to this"* in an ad built from AI voice
  and AI imagery.
- **A new unverifiable craft claim, in two briefs:** *"It takes decades to learn
  these skills, and only a handful of blacksmiths in the world can do it"*
  (NK918) and *"Skills like this take decades to learn"* (NK919).
- **NK918 and NK919 ban "Black Friday" outright** (*"No 'Black Friday' anywhere
  in the ad, on screen or in the VO"*) — the first briefs to do so, which makes
  them Evergreen-safe on the event. But NK918 still says *"for the next few
  days"* and both CTAs say *"before the deal ends"*, so the implied deadline
  survives the fix.
- **Good practice worth copying:** *"Say 'BJORN' as one syllable: type it
  'Byorn' in ElevenLabs, write BJORN on screen"* — a pronunciation note for an
  AI voice, in all three briefs. And *"The ODIN shot is the ODIN 6" Chef Knife,
  not the Hybrid Cleaver"* disambiguates two similar products. Both are the kind
  of instruction that prevents a revision.
- **"ODIN Chef Knife" is not a `Product` option** (the catalog has ODIN 6 Boss,
  ODIN 8 Boss, ODIN SET, ODIN Hybrid Cleaver) — spoken in NK917 and NK918.
- Recurring, unchanged: *"a tiger engraved in the steel"* (all three),
  *"Over ten inches"* (all three), *"lifetime warranty... even the free ones"*
  (all three), *"147,000 customers"* ✓ correct in all three.

## ✅✅ The longest-running flag in this engagement is closed, with the reason (NK916, 2026-11-17)

**"Never say etched" is now documented as a complete rule, and NK916 states
why.** This has been open since NK569 on 2026-09-14.

> *"NEVER describe how the feather gets onto the blade. No laser, etched,
> engraved, printed, applied, laid, burned, stamped, coated, finished, inlaid.
> The source is built on 'laser etch' — **this is the page where that word is
> most likely to creep in**, from an editor reading the inspo. Name the feather.
> Show it. Move on."*

And in NK916's inspo analysis, the reason:

> *"The source's mechanism... is built on 'they laser etch a stainless steel
> hexagon pattern'. **The Feather's pattern is made the same general way, and the
> catalog says never describe the technique at all.** So the anatomy goes by
> **depth**, never by **process**."*

Two things settle here. The rule is **not** "don't say etched" — it is **never
describe the technique at all**, with eleven banned words listed. And the reason
the word keeps appearing is now identified: editors read an inspo ad that
explains its own manufacturing, and import the frame.

**The accompanying distinction is the one that makes the rule usable:**

> *"Describe how the STEEL is made. Never how the FEATHER is made. 'Hammered
> into shape by a blacksmith' is house language and approved."*

That retroactively settles several entries in this log. NK910's *"High-carbon
steel, hammered by hand"* is **correct** — it describes the steel. NK917's
*"the feather design runs the whole length of the steel **because he puts it
there, one at a time**"* (2026-11-17, Andy) is **wrong**, and so is the whole
"no file, it's a guy" payoff built on it. The line between them is now written
down.

**The same rule now exists for the Santoku**, in three briefs: *"Never describe
how the engravings got onto the blade. Name them, show them, move on."* (NK908,
NK911, NK914).

## ✅ Four more open items closed or substantially answered

### The customer count — closed, with a date

NK911 and NK912 both carry:

> **"147,000 customers** — updated 2026-11-16 from 100,000. Customers, never
> reviews or stars."

So 147,000 is current and 100,000 is superseded as of 2026-11-16. That explains
the fork reported yesterday: NK907 and NK909 say 100,000 because they predate
the update inside the same day; NK843, NK847, NK908, NK910–916 all say 147,000.
**Nothing further is needed — the figure is 147,000 and it is now documented in
the briefs themselves.**

### The "Japanese" rule — the mechanism is now stated

NK914's red callout gives the reason the rule exists, which no document had:

> *"NEVER explain the word 'Santoku'. The device is applied to BJORN only.
> **'It's called a santoku because...' can only be finished with its Japanese
> origin, and the brand never says that.** If an ad-lib, caption or supered
> definition starts explaining the knife shape, cut it. This is the
> highest-risk line on any page in the trio."*

NK908 adds the failure mode: *"a dialogue about a knife's shape invites it. If a
hook or ad-lib starts drifting toward 'what even is a santoku', cut the
question."*

So the rule is about **never explaining the shape**, not merely avoiding a word.
That resolves the Santoku side of the 15-instance tally. The separate question —
competitor disparagement (*"$300 Japanese knives"*, NK648/NK670, and NK871/NK873
on 2026-11-16) — is untouched by this and still needs a ruling.

### The invented multiplier — the principle is stated

NK911 and NK912:

> *"No speed or time claim. The source's '30 minutes down to seconds' and '10
> times faster' are refused. This page says the boring part stops being a fight
> — **a feeling, not a measurement. Never say it makes you faster.**"*

"A feeling, not a measurement" is the generalised fix for *three times sharper*
(NK855–859), *five times sharper* (NK800–805, NK862–864) and *three times the
control* (NK646).

### "Up to 67% off" — the reasoning, not just the number

NK910 and five siblings:

> *"No percentage, and no price. The offer is B2G2 and **B2G2 is never converted
> into a percentage — it is a mechanic, not a discount.** The source's '60% off'
> and the 'up to 67% off' tier are both out of the read."*

This is stronger than "67% is not a real tier": the percentage framing itself is
refused. **NK866, assigned in this same run, still says "up to 67% off" — the
19th brief.**

## 🆕 New product facts disclosed in this batch

Three facts appear for the first time, each as a scoping rule:

- **The RAGNAR Tiger Cleaver is not full tang** (NK913). The rule built on it is
  beat-level: *"No Full-Tang after block 2... Full-Tang is said once, in the
  Feather's own beat, before any other knife appears — and the close does not
  carry it."* Because a four-knife lineup would otherwise let the claim spread.
- **The Santoku is not full tang** (NK914).
- **The LOKI Reaper's two facts**: *"The opener is notched into the blade, and
  the tip runs straight"* (NK914). This is the product that has been causing the
  Blackout opener error.

Also newly budgeted: **the Tiger Cleaver gets 2 facts** (it is a cleaver, it
ships in a leather sheath) in NK913 and **1 fact** in NK914, with *"Never its
size, never 'heavy', never bone, and do not explain the 'Tiger' name"*. That
retires the *"over ten inches"* dimension flag and the *"tiger engraved"*
method flag — **by forbidding both**. NK896, in this same run, says both.

And **the LOKI Viking's facts are capped** in NK915: *"it's the bestseller, and
it has Viking in the name. Do not describe its handle, box or anything else."*

## 🔑 "Bottle opener tip" is boilerplate in the Visual-cell template — a one-place fix

This is the second finding of this shape, after the ultimatum line in the
persona block, and it is cleaner than that one.

The phrase **"showing the blade and handle and bottle opener tip"** appears in
the Visual column of **five briefs across both strategists**: NK912, NK913,
NK914, NK915 (Mark) and NK919 (Andy). In every case the VO in the same brief is
**correct**:

| Brief | Visual cell | VO in the same brief |
|---|---|---|
| NK912 | *"...and bottle opener tip"* | *"it opens a bottle off the handle"* ✓ |
| NK913 | *"...and bottle opener tip"* | *"the bottle opener lives in the handle, not the blade"* ✓ — **same table row** |
| NK914 | *"...and bottle opener tip"* | (the Reaper's facts; see below) |
| NK915 | *"...and bottle opener tip"* | *"there's a bottle opener in the handle"* ✓ |

NK912, NK913 and NK915 each also carry the red-callout rule *"The bottle opener
is built into the HANDLE. Not the blade, not the spine"* — on the same page as
the offending cell. **Nobody believes the opener is in the tip.** It is a pasted
snippet in the visual-direction template that has never been edited, and it is
reaching editors as a shot instruction.

Fix the template string once and five briefs plus every future one are correct.

## 🚨 NK914 attaches the LOKI Reaper's facts to the Blackout's name

The one real product error in Mark's eight, and it is the exact confusion NK909
warned about one day earlier.

NK914's roster note is deliberate: *"No Blackout here — **the LOKI Reaper takes
its slot**, which also keeps the 2 opener positions out of the same lineup."*
Its red callout is correct: *"LOKI Reaper: only 2 facts. The opener is notched
into the blade, and the tip runs straight."*

But block 8's VO reads:

> *"The LOKI **blackout**. The opener is notched right into the blade, and the
> tip runs straight."*

The Reaper's facts, under the Blackout's name — which states the thing NK909
exists to prevent. The Visual cell compounds it (*"Montage clip of blackout...
and bottle opener tip"*), so the editor is told to shoot the Blackout too.

**It is a one-word fix in the VO plus the Visual cell**, and it matters more than
usual because NK914 went to Fahad, who has had two briefs ever and no history to
catch it against.

## ⚠️ A dated rule change reached one brief out of eight

NK916 says:

> *"**'Black Friday Sale' is allowed, and wanted.** The strategist lifted the
> house ban on the word 'sale' for Black Friday briefs on 2026-11-17.
> 'Discount' is still banned, and so is any superlative about the sale itself."*

The other seven briefs in the same queue all say *"No sale language. Never
'discount', 'sale', or 'biggest deal of the year'."* NK916 is the newest and
carries the change; NK908–915 were not updated.

So the editors currently hold eight briefs where seven ban a word and one
requires it, with the change dated today. NK916 is presumably right — but
somebody has to say so, because an editor reading two of these back to back will
assume one is a mistake.

## 📌 Other findings

- **🚨 NK866 arrived with a populated `Delivery Link`** —
  `next.frame.io/.../0fc3852e-b411-47cb-86a0-385d5f14e1cc`. Every other brief
  this play has routed had it empty; it is the field editors fill on delivery.
  A brief sitting in `Ready to edit` with a delivery already attached most
  likely means it was cut, delivered, and then returned to the queue — in which
  case `Revision needed` is the status that fits, and Fahad should know a cut
  exists before he starts. It gated clean and was posted, but **check it before
  he spends a day on it.** This is a new edge case; the gate does not cover it.
- **Both new editors are now live.** NK915 and NK916 are **Waheed's first two
  briefs** and `#11-waheed-editing` (`C0CEJBP4MQC`) took both posts and both
  thread replies. With NK873 and NK914, Fahad is on his second and third. The
  2026-11-09 channel verification is now confirmed in use for both.
- **🎯 A new brief technique worth naming: the collision guard.** Mark's briefs
  now cross-reference other concepts by ID to stop a new brief duplicating one
  that exists — *"that hook is already NK135 'Triple Discount'"*, *"the picking
  decision is NK214 / NK762"*, *"NK421-423 already runs the offer as the
  concept"*, *"the gift space is the most crowded corner of the Feather book"*
  with six concepts named, *"do not close on 'replaces everything' — that is
  NK388-389 and NK175"*, *"a catalogue of 4 would work against it (the NK461
  precedent)"*. Nothing else in the corpus does portfolio-level deduplication
  inside the brief.
- **🎯 And the inspo-hygiene block.** NK913 refuses the source's claims one by
  one, quoting them: no dishwasher or care claim (*"the source is built on
  'dishwasher safe'"*), no speed claim (*"'time back with my family' is a
  time-saving claim — refused"*), no health or testing claim (*"'free from
  forever chemicals' and 'third-party testing' do not come across in any
  form"*), no durability claim. NK910 catches a figure that would have been
  imported wholesale: *"Ours is 30 days. The source says 60 — never inflate
  it."*
- **🎯 Avatar choice is now justified in writing.** NK911: *"Why VANCE and not
  JOHN, although the Santoku is JOHN's product: the voice says outright that he
  is not serious about knives, which contradicts the collector. §C.3.1 makes
  JOHN *eligible* for offer-led concepts, not mandatory — and this script's
  voice decides it."* First brief to cite the process doc by section.
- **🎯 NK908 refuses a durability claim on purpose and says so**: *"No
  durability or 'built to last' claim. The script deliberately refuses one —
  keep it refused."* The body executes it — *"I'm not going to tell you it's
  indestructible. I'll tell you the steel is Hand-Forged high-carbon and the
  brass is solid"* — and the persona note calls that *"the most important line
  on the page. Do not soften it."* This is the antidote to *"basically
  indestructible"* (NK707/708/709).
- **🎯 NK916 states the correct form of the scarcity claim**: *"The scarcity is
  real — keep it exact. Runs of 500, 3 months to the next. Never 'sold out',
  never 'selling fast', and never claim the sale makes it go faster."* Directly
  opposite to NK849/NK851's fourteen hooks of invented stock panic.
- **Santoku ebony reaches 10.** NK866 (*"carved ebony handle"*) and NK896
  (*"Carved ebony handle"*) add two. Meanwhile NK908, NK911 and NK914 — same
  day, same product — use *"a handle carved by hand"*, *"a handle somebody
  carved"* and *"The handle is wood, carved by hand"*. The correct form exists
  three times over in the same queue.
- **🚨 NK866 asks for the forbidden shot**: *"two Santokus side by side showing
  the different engravings"*, paired with *"because it's hand-forged, no two
  Santokus will ever look the same"*. Same instruction class as NK865's two
  Feathers, and against NK908/NK911/NK914's engraving rule.
- **NK866 contradicts itself on the dragon**: reason #1 says *"a dragon sculpted
  into the bolster"* ✓, reason #3 says *"A dragon carved into the handle"* ✗.
- **NK896's blacksmith has an invented personal life** — *"Hands covered in burn
  marks. Up before the sun. Goes home to a wife and two kids... right now he's
  working out how to pay for Christmas"* — the same class as NK895's *"Who's
  going to tell his kids Santa isn't coming this year?"* Tone call, but it
  attributes specific circumstances to a real supplier.
- **✅ Andy picked up two of Mark's production notes.** NK896 carries *"Say
  'BJORN' as one syllable: type it 'Byorn' in ElevenLabs"* and *"The ODIN shot
  is the ODIN 6" Chef Knife, not the Hybrid Cleaver"*. Both originated in Mark's
  briefs. Worth saying: things do travel between them — these two did.
- **"Free returns" is in all ten of Mark's briefs this week** (NK907–916) and
  NK844 cut it deliberately on 2026-11-12 (*Changed: "Free returns." → cut*).
  At 10-to-1, NK844's cut now reads as a decision local to that script rather
  than a policy. **Downgrading this from a contradiction to a one-line
  confirmation.**
- **Five concepts in this routine now come from HexClad's ad library** (NK865,
  NK866, NK867, NK913/914/915, NK916 — NK916 calls itself *"the fifth HexClad
  source in this routine"*). Not a problem in itself; worth knowing the
  concentration. NK913's treatment (refuse the claims, keep the device) and
  NK865/866/867's (copy the caption styling) are opposite approaches to the same
  advertiser.
- Metadata: **seven briefs have `Category` = `Net New` while their Batch name
  says `Adapt`** (NK910–916). The file names and the database will disagree.
- **"Northern Knife" as two words** in the VO of eight briefs (NK907–916). The
  brand is one word.
- Garbled Visual cells: NK908 *"Why get to clip?"*, NK910 *"Viral clip of Feder"*,
  NK913 *"Biro clip"* and *"Montage clip of header"*, NK896 *"On touchpad"* and
  *"Buy to get to click"*.

## ✅ Notion edits made on Mark's instruction, 2026-11-17: NK914 + the opener-tip phrase

Mark's instruction, verbatim: *"Fix NK914 and the bottle opener tip template"*.
Five pages edited. **These are the third, fourth, fifth, sixth and seventh page
edits this play has made** — after NK679 (weight claim) and NK795
(`Andy_EDITOR` → `Andy_Anas`), both also on his explicit instruction.

### NK914 — the Reaper's facts were under the Blackout's name

Block 8, two cells:

| | Before | After |
|---|---|---|
| Copy | *"**The LOKI blackout.** The opener is notched right into the blade, and the tip runs straight."* | *"**The LOKI Reaper.** The opener is notched right into the blade, and the tip runs straight."* |
| Visual | *"Montage clip of **blackout** showing the blade and handle and **bottle opener tip**"* | *"Montage clip of **the LOKI Reaper** showing the blade and handle, the opener notched into the blade, the tip running straight"* |

The VO's two facts were already the Reaper's and were left untouched — only the
product name was wrong. The replacement wording for the Visual cell is taken
from the brief's own red callout (*"LOKI Reaper: only 2 facts. The opener is
notched into the blade, and the tip runs straight"*) rather than invented, and
it matches the roster note (*"the LOKI Reaper takes its slot"*).

**Verified by re-reading the page after the edit**, per the NK795 rule. A
second pass tidied a stray space before a comma that the first edit left in the
Visual cell.

### The opener-tip phrase — four more pages

`and bottle opener tip` → `and the bottle opener in the handle` in the Visual
column of **NK912, NK913, NK915** (Mark's) and **NK919** (Andy's). All four are
genuinely the Blackout, where the opener is in the handle.

**NK913 spot-checked by re-read:** its block 8 Visual cell and its VO now agree
(*"...and the bottle opener in the handle"* / *"the bottle opener lives in the
handle, not the blade"*), where before they contradicted each other inside one
table row. NK912, NK915 and NK919 returned clean with no warnings; a
`content_updates` operation that matches nothing is reported in `warnings`, so a
clean return means the replacement applied.

### Editors were told, because they already had the briefs — 🛑 practice since retired

All five briefs were already `Assigned to Editor` and posted, so each fix was
noted as a plain thread reply under the brief's own message — the NK646 and
NK679 precedent (*"changed it and noted it in Umar's thread, since he already
had the brief"*). Fahad got the NK914 correction naming the Reaper; Onyeka
(×2, for NK912 and NK919), Umar and Waheed got the one-line opener note.

> 🛑 **Retired the same day.** Mark's standing instruction of 2026-11-17
> (*"Whenever there's update on script or visual no need to message on the
> thread since they will just see it inside notion"*) ends this practice. A
> brief edit now gets no thread note at all. See the rule section above.


### What was deliberately left alone

- **The `bottle opener on the back` wording in the VO of NK851, NK867, NK873 and
  NK894** — a different string, in the spoken copy rather than the Visual
  column, and all four are Andy's. Mark's instruction named the *tip* phrase, so
  these were not touched. **✅ Closed the same day**: Mark followed up with *"Fix
  the bottle opener on the back ones too"* and all four were fixed — see the
  next section.
- **NK919 is part of the "Chinese Spy" concept** that this log recommends
  pulling. Fixing its Visual cell does not change that recommendation; it was
  edited because it carried the phrase Mark asked to be fixed.

## ✅ Notion edits made on Mark's instruction, 2026-11-17 (second round): "on the back" in the VO

Mark's instruction, verbatim: *"Fix the bottle opener on the back ones too"* —
the four briefs the previous round deliberately left alone. Four pages edited,
bringing this play's total page edits to **eleven**. With these, **the whole
`bottle opener` error class is clear**: five Visual cells in the first round,
six VO instances across four pages in this one.

| Brief | Editor | Before | After |
|---|---|---|---|
| **NK867** | Hammad | 3 occurrences — one Visual cell, two VO lines | `bottle opener on the back` → `bottle opener in the handle` (`replace_all_matches: true`) |
| **NK873** | Fahad | *"a bottle opener **on the back**"* | *"a bottle opener **in the handle**"* |
| **NK894** | Anas | *"the bottle opener **on the back** is real"* | *"the bottle opener **in the handle** is real"* |
| **NK851** | Renniel | *"Black blade, black handle, bottle opener on the back."* | *"Black blade, black handle **with the bottle opener in it**."* |

### NK851 was reworded, not swapped

The mechanical substitution would have produced *"Black blade, black handle,
bottle opener in the handle"* — correct on the fact and bad as spoken copy, with
"handle" twice in six words in a line built on a three-beat rhythm. It was
rewritten to keep the rhythm and the fact: *"Black blade, black handle with the
bottle opener in it."* **This is the first page edit in this play that changed
wording rather than substituting a string**, so it is recorded as a judgement
call and was disclosed as one in Renniel's thread note.

### NK867 carried the error three times, in both columns

It is the only brief where the error appears in both the Visual column and the
VO — the Visual cell, *"with a finger loop grip and a bottle opener on the
back"*, and *"A knife with a bottle opener on the back"*. `replace_all_matches`
handled all three in one operation. **Verified by re-reading the page**, per the
NK795 rule: all three now read *"in the handle"*.

**NK851 was also verified by re-read**, because its change was a rewording
rather than a substitution. NK873 and NK894 returned clean with no warnings.

### Editors were told, in each brief's own thread — 🛑 practice since retired

All four were already `Assigned to Editor` and posted, so the NK646/NK679
precedent applies again: a plain thread reply under the brief's own message.
The note names the *spoken* copy this time rather than the Visual cell — *"a VO
line said the bottle opener is 'on the back'. It's built into the handle, not
the back of the blade."* Hammad's names all three places; Renniel's also gives
the reworded line verbatim, since his was not a straight swap.

> 🛑 **Retired the same day.** Mark's standing instruction of 2026-11-17
> (*"Whenever there's update on script or visual no need to message on the
> thread since they will just see it inside notion"*) ends this practice. A
> brief edit now gets no thread note at all. See the rule section above.


### What this closes, and what it does not

**Closed:** the six instances that were known when Mark gave the instruction.

🚨 **NOT closed as a class — and this was disproved within the hour.** The
very next run (2026-11-17, third of the day) found **two more** in the
`Ready to edit` queue, both of which had been sitting there the whole time:
**NK854** carries *"Black blade, black handle, finger loop, bottle opener on
the back."* — near-verbatim the NK851 string that had just been rewritten —
and **NK881** carries *"even one with a bottle opener on the back"*. Three
more briefs also carry the `bottle opener tip` Visual phrase (NK920, NK922,
NK854), two of them authored today, after the five were fixed. **So the
instances were a symptom and the count was never the real number**: it was
the number *visible from the briefs this play had read*. The struck-through
table row above should be read that way.

**Not closed:** the finding that produced them. All six VO instances were
Andy's, and the rule was written down in Mark's NK909 and NK844 before any of
them were authored. Fixing the instances removes the symptom from six pages; it
does not make the rule travel to the next brief. **This error class will come
back unless the rule reaches Andy's brief template**, which is the one-place fix
this log has recommended twice — once for the MIKE gender-ultimatum
boilerplate, once for the `bottle opener tip` Visual-cell snippet. It came back
the same afternoon. **Stop counting instances and fix the template.**

## 🚨 2026-11-17, third run: the fix proves the rule doesn't travel, and NK881 certifies a false fact

Go signal: *"Assign task. Due on thursday"*. Eight briefs, all Andy's, all with
an editor, none Callum's, no populated `Delivery Link`. Gate passed on all
eight. Posted, "Due on Thursday" threaded, flipped; closing query empty.

NK850→Onyeka, NK853→Naveed, NK854→Waheed, NK872→Hasnain, NK881→Hammad,
NK920→Onyeka, NK921→Hammad, NK922→Hasnain.

### 🚨 NK881 is the most serious product error this play has logged

Not because the error is new — it is the NK599 copper-bolster error, which has
its own file in this repo (`brand-accuracy/santoku-bolster-discrepancy.md`) —
but because of **where it sits in the ad**. NK881 is a "we lied" public-apology
format: the whole device is the brand stating its claims and certifying each one
**True**, one at a time, each with a green check SUPER. Inside that list:

> *"We said the dragon sculpted bolster is **copper**, not plastic. **True**."*

with the instructed SUPER **COPPER DRAGON**. The bolster is **brass**. So the
ad does not merely get a material wrong in passing — **it formally certifies
the wrong material as a verified truth claim**, in an ad whose premise is the
brand's own honesty, to an audience it opens by saying *"NorthernKnife just
admitted they lied to over 147,000 customers"*. The same list certifies
**REAL EBONY**; the Santoku's handle is hand-carved wood, and ebony is the
LOKI Blackout's.

This is a different risk from the earlier tone flags (ultimatum, profanity,
"Chinese Spy"). An ad built on "here is everything we told you that is true"
which then states a false material fact about the product is an
advertising-standards exposure, not a taste call. **It needs a one-word fix
(`copper` → `brass`) and the EBONY check pulled, before Hammad builds the
green-check supers around both.**

### 🚨 NK922's opener error is load-bearing, not a stray phrase

Every previous instance of this error was a swappable noun phrase. NK922 is a
whole beat with reasoning attached:

> *"**A bottle opener built into the blade**: he opens his beer and slices his
> steak with the same hand, without putting anything down."*

The benefit is derived from the wrong placement, so there is no word to swap:
the beat has to be rewritten. The same block also says *"A finger hole in the
blade: his finger goes through it, **so the knife never slips**, even with
greasy hands"* — an absolute safety guarantee on a knife, which is a new claim
type and the kind that does not survive a complaint.

### ✅ Mark's decision on both: leave them

Offered to fix NK881's `copper`/`REAL EBONY` and NK854's *"bottle opener on the
back"*. Mark: **"No need for that"**. Both pages stand as written and went to
Hammad and Waheed unchanged.

**Read this narrowly, the way the NK644 ruling is read.** It declines *these two
edits*; it is **not** a ruling that the bolster is copper, that the Santoku
handle is ebony, or that *"on the back"* is now acceptable copy. The catalog
facts are unchanged, Mark's own NK862–864 `Do not:` lines still say *brass*,
*no wood species for the handle* and *the opener is in the handle*, and
**the next instance gets raised the same way** rather than waved through on
this answer.

Two things follow from it for how this play reports:

- **Do not re-raise NK881 or NK854.** They are closed as decided. Re-flagging a
  brief Mark has ruled on wastes his attention and makes the live flags look
  cheaper than they are.
- **The pattern across three answers is consistent**: NK644 (gender ultimatum,
  *"that's fine for now"*), the "Chinese Spy" set (no answer), and now these
  two. Mark acts on **invented numbers and wrong names** when told
  (NK646’s multiplier, NK795’s placeholder, NK914’s product name, the eleven
  opener strings) and **declines material-fact and tone corrections on briefs
  already out the door**. That is a usable rule for what to put in front of him:
  **lead with the fixable, and keep the rest to one line.** This log has been
  doing the opposite.

### Counts after this run

| Item | Before | After | Added by |
|---|---|---|---|
| Santoku **ebony** | 10 | **15** | NK850, NK872, NK881, NK921, NK922 |
| **"up to 67% off"** | 19 | **25** | NK850, NK853 ×3, NK854 ×2, NK872, NK881 |
| `bottle opener tip` in a Visual cell | 5 (all fixed) | **3 new** | NK854, NK920, NK922 |
| `bottle opener on the back` in VO | 6 (all fixed) | **2 new** | NK854, NK881 |
| NK price on a `Mkt-All` brief | 2 | **3** | NK872 (*"for less than 200 bucks"*) |
| Tiger Cleaver size + name explained | retired by rule in NK913/914 | **3 new** | NK920, NK921, NK922 (*"Over ten inches... tiger engraved"*) |

### ⏰ Time-critical, and worth saying on its own

**NK850, NK853 and NK854 have been in `Ready to edit` since 2026-11-12 — five
days — and all three are saturated with Black Friday.** NK850 says "Black
Friday" roughly fifteen times, in seven hooks and the body, and its entire
mechanic is *"the stock will not survive until Black Friday"*. Black Friday
2026 is **27 November**. The editors received them today, so they have about ten
days to cut, QA and launch creatives whose premise expires on a fixed date.
NK872 and NK881 (11-14 and 11-16) are in the same position.

That is not a copy note, it is a scheduling one: **the queue is holding dated
creative past the point where the date is comfortable**, in a database called
*Evergreen Video*. If briefs with a hard event in them are going to sit, they
need either a faster sweep or the event stripped (NK918/NK919 showed Andy can
write the same ad without naming Black Friday at all).

### 🎵 New risk class: the briefs instruct a copyrighted music track

NK920, NK921 and NK922 each instruct, in the Creative Brief Instruction:

> *"Music: **the same track as the TikTok (Elf main theme)**, loud on the hook."*

plus *"same style of font"* copied from a named real creator (@abbieherbert,
whose video is embedded). The *Elf* main theme is a copyrighted film score, and
these are paid Meta ads, not organic TikToks — the fair-use latitude a creator
has on TikTok's licensed library does not transfer. Three editors have now been
told to use it. **This is cheap to fix before the cut and expensive after**:
either a cleared library track in the same register, or Mark's explicit sign-off
that the licence is covered.

### The fake sold-out device, again

**NK853 and NK854** are the same two-voice concept, and both have the brand
state a flatly false stock fact as a gag:

> *B: "Cause there isn't any Santoku left. We're sold out."* / *A: "You're
> joking."* / *B: "I am."*

then immediately re-assert a softened version (*"Half of the Santoku stock is
already gone"*, *"more than half the stock is already gone"*). This is the
NK852 pattern. It is a deliberate device and it is funny; it is also the brand
saying "we are sold out" when it is not, twice, in an ad. Worth one decision
from Mark rather than a flag per brief.

### ✅ Two things Andy got right that earlier flags asked for

- **Profanity is now handled.** NK853 and NK854 both end the gag on *"Oh, fuck
  off."* and both carry the Note **"bip the fuck off"**. The NK769 flag was
  that the profanity had *no* bleep instruction and left Hammad deciding; here
  the instruction is on the page. The flag has its counter-example.
- **The originality gate is written into the brief.** NK872: *"Nothing from the
  source is quoted beyond the structure."* NK881: *"Every 'true' line is a real
  Santoku fact, nothing from the pan ad is quoted beyond the mechanic."* That is
  the process doc's Section F stated by the strategist, unprompted — and NK881
  is the irony: the gate held on the source and failed on the product facts.
- **Sister-brief cross-references.** NK921 and NK922 name their siblings and
  which editor holds each (*"Santoku twin of NK871 (Feather, Hammad)"*,
  *"Sister briefs: NK920... NK921..."*). This is Mark's collision-guard
  technique appearing in Andy's briefs.
- **`Category` and the Batch name agree on all eight** (Adapt/Adaptation,
  New/Net New). The seven-brief mismatch flagged on 11-17 does not recur.

### Smaller notes

- **NK854**: *"The Blackout is our fastest seller"* — NK909 reserves best-seller
  for the LOKI Viking. NK919 did the same thing with *"Our best seller"*.
- **NK872**: *"Forget spending \$1000 on an overpriced **Japanese** blade"* — the
  competitor-disparagement use of the word, still the open half of that rule.
- **NK872**: *"And it's still in stock, don't think twice"* — should be *"if
  it's still in stock"*; the typo inverts the meaning into a stock assertion.
- **NK881 contradicts itself inside the page**: the instruction says *"Meat
  first, no vegetable montage"*, and a Visual cell says *"Broll clip of cutting
  a **vegetable** with Santoku"*.
- **NK920**: *"it's gone for long"*; **NK854**: *"a guy who cooks and like
  beers"*. Garbled Visual cells: NK853 *"Buy to get to clip."* and *"Montage
  clip of multiple knives, Ram, and K"*; NK854 *"Poor Broll clip of poor
  knives"*; NK881 *"Try to get to the clip."*; NK872 *"Broll clip of Santokh
  gifting"*.
- **Scarcity**: NK850's seven hooks are seven scarcity claims (*FINAL STOCK*,
  *FINAL UNITS*, *NEARLY GONE*, *"the last ones are already leaving the
  warehouse"*), against NK907/NK909's *"never invent an end date, a clock, a
  countdown"*. NK922 adds *"Orders pouring in by the thousands... the last batch
  went in days"*.
- **"Free shipping" / "shipping is on us"** appears in NK853, NK854 and NK920.
  Like the lifetime warranty, it is load-bearing in the close and has never been
  confirmed against a product fact.

## ✅ 2026-11-23: the compliance high-water mark, and the Black Friday finding answered

Go signal: *"Assign task now due on wednesday"*. Two briefs, **both Mark's own**,
both Umar's, both created that morning. Gate passed on both. Posted, "Due on
Wednesday" threaded, flipped; closing query empty.

NK964 *Under The Feather Holiday Sale - Blackout* → Umar.
NK965 *Unplugged Holiday Sale - Feather* → Umar.

### ✅ The 11-17 scheduling finding was acted on

That run flagged that the queue was holding Black Friday creative past the point
where the date was comfortable, in a database called *Evergreen Video*. **NK964
answers it in writing, with a date and an owner:**

> *"The Feather cut, NK916, stays on Black Friday; this cut **moved to the
> Holiday Sale on 2026-11-23**, by the strategist's call."*

A new `Specialty` value, **`Holiday Sale`**, carries it on both briefs, and the
theme runs end to end — a `"HOLIDAY SALE"` super on every hook's opening frame,
the offer and the close. So the event was migrated rather than left to expire.
**Nothing further is owed on that finding.**

### ✅ And the "sale" fork resolves, correctly

The 11-17 run flagged that NK916's dated lift (*"the house ban on the word
'sale'"*) had reached one brief in eight, leaving editors holding seven that
forbade the word and one that required it. The rule is now stated properly:

> *"**'Holiday Sale' is allowed, and wanted.** 'Discount' is still banned, and
> so is any superlative about the sale."*

The ban was never really on *sale* — it is on **discount** and on superlatives.
That is a usable rule rather than a word-list, and it closes the fork.

### 🎯 These two briefs are the most compliant work in the corpus

Every rule this log has reported over two months appears on these pages as a
pre-emptive red callout, **with its reason attached**. Not a sample — the list:

| Rule this log has chased | How the brief states it |
|---|---|
| The opener is in the handle | *"built into the **HANDLE**. Not the blade, not the spine. **The LOKI Reaper is the blade one.** Never let a visual show the bottle meeting the steel."* |
| The Viking is the bestseller | *"The LOKI Viking is the bestseller, not the Blackout. The Blackout is its all-black remake."* |
| "Black right through" | *"'Every surface you can see' is as far as the black goes. 'Black right through' is not a verified fact — never say it or imply it."* |
| Full-Tang is Feather-only | *"No Full-Tang on this page. That claim is Feather-only."* |
| Batch cap / restock are Feather facts | *"No scarcity. The batch cap and restock window are Feather facts."* |
| Feather pattern technique | *"Never describe how the feather got onto the blade. Name the pattern. Never etched, engraved or hand-finished."* |
| Scarcity form | *"runs of 500, about 3 months to the next. Never 'selling out', never how fast a run went, **and never that the sale makes it go faster**."* |
| No price, no percentage | *"B2G2 is a mechanic."* |
| Customer count | *"147,000 customers."* |
| No manufactured urgency | *"No invented deadline — no end date, clock, countdown or 'hurry'."* |
| Named cuts of meat | *"'Meat' — never a named cut. Holiday carving invites one. Not in the VO, not in a super, not in a visual direction."* |

The offer lands at ~72% and ~71% through, with beats after it, exactly as the
process doc requires — and both briefs state the percentage in the Note column.

### 🆕 Four rules that are new, and three of them are pre-emptive

- **“No delivery promise — never ‘in time for Christmas’.”** On both briefs. This
  is the claim a Christmas-framed ad invites hardest, in the week it is least
  safe to make, and it was banned before anyone wrote it.
- **“No weather claim in either direction.”** NK964, because a grill setting
  invites one.
- **“No brand on the electric knife. It’s the enemy, not a named one.”** NK965.
  **Worth putting directly against NK872’s *"Forget spending \$1000 on an
  overpriced Japanese blade"*** — same job (position against the thing the buyer
  already owns), one done without naming or disparaging anyone. That is the
  answer to the open competitor-disparagement item, written by Mark, in the form
  the next brief can copy.
- **“Never call the Feather a carving knife**, and never describe its blade shape
  as a spec. It carves. That’s all we say.” NK965 — a product-category
  guardrail, new.

### 🎯 A new technique: naming the confusion the brief itself creates

NK964 is called **"Under The Feather Holiday Sale - Blackout"** and there is no
feather on a Blackout. The brief pre-empts it in its own callout:

> *"The concept name comes from the Feather cut. **There is no feather on this
> knife** — the name groups the trio."*

That is the strategist anticipating a cross-product visual error of exactly the
kind NK919 made when its Feather block told Onyeka to shoot the Tiger Cleaver.
It is cheap to write and it removes the error class. **Copy it anywhere a
concept name travels across products.**

### 🆕 Mapping gap: `Ali` and `Abdul` are now on the `Editor` property

The schema's `Editor` options now read: Hasnain, Renniel, Umar, Hammad, Onyeka,
Anas, Naveed, Huzaifa, Waheed, Fahad, Mark, **Ali**, **Abdul**.

Neither was used this run, and **neither has a verified Slack channel in the
mapping above**. This is the same gap shape as Waheed and Fahad on 2026-11-04,
which sat open for five days until Mark mentioned the new editors mid-run.
**Flagging it now rather than discovering it mid-sweep**: the first brief
assigned to Ali or Abdul will fall to Mark's fallback channel under the
never-guess rule. Two channel IDs would close it — and per the resolved-channels
section, they must be read from a listing, never from `slack_search_channels`.

### Smaller notes

- **`Category` says `Net New`, both Batch names say `Adapt`** — and both briefs
  genuinely are adaptations of HexClad sources, each with a "What transferred,
  and what could not" block. So here the **property** looks wrong, not the name.
  That inverts the earlier seven-brief mismatch, where the Batch name was the
  odd one out.
- **NK964's Batch name says `6r-Blackout`**, but `Landing Page` is
  `6 Reasons - General` and **no Blackout option exists** in the schema
  (PDP, Offer Page, 6r-General, 6r-Outdoor, 6r-Sharpener, 6r-Santoku). The
  Batch name names a landing page that does not exist.
- **"Free returns." is in both closes.** That makes 12+ of Mark's briefs against
  NK844's single deliberate cut. It is settled house copy; **this log should
  stop tracking it.**
- **"Northern Knife" is two words in both**, in block 1 of each (*"from Northern
  Knife"*). The item has been open on eight of Andy's VOs; it is now in Mark's
  own briefs too, which moves it from a slip to a house inconsistency. One
  decision on the spelling settles all ten.
- **The trio is split across statuses.** NK964 names NK916 (Feather) and NK963
  (Santoku) as its siblings. NK916 was assigned on 11-17; NK963 was not in this
  queue. So one concept reached its editor in three separate sweeps — worth
  knowing when Umar asks why he has one third of a set.
- **No thread notes were sent for anything beyond the due day**, per Mark's
  2026-11-23 standing instruction. Nothing needed one.

## 🚨🚨 2026-11-23, second run: the same product, the same day, opposite instructions

Go signal: *"Assign task due on Due on wednesday"* (typo; read as Wednesday).
Seven briefs — **three of Mark's Holiday Sale cuts and four of Andy's R2B8 Santa
UGC cuts**. Gate passed on all seven. Posted, "Due on Wednesday" threaded,
flipped; closing query empty.

NK963→Hasnain, NK966→Hasnain, NK967→Fahad, NK974→Hasnain, NK975→Hammad,
NK976→Umar, NK977→Hammad.

### 🚨 This is the clearest evidence the rule-travel finding will ever get

Every earlier version of this finding had a gap in it — different weeks,
different products, a rule written after the brief. **This run has none of
those outs.** Same date, same products, both strategists, and the contradictions
reached the same editors within hours of each other:

| | Mark, 2026-11-23 | Andy, 2026-11-23 |
|---|---|---|
| **Scarcity on the Blackout** | NK964, NK967: *"**No scarcity.** The batch cap and restock window are **Feather facts**."* | NK974, NK975: *"their **limited edition** Loki Blackouts"* |
| **How the Feather's run is described** | NK965: *"runs of 500, about 3 months to the next. **Never 'selling out', never how fast a run went**, and never that the sale makes it go faster."* | NK975, NK976, NK977: *"They only make about five hundred at a time. **And it always sold out in days.**"* |
| **Percentages** | All three: *"**No price, no percentage.** B2G2 is a mechanic."* | NK977: *"buy two, get two free **and up to 67% off**"* |
| **Invented urgency** | All three: *"**No invented deadline** — no end date, clock, countdown or 'hurry'."* | NK975, NK976: *"This is a **limited time deal and it might not be available when you watch this video**."* NK977: *"only runs **while stock lasts**, and once it's gone, it's gone."* |
| **Customer count** | All three: *"**147,000** customers."* | NK975, NK976, NK977: *"**100,000** customers."* |

**And one editor holds both sides.** Hasnain was handed NK963 and NK966 (Mark's,
carrying the rules) *and* NK974 (Andy's, breaking them) in the same sweep, in the
same channel, minutes apart. Hammad holds NK975 and NK977.

There is nothing left to establish about this finding. **The only open question
is whether Mark's `Do not:` block gets into the brief template.**

### 🚨 The customer count has forked again, and this time backwards

It was "resolved" to **147,000** on 2026-11-09 (seven briefs, five as an
on-screen super). The 11-16 run found it forked inside Mark's own briefs the
same morning. It was re-confirmed on 11-17 with a dated note (*"updated
2026-11-16 from 100,000"*). **Today Mark's three say 147,000 and Andy's three
say 100,000.**

This one is worth separating from the copy flags because **it is not a style
question and it is not arguable**: it is a single number, it appears in the
proof stack of nearly every ad, and the two strategists are 47,000 apart on the
same day. If it is in the brief template once, it stops forking.

### 🚨 NK976's fifth hook is an innuendo, and it is in the hook

> *"So my wife finally got me a knife **as big as my.. You know what I mean**,
> for Christmas."*

This is not the same thing as the tone flags this log has filed before (the
ultimatum, the profanity, "we lied"). Those were register and positioning
calls. This is a **phallic innuendo with the punchline deliberately left to the
viewer**, placed in the **first three seconds**, where a viewer cannot skip past
it and where Meta's review looks hardest — and it is delivered **on camera by a
real named creator**, Ryan, whose face carries it.

Routed per the editor-slot-only gate, as always. **But it needs Mark's call
before Umar cuts it**, and unlike the earlier tone flags there is no version of
this that is only a matter of taste: it is the kind of line that gets an account
flagged rather than an ad rejected.

NK976 also carries three more size claims on the Tiger Cleaver (*"the size of my
forearm"*, *"so massive"*, *"a viking axe"*) — the claim NK913 and NK914
retired by rule on 11-17.

### 🔑 The MIKE boilerplate is 11 days old as a known one-place fix, and it has now produced 7 hooks

All four of Andy's briefs carry the **identical** persona block, and inside it:

> *"For him we can do more hard marketing “Ïf you’re wife didn’t get you this
> gift, you need a new wife”"*

That sentence was identified as the root cause on **2026-11-12**. It is still
there, unedited, and this run it generated:

- **NK974** — 3 of 3 hooks
- **NK975** — 3 of 6 hooks
- **NK976** — 3 of 6 hooks

**Seven ultimatum hooks in one sweep**, from one unedited sentence in a pasted
block. Mark cleared this line on NK644 *explicitly as a one-off*; it has now
appeared in NK855, NK856, NK858, NK859 and these three. Raising it per the
standing rule.

The same block remains garbled in the way first noted on 11-12: it lists
**SARAH, MIKE - GRILL MASTER, DON - OPPORTUNIST, DON | The Hunter and COLE** —
five personas, **two of them called DON** — while the `Avatar` property on all
four briefs is **`VANCE- The Opportunist`**, who appears nowhere in it. The
editor is given five personas, none of them the one the brief is for.

### ✅ Mark answered the NK881 copper error — forward, in the template

He declined to edit NK881 on 11-17 (*"No need for that"*). **NK963, written six
days later, closes both halves of that error as rules:**

> *"It's **brass**, with a dragon sculpted into it."*
> *"**'Sculpted' is the catalog's word for the dragon, and it is the only one.**
> Never 'solid', never 'cast', never anything else about how the bolster is
> made."*

and the handle is *"Wood, **carved by hand**"* — no ebony. NK966 repeats both.

**That reframes the earlier decision.** "No need for that" was not indifference
to the fact; it was declining to re-touch a shipped page while fixing the cause
in the next brief. Worth recording, because this log read it as the former. The
useful lesson for this play: **when he declines a page edit, check the next
brief before concluding the item is unresolved.**

### 🆕 New house visual spec: Christmas subtitle pills

All three of Mark's briefs carry a green callout with an image asset and exact
values:

| Pill | Background | Text |
|---|---|---|
| Red (hook line) | `#D7263D` | `#FFFFFF` |
| Green (offer line) | `#1B6B3A` | `#FFFFFF` |
| White (neutral line) | `#FFFFFF` | `#1B6B3A` |

Default stays the usual black-and-white supers; the pills are optional per hook
or per section. First appearance of a colour spec in a brief, and the first
time the subtitle treatment has been given hex values rather than described.

### ✅ Two roster edge cases closed at source

The `Editor` property options are now: **Hammad, Umar, Onyeka, Hasnain, Renniel,
Anas, Naveed, Waheed, Fahad, Ali, Abdul** (11).

**`Huzaifa` and `Mark` have both been removed.** That retires two rows that this
spec has carried as special cases:

- **`Huzaifa` — "off roster, never assign"** (since 2026-10-13). No longer
  selectable, so the edge case cannot occur. The row stays in the mapping table
  as history, marked.
- **`Mark` as an `Editor` option** (added 2026-11-16, never used, no editor
  channel). Also gone, which closes that gap without it ever biting.

The fallback channel (`#11-mark`, `C09QUL7S3GA`) is unaffected — it is still
where exceptions go. What changed is that `Mark` is no longer a *destination* an
editor slot can name.

### Counts after this run

| Item | Before | After | Added by |
|---|---|---|---|
| `bottle opener tip` in a Visual cell | 3 (post-fix) | **6** | NK975, NK976, NK977 |
| **"up to 67% off"** | 25 | **26** | NK977 |
| "three times sharper" (NK646 class) | — | **4 new** | NK974, NK975, NK976, NK977 |
| Ultimatum hooks | 4 briefs | **7 hooks / 3 briefs** | NK974, NK975, NK976 |
| Uncensored profanity, no bleep | — | **2 new** | NK974, NK975 (*"those other bullshit knives"*) |
| Stale 100,000 count | closed 11-09 | **3 reopened** | NK975, NK976, NK977 |

### ✅ One thing Andy's VO got right that the Visual column did not

**All three extension briefs say the opener correctly in the spoken copy** —
*"a bottle opener **forged into the handle**"* (NK975, NK976, NK977) — while the
Visual cell in each still reads *"showing the blade and handle and **bottle
opener tip**"*. That is the NK913 shape exactly: the rule has reached the VO and
not the shot template. It is more evidence for the same one-place fix, and it
means the error is now **only** in the boilerplate, nowhere a writer typed it
fresh.

### Smaller notes

- **NK974 has no Visual direction at all.** Every cell in both the HOOK and BODY
  tables is empty, and the AD INSPO block is an empty `<video />` tag. Hasnain
  has the copy and nothing else. The other three extensions have full Visual
  columns, so this looks unfinished rather than intentional.
- **NK975 names the "ODIN Chef Knife"**, which is not in the catalog
  (`ODIN SET`, `ODIN 6 Boss`, `ODIN 8 Boss`, `ODIN Hybrid Cleaver`). Same error
  as NK858.
- **NK967 says "ebony handle" and is correct** — ebony *is* the Blackout's
  handle. Worth stating plainly in this log, because 15 instances of
  "Santoku ebony" could be misread as a ban on the word: the rule is
  **ebony on the Blackout, hand-carved wood on the Santoku**.
- **NK975 keeps the "batman" descriptor** (*"something batman would use"*),
  first flagged 2026-11-05 as a trademark and tone call.
- **"Northern Knife" is two words in all seven briefs**, both strategists. At
  this point it is the house spelling in practice. **One decision retires the
  item**; until then this log should stop counting it.
- **`Iteration` is `__NO__` on all four of Andy's** while `Category` is
  `Iteration` — the checkbox and the select disagree on every one.
- **Gate handled 6-hook briefs correctly**: NK975 and NK976 each have 6 hooks
  and 6 matching File naming rows, all reading `Andy_Hammad` / `Andy_Umar`.

## ✅ The MIKE persona block, fixed on Mark's instruction — 2026-11-23

Mark, verbatim: *"Fix the MIKE persona block"*. This is the one-place fix this
log had recommended since 2026-11-12.

### 🔍 First finding: there is no source page. The block is pasted per brief.

Searching for the exact sentence returns **25+ pages across four databases** —
`Evergreen Video`, and the Holiday Brief Database's `Father’s Day Sale`, `EOFY`
and `Memorial Day Sale` — going back to **May 2026**. There is no master page,
no shared block, no linked database holding it. Every brief carries its own copy.

**So "the block" is not one object that can be edited once.** Whatever Andy
copies from is upstream of anything this play can reach through the API — almost
certainly a Notion *database template*, which the connector does not expose.
**That part has to be edited in the Notion UI by Mark or Andy**; this play cannot
do it, and a brief created from that template tomorrow will carry the old
sentence again.

### 🚨 Second finding, and the better argument: the block contradicts the real persona doc

There **is** a canonical persona document — `MIKE | The BBQ Guy/Grill Master`,
in `NK Creative Strategy Lab / Buying persona's`. **It does not contain the
ultimatum line.** It says the opposite, in three places:

| The canonical MIKE doc | The pasted block |
|---|---|
| **He recoils FROM:** *"'He'll love it' / **wife-buyer framing**"* | *"For him we can do more hard marketing “If you’re wife didn’t get you this gift, you need a new wife”"* |
| **He recoils FROM:** *"**Soft, gifting-focused language**"*, *"Generic 'perfect gift' language"* | The whole R2B8 concept frames him as the gift recipient |
| **What to avoid:** *"**Gift-framing language** ('perfect for him', 'he'll love it', 'surprise him')"* | — |
| *"Buyer type: **Self-buyer — always.** He is the buyer and the user simultaneously"* | — |
| *"'He'll love it' lands in the wrong universe — ***he*** is the he"* | — |

So the pasted block is **not a degraded copy of the persona doc. It is a
different document that contradicts it.** The ultimatum line makes MIKE the
*recipient* of a wife's gift, which his own persona doc names as the single
thing he recoils from hardest. That is a stronger reason to cut the line than
any tone argument this log has made, and it is Mark's own source material.

### What was changed

The sentence, before and after:

| | |
|---|---|
| **Before** | *"For him we can do more hard marketing “Ïf you’re wife didn’t get you this gift, you need a new wife” We can use harder marketing, a deeper darker voice on Eleven Labs, some rock music too, even hard rock."* |
| **After** | *"For him we can use harder marketing: a deeper darker voice on Eleven Labs, some rock music too, even hard rock. **Never frame him as the gift recipient of a wife-buyer, and never use the “you need a new wife” line** — the MIKE persona doc lists “wife-buyer framing” and “soft, gifting-focused language” under what he recoils from."* |

The legitimate direction is kept (harder marketing, deeper voice, rock). The
ultimatum is replaced by the prohibition **plus its reason**, cited to Mark's own
persona doc — because a bare deletion gets re-added by the next writer, and a
rule without a reason gets argued with.

**Applied to the four live briefs**, all `Assigned to Editor`, all assigned
earlier the same day: **NK974, NK975, NK976, NK977**. **Verified by re-reading
NK976**, per the NK795 rule; the block now carries the rule and the ultimatum is
gone from it.

### 🛑 What was deliberately NOT touched

- **The hooks.** NK974 (3 of 3), NK975 (3 of 6) and NK976 (3 of 6) still open on
  the ultimatum as **hook copy**. Mark asked for the *block* fixed. The block is
  the cause; the hooks are a strategist's creative decision, and deleting seven
  hooks from assigned briefs is not what was asked. **They are still live and
  still need his call** — raised separately.
- **One brief with `Strategist = Callum` also carried the block.** Not read
  beyond the query row, not edited, not triaged. The standing instruction of
  2026-10-13 has no exception for a fix Mark ordered on other briefs.
  **Closed, not tracked** — per the 2026-11-24 settlement below, a Callum brief
  does not belong on an open-items list at all, so its ID has been removed from
  this entry. It is his to review.
- **The four shipped R2B8 briefs** — NK855, NK856, NK858, NK859, all
  `Uploaded on Drive`. Changing a brief after the asset has shipped changes
  nothing about the asset.
- **Everything in the Holiday Brief Database** (Father’s Day, EOFY, Memorial Day)
  and the older Evergreen instances. All long shipped; a backfill is Mark's call
  and would be a sweep of 20+ pages for no live effect.

### 🔧 A cheap technique worth reusing

The 14 upstream Santa briefs in `Ready for visuals` (NK955–NK973) were probed by
sending the `update_content` call straight at them **without fetching first**.
A non-matching `old_str` makes the call **fail with `No matches found` and change
nothing** — so it is a safe existence test. All 14 failed, which proves they do
**not** carry the block, at the cost of one call each instead of a ~12k-token
fetch each.

Use this whenever a known string has to be found or fixed across many pages:
**fire the edit, read the failures.** It cannot damage a page that does not match,
and it is the only way to check a large set affordably. The one caution is that
it writes to the pages that *do* match, so it is for cases where the edit is
wanted everywhere the string appears — not for reconnaissance alone.

### What is actually closed, and what is not

**Closed:** the block in every live brief this play may touch.

**Not closed:** the template. Until the page Andy creates briefs from is edited,
the sentence comes back on the next brief, and this play will be fixing instances
again. **That edit needs the Notion UI and Mark or Andy** — it is the one part of
this fix that cannot be done from here, and it is the part that matters.

## 🛑 2026-11-23: scope narrowed to Mark's work only

Mark, verbatim: *"Never touch callum or Andy's output only from Mark"*.

The hard rule at the top of this doc is rewritten accordingly, the detection
query now reads `AND "Strategist" = 'Mark'`, the edge-case table row is widened
from Callum to "anything but Mark", and `CLAUDE.md` is updated to match. **The
rule is now an allowlist of one.**

### What changed, precisely

| | Before (2026-10-13 → 2026-11-23) | After |
|---|---|---|
| Shape | Blocklist — skip `Callum`, take everything else | **Allowlist — take `Mark`, skip everything else** |
| In scope | `Mark`, `Andy`, `Mauro`, `Claude`, blank | **`Mark` only** |
| Out of scope | `Callum` | `Andy`, `Callum`, `Mauro`, `Claude`, blank |
| Query clause | `("Strategist" IS NULL OR "Strategist" != 'Callum')` | `"Strategist" = 'Mark'` |

The allowlist is the safer shape for a second reason worth recording: **a new
`Strategist` option added to the property later is out of scope by default.**
Under the blocklist it would have been swept up silently. The `Editor` property
has gained four names in three weeks, so the `Strategist` property gaining one is
not hypothetical.

### The volume consequence, measured

| Strategist | Briefs created in Nov 2026 | Share |
|---|---|---|
| Andy | 121 | 52% |
| **Mark** | **25** | **11%** |
| Claude | 1 | <1% |

And the pipeline immediately ahead: **all 26 briefs in `Ready for visuals` are
Andy's**, and none are Mark's. So the next several sweeps will find a queue and
assign almost nothing from it.

**This is the instruction working as written.** It is recorded here so the play
does not re-raise it every run, and so a future reader does not mistake a nearly
empty run for a broken query. **Say "N in the queue, M of them Mark's, M
assigned" in the run summary** rather than listing the rest.

### The open gap, raised once

**Andy's briefs — roughly 120 a month — now have no handoff route through this
play.** Callum's never needed one: he is a member of every editor channel and
does his own handoffs, which is why that exclusion never left a gap. Whether the
same is true of Andy is **not established anywhere in this spec**, and his briefs
have been routed by this play since 2026-10-13. If he does not route them
himself, 26 briefs are about to reach `Ready to edit` with nobody assigning them.

Not re-raised after this entry. If Mark says Andy routes his own, this becomes a
closed question and should be recorded as one.

### ⚠️ In flight when the instruction arrived

**Four of Andy's briefs were posted, threaded and flipped earlier the same day**
(NK974, NK975, NK976, NK977), and their MIKE persona block was edited on Mark's
own instruction minutes before this one. All of that was correct under the rule
in force at the time.

**Nothing was reversed.** Un-flipping them or deleting the Slack posts would take
briefs away from three editors who already have them and are cutting them for
Wednesday, which is a worse outcome than the scope breach it would tidy up, and
the instruction reads forward rather than retroactively. **Flagged to Mark as a
question rather than acted on** — if he wants them pulled back, that is a
deliberate reversal to do on his word, not a cleanup to assume.

The rule applies from this point: **the next sweep takes Mark's briefs and
nothing else.**

## 🚨 2026-11-24, second run: scope restored, and the NK795 placeholder is now a batch-wide pattern

Mark: *"Andy is fine since I also manage that only callum's work will never be
touch"* — reverting the 24-hour narrowing. The Thursday go signal was still
live, so the sweep was re-run rather than waiting for a new one.

Queue: **7 of Andy's in scope**. Gate passed
on 4, **failed on 3**. Posted 4, "Due on Thursday" threaded, flipped.

NK941→Renniel, NK944→Hammad, NK956→Naveed, NK961→Onyeka.

### 🚨 Three gate failures, same cause: `Andy_EDITOR` left unreplaced

**NK968** (`Editor` = Hasnain), **NK970** (Hammad) and **NK972** (Naveed) all
carry the literal placeholder **`Andy_EDITOR`** in the Batch name *and* in every
File naming row — 3, 5 and 3 rows respectively. Held, not posted, status left at
`Ready to edit`.

**This is the NK795 case from 2026-11-09, and it has gone from one row to three
whole briefs.** On NK795 a single H1 row read `Andy_EDITOR` against `Andy_Anas`
in the Batch name and the other two rows; here nothing is filled in anywhere, so
there is no second value to compare against.

**Why it is still a hold and not a safe auto-fix.** All three briefs carry an
upload-checklist line reading *"File names match the table, **your name in place
of EDITOR**"* — so the placeholder is arguably addressed to the editor rather
than a slip. Two things argue the other way:

- **NK956 and NK961, same batch, same day, same author, have the real name
  filled in** (`Andy_Naveed`, `Andy_Onyeka`) — and NK961 carries the same
  "your name in place of EDITOR" checklist line anyway. So that line is
  boilerplate present on filled and unfilled briefs alike, and the filled ones
  show the intended end state.
- The gate rule is *never guess which side is right*, and the NK795 precedent is
  that Mark was asked and answered **"fix and assign"**. One token per row, taken
  from the `Editor` property, is all it needs.

**Recommended:** substitute the `Editor` value into the Batch name and every File
naming row on all three (Hasnain / Hammad / Naveed), then post. Awaiting the word
rather than editing three pages unasked.

### ✅ Andy is now writing the rules this log has chased — and the Visual template still is not

**All five Santa briefs state the opener rule themselves**, in the Creative Brief
Instruction *and* again in an upload checklist:

> *"Blackout: the bottle opener is in the handle, never show it in the blade."*
> *"No opener in the Blackout's blade."*

and the VO in each says *"a bottle opener built into the handle"* — **correct**.
NK961 adds *"No sold-out claims on the Blackout"*, *"No countdown timer"*, *"No
review counts on screen"*, and NK956/NK968 add *"no dragon on the Tiger
Cleaver"*.

**And the Visual cell in NK956, NK968, NK970 and NK972 still reads *"showing the
blade and handle and bottle opener tip"*.** Four more instances, on pages that
forbid exactly that, twice each. The error now survives *only* in the pasted
Visual snippet — nowhere a writer typed it fresh, and nowhere a rule is missing.
**There is nothing left to establish: the snippet is the whole remaining
problem.**

✅ **Mark's Christmas subtitle pills reached Andy's briefs** — the same hex table
(`#D7263D` / `#1B6B3A`) and image appear in NK961, NK968, NK970 and NK972, three
days after first appearing in Mark's NK963/966/967. Things do travel; it is the
*product facts* that do not.

### Other findings

- 🚨 **The customer count is stale in four of the seven**: NK956 and NK970
  say *"a hundred thousand customers"*, NK961 *"Over 100,000"*. Mark's briefs say
  147,000.
- 🚨 **A new unverified proof claim**: *"Over five thousand five-star
  reviews"* (NK956, NK970) — while NK961 and NK968 both instruct *"No review
  counts on screen"*. Three briefs assert it, two ban it, same batch.
- 🚨 **Rosewood on the wrong knives again**: NK956 gives the **Santoku** a
  *"rosewood handle"* (it is hand-carved wood) and the **Tiger Cleaver**
  *"rosewood and copper handle"*; NK970 repeats the Tiger Cleaver version.
  NK968 gets it right — *"a hand-carved wooden handle"*.
- 🚨 **NK941 puts the opener in the steel**: *"a bottle opener built into
  the steel"*, and NK944 *"built right into the steel"* — the two non-Santa
  briefs, which carry none of the Santa briefs' rule callouts. Both also say
  *"a finger hole in the blade **so it never slips** in his hand"*, the absolute
  safety claim first seen in NK922.
- 🚨 **NK944: *"it's five times sharper"***; **NK941: the non-catalog
  *"ODIN chef knife in Damascus steel"***, which also introduces a steel type
  that appears in no product fact.
- **Tiger Cleaver size and stripes**: *"Ten inches of tiger-striped steel"*
  (NK956, NK968, NK970) — the size claim NK913/NK914 retired by rule, plus the
  *"tiger-striped"* form NK844 corrected to *"a tiger across the face"*.
- **Scarcity on the Blackout**: NK961's *"we only make it in limited numbers"*,
  *"For as long as this batch lasts"*; NK968 *"The last drop was gone inside two
  weeks"*; NK970 *"the last batch went in two weeks"*. Mark's NK964/NK967 say the
  batch cap is a **Feather** fact. NK968 also revives *"Three months in the
  workshop"*.
- **"the biggest deal we've ever put out"** (NK956, NK968, NK970) — a superlative
  about the sale, which Mark's Holiday Sale briefs ban outright.
- ✅ **Worth copying**: every Santa brief names its winning hook *with the spend
  behind it* (NK222 H1 took US \$84k at 1.80; NK651 H5 took US \$48k; NK401 H2 took
  AU \$35k) and says which hook it replaces and why (*"it replaces the old H1,
  which never converted"*). That is the clearest creative reasoning in the
  corpus. NK970's stacked-opening direction (silent cut, then VO, then music) is
  a real craft note, not a shot list.
- **NK941 has no Visual direction at all** — every BODY cell empty, as NK974 had.
  It does carry a tier-board reference image and a described mechanic, so it is
  less exposed than NK974 was.
- Garbled Visual cells: NK970 *"Montage clip of multiple games from NK"*,
  *"1-3 cutting clip with knockout"*, *"One Touch Tiger Cleaver"*; NK968
  *"Montage Tiger Clipper"*.

## ✅ 2026-11-24, third run: Ali's first brief, and the verified channel ID earns its keep

Second *"Assign task due on thursday"* of the day. The SQL allowance was spent
again, so the run went through the saved-view fallback. **12 of Andy's in scope** — 6 posted, 3 to the fallback channel for a blank
`Editor`, 3 still held on the placeholder gate.

NK942→Onyeka, NK945→Onyeka, NK955→Hammad, **NK958→Ali**, NK959→Waheed,
NK960→Waheed. Posted, "Due on Thursday" threaded, flipped; closing query shows
all 6 gone and no mid-run arrivals.

### 🔑 The channel-ID verification paid for itself in one day

**NK958 is the first brief ever assigned to Ali.** It went to
`#11-ali-editing` = **`C0CJ8LNCDLP`**, the ID read from the live listing on
2026-11-23 — **not** the `C0D4MN8PQR1` Mark supplied. The channel accepted both
the post and the thread reply.

Had the supplied ID been written into the mapping unchecked, this post would
have failed or gone to nothing, **one day later, on a brief nobody was watching
for** — which is exactly the silent failure mode the never-guess rule exists to
prevent: the flip would have followed the "successful" send and the brief would
have left the queue with no editor ever seeing it.

**The rule stands as written**: a channel ID is verified against a live listing
before use, whatever its source. The cost was one tool call; the averted cost was
a lost brief.

### Blank `Editor` on three briefs — the rule applied as written

**NK989, NK990 and NK991** (*Triple Discount Holiday (NK135)*, Blackout /
Feather / Santoku, all Andy's, all created today) have **no `Editor`**. Per the
blank-editor rule: **one fallback post to `#11-mark`** naming all three, and
**`Status` left at `Ready to edit`** so they stay queued until a human assigns
them. Nothing was guessed and no editor was posted to.

### The three placeholder briefs are still held

**NK968, NK970, NK972** remain in `Ready to edit` with `Andy_EDITOR` unreplaced.
The repeated go signal does not change that — the spec's definition of a go
signal is *every brief that is not Callum's **and not malformed***, and these are
malformed. They need the one-token fix per row (Hasnain / Hammad / Naveed) or
Mark's word, as on NK795.

### ✅ NK958 is the cleanest brief in the Santa set, and it is worth saying why

Of the five Santa briefs now assigned, NK958 is the only one with **no stale
customer count and no review count** — and it is the one whose instruction says
*"No review counts on screen"*. **It obeys its own rule**, where NK955 and NK959
carry the same instruction family and then assert *"Over five thousand five-star
reviews, a hundred thousand customers"* in the body. It also gets the Tiger
Cleaver handle right (*"hand-carved wooden handle"*) where NK955, NK959 and NK960
all say *"rosewood and copper handle"*.

**So the difference between the clean brief and the others is not the rules — it
is whether the body was checked against them.** Same author, same day, same
concept family.

### 🎯 NK945 has the best inspo documentation in the corpus

Its AD INSPO block names the source (Dore & Rose, 48 s, with run dates) and then
splits the analysis three ways:

- **Why it works** — *"the box is in hands and being untied in the first 2
  seconds, before a word about the product"*
- **Shape we keep** — the beat list
- **Shape we change** — *"their discount is the last line. **Ours lands at ~65%
  with three beats after it**"*

That last line is the `CLAUDE.md` offer rule (offer at 60–80%, never last,
followed by 2–4 beats) **stated as a deliberate deviation from the source, with
the figure**. It is the first brief in the corpus to show the originality gate
being reasoned rather than asserted. **Copy this block structure.**

### Counts and repeats

- **"five times sharper"** — NK942, NK945 (and NK944 earlier today). The NK646
  invented-multiplier class Mark ordered fixed on 2026-10-20.
- **Stale 100,000** — NK945 (*"more than a hundred thousand men"*), NK955, NK959.
- **"Over five thousand five-star reviews"** — NK955, NK959.
- **Tiger Cleaver** — *"ten inches"* in NK955, NK958, NK959, NK960;
  *"rosewood and copper handle"* in NK955, NK959, NK960. NK958 is the exception
  on the handle, and uses *"tiger-striped face"*, the form NK844 corrected to
  *"a tiger across the face"*.
- **`bottle opener tip`** in the Visual column of NK955, NK958, NK960 — while
  **NK959 gets it right** (*"Mauro's LOKI Blackout details, bottle opener popping
  a beer"*), which is the first Santa brief whose Visual cell is clean. One
  author, one batch, one snippet, four pages, three wrong.
- **Feather scarcity speed** — *"the last batch was gone in two weeks"* / *"sold
  out inside two weeks last drop"* in NK955, NK958, NK959, against Mark's NK965
  rule. **"Three months in the workshop"** in NK955 and NK958.
- **"the biggest deal we've ever run"** — NK955, NK959.
- **NK945 adds a new unverified claim**: *"more than twenty knife styles"*.
- **NK959 uses a new Visual shorthand** — *"As NK651"* per block instead of shot
  descriptions. Efficient for an editor who watches the original first, which the
  brief does instruct; worth watching whether it survives a handover to an editor
  who does not.

## 🚨 2026-11-24, fourth run: `Andy_EDITOR` is template-level, and "copper bolster" is back four times

The second *"Assign task due on thursday"* ran in three waves as Mark decided
the editors and the queue filled underneath it. **15 briefs posted in total**,
all gate-clean after **9 placeholder fixes**. Closing query: nothing in scope
and nothing else.

| Wave | Posted |
|---|---|
| Opening read (20 rows) | NK942→Onyeka, NK945→Onyeka, NK955→Hammad, NK958→Ali, NK959→Waheed, NK960→Waheed |
| After Mark's editor decisions | NK968→Hasnain, NK970→Hammad, NK972→Naveed, NK989→Umar, NK990→Ali, NK991→Umar |
| Mid-run arrivals | NK969→Onyeka, NK971→Umar, NK973→Onyeka |

### 🚨 The placeholder is not a slip. It is on every Santa-family brief.

`Andy_EDITOR`, unreplaced in the Batch name **and every** File naming row, was
found on **nine briefs**: NK968, NK969, NK970, NK971, NK972, NK973, NK989,
NK990, NK991. That is **every brief Andy created on 2026-11-23 and 2026-11-24**
in the Santa and Triple Discount families.

The escalation is worth stating plainly:

| Date | Scope |
|---|---|
| 2026-11-09 | **NK795** — one File naming row, against a filled Batch name |
| 2026-11-24 (am) | **NK968/970/972** — three briefs, nothing filled anywhere |
| 2026-11-24 (pm) | **nine briefs** — the whole day's output |

**This is a template field that stopped being filled, not an author forgetting.**
Every one of the nine also carries the checklist line *"File names match the
table, your name in place of EDITOR"*, so the placeholder and the instruction to
replace it ship together — and NK955, NK958, NK959, NK960 from the same family
have real names filled in and carry that same line. **The fix belongs wherever
the Batch name is generated**, not in nine pages a day.

### 🚨 "Copper bolster" is back, four times, three days after Mark ruled on it

NK969, NK971, NK973 and NK991 all say the Santoku has **a dragon sculpted into
the copper bolster**. It is brass.

This matters more than a repeat count because of the sequence:

- **2026-11-17** — NK881 certifies *"the dragon sculpted bolster is copper...
  True"*. Offered to fix it; Mark said **"No need for that"**.
- **2026-11-23** — his own NK963 states the rule: *"It's **brass**, with a dragon
  sculpted into it"* and *"**'Sculpted' is the catalog's word for the dragon, and
  it is the only one.** Never 'solid', never 'cast'."*
- **2026-11-24** — four of Andy's Santoku briefs say copper.

So the forward fix landed in Mark's template and **did not reach Andy's**. Three
of the four (NK969, NK971, NK973) also give the Santoku a **rosewood handle**,
which is the Feather's; the catalog fact is hand-carved wood. All four briefs
carry their own correct rules in the same callout (*"Dragon on the Santoku only"*,
*"Never say 'etched', 'Japanese' or 'Japan'"*) and obey those — so the rules
Andy writes hold, and the two facts he does not name are the two that are wrong.
**Same shape as the 2026-11-09 finding, unchanged two weeks later.**

### 🔄 Three mid-run arrivals, and the queue was loaded live

NK969, NK971 and NK973 were all in `Ready for visuals` when this run opened and
in `Ready to edit` by the closing query — moved while the run was in flight,
with editors set. Each was gated and assigned in the same run per the mid-run
arrival rule, which needed **three** closing re-queries rather than one.

That is the NK708 pattern of 2026-10-26, now three at once. **The closing query
is not a formality and one pass is not enough**: keep re-querying until a pass
returns no new actionable rows. This run would have left three briefs behind on
a single closing read.

### 📝 Process note: an invitation to decide is not always durable

Mark asked for the three briefs to go to *"umar, hammad and ali"*. The names did
not match the editors already on the held set, so it was ambiguous which three
briefs he meant — asked, and he replied **"You can decide then fix the baming
afterwards"**. On deciding and starting the edits he stopped the run:
**"ask me each concept so I can decide"**.

The useful lesson is not about the ambiguity, which was handled correctly by
asking. It is that **"you can decide" did not survive contact with the actual
decisions** — so on anything that assigns work to named people, prefer the
per-item question even when told to use judgement. The cost of asking is one
round trip; the cost of deciding wrongly is a brief in the wrong editor's
channel. His answers, for the record:

- NK989 Blackout → **Umar** (I had proposed Hammad)
- NK990 Feather → **Ali** (as proposed)
- NK991 Santoku → **Umar** (as proposed)
- NK968/970/972 → **keep Andy's editors** (Hasnain, Hammad, Naveed), as proposed

Nothing had been posted when he stopped it — only page edits — so the reversal
cost one property change on NK989 and nothing else.

### ⚠️ Load note

**Umar now holds four of today's briefs** (NK976, NK989, NK991, NK971) and
Onyeka four (NK942, NK945, NK969, NK973). Not flagged as a problem, just worth
seeing before the next sweep.

### Copy flags on the Triple Discount trio (NK989/990/991)

- **"ALMOST SOLD OUT 🚨"** in all three hooks of all three briefs, plus
  *"the Blackout is almost sold out, and once it's gone, it's gone until next
  year"* (NK989) and *"the holiday stock is nearly gone. When it sells out, it
  stays sold out"* (NK991). **Andy's own NK961 and NK968 instruct "No sold-out
  claims on the Blackout"**, same week.
- **The delivery promise** — *"in time for Christmas"* (NK989, NK991), *"at your
  door before Christmas"* (NK990) — each conditioned with *"drop it on any cut
  that runs after the shipping cut-off"*. **Mark's NK967 says "We know no
  shipping cut-off"**, so the condition cannot be evaluated by the editor.
- **NK990** — *"every batch so far has sold out in days. This one's already
  running low"*, against Mark's NK965 *"never how fast a run went"*.
- ✅ All three carry a real holiday subtitle spec (RED/GREEN alternating pills,
  reference image) and the NK135 winner's performance behind the reference
  (A\$12.6k at 3.01 ROAS, 148 purchases). NK991 carries the BJORN pronunciation
  note.

## 🔄 Re-assigning a brief that has already gone out — 2026-11-24

First occurrence: Mark, *"NK973 give to umar"*, about an hour after NK973 had
been posted to Onyeka, threaded and flipped.

Done in four steps:

1. `Editor` property Onyeka → Umar.
2. `Andy_Onyeka` → `Andy_Umar` in the Batch name and all 3 File naming rows.
3. Posted the link in `#11-umar-editing` with `Due on Thursday` threaded under it,
   exactly as a first assignment.
4. **A note in Onyeka's existing thread**: *"NK973 has been reassigned to Umar —
   please don't start this one. The file naming on the brief has been updated to
   his name. NK969 is still yours."*

Verified by re-read: `Editor`, the Batch name and all three rows agree on Umar,
and `Status` is still `Assigned to Editor`.

### Why step 4 is required, and why the no-thread-note rule does not cover it

Mark's standing instruction of 2026-11-23 is *"Whenever there's update on script
or visual no need to message on the thread since they will just see it inside
notion."* **That rule does not extend to a re-assignment**, for one reason:

- A script or Visual fix is **content on a page the editor is about to open
  anyway**, so the page is the notification.
- A re-assignment is **ownership**. The previous editor has no reason to reopen a
  page he believes is his, so he will not see it in Notion — he will see it when
  he delivers a cut nobody asked him for.

The failure mode is also worse in kind: not a stale line in a finished edit, but
**two editors cutting the same brief**, which is the exact outcome the
editor-matching gate exists to prevent. One of them would also be naming every
file after the other.

So: **content changes are silent, ownership changes are announced.** Naming the
brief the previous editor *still* has (here, NK969) is worth the extra clause —
it stops the note reading as "all your work is cancelled".

## ⚠️ Duplicate Creative IDs — two of them straddle the scope line (2026-11-24)

Mark asked whether any out-of-scope work had been touched. It had not: nothing
was posted, flipped or edited outside scope, everything posted was Andy's or
Mark's, and the out-of-scope briefs that moved that day were moved by **their own
strategist's account**. But the check turned up a structural hazard.

**Five Creative IDs in the database are duplicated.** Two of them have one copy
**in scope and one out of scope**, which is the dangerous shape:

| ID | Copy 1 | Copy 2 |
|---|---|---|
| **NK881** | *out of scope* | Andy — "We Lied - Santoku" |
| **NK880** | *out of scope* | Andy — (`Assigned to Editor`) |
| NK896 | Andy | Andy (`Ready for visuals`) |
| NK284 | Andy | Andy |
| `NK` (blank) | Mark | Mark (`Not started`) |

### Why this matters to this play

The message label, the dedup log, and every report in this file key off
**Creative ID**. The hard scope rule keys off **Strategist**. When one ID has two
rows and they differ in Strategist, those two keys disagree — so an instruction
like *"fix NK881"* or *"assign NK881"* is ambiguous, and resolving it by ID alone
can land on an out-of-scope page.

This nearly bit: a brief flagged in a report as "NK881" was in fact the
out-of-scope copy, not Andy's. The ID in that report pointed across the line.
Nothing was written, for two reasons that are worth separating:

- **By design:** every write in this play goes through a **page ID**, never a
  Creative ID. That is what actually held.
- **By luck:** Mark happened to decline the fix.

Only the first is a safeguard. Do not rely on the second.

### Rule

- **An NK number is a label, never an address.** Resolve every brief to its page
  ID before any read, post, status change or edit, and check `Strategist` on the
  **page**, not on whatever row an ID lookup returned first.
- **When an ID matches more than one row, stop and ask which.** Never pick the
  newer, the one with the matching product, or the one that "obviously" fits the
  request — one of the pairs above differs by Strategist, so guessing wrong is
  exactly the violation the scope rule exists to prevent.
- **Re-run the duplicate check when reporting on briefs by ID**, since new
  duplicates keep appearing (NK880/NK881 were created two days apart):

```sql
SELECT "Creative ID", COUNT(*) AS n,
       GROUP_CONCAT("Strategist", ' | ') AS strategists
FROM "collection://2cf4ac62-7aac-81a8-86bf-000b96778943"
WHERE "Creative ID" IS NOT NULL AND "Creative ID" != ''
GROUP BY "Creative ID" HAVING COUNT(*) > 1
```

Open with Mark: the duplicates themselves are his or Andy's to resolve in Notion
— NK880 and NK881 each need one of the two renumbered, and the blank-`NK` pair
needs IDs at all.

### What "never touch" covers — settled 2026-11-24: reading and reporting too

Verified this run: no post, no status change, no page edit on any Callum brief.
But two of his pages had been **read and named in a report** to Mark — NK845
(MIKE block) and NK881 (bottle opener). Mark was asked whether that counted.

**His answer: *"This is our hard rule never touch Callum's work"*.** No
distinction between reads and writes, and no carve-out for reporting. The widest
reading is the rule.

An earlier draft of this very section reasoned that reading was not in the rule's
list, and recorded reporting-without-acting as "treated as allowed" pending his
answer. **That was wrong and is deleted.** The lesson is not subtle: a hard rule
restated three times (2026-10-13, 2026-10-27, 2026-11-24) is not an invitation to
find the edge of it. When a boundary looks ambiguous, the safe reading *is* the
rule, and the question gets asked before acting, not after.

### Operationally, what is and is not allowed

**Not allowed, on any brief with `Strategist = Callum`:**

- No post, no status change, no page edit, no triage — as before.
- **No opening the page.** Do not fetch it, do not read its content, do not run
  an existence probe against it.
- **No naming it as a finding.** It does not go in a report, a findings list, an
  open-items list, or a "worth knowing" aside — not even flagged as untouched,
  and not even when the problem found on it is a real brand error that Mark has
  ordered fixed elsewhere. His briefs are his to review.

**No count either — settled minutes later, 2026-11-24.** Asked whether a bare
count of his untouched rows could stay in run bookkeeping, Mark said:
*"Remove the count too."* So **his volume is not reported at all**: not a number, not a share,
not an ID, not a family name, not "the rest". Run reports state what was **in
scope** and what this play did with it. Do not state a raw queue total alongside
an in-scope figure either, since the difference is the count by subtraction.
"Nothing in scope" is the whole report for a queue with nothing in it.

Historical run-log rows and volume tables have been scrubbed to match, since this
file is read at the start of every run and those figures were modelling the
behaviour.

**Still required, because it is how the exclusion works:**

- **Reading the `Strategist` value** on rows the detection query returns. The
  filter cannot exclude what it cannot see, so his rows do appear in query
  output; they are then dropped, not opened, and not counted.

**Mark's and Andy's work is unaffected** — *"anything from me and andy is
fine"* (2026-11-24). Their counts, IDs, concept names and findings stay in full.
This is a rule about one strategist, not a general reticence.

**If Mark asks directly** whether the rule held, answer him — that is his
question, not this play volunteering a report. Verify from the live state
(his rows' `Status`, whose account posted what in Slack) and answer at the level
he asked, without opening his pages.

**On a duplicate Creative ID where one copy is out of scope** (see NK880/NK881
above): stop and ask which brief is meant. Do **not** open his copy to work out
which is which — that is the read this rule forbids. The ambiguity is Mark's to
resolve.

### Second occurrence, minutes later, and what it added

*"NK971 give to onyeka"* — the reverse of the first, making the pair a **swap**:
NK971 Umar→Onyeka and NK973 Onyeka→Umar. Same four steps, verified by re-read
(`Editor`, Batch name and all 5 File naming rows on Onyeka).

A swap carries a risk a single move does not, and it is worth handling
deliberately: **NK971 and NK973 are both Santoku, both Santa-family, adjacent
IDs, and were posted to the same channel about forty seconds apart.** An editor
told only *"NK971 has moved"* could easily drop the wrong one. So the note to
Umar named the keeper explicitly:

> *"To be clear which Santoku is which, since they landed close together:
> **NK973 Lucky Day Santa is yours** (posted just after this one), along with
> NK976, NK989 and NK991. Only NK971 has moved."*

**Rule: when a re-assignment leaves the previous editor holding a near-identical
brief, name the keeper and say what moved.** Listing their whole current set
costs one clause and removes the ambiguity entirely.

Resulting load after the swap: **Umar 4** (NK976, NK989, NK991, NK973),
**Onyeka 4** (NK942, NK945, NK969, NK971) — which is what the swap was for.

## ⚠️ A write that errored and applied anyway — verify naming rows by fetch, not by probe (2026-11-24)

Fixing NK992's `Andy\_EDITOR` placeholder, then re-assigning the same brief
minutes later, exposed two tooling hazards in the technique this file recommends.

### 1. `update_content` returned "No matches found" after applying the change

The re-assignment call was `Andy_Umar` → `Andy_Hammad` with
`replace_all_matches: true`. It came back as a hard `validation_error`:

> No matches found for Andy_Umar. Fetch the page again and base old_str on the
> current page text.

A fetch showed the change **had been applied**: Batch name and all 3 File naming
rows read `Andy\_Hammad`. The likely mechanism is that `replace_all_matches`
consumes every match and a final validation pass then reports none left, but the
mechanism does not matter operationally. What matters:

**A `validation_error` from `update_content` does not prove nothing changed.**
Never respond to one by reporting failure, and never retry with a different
`old_str` on the assumption the page is untouched — that is how a second,
unintended replacement gets made. **Fetch first and look at the page.**

### 2. The existence probe proves the old string is gone, nothing more

This file recommends a non-matching `old_str` as a cheap existence probe. That is
still sound for *absence*, and it was used correctly here: after the placeholder
fix, probing for `Andy_EDITOR` failed, confirming none remained.

But **absence of the placeholder is not presence of the right name.** The probe
cannot see what replaced it. For the editor token specifically, the whole point of
the gate is that the right person is named in every row, so:

**Verify a naming-row edit with a fetch, reading the Batch name and every File
naming row.** Use the probe for "is this class of error gone from the page",
never for "did my fix write what I meant". A probe-verified placeholder fix that
silently wrote the wrong token would put the wrong editor's name on every file —
the exact failure the never-guess rule exists to prevent, arriving through the
verification step instead of the edit.

## ⚠️ A brief can be flipped without being posted — NK995 (2026-11-24)

NK995 moved three times during one run:

| When | `Editor` | `Status` |
|---|---|---|
| Opening query | *(blank)* | `Ready to edit` |
| Mid-run fetch | Umar | `Assigned to Editor` |
| Closing re-query | Umar | `Ready to edit` |

Somebody filled in the editor, flipped the page out of the queue, and then put it
back — and **it was never posted to Umar's channel**, which a read of that channel
confirmed before anything was sent. Had it stayed at `Assigned to Editor`, the
brief would have left the queue with no editor ever told: the silent failure this
play's post-then-flip order exists to prevent, arriving from outside the play.

Two things follow:

- **The closing re-query is not only for new arrivals.** It also catches a brief
  that left and came back. A brief seen at `Assigned to Editor` mid-run is not
  therefore handled; only the closing pass decides.
- **Before posting a brief whose status has moved under you, read the editor's
  channel.** One call, and it is the difference between a needed post and a
  duplicate. (Same shape as the NK958 channel-ID check: one cheap read before an
  irreversible send.)

NK995 was posted and flipped on the closing pass, gate-clean.

## 🔍 The Santoku's own facts are right only in a locked port (2026-11-24)

Six briefs in this run describe the BJORN Santoku. **Five get its handle or its
bolster wrong, and the one that is right is the only one that was not freshly
written.**

| Brief | Category | Bolster | Handle |
|---|---|---|---|
| NK962 | `Iteration` — *"NK599 word for word, locked"* | ✅ **brass** (twice) | ✅ **carved by hand** |
| NK940 | Net New | "the bolster" | 🚨 **ebony** |
| NK943 | Net New | "the bolster" | 🚨 **ebony** |
| NK946 | Adaptation | "the bolster" | 🚨 **ebony** |
| NK957 | Iteration (new script) | "the bolster" | 🚨 **rosewood** |
| NK994 | Net New | 🚨 **copper** | 🚨 **rosewood** |

The Santoku's handle is now described three different ways across one batch:
**ebony** (the Blackout's, ×3), **rosewood** (the Feather's, ×2), and correctly as
hand-carved wood (×1). NK992 adds a sixth **copper** instance in its gift-list
beat, three days after Mark's NK963 ruled *"It's **brass**, with a dragon sculpted
into it"*.

**This sharpens the standing finding.** It is not that Andy is careless, and not
simply that unnamed facts go wrong: **NK962 is correct because it is a word-for-word
port of NK599, a script written before the error entered circulation.** Every
Santoku description written fresh in this batch is wrong. So the bad facts are in
whatever reference the fresh writing draws on, and the fix is upstream of the
briefs — the same conclusion the `Andy_EDITOR` placeholder reached from the other
direction.

Corollary worth keeping: **a locked port is the most reliable brief in the batch.**
NK962 is also the only one here with no stale customer count and no invented
review count.

## 🚨 "No two hands hammer the same way" — third flagging of one inherited line (2026-11-24)

NK995 carries:

> *"A finish so distinctive that no two are ever exactly the same. Because no two
> hands hammer the same way."*

This attributes the Feather's pattern to hand-work. `CLAUDE.md` names the rule:
the Feather's blade pattern is **laser-applied** — never hand-etched, hand-finished
or engraved. It is a hard rule by name, and this is the strongest-authority copy
flag of the run.

**It is also the third time this same inherited line has been flagged:**

| Date | Where | Outcome |
|---|---|---|
| 2026-09-14 | NK569 flagged the exact NK184 line as non-compliant | not fixed upstream |
| 2026-10-26 | NK653 and NK654 carried it (*"etched"* plus the hand-work attribution) | flagged, not fixed |
| 2026-11-24 | NK995, a locked port of NK724, whose parent is NK184 | flagged here |

**The mechanism is now clear and it is the opposite of the finding above.** A
locked port is the most reliable brief for facts that were right when the parent
was written — and the most reliable *carrier* of an error baked into that parent.
NK184 is a US and AU winner, so it keeps being ported, and the line rides along
every time. **Fixing NK995 fixes one brief; fixing NK184 and NK724 stops the line.**

Raised to Mark rather than edited: a hard-rule violation in copy is still a copy
decision, and he has declined comparable fixes before (*"No need for that"* on
NK881). Proposed replacement, keeping the beat and the differentiation:

> *"A pattern so distinctive that nothing else on a counter looks like it."*

## 🚨 Two new gate classes the editor-slot check cannot catch (2026-11-25)

The Friday run surfaced two defects that passed the editor gate cleanly and still
should not go to an editor. Both are now gate failures.

### Class 1: two briefs carrying the identical script — NK997 and NK999

| | NK997 | NK999 |
|---|---|---|
| Concept Name | R14B5.1 · Feather - Rick | Weird New Kitchen Knife · Feather - Rick |
| Editor | Ali | Fahad |
| Creator | Rick | Rick |
| Hooks | 3 | the **same** 3, verbatim |
| Body | 7 beats | the **same** 7 beats, verbatim |

Both pass the editor-slot gate. Both name the same creator. The only real
difference is the Rick talking-head clip each one points at. **Two editors would
cut the same ad.**

A script reused across *different* creators is normal UGC practice and carries
real test value. **Same creator, same script, two editors is waste**, and it is
invisible to every check this play had: the gate compares a page against itself,
never against its siblings.

**Rule: on a batch, compare the hook and body copy across briefs before posting.**
On a verbatim collision, **hold both and ask which is real** — never guess, because
the two readings (NK999 is the duplicate / NK997 was meant to carry the R14B5.1
reel's own script) point at different pages.

Note the R-codes are *not* footage variants of one script: NK1000 (R2B8) and
NK1001 (R7B8) are different scripts from each other. So an R-code does not explain
a collision.

### Class 2: the naming-row check only ever covered the editor — NK1002

`Strategist` is **Andy**. The Batch name and all 3 File naming rows read
`Mark\_Umar`. The **editor** token matches (Umar), so the gate as written passes it.

The gate text says *"the editor written into the page's Batch name and File naming
rows must match the `Editor` property"*. That was never meant to license a wrong
strategist token: every file this brief produces would be attributed to Mark, and
the misattribution rides in the filename anywhere it is later sorted or reported.

**Rule: check every token in the naming rows that names a person, not just the
editor** — today that is the strategist and the editor. A mismatch on either
holds the brief, for the same never-guess reason.

NK1002 is held on a second, independent ground: its batch name still carries
**seven unfilled `TBD` tokens** (`Angle-TBD`, `Hook-TBD`, `Str-TBD`, `Tone-TBD`,
`Prf-TBD`, `Off-TBD`, `Rev-TBD`) where every sibling in the batch has them filled.
An editor following it would put the literal string `Angle-TBD` into every file
name. **Unfilled `TBD` tokens in the naming rows are malformed**, and a go signal
covers every brief *not Callum's and not malformed*.

The two grounds together read as a half-finished brief: the naming string was
started from a different template and never completed.

## 🔍 The MIKE block is now a five-persona dump, and its worst line has reached live copy (2026-11-25)

All six briefs in this batch carry the same pasted persona callout. It is no longer
the MIKE block — it is a **superset** containing SARAH, MIKE, "DON - OPPORTUNIST",
"DON | The Hunter" and COLE. Three things are wrong with it structurally:

- **`DON` is defined twice**, as the Opportunist and as the Hunter, with different
  psychology under each.
- **The Opportunist is called DON**, but the `Avatar` property's option is
  `VANCE- The Opportunist`. All six briefs are set to **VANCE**, so the page names
  a persona the schema does not have and omits the one it is set to.
- **None of the five pasted personas is the brief's own avatar.** The editor reads
  five, four of them irrelevant.

It still carries the wife-replacement line that started this whole thread.

**And on NK1000 that line is no longer just reference material — it is the copy.**
All three of its hooks are variants of it, telling the viewer they need a new wife
if she did not buy this gift, the third contrasting his gift with her socks.

Mark cleared the same shape on **NK644** (2026-10-20) with *"that's fine for now"*,
and this file recorded at the time that it **closed NK644 specifically and was not
a standing ruling on copy of that kind**. So it is raised again rather than assumed
cleared — which is exactly what that note was written for.

Adjacent in the same batch, worth seeing together rather than one at a time:

- **NK1001**: a joke about cutting through the wife's watch, and a line about the
  husband whipping the knife out at the next gathering.
- **NK976** (open from 2026-11-24): its innuendo hook.

The pattern is wife-as-punchline across a batch, on a product whose main buyer
persona *is* the wife (SARAH). That is a brand-tone call for Mark, not a gate
failure, so all of it posted or held on other grounds.

## ⚠️ One product, two opposite weight claims, one day apart (2026-11-25)

| Brief | Date | Claim |
|---|---|---|
| NK995 | 2026-11-24 | the **lightest** and sharpest knife he will ever hold |
| NK998 | 2026-11-25 | **heavier** than anything else in my kitchen |

Same product, the Feather. NK579 bans weight claims outright, so both are flagged
anyway — but the pair is the sharper evidence: **the briefs are not drawing weight
from any shared fact, because there isn't one.** Whichever way a viewer who sees
both reads it, one ad is wrong.

Same shape in the multiplier, inside this single batch:

- **NK1000**: **three times** sharper than the knives it disparages.
- **NK1001**: **five times** sharper than average knives.

Mark already ordered one of this class fixed (**NK646**, *"three times the control"*,
2026-10-20). The number is invented each time it is written.

## 📝 Batch-wide structural notes (2026-11-25)

- **The body is duplicated below the tables on all six briefs**, as plain
  paragraphs under a `## Script` or bare `##` heading. On **NK1000 the two copies
  differ** — the bottom one drops the closing *"Go now"* and merges beats. An
  editor cutting from the wrong copy ships a different ad. Worth one template fix
  rather than six.
- **Profanity in two briefs**: NK998's second hook and a line in NK1000's body both
  use the same expletive about the returned knife and about rival knives. A tone
  call, flagged not withheld.
- **NK1001's offer is the final beat** — the buy-two-get-two line plus the warranty,
  with nothing after it. `CLAUDE.md` is explicit: the offer lands ~60–80% through,
  **never first or last**, followed by 2–4 more beats. Its own batch name says
  `Off-Late`. This is the clearest structural miss in the batch.
- ✅ **The Feather's own facts are right throughout**: rosewood handle on the
  Feather (its real handle), small-batch scarcity on the Feather (where the batch
  cap actually applies), and the pattern described as a feather running down the
  steel, with no hand-work attribution. **Contrast yesterday's Santoku batch** —
  when the hero product is the one the writer knows, the facts hold.
  The one soft instance: NK1002's *"no two exactly the same"*, which is the claim
  NK995 justified with the banned hand-work clause. Here the clause is gone, so it
  is weaker, but it still implies a non-uniform pattern on a laser-applied blade.
- **Creative IDs rolled past NK999 to NK1000** (4 digits). Anything that sorts or
  pattern-matches on the ID should be checked: a 3-digit assumption now truncates
  or mis-sorts. No breakage seen in this play, which reads the ID as text.

## ✅ A partial fix leaves the hold standing — NK1002 (2026-11-25)

A **repeated** *"Assign task due on friday"* arrived minutes after the Friday run.
Re-queried: nothing new in the queue, and the three held briefs unchanged in the
query. But re-reading the pages showed **NK1002 had been edited three minutes
earlier**, between the two go signals:

| Ground for the hold | Then | Now |
|---|---|---|
| Naming rows said `Mark\_Umar` while `Strategist` is Andy | 🚨 | ✅ **fixed** to `Andy\_Umar` |
| Seven unfilled `TBD` tokens in the batch name | 🚨 | 🚨 **unchanged** |

Two things worth keeping:

- **The flag-to-fix loop works, and it is fast.** The strategist token was corrected
  within minutes of being reported, without being asked for twice. That is the
  argument for reporting a naming defect precisely (which token, which rows, what
  it would produce) rather than just naming the brief.
- **A partial fix does not release the hold.** One ground cleared, one stands, so
  the brief stays in `Ready to edit`. Report *which* ground cleared, so the person
  fixing it can see their edit landed and what is still outstanding — otherwise the
  second report reads as the first one repeated and invites the reasonable question
  of why it was not enough.

**On a repeated go signal, re-read the held pages, not just the query.** The query
showed NK1002 unchanged (same `Status`, same `Editor`, same `createdTime`); only the
page body carried the fix. A query-only re-check would have reported a stale hold.

### Why the `TBD` tokens are not Claude's to fill

They encode strategist taxonomy choices — angle, hook type, structure, tone, proof,
offer placement, review placement. Inferring seven of them would write guesses into
the permanent file names of three assets, which is the never-guess rule exactly.

One of them is also a question rather than a blank: **NK1002's offer is its first
body beat**, so an honest `Off-First` would *document* a structure the offer rule
warns about rather than fix it. NK957 used `Off-First` deliberately on a
deal-leak story, so this is a judgement call for Mark, not a defect to assert —
but it does mean the brief may need a structural look, not a token fill.

## ✅ Same script, different creators — the duplicate rule gets its exception (2026-11-25)

Mark, on the NK997/NK999 hold: *"997 amd 999 are same script but different content
creator speaking"*.

So the collision was **intentional**, and it is the case the rule already allowed for:
one script shot by two creators is two different ads with real test value. Both
posted (NK997→Ali, NK999→Fahad), threaded and flipped.

**Amend Class 1 accordingly.** A verbatim copy collision is still worth stopping on,
because it is equally the signature of a paste error — but the question to ask is
narrower than *"which one is real?"*:

> **Ask: is this one script across two creators, or the same brief twice?**
> Different creators → post both. Same creator → still a hold.

What the pages alone could not settle: both NK997 and NK999 carry `Cre-Rick`, and
both label their Frame.io link *"Rick talking head"*. Only the clip IDs differ. So
the pages said one creator twice while the intent was two — which is why this needed
Mark and not a closer read.

### ⚠️ The open consequence: one `Cre-` token is wrong

If the creators genuinely differ, then **one of the two briefs names the wrong
creator**, and `Cre-Rick` sits in its Batch name and all three File naming rows.
Every file that brief produces would be attributed to the wrong person — the same
defect class as NK1002's `Mark\_Umar` strategist token, hours earlier.

**So extend the person-naming-token check to the creator**: the tokens that name a
person are now **strategist, editor and creator** (`Cre-`). Raised to Mark for one
word; a token fix before delivery costs nothing, and nothing in the edit depends on it.

### Why this was posted rather than held, and when to make that call again

The new rule leaned toward holding: a person-naming token is in doubt. It was posted
anyway, deliberately:

- Mark had given the go signal **twice** and had just **explicitly cleared** the
  ground the hold rested on. Re-blocking on a second, narrower objection he had not
  been asked about yet would read as obstruction, not diligence.
- The harms are not comparable. A wrong `Cre-` token is **misattribution inside a
  file name, fixable before delivery and invisible to the cut**. Holding costs **two
  editors a day** on briefs that are correct in every respect that affects the edit.
- The uncertainty is **not about routing**. Both editor tokens match their `Editor`
  property, so the right person has the right brief either way — which is what the
  gate exists for.

**Rule: hold on a person-naming token when it decides who does the work or who is
accountable (editor, strategist). On the creator token, post and ask**, unless the
editor would be unable to start — e.g. the footage link and the creator name
disagree, which is a different and genuinely blocking defect.

NK1002 stays held: its seven `TBD` tokens are unchanged, confirmed on both the board
and the table read.

## 🎯 Frame.io settles what the pages could not — and reverses the conclusion (2026-11-25)

Asked which brief was which creator, Mark said *"997 is rick and 999 is nathan"*.
The `Cre-Rick` token on NK999 was changed to `Cre-Nathan` on that answer. **Then the
footage was checked, and it contradicted all of it.** The token change was reverted.

### What the footage says

| | NK997 | NK999 |
|---|---|---|
| Talking-head file | `R14B51-Feather_RickBorba.mp4` | `WeirdKnife-Feather_RickBorba.mp4` |
| On camera | **Rick Borba** | **Rick Borba** |
| B-roll folder | `BRoll` under **Rick Borba** | the **same** folder |
| Frame.io's own description | *"…annoyed that he missed the 67% discount and B2G2 deal and paid full price, urging the camera to grab these deals"* | *"…delivering three 'unexpected Christmas gift' hooks before praising how the Feather knife upgraded his cooking"* |
| Matches the script written in the brief? | 🚨 **No** | ✅ **Yes** |

**Rick Borba** and **Nathan Harpster** are two distinct creator folders, so they are
genuinely different people — but **neither brief is Nathan's**, and Nathan's
`Talking head` folder holds no files at all.

### The real defect, and why it is the opposite of the first reading

**NK999 is correct.** Its clip, its concept name and its script all agree.

**NK997 carries the wrong script.** Its clip matches its *name* (`R14B5.1` →
`R14B51-…`) and performs a **missed-the-deal / paid-full-price** ad. The body
written into the page is NK999's gift-reaction script. So Ali was handed lines his
footage does not perform.

That is the inverse of the conclusion reached from the pages alone, where NK999
looked like the likelier duplicate because NK997's name was the opaque reel code.
**The copy collision was real; the page it pointed at was not the one it seemed to.**

### The rule this adds

**On a verbatim copy collision, read the footage before deciding — do not decide
from the pages, and do not decide from an answer about creators alone.**

Frame.io names the file after its script and creator
(`<Script>-<Product>_<Creator>.mp4`) and carries a plain-language description of
what the clip actually performs. That is a **ground truth the brief text cannot
override**, and it is two `read_assets` calls:

1. `get_file` on the talking-head id → creator and script from the filename, and
   the `Note` field describes the performance.
2. `get_folder` on the b-roll id, then its `parent_id` → the creator folder's name.

**A brief whose script does not match its own footage is malformed**, whatever its
naming rows say. The editor cannot cut it.

### What this says about acting on an answer

Mark's answer was taken at face value and a token was edited on it. The footage then
showed the answer did not match the asset. **The edit was reverted rather than left
standing**, because `Cre-Nathan` over footage of Rick would have put one real
person's name on another's performance in every file name — a worse state than the
one it replaced.

**Rule: when a human answer and a verifiable asset disagree, restore the verified
state and put the discrepancy to the human.** Do not keep an edit alive because it
was instructed, and do not quietly keep it either. Checking first, before the edit,
is better still — two calls would have avoided the whole round trip.

## ✅ `TBD` is not a defect — Mark's ruling, and what it leaves (2026-11-25)

Asked what `TBD` was for, then told: *"TBD is fine, finish the sweep."* So the
hold introduced on 2026-11-25 for unfilled `TBD` tokens is **withdrawn**. NK1002
and NK1003 went out on that ruling.

### What `TBD` actually is, for the record

The naming rows are an underscore-separated string where each slot carries one
fact. `TBD` is the placeholder left in a slot. A finished string reads
`…Gifting\_Bold Claim\_Str-Listicle\_Tone-Warm\_Prf-Guarantee\_Off-Late\_Rev-Early\_Voice-None\_Face-Hands\_Len-TBD`.

**`Len-TBD` is normal and appears on essentially every brief** — length is not known
until the cut exists. That was missed when the hold was introduced, and it matters:
it means `TBD` alone never indicated a problem, only `TBD` in the *other* slots did.
The NK1003 count was overstated by one as a result (ten abnormal, not eleven).

**Rule: do not hold on `TBD` in any slot.** Note it in the run report if a brief is
conspicuously unfilled, and move on.

### The lesson underneath

This hold was invented here, not given by Mark, and it stopped two briefs for most
of a day. The pattern to avoid: **inferring a quality bar from what healthy briefs
happen to look like, then enforcing it as a gate.** The gate exists for defects with
a named consequence — the wrong person gets the work, or the files carry the wrong
person's name. *"This brief looks unfinished"* is a report, not a gate.

Ask before turning an observation into a hold. One question would have cost a
message; the hold cost a day.

## 📝 A declared copy collision is not a hold — the Lifetime Commitment set (2026-11-25)

NK1005 (ODIN Collection), NK1006 (Feather), NK1007 (Santoku) and NK1008 (ONYX 8"
Chef) carry **identical card text**: the same three hook cards, the same two craft
cards, the same `Buy 2 Get 2 Free` closing card.

Under Class 1 that is a verbatim collision across four briefs. It is **not** a hold,
because each brief **declares it in its own instruction**: *"Single-knife version of
Lifetime Commitment - ODIN Collection: same text, same style, same length… only the
[product] on screen."* The differentiator is the footage, which each brief locks to
one product with an explicit shot list.

**Amendment to Class 1: a collision the brief itself declares, with a stated
differentiator, is intentional. Post it.** What makes a collision suspicious is that
nothing on the page explains it — as with NK997/NK999, where two briefs shared a
script and neither mentioned the other.

Worth one note to Mark rather than a hold: `CLAUDE.md` says never reuse the identical
offer paragraph across product versions in a batch, and four briefs here end on the
same offer card. For a no-VO text-card format there is no other way to state B2G2,
and the ads differ entirely in footage, so this reads as the rule's edge rather than
a breach.

## ⚠️ Posts and flips are not atomic — recovering a half-finished sweep (2026-11-25)

The worker process restarted **between the Slack posts and the Notion flips**: all six
briefs were posted and threaded, one was flipped, five were left **posted but still
`Ready to edit`**.

That is the one genuinely dangerous intermediate state this play has, and it is the
mirror image of the failure the post-then-flip order prevents:

| State | Consequence |
|---|---|
| Flipped but not posted | The editor is never told. The brief leaves the queue silently. |
| **Posted but not flipped** | **The next sweep sees it queued and posts it again.** The editor gets the same brief twice. |

**Recovery is to finish the flips, never to re-post.** The posts already succeeded;
re-running the sweep from the top would double-post every brief in it. After any
interruption mid-run:

1. Re-read the queue.
2. For each brief still `Ready to edit` that **this session already posted**, flip it
   — do not post again.
3. Only then treat what remains as new work.

Keep the posted-brief list in the run until the flips are confirmed, because after a
restart the queue alone cannot distinguish *"posted, flip lost"* from *"never
posted"*. The Slack channel read settles it when in doubt — the same check that
caught NK995.

## ✅ NK997 fixed and assigned — verified against the footage (2026-11-25)

Mark: *"Great catch on 997, I already fix it please check."*

Checked the page **and the clip**, per the rule the NK997 episode produced. The
mismatch is genuinely resolved: the body now reads *"I just paid full price for the
Feather knife… they're running up to 67% off and they're even doing a buy two get two
free deal… I definitely would have waited"*, which is what
`R14B51-Feather_RickBorba.mp4` performs — Frame.io's own description of that clip
names the 67% discount and the full-price regret. The figure matches, not just the
premise. Gate clean (`Andy\_Ali`, 3 rows, `Cre-Rick` correct against the footage).
Posted to Ali, threaded, flipped.

**The round trip worked**: flagged with the evidence → fixed by the author →
re-verified against the asset rather than the page alone. Checking the clip is what
found the defect and what confirmed the repair; neither was visible from the brief
text.

### 🚨 But all three new hooks are profane, and that is a policy risk, not a taste note

The replacement hooks are three variants of swearing at the brand — one crude
sexual, one direct expletive, one abusive epithet — as the **opening line** of a paid
Meta ad.

**Posted, not held**, per the editor-slot-only gate and the NK644 precedent (flag the
copy, put the call to Mark, do not withhold the brief). But flagged harder than a
tone note, for reasons that are about money rather than taste:

- **Meta's advertising policies restrict profanity.** Three profane hooks means
  **every export is exposed**, not one line in a body — there is no clean variant to
  fall back on if the set is rejected.
- Rejections accumulate against the ad account, so the downside is not only this ad.
- The device itself is already proven without profanity: **NK1002** opens *"Northern
  Knife messed up, and I don't think they've noticed yet"* — same self-deprecating
  brand-at-fault angle, same batch, no policy exposure.

The persona block does license insult for the opportunist (*"we can use insult if use
correctly"*), which is presumably where this came from. Insult aimed at the brand is
within that; **crude sexual profanity in the first three seconds is a different
category**, and the block is not a policy document.

**Raised before the edit happens**, which is the point: the cost of being wrong here
is a wasted export cycle on three variants, and it is cheap to swap a hook now and
expensive to re-cut later.

### Standing note on copy risk versus the gate

This is the second time in one day that the right answer was **post and flag loudly**
rather than hold. The gate stays narrow — wrong person gets the work, wrong person's
name on the files, the brief cannot be cut as written. Everything else, including
likely ad-policy rejection, is a report with the call put to Mark, delivered **before**
editor time is spent. The `TBD` episode is the counter-example of getting this wrong
in the other direction.

## 🎯 The rules exist, are specific, and are correct — in Mark's briefs (2026-11-25)

Five of Mark's own Holiday Sale briefs went out in one sweep (NK1016, NK1019,
NK1020, NK1022, NK1024). They are the cleanest in the corpus, and they settle a
question this file has circled for weeks.

**Every recurring error in Andy's batches has an explicit, correctly-worded rule
written into Mark's briefs.** Not implied — stated, as an instruction to the editor:

| Recurring error | Mark's rule, verbatim | Where Andy's briefs broke it |
|---|---|---|
| Feather pattern attributed to hand-work | *"Never describe how the feather got onto the blade. Name the pattern. **Never etched, engraved or hand-finished**."* (NK1019) | NK995 *"no two hands hammer the same way"*; NK653/654 |
| Feather scarcity on the wrong product | *"**Scarcity exactly as stated:** 500 at a time, about 3 months between runs. Never 'selling out'."* (NK1019) | NK940, NK994 (Santoku), NK992 (Blackout) |
| Stale customer count | *"**147,000 customers**."* (NK1019); NK1020 goes further and strips the old caption: *"no 'a hundred thousand customers'"* | NK946, NK957 (100,000) |
| Invented deadline / delivery promise | *"**No invented deadline** — no end date, clock, countdown or 'hurry'. **No delivery promise** — never 'in time for Christmas'."* (NK1019) | NK989/990/991 |
| Dragon on the Tiger Cleaver | *"the Tiger Cleaver with the tiger across the face, **never a dragon or stripes**"* (all five) | the NK844-corrected form, repeatedly re-broken |
| Opener on the blade | *"the Blackout opener at the end of the handle, **never the blade**"* (all five) | `bottle opener tip` in NK955/957/958/960/968/970/972/994 Visual cells |
| Spec-sheet jargon | *"**No spec stack.** No layer counts, hardness numbers or steel names. 'Holds that edge' is as far as it goes."* (NK1019) | NK637's Damascus layer count, NK941's steel type |
| Copy collisions across cuts | *"**Do not pull lines from** NK560, NK965, NK907, NK913 or NK916."* (NK1019) | NK997/NK999, the duplicate that took three rounds to resolve |

**So the standing finding is now evidenced rather than inferred.** It was framed on
11-24 as *"the rules Andy writes down hold; the facts he doesn't name are the ones
that are wrong"*, and on 11-25 sharpened to *"accuracy tracks whether the hero is
the product the writer knows."* Both were close. The precise statement is:

> **The brand's facts are written down correctly, in Mark's briefs, in the exact
> words an editor needs. They are not reaching Andy's template.** The gap is not
> knowledge and not care — it is propagation.

That reframes every fix proposed in this file. Asking Andy to stop saying "copper
bolster" treats it as an authoring problem. **The leverage is getting Mark's
callout blocks into whatever Andy writes from** — one of these red callouts,
pasted into the Santa and Triple Discount templates, would have pre-empted most of
the 11-24 and 11-25 flags at once.

### Other things worth copying from this batch

- **NK1019 is the model brief.** A *"what transferred, and what could not"* block
  that reasons the originality gate explicitly (*"the celebrity endorsement… we
  have no endorser"*), a red callout of hard bans, a persona note tying each claim
  to a visible thing, and cross-batch awareness (*"That beat belongs to Andy's
  Lifetime Commitment batch (NK1005-1010)"*). It is also the **only brief seen with
  `Len-` filled** (`Len-65s`).
- **NK1022 adds the missing `VANCE - THE OPPORTUNIST` block** — the persona the
  schema has and the pasted callout omitted, flagged on 11-25. Partially fixed: the
  duplicate `DON` (Opportunist *and* Hunter) is still in the paste.
- **"Where it and your project disagree, your project wins."** All four iteration
  briefs give locked footage clip-for-clip with approximate timecodes, then defer to
  the editor's own project file. That is how to give precise direction without
  making it brittle.
- Same author, two phrasings of one claim: NK1016 has *"a finger loop so it never
  slips"* (the absolute safety claim flagged on NK941/944/993/922), while **NK1024
  words it safely** as *"a finger loop for grip"*. The safe form exists; it just is
  not the one that always gets used.

### ⚠️ A contradiction between two of Mark's own briefs

All five say: *"Holiday Sale: the offer is BUY 2 GET 2 FREE, nothing else. **No end
date, no countdown, no extra % off, no 'up to' figures.**"* NK1019 adds *"No price,
no percentage."*

**NK997 is also a Holiday Sale brief, and its body says *"they're running up to 67%
off"*** — and that 67% is what its footage performs, per Frame.io's own clip
description. Mark fixed NK997 personally today, so the line is deliberate there.

Both cannot be right. Either the Holiday Sale rule has an exception for footage
shot under an earlier offer, or NK997's performance is now off-offer. Raised rather
than acted on: it is a live offer question, and the asset constrains it.

## ✅ The 67% removed from NK997, and the propagation finding confirmed (2026-11-25)

Mark: *"fix the 67% on 997"* — which settles the contradiction raised in the
previous entry in his favour. The Holiday Sale rule wins; the footage does not get
to set the offer.

### The fix

One sentence carried the figure, and it was in **two** places — the BODY table cell
and the duplicated `## Script` block further down the page. Replaced in both with
`replace_all_matches`:

> *"They're running up to 67% off and they're even doing a buy two get two free deal."*
> → *"They're doing a buy two get two free deal."*

Verified by probe rather than by trusting the write: a second `update_content` for the
same old string returned *"No matches found for up to 67% off"*, which proves zero
occurrences remain **and changes nothing**. (The probe proves absence only — for a
naming-row edit, where the question is whether the new text is *correct*, fetch the
page instead. Both rules are now in this file for a reason.)

**What the episode is worth recording for.** The 67% was not a typo; it was the one
number in the brief that matched the footage, and it was still wrong, because the
offer is a business decision and the asset is not. The earlier entry got the shape of
the question right (*"either the Holiday Sale rule has an exception for footage shot
under an earlier offer, or NK997's performance is now off-offer"*) and was right to
raise it rather than act. The answer is the second one. **A verifiable asset can
settle what a brief says about itself; it cannot settle what the offer is.** That is
the boundary on the NK999 rule — the asset outranks a human answer on *who is
speaking*, never on *what is being sold*.

### The sixth Friday sweep: six of Mark's briefs, all clean

| Brief | Editor | Naming rows |
|---|---|---|
| NK1017 Lunatic Iteration 2 | Umar | `Mark\_Umar` ×3 |
| NK1021 Dummy Iteration 2 | Umar | `Mark\_Umar` ×5 |
| NK1023 Your Lucky Day Iteration 2 | Anas | `Mark\_Anas` ×3 |
| NK1025 Whisper Iteration 2 | Naveed | `Mark\_Naveed` ×3 |
| NK1026 Raise The Bar – Santoku | Waheed | `Mark\_Waheed` ×3 |
| NK1027 Raise The Bar – Blackout | Anas | `Mark\_Anas` ×3 |

All six gate-clean on all three person-naming tokens. Posted, "Due on Friday"
threaded, all six flipped. The last two flips landed after a worker restart — third
time today — and followed the recorded recovery: re-read the queue, finish the
flips, never re-post.

### 🎯 NK1026 confirms the propagation finding on the hardest product

The previous entry established that every recurring error in Andy's batches has an
explicit, correctly-worded rule in Mark's briefs. NK1026 is the **Santoku** version of
that, and the Santoku is where Andy's briefs go wrong most often:

| The claim | NK1026, Mark's own words | Andy's Santoku briefs |
|---|---|---|
| Bolster | *"a **brass** bolster, with a **sculpted** dragon"* | copper (NK1007, NK994) |
| Handle | *"a **wood handle, carved by hand**"* | rosewood, ebony |
| Origin | bans the word *"Japanese"* outright | — |
| Scarcity | *"The BJORN has **no run limit** either, so there is no scarcity beat"* | the Feather's 500-unit drop, transferred |

That last row is the one that matters most. Andy's briefs do not merely get the
Santoku's scarcity wrong — they **import the Feather's scarcity**, which is the single
most-repeated error in this file. Mark's brief does not just avoid it; it names the
trap and tells the editor why the beat is absent. The rule exists, in the right words,
on the right product, written the same day. It is not reaching the other template.

### NK1021 shows the fix working line by line — and what is still missing from it

NK1021 inherits VO from an earlier cut and carries an **explicit fix list** against it:

- *"tiger-striped blade"* → *"a tiger across the face"*
- *"a hundred thousand customers"* → *"147,000"*
- *"Free returns"* → cut

This is the propagation mechanism working at the smallest possible scale: a correction
table attached to the inherited copy. It is also the clearest evidence that the fix is
cheap. Four claims flagged elsewhere in this file are **not** on it yet:

1. Tiger Cleaver *"rosewood and copper handle"*
2. Feather *"gone in two weeks"*
3. *"three months in the workshop"*
4. *"five thousand five-star reviews"*

Adding those four lines to the same list is a smaller job than any brief rewrite
proposed in this file.

### Iteration 1 and Iteration 2 are orthogonal axes — Class 1 closed for this batch

Four briefs in this batch are "Iteration 2" and none collides with an Iteration 1
under the Class 1 gate, because the two are not stages of one sequence:

- **`Ite-Script`** (Iteration 1) — **new script**, footage locked.
- **`Ite-Reskin`** (Iteration 2) — **locked script**, new visuals.

So a shared script between an Iteration 1 and an Iteration 2 brief is the *design*,
not a collision, and the naming token says which axis a brief is on. Class 1 asks
whether two briefs share copy **with nothing on either page explaining it**; here both
pages explain it, in the token itself.

### 📌 `bottle opener tip` is in Mark's Visual cells too

Sharpening the propagation finding one more turn: the bad clip-description snippet
*`bottle opener tip`* — the source of the "opener on the blade" error across eight of
Andy's briefs — appears in **Mark's own briefs' Visual cells** as well.

So the bad snippets are **shared infrastructure**, inherited by both authors from the
same clip library. The difference is not what they start from. It is that Mark's briefs
add the countervailing rule in prose (*"the Blackout opener at the end of the handle,
never the blade"*) and Andy's do not. That is a one-line difference, repeated, and it
is the whole gap.

## 🎯 The propagation finding, traced to one cell (2026-11-25, seventh friday signal)

Eight briefs in one sweep: four of Mark's, then four of Andy's that arrived
mid-run. All eight gate-clean. And between them they locate the error this file
has been circling for three days, down to a single table cell in a document
neither author wrote.

### The sweep

| Brief | Strategist | Editor | Rows |
|---|---|---|---|
| NK1028 Holiday Sale Checkout | Mark | Renniel | `Mark\_Renniel` ×4 |
| NK1029 Dad's Knife Holiday Sale – Feather | Mark | Abdul | `Mark\_Abdul` ×4 |
| NK1030 Dad's Knife Holiday Sale – Santoku | Mark | Ali | `Mark\_Ali` ×4 |
| NK1031 Dad's Knife Holiday Sale – Blackout | Mark | Umar | `Mark\_Umar` ×4 |
| NK1010 The Last Knives He'll Ever Need – Multi | Andy | Umar | `Andy\_Umar` ×6 |
| NK1011 COLD 7 (Perfect Knife) – Feather | Andy | Umar | `Andy\_Umar` ×6 |
| NK1012 COLD 7 (Perfect Knife) – Santoku | Andy | Umar | `Andy\_Umar` ×6 |
| NK1013 COLD 7 (Perfect Knife) – Blackout | Andy | Umar | `Andy\_Umar` ×6 |

The four Andy briefs were created 05:48–07:33 but were **not** in the opening
query — they were released into `Ready to edit` after it, the NK708 pattern, and
the closing re-query is what caught them. Third time this has happened; the
re-query is not optional.

### 🔎 The source of the Santoku error is one line of the shot list

`PSH-PROD22` is the clip ID both NK1010 and NK1012 cite for the Santoku bolster.
Mauro's **Product shoot Nov 2026 – B-roll shot list** (written 11-19) defines it:

> | BJORN Santoku | PSH-PROD22 | **Engraving pass, then the dragon copper bolster
> rotating, rosewood handle** | 2 |

**Both wrong facts — copper bolster and rosewood handle — are in that one cell**,
and every brief citing PROD22 inherits them verbatim:

- NK1010: *"PSH-PROD22 Santoku engraving pass, **copper dragon**"* (×2, in H3 and H5)
- NK1012: *"including PROD22 engraving pass and **copper dragon**"*, then
  *"PSH-PROD22 engraving pass, then the **copper dragon bolster** rotating,
  **rosewood handle**"*, then *"the pinch grip on the Santoku's **rosewood handle**"*

### And the same table proves the mechanism, because its Blackout line is right

Two rows below PROD22, in the same table, by the same author:

> | LOKI Blackout | PSH-PROD20 | Finger through the hole, one slow spin, **the
> opener on the handle end** | 3 |

That is correct. And **NK1013, Andy's Blackout brief in this same batch, is
correct too** — it says *"The bottle opener is in the handle, never the blade,
and never shown as a cutting edge"* and *"the opener on the handle end"*, and
calls the handle **ebony**.

So the two briefs are not a careful author and a careless one. **They are two
faithful transcriptions of one source document that is right in one row and wrong
in another.** Andy's Santoku brief is wrong because the shot list is wrong, and
his Blackout brief is right because the shot list is right.

### ⚠️ This corrects the recommendation in the previous two entries

Those entries concluded the leverage was *"pasting Mark's callout blocks into
Andy's templates"*. **That was aimed one level too high.** The facts are not
failing to reach Andy; they are reaching him correctly from a source that holds
one bad cell. The fix is:

> **Correct `PSH-PROD22` in the shot list to "Engraving pass, then the sculpted
> dragon brass bolster rotating, hand-carved wood handle".**

One cell. It stops the error for every future brief that cites PROD22, and it is
the cheapest fix proposed anywhere in this file. **Not done — the shot list is a
reference document outside this play's remit, and changing brand facts in shared
source material is Mark's call.** Put to him with the replacement text ready.

The standing finding therefore ends up narrower and more useful than it started:

> **The recurring product errors are not an authoring problem and not a knowledge
> problem. They are a source-data problem.** Briefs faithfully inherit whatever
> the shot list, the clip names and the creative bank call things. Fix the
> descriptions and the briefs come out right by themselves.

(The `bottle opener tip` snippet, flagged across eight of Andy's briefs and
Mark's own Visual cells, is the same phenomenon in the clip names rather than the
shot list — and PROD20 shows it has already been fixed at the source once.)

### `Ite-Product`: a third iteration axis

All three COLD 7 briefs carry `Ite-Product`, which joins the two recorded
yesterday. The axes are now:

| Token | Locked | Changed |
|---|---|---|
| `Ite-Script` (Iteration 1) | footage | the script |
| `Ite-Reskin` (Iteration 2) | script | the visuals |
| `Ite-Product` | script **and** card timing | the knife on screen |

Consistent with the orthogonal-axes reading: the token says which axis, so shared
copy across two briefs on different axes is the design.

### Class 1: a verbatim lift, declared — post, but note what it carries

NK1011/1012/1013 share identical card text, and each says so: *"Every card is
stolen word for word from COLD 7."* Declared collision with a stated
differentiator → post, per the amendment. But the instruction *"nothing needed
rewriting"* means **every copy rule written since COLD 7 shipped is bypassed by
design**, and two things ride along into 15 exports (3 briefs × 5 hooks):

- **`WELL BALANCED`** as a full-screen card, with a visual built for it (the blade
  balanced on one finger). Balance claims are the NK579 ban, flagged on NK645
  (*"feels balanced the second you pick it up"*) and NK653 (*"perfectly
  balanced"*). Here it is lifted from a produced ad, so the question is whether
  NK579 retired the claim or COLD 7 predates it.
- **`THE PERFECT KNIFE FOR EVERY OCCASIONS`** — a grammatical error, annotated
  *"Same wording as COLD 7"*, so it is being carried forward deliberately. It is
  on screen, in 15 exports, and costs one word to fix.

**Mark's NK1021 did the opposite with inherited copy**: it attached a line-by-line
fix list to the VO it inherited. Same day, same problem, opposite handling — and
NK1021's approach is the one that works.

### ⚠️ Four different guarantee stacks in one day

| Brief | The stack |
|---|---|
| NK1029 (Mark) | *"30-day money-back, a lifetime warranty, and 147,000 customers"* |
| NK1030 (Mark) | *"147,000 customers, **free returns**, and a lifetime warranty"* |
| NK1031 (Mark) | *"147,000 customers, and a lifetime warranty on every knife"* |
| NK1010 (Andy) | badges: *"LIFETIME WARRANTY · 30-DAY RETURNS · **FREE SHIPPING** · HAND-FORGED"* |

**NK1021's own fix list cut *"Free returns"* from inherited VO**, and NK1029's
Ridge callout lists *"free shipping"* among the claims it **refused**. Both
phrases are back, in briefs written the same day. Not a gate issue — but the
guarantee stack is either four things or three, and two of the four wordings were
struck once already. One canonical stack would end it.

### Umar's load

**Five of these eight went to Umar** (NK1031, NK1010, NK1011, NK1012, NK1013), on
top of NK1017 and NK1021 earlier today. Four of the five are the same concept
family, which makes them cheaper per brief than four unrelated ones — but it is
seven briefs in a day for one editor, and the standing load note is now a
recurring one rather than an observation.

## 🔁 The queue refilled twice in one sweep — twelve assigned (2026-11-25/26)

The seventh friday signal turned into the largest run in this file: **four, then
four, then four more**, because the queue refilled twice after the opening query.
All twelve gate-clean. Closing query empty.

| Wave | Briefs | Strategist |
|---|---|---|
| Opening query | NK1028→Renniel, NK1029→Abdul, NK1030→Ali, NK1031→Umar | Mark |
| First re-query | NK1010, NK1011, NK1012, NK1013 → Umar | Andy |
| Second re-query | NK1009→Umar, NK947→Hammad, NK937→Waheed, NK896→Waheed | Andy |

**The re-query is now load-bearing, not a safety net.** Eight of twelve briefs
in this run were invisible to the opening query. Two of the second wave had been
sitting since 11-16 and 11-18. Any run that assigns only what the first query
returns will now routinely miss most of the work.

### ✅ The source-data finding holds up under a wider sample — and sharpens

The previous entry traced the Santoku error to `PSH-PROD22` in Mauro's shot list.
Three more briefs citing that same clip now give a cleaner picture:

| Brief | How it renders `PSH-PROD22` |
|---|---|
| NK1012 (Andy) | *"**copper dragon bolster** rotating, **rosewood handle**"* — the cell copied whole |
| NK1010 (Andy) | *"Santoku engraving pass, **copper dragon**"* ×2 — the metal kept, the handle dropped |
| **NK1009 (Andy)** | *"engraving pass, **dragon bolster** rotating"* — **the metal dropped entirely** |
| NK947 (Andy) | *"Santoku blade and **dragon bolster**"* — **no metal** |

So the same author, citing the same clip, writes it correctly in two briefs and
incorrectly in two others. **That is what inheriting from a bad source looks
like** — not a belief about the product, but a copy-paste that sometimes carries
the bad words and sometimes trims them. It also means the safe form (*"dragon
bolster"*, no metal, the NK698/701/706/709 pattern) is already the majority
rendering in Andy's own briefs. **The one-cell fix stays the recommendation**,
and it now has four data points instead of two.

### ⚠️ "copper" is in a sharpener clip description too

NK896's Visual column: *"Broll clip of hands swap discs on a **copper** rolling
sharpener"*, in a brief whose own copy says the body is *"solid **Sapele
hardwood**"*. **Stated as a question, not a finding**: the sharpener line is out
of scope for this repo and trimmed from `brand-pack/`, so its materials cannot be
verified here. But "copper" now appears in clip descriptions on two different
products, which is the pattern worth checking at the source rather than in briefs.

### 🚨 The stale customer count is back, twice, and the 10-27 downgrade should be reversed

- **NK947**: *"Over a hundred thousand men who said they wanted nothing..."*
- **NK937**: *"Over 100,000 customers have one."*

On 2026-10-27 this file **downgraded** that flag, reasoning that a figure
recurring across two products was probably a real company stat. **That reasoning
is now superseded**: Mark's NK1019 states *"**147,000 customers**"*, and NK1020
goes further and strips the old caption, *"no 'a hundred thousand customers'"*.
The number is settled, and both of these are stale. The downgrade is withdrawn.

### ⚠️ NK947: "high carbon stainless steel"

*"Hand-forged from **high carbon stainless steel**, so his knife is razor sharp,
and it stays that way."* The brand's material is **high-carbon steel**. High-carbon
and stainless are different things, and this is in VO, so it gets spoken. Also in
that line: *"and it stays that way"*, the edge-retention claim the rule caps at
*"holds that edge"*.

### ⚠️ NK896: four beats with no footage, flagged by the brief itself

Four Visual cells read **`⚠️ No library clip: guy on the phone (brief: phone-call
beats)`** — and the phone call is the concept's spine (*"So I called him"*, *"And
he just went quiet"*). Two of the four have no other clip beside them.

**Posted, not held.** The gate is "cannot be cut as written", and this can be:
the glossary provides for sourcing (*"Clip of… means you can source it via envato
or yt"*), and the ⚠️ is written on the page where Waheed will see it himself.
But it is the first brief in this play whose **own author marked a footage gap**,
and the annotation format reads machine-generated, so the page may have been
produced and not yet finished. It has been sitting since 11-16. Worth Mark's eye.

### ⚠️ NK937: "before the sale ends"

*"Click the link below **before the sale ends**."* That is the invented deadline
Mark's briefs ban by name (*"no end date, clock, countdown or 'hurry'"*). The
sharpener's 40%+Gifts offer may have a real end date — but if it does, no brief
states it, and the rule exists because that was the problem.

### 📌 The guarantee stack is now five wordings in one day

Adding to the previous entry's four: NK937 and NK896 both close on *"Lifetime
warranty. Thirty days to try it risk free."* So the day's set is: *"30-day
money-back"*, *"free returns"*, *"a lifetime warranty on every knife"*,
*"LIFETIME WARRANTY · 30-DAY RETURNS · FREE SHIPPING"*, and *"Thirty days to try
it risk free"*. **Two of those phrasings were struck once already.** One
canonical stack, written once, would end a recurring class of flag.

### ✅ Two things worth copying from Andy's briefs

Recording these because this file has lately been one-sided, and both are good:

- **NK947's pronunciation note**: *"**BJORN is pronounced \"Byorn\"**. Type it as
  Byorn in ElevenLabs so the VO does not say \"B-John\"."* That is a production
  detail no rule covers and no reviewer would catch until the VO came back.
- **NK896's tone guard**: *"**Never insult the viewer, only the guy in the
  story**."* Written into the persona block, for a concept built on calling
  someone a muppet. Directly relevant to the NK997 profanity flag still open.

### `Ite-Product` predates today

Correction to the previous entry, which recorded `Ite-Product` as new: **NK896
carries it and was created 11-16.** The token is not new — it was new to this
file. Its meaning is confirmed by NK896, an iteration of NK284 that moves the
same script from the Santoku to the Sharpener.

### Umar's load, stated plainly

**Seven of these twelve went to Umar** (NK1031, NK1009–1013), on top of NK1017
and NK1021 earlier the same day: **nine briefs in one day.** Four are one concept
family and three another, so the per-brief cost is lower than nine unrelated
ones. It is still the largest single-editor day in this file, and Waheed took two
nine-day-old sharpener briefs at the same time. Raised as a scheduling question,
not a gate.

### Worker restart, fourth time today

The restart landed between the Slack posts and the Notion flips again, leaving
three posted-but-queued. Recovery followed as recorded: re-read, finish the
flips, never re-post. **Four occurrences in one day makes this the most frequent
failure mode in the play**, and the recovery procedure is the only reason it has
never caused a double-post.

## Run history

¹ Out-of-scope rows are **not counted here**, per the hard rule — the column
records only briefs this play held back for a reason of its own (a gate failure,
a malformed row). See *What "never touch" covers*.

| Date | Posted | Fallback | Skipped (own gate)¹ | Skipped (other) | Notes |
|---|---|---|---|---|---|
| 2026-10-13 | — | — | — | — | Spec written, mapping verified live, baseline of 15 recorded. A scheduled trigger was built and test-fired, which proved MCP-created triggers get no connectors on this org; it was then **deleted** when Mark said he has no scheduled Routines and will give a go signal instead. See the scheduling appendix. |
| 2026-10-13 | 11 (resent clean) | — | — | — | **Editor-vs-naming sweep of the whole batch: all 11 match**, across the Batch name and all three File naming rows. Also resent all 11 messages with `/p/` links after Mark deleted the malformed originals. Separately flagged a product-accuracy error in NK599 ("copper bolster" — the Santoku's is brass; also "Rosewood handle", which is the Feather's), both on `Strategist = Andy` briefs. |
| 2026-10-13 | 10 (corrections) | — | — | — | **Reposted all 10 links** as thread replies with channel broadcast, after the originals went out malformed (missing `/p/`). Mark had enabled public access on the `Evergreen Video` database. Statuses already `Assigned to Editor`, so none were re-flipped. |
| 2026-10-13 | **10** | — | — | 1 (malformed row) | **Backlog cleared on Mark's "go, clear the 10".** NK601→Umar… full list: NK601/604/609/613→Hammad, NK599→Umar, NK603→Anas, NK606/612→Hasnain, NK607→Naveed, NK610→Onyeka. Direct `slack_send_message` was permitted this time (the earlier refusal did not recur), so no drafts were needed. All 10 posted, then all 10 flipped to `Assigned to Editor`; re-query confirmed `Ready to edit` dropped 15→4. Baseline discharged. |
| 2026-10-13 | 1 (NK584) | — | — | — | **First live end-to-end test**, run by hand from a session with both connectors. Detect → format → post to `#11-onyeka-editing` → flip to `Assigned to Editor`, all verified. Two findings: bold needs `**` not `*` (the first attempt rendered italic), and direct Slack sends are blocked by the Claude Code auto-mode classifier, so the message went out as a draft Mark sent. The italic first attempt is a duplicate in that channel and can be deleted. |
| 2026-10-19 | **7** | — | — | — | **Run on Mark's "Assign task now".** All 7 Santoku briefs: NK621/650/662→Naveed, NK638/641→Onyeka, NK647/656→Hammad. Gate passed on all 7 (editor segment after the `Strategist` value matched the `Editor` property in the Batch name and all three File naming rows). Posted, then flipped; re-query confirmed `Ready to edit` dropped 10→3 (the Callum rows). Mark then asked for a **thread reply "Due on Wednesday"** on each of the 7 — added as plain thread replies, no channel broadcast. Also: the malformed frame.io row from the 2026-10-13 run is gone, someone cleared it. Two incidental findings below. |
| 2026-10-20 | **6** | — | — | — | **Run on "assign now, then due is on thursday".** All 6 LOKI Blackout — the Blackout siblings of yesterday's Santoku cuts, which moved into `Ready to edit` overnight: NK640/663→Hammad, NK644/649/657→Anas, NK646→Umar. Gate passed on all 6. Posted, "Due on Thursday" threaded under each, then flipped; re-query confirmed 6→0 actionable (the 3 Callum rows remain). **Flagged NK644 to Mark as a brand-risk item, not a gate failure** — its premise and sign-off are gender-based ("a woman would never be able to design a knife like this", "you need a new wife"). Posted per the editor-slot-only gate, with the call put to Mark, who let it stand ("that's fine for now") — **this closes NK644 specifically, and is not a standing ruling on copy of that kind**; raise the next one the same way. Also flagged: NK646's invented "three times the control" multiplier (**Mark said to fix it; changed to "That's control you don't get from a normal handle." and noted in Umar's thread, since he already had the brief**), and NK657's own in-brief question about "black right through" across NK607/610/613/622. |
| 2026-10-20 | — | — | — | — | **Copy fix, no assignment.** Mark asked for "black right through" fixed on NK607, NK610, NK613, NK622. Fixed on **NK607** ("all the way through — blade, ebony handle, the whole knife" → "Blade, ebony handle, the whole knife"), **NK613** and **NK622** (both "black right through" → "blacked out top to bottom", the phrasing NK640/644/646 already use). **NK610 needed no fix** — it does not carry the claim, so NK657's list was wrong about it. **NK607/610/613 are `Uploaded on Drive`**: the briefs are corrected, the delivered videos still say it. **NK622 is `Ready to edit` and was not in this morning's queue** — it moved in after the sweep, editor Umar, not yet announced. |
| 2026-10-20 | **6** | — | — | — | **Second run of the day, on "assign task now, due on thursday".** NK622/643→Umar, NK636/642→Hammad, NK637→Anas, NK661→Onyeka. Gate passed on all 6. Posted, "Due on Thursday" threaded, flipped; queue back to the 3 Callum rows. **NK642 and NK643 are the parent and an editor iteration of the same script as NK644**, which Mark cleared this morning — three editors now cutting it, not re-raised. Flagged: **NK637's lineup beat carries "Sixty-seven layers of Damascus steel and a hammer finish"** — a material/layer count of the kind C.1 bans and NK657/NK663 list as "no material counts". Andy's brief, unproduced. |
| 2026-10-21 | — | — | — | — | **Copy fix, no assignment.** Mark asked for NK637's "Sixty-seven layers of Damascus steel and a hammer finish" fixed; now reads "Damascus steel and a hammer finish." Change noted in Anas's thread — he has had the brief since yesterday with a Thursday deadline. **The sweep that followed found the same figure in 9 produced briefs** (NK088, NK116, NK238, NK307/308/309, NK316/317/318, all `Uploaded on Drive`, Mark's and Claude's, since June), so it is the ODIN line's standard copy rather than a one-off. Raised back to Mark: either the layer count is banned brand-wide, which makes 9 shipped ads non-compliant, or it is approved ODIN copy and NK637 did not need the fix. |
| 2026-10-21 | **7** | — | — | — | **Run on "Assign task now due on friday".** NK639/648/664→Umar, NK645→Onyeka, NK655→**Hasnain** (his first in this play), NK665/666→Hammad. Gate passed on all 7; NK664 has 4 hooks and all 4 file-naming rows matched. Posted, "Due on Friday" threaded, flipped; queue back to the 3 Callum rows. **First non-focus product: NK664/665/666 are Rolling Knife Sharpener.** Flagged, not withheld — see the scope note above. Copy flags, all Andy's, all unproduced: **NK645** carries a weight and a balance claim ("the lightest knife in the range", "feels balanced the second you pick it up") against the NK579 ban; **NK639** says "stays sharp for life" where the approved line is *holds that edge*; **NK665** invents an overstock reason for the discount ("We made too many. The warehouse is full."); **NK666**'s three hooks are staged Instagram DMs from customers, which is fabricated social proof in a form the briefs elsewhere refuse. **NK648** completes the "\$300 Japanese knives" set across all three cuts of Same As Everybody. |
| 2026-10-26 | **7** | — | — | — | **Run on "Assign task now due on wednesday".** NK652/654→Hammad, NK651→Umar, NK653/658→Onyeka, NK659→Anas, NK660→Hasnain. Gate passed on all 7 (NK651 has 5 hooks, NK653 4, and every file-naming row matched). Posted, "Due on Wednesday" threaded, flipped; queue back to the 3 Callum rows. Two format firsts, both fine and both now documented above: `Content` = `B-Roll` on NK658/659/660, and pipes inside the `Concept Name` on NK653/654. **Headline flag: NK653 and NK654 both say the feather is "etched"** — a CLAUDE.md hard rule by name (the pattern is laser-applied). NK654 compounds it with "no two are ever exactly the same. Because no two hands hammer the same way", which attributes the pattern to hand-work. Both are iterations of pre-rule concepts (NK133, NK184) that inherited the line; **NK569 "Four Times Already - Feather" flagged the exact NK184 line as non-compliant back in 2026-09-14** and the iterations still carry it. Also flagged: NK653's "perfectly balanced" (NK579 ban), and NK652's concept name says "Return Feather" on a `LOKI Blackout` brief, so every file name will read Feather on a Blackout asset. |
| 2026-10-26 | **8** | — | — | — | **Second run that day, on "Assign task now due on wednesday".** NK687/696/702→Naveed, NK697→Onyeka, NK699/707→Hammad, NK703→Hasnain, **NK708→Renniel (his first in this play)**. Gate passed on all 8. Posted, "Due on Wednesday" threaded, flipped; queue back to the 3 Callum rows. **8, not 7: NK708 was not in the opening query** — Mark moved it to `Ready to edit` mid-run ("Renniel can handle now so I assigned some task to him"), so the closing re-query is what caught it. See the re-query note under the detection query. Copy flags, all Andy's, all unproduced: **NK687** carries "The lightest knife you'll ever hold, and the sharpest" — the NK579 weight ban, and the third brief in three runs with that shape (after NK645 and NK653); it also claims "Over a hundred thousand people have brought one home", an unverified figure I did not get to sweep. **NK707 and NK708** both say the knife is "built tougher than any knife he's had before" and "basically indestructible" — one writing event across a concept pair, not established copy. **NK696/NK697** both describe the RAGNAR as "ten inches of tiger-striped steel", a dimension spec of the kind C.1 brackets with mm/gram; unswept, so a candidate rather than a finding. **Structural, and the one worth acting on: NK702 and NK703 both instruct "Ship all four hooks as H1, H2, H3 and H4" and both carry 4 hooks, but their File naming tables give only 3 rows (H1/H2/H3)** — both editors are a file name short for H4. NK664 on 2026-10-21 had 4 hooks and 4 matching rows, so the convention is that the rows track the hook count. |
| 2026-10-27 | **4** | — | **1** (NK716, malformed) | — | **Run on "assign task then due on thursday".** NK698/701/706→Hasnain, NK709→Onyeka. Gate passed on all 4. Posted, "Due on Thursday" threaded, flipped; queue back to the Callum rows. **All four were BJORN Santoku** — the first all-Santoku batch, and the product with the most hard rules. **A fourth Callum row appeared: NK716 "Overqualified Bottle Opener - Blackout"**, created that morning; excluded and not opened. Mark restated the Callum rule mid-run (see the hard-rule section). Clean on the two rules that bite hardest here: **no brief said "Japanese"**, and **none said the bolster was copper** — NK698/701/706/709 all say "dragon sculpted into the bolster" with no material, which is the safe form. **Headline flag: NK698 and NK709 both give the Santoku a "hand-carved rosewood handle".** Rosewood is the *Feather's* handle; the catalog calls the Santoku's "hand-carved wooden" and names no wood, and the house pattern (NK603/606/609) is "carved by hand" with no wood. This is the documented rosewood-on-Santoku error in `brand-accuracy/santoku-bolster-discrepancy.md` — which recorded that **no affected brief had ever been unproduced**, so all 7 were left as shipped history. **NK698 and NK709 are the first unproduced ones**, i.e. the first that could actually be fixed. Flagged, not touched. Also: **"basically indestructible" + "built tougher than any knife he's had before" is now in 4 briefs** (NK707/708/709 plus NK707's Feather original) — one Ladies This Year/Christmas writing wave, not established copy. NK706's son is "twenty-one" but "at uni" on a `Mkt-US` brief. |
| 2026-10-27 | **6** | — | 1 (NK716, malformed) | — | **Second run that day, on "assign task and due on thursday".** NK688/691/693/694/695→Umar, NK692→Hammad. Gate passed on all 6. Posted, "Due on Thursday" threaded, flipped; queue back to the 4 Callum rows. **All six are Rolling Knife Sharpener** — second non-focus batch after 2026-10-21, and the largest. All were created 22–24 Oct, i.e. they predate briefs assigned earlier the same day, so they sat in another status and were released in a block. Four carry pipes in the `Concept Name`; `#11-umar-editing` read back after sending and **all five of Umar's links rendered intact**. **Headline flag: the word "Japanese" appears 5× across NK691/692/694/695** — a named CLAUDE.md hard rule, but every use is about the customer's own knives, and NK688 shows the compliant form. Written up as its own section above; needs Mark's ruling rather than a fix. Also: **three different time-to-sharp claims in one batch** — "about a minute" (NK692), "a few minutes" (NK691, NK694, NK695), "under five minutes" (NK688); NK692 is the outlier. NK693's *"a literal samurai sword"* and NK695's *"samurai-sword sharp"* reach for Japanese imagery without the word. NK692's *"Regular sharpeners stop at #1000 grit"* is an unverifiable competitor claim. Grit and angle figures (#400/#1000/#6000/#10000, 15°/20°) are everywhere and are the product's actual stages, so not treated as C.1 spec-jargon. **Partly resolves an earlier flag:** NK694 says *"Over 100,000 customers"*, the same figure as NK687's "over a hundred thousand people" flagged on 2026-10-26 — recurring across two products makes it a real company stat rather than an invented number, so that flag is downgraded. The `\[customer voice\}` bracket typo (open square, close curly) appears 6× in NK691 and 3× in NK693. |
| 2026-10-27 | **2** (of 3) | **1** (NK680) | 1 (NK716, malformed) | — | **Third run that day, on "assign task and due on thursday".** NK670 and NK678 → Renniel, posted with "Due on Thursday" threaded and flipped. **NK680 held and not posted** — its body says *"Script still in progress. Do not shoot or cut until Status moves"* while its status was `Ready to edit`; see the hold-instruction rule above. It stays in the queue by design. Gate passed on all three. **`Content` = `Street Interview` is a third format value** after `AI VO` and `B-Roll`; note NK680's file naming says `UGC` in the content slot while the property says `Street Interview`, a non-editor-slot mismatch that is out of gate scope but will make the link text and the file names disagree. **Headline flag: NK670's hooks and body all claim the founder was "laughed off Shark Tank"** — written up above as its own class of flag, needs Mark's confirmation rather than a copy judgement. NK670 also carries *"The Japanese ones, all hype and overpriced"*, which is the competitor-disparagement form of the open "Japanese" question, and an editor payment term inside the brief body (*"we pay you double for this video"*) that goes to Renniel along with everything else. **Useful context for that open question: NK678's own red callout says "nothing related to Samurai and Japan style but around vikings"** — Andy actively steers away from Japanese imagery in brand storytelling, which argues the sharpener-line uses are functional rather than intentional. **NK670 and NK678 both have a completely empty `Visual` column** across every hook and body row, with direction given only in the red callout; that is the pattern for these two Hatori-reference AI documentary pieces, not a one-off omission, but it is a lot of unspecified footage for 20 beats. |
| 2026-11-04 | **5** | **1** (NK680) | **0** | — | **Run on "assigne task and due on friday"** — a week after the previous run. NK679/717/778→Hammad, NK718→Umar, NK719→Onyeka. Gate passed on all 5 (NK717/718/719 each have 5 hooks and 5 matching file-naming rows). Posted, "Due on Friday" threaded, flipped; queue down to NK680 alone. **NK680 held for the second consecutive run** — same unfinished-script note, and `page_last_edited_at` unchanged since 2026-10-27, so the script genuinely has not moved. **First run with zero Callum rows**: NK587/588/589 and NK716 all left `Ready to edit` without this play touching them, consistent with Callum routing his own work. **Mark's "Renniel can do task now" arrived mid-run** and is written up above as its own rule — it neither lifts NK680's hold nor authorises rerouting another editor's brief. `Content` = `AI VO ASMR` is a fourth format value after `AI VO`, `B-Roll` and `Street Interview`. Two new `Editor` options with no channel mapping (`Waheed`, `Fahad`) — see the warning above. **Headline flag, and it is a pattern now, not a slip: NK679 and NK778 both carry a red callout demanding real footage while their Visual columns instruct Higgsfield generation.** NK679's callout is *"REAL B-ROLL ONLY. NO AI-GENERATED VIDEO… No Higgsfield generation"* against five or six rows saying "Generate…" / "Use higgsfield", on a brief whose concept name is literally *"(Real B-roll)"*; NK778 says *"Real b-roll only from the Frame.io library"* against two Higgsfield rows, one of which generates a woman and children standing in for a named customer. Both are Hammad's, so he hits it twice. The editor cannot satisfy both instructions. **Also: NK719's H4 is a duplicate of its own H5**, while NK717 and NK718 carry a distinct H4 — so Onyeka produces four distinct assets where the other two produce five, which undercuts a three-way bake-off. Copy flags: **NK679 says "The lightest knife in the range"**, word for word the NK645 line, making this the fourth brief in three weeks with the NK579 weight claim (after NK645, NK653, NK687). NK717/718/719's closing line *"Four Feathers for the price of two"* states the offer differently from every other brief in the corpus, which says *"your choice on all four"* — and NK778, in the same batch, explains the real mechanic correctly (*"You've got to have two knives in your cart from the start"*), so the two readings sit side by side. Unverifiable specifics recur rather than being invented: *"5,000 five-star reviews"* appears again after NK670, which downgrades that flag the same way the 100,000-customer figure was downgraded. |
| 2026-11-04 | **6** | **1** (NK680) | **0** | — | **Fourth run that day, on "Assign task due on friday"**, arriving minutes after the previous run drained the queue — Andy/Mark released a block of six created 28 Oct–4 Nov. NK720→Umar, NK724/771→Naveed, NK731→Hammad, NK768→Onyeka, NK775→Anas. Gate passed on all 6 (NK724 has one hook and one file-naming row, matching). Posted, "Due on Friday" threaded, flipped; queue back to NK680 alone. **NK680 held a third time**, unchanged. Also this turn: **Mark ordered the NK679 weight-claim fix**, applied and noted in Hammad's thread — see the systemic-weight-claim entry above, which now runs to six briefs and gained two (NK720, NK724) in the same hour. **Hard flag: NK731's "up to 67% off" is not one of the `Offer` property's real tiers** (64% and 56% are). **NK724 reproduces the NK654 hand-hammer line verbatim**, attributing the laser-applied pattern to hand-work. **The customer count forked**: NK720 "over a hundred thousand" vs NK775 "over 147,000", same batch. **NK771 is the compliance model** — it instructs "Never say how the Feather's pattern is made", bans review counts on screen, and is the first brief ever to call the bolster brass. NK768 clean. NK771's roast register ("sweet cheeks", "cries like a princess") sits at the edge of its own persona note, which says affectionate never insulting — tone call for Mark. |
| 2026-11-04 | **1** (NK680) | — | **0** | — | **NK680 released on Mark's explicit override**, after three runs held: *"Assign the NK680 to editor."* Re-read first — page unchanged since 2026-10-27, script note still present — so sent as a knowing override rather than a lifted hold. Posted to Renniel and flipped. **No bare due-date reply:** the thread carries a note that the "Do not shoot or cut" line is superseded, that Mark cleared it, and to check with him or Andy if the script reads unfinished. **The go signal named no day**, and per the deadline rule a day is never invented — asked Mark rather than carrying Friday over from the batch minutes earlier, which matters more than usual here because a Friday deadline on an unfinished shoot script is not obviously coherent. Queue now empty. |
| 2026-11-04 | **5** | — | **0** | — | **Fifth run that day, on "assign task due on friday"** — five Santoku siblings of the Feather briefs assigned an hour earlier, released as another block. NK721/725→Hammad, NK770/776→Hasnain, NK773→Naveed. Gate passed on all 5 (NK725 has one hook and one row, matching). Posted, "Due on Friday" threaded, flipped. **Queue completely empty for the first time** — no Callum rows either. **Headline: rosewood-on-Santoku in 5 of 5**, written up above as systemic, and present in NK770/NK776's production direction and persona note as well as the VO, so an editor is told to shoot it. **NK721 is the only copper bolster**; the other four say brass, as did NK771 — the error is now the exception rather than the default. NK721 also carries a stray "then the Feather" in a Santoku Visual cell, which shows the find-and-replace derivation the write-up above describes. **The customer count splits by concept family, not at random**: the Apology pair (NK720/NK721) says "a hundred thousand", the Waiting For The Sale pair (NK775/NK776) says "147,000" — still Mark's to pick, but the pattern suggests 147,000 is the newer figure. Two separate yesterday-buyer counts in the Apology pair as well: 748 (Feather) and 512 (Santoku), which could legitimately be per-product. NK725's `Concept Name` ends in a stray " =" which lands in the Slack link label but not the file names. Good discipline worth noting: NK773 and NK776 both ban review counts on screen, and NK773's instruction keeps Norse god names out while carving out BJORN by name. |
| 2026-11-05 | **5** | — | **0** | — | **Run on "Assign task due on saturday".** NK700→Onyeka, NK705→Naveed, NK769/777→Hammad, NK772→Hasnain. Gate passed on all 5. Posted, "Due on Saturday" threaded, flipped. **All five LOKI Blackout, and materially clean on the product's hard rules** — the bottle opener is in the **handle** throughout, brass wherever a bolster is named, no rosewood misattribution. That is the first batch in weeks with no product-accuracy flag, and it is worth saying so rather than reporting silence. Three softer notes, all written up above: **"Batman" as the Blackout's descriptor** in NK769 and NK777 (consistent, so house copy rather than a slip — a trademark and tone call for Mark), and **NK769's unhandled profanity**, with no bleep or mute instruction anywhere in the brief, which leaves Hammad deciding it. **NK772 is worth citing as a model** alongside NK771: it instructs *"Do not imitate any real presenter"* and *"Show the Tiger Cleaver, not the RAGNAR Butcher"* — Andy pre-empting both an impersonation risk and a wrong-product shot. |
| 2026-11-05 | **5** | — | **0** | — | **Second batch that day, same "Assign task due on saturday" signal.** NK782/783→Hammad, NK785→Hasnain, NK786/787→Onyeka. Gate passed on all 5. Posted, "Due on Saturday" threaded, flipped. **A new placement: AppLovin**, written up above as its own section — strictly under 60 seconds, 9:16 at 1080x1920, and every brief a **re-cut of an already-shipped winner** rather than a new script. The runtime is pass/fail, not guidance: one of these records **NK146 being rejected at 61 seconds**, one second over. **Headline flag, and it is the systemic kind: NK782 (re-cut of NK184, a US+AU winner) and NK787 (re-cut of NK133) both say the Feather's pattern is "etched"** — because both source winners do. NK569 flagged the NK184 line in September, NK653/NK654 inherited it in October, and it is now being carried onto a new platform, so the decision is about the source winners rather than these two briefs. Also: **all five carry a generic MIKE/SARAH/VANCE persona template that contradicts their own `Avatar` property**, which names one persona — an untrimmed template header the editor can see both halves of. |
| 2026-11-05 | **5** | — | **0** | — | **Third batch that day, caught by the closing re-query**, which is the second time that habit has paid for itself (after NK708 on 2026-10-26). All five Rolling Knife Sharpener, all Andy's: NK762/763/765/766→Hammad, NK764→Umar. Gate passed on all 5. Posted, "Due on Saturday" threaded, flipped; **closing query returned zero rows — queue completely empty, no Callum rows either**, as on the last run. `Content` = **`AI VO Whisper`** on NK765 is a fifth format value, logged above with the other four. **The "Japanese" question moved, without resolving: four of these five carry the same angle beat** (NK762/763/764/766), taking the count to nine instances across eight briefs, while **NK765 uses NK688's neutral "15 or 20 degrees"** — the neutral form keeps turning up in exactly the briefs derived from NK688. That strengthens both readings at once and still needs Mark's ruling, so it was reported as a count rather than as a fresh discovery. All five say *"Over 100,000 customers"*, consistent with the figure already downgraded from a flag. NK764 and NK766 both ban review counts on screen. |
| 2026-11-09 | **15** | — | **0** | — | **Run on "Assigned task, due on wednesday"** — the largest single batch this play has handled, four days after the last run. NK704/779/793/801/803/804→Hammad, NK789/791/795→Anas, NK800/802/805→Umar, **NK790/794→Waheed** and **NK792→Fahad**, both of them their first briefs ever. Posted, "Due on Wednesday" threaded, flipped; closing query empty, no Callum rows for the third run running. **Mark mentioned mid-run that "we have 2 new editors"**, which closed the 2026-11-04 mapping gap: `#11-waheed-editing` `C0CEJBP4MQC` and `#11-fahad-editing` `C0CENMTDF9C`, both verified by listing (not guessed — see the resolved-channels section, including why `slack_search_channels` is the wrong tool for this). **First real gate failure in ~100 briefs: NK795's H1 file-naming row read `Andy_EDITOR`**, an unreplaced placeholder, against `Andy_Anas` in the Batch name and the other two rows. Held, reported, and on Mark's **"fix and assign"** the one token was corrected, the page re-read to confirm all four strings matched, then posted and flipped — so 15 of 15 landed, one of them on a second pass. Written up above as its own gate section. **Headline finding, and the most actionable thing this play has produced: Andy's in-brief rule block now works, and the only errors left are the two it does not name.** Every rule he writes down held across all 15 — no "etched", no "Japanese" outside the sharpener line, dragon placement correct throughout — while **NK790 said "copper bolster" twice and NK794 said "a rosewood handle" twice**, the two Santoku facts absent from the block. Two added lines would close both systemic errors at source. **Resolved: the customer count is 147,000** — seven briefs say it, five as an explicit on-screen super, so the 100,000 fork is closed. **Progress worth recording:** NK790/NK791 are the first Feather/Santoku sibling pair with no rosewood leak, four briefs carry explicit "do not copy their lines" sibling warnings, and NK793 annotates every deviation from its source winner. **Other flags:** NK779 puts *"a fucking bollocks"* in a **hook** with no bleep instruction (NK769's gap, escalated to the first three seconds of the ad, and Hammad's again); NK779 is the third and fourth real-b-roll-vs-Higgsfield contradiction, all four Hammad's; NK793 turns the ~3-month *restock* into *"three months in the workshop"*; "lifetime warranty" appears in all seven Lucky Day briefs as an on-screen badge and needs one confirmation. **The UGC "Husband Obsession" set (NK800–805) is the weakest work seen here** and all of it is template-level: *"five times sharper than average knives"* in all six (the NK646 invented-multiplier class Mark already ordered fixed once), the Santoku's **dragon bolster and hand-carved handle left on the Feather cuts** NK800/NK804 — the leak running Santoku→Feather for the first time — the identical offer paragraph across four briefs in one batch (a CLAUDE.md ban by name), the offer as the final beat with nothing after it, and the address flipping from wife to husband mid-ad. Six briefs, one script, so one editing pass. Also: NK792 and NK795 send editors to NK779's folder for footage, and NK779 was assigned in this same run — Fahad, on his first brief, is the one least able to know it is empty. |
| 2026-11-09 | **7** | — | **0** | — | **Second run that day, on "assign task, due on wedneday"**, minutes after the 15-brief batch drained the queue. All seven Rolling Knife Sharpener, all Andy's: NK767→Hammad, **NK796/797/798/799/806/807→Waheed**. Gate passed on all 7. Posted, "Due on Wednesday" threaded, flipped; closing query empty. **Six of seven to one editor who had received his first brief an hour earlier** — flagged as a load question, then partly answered by the briefs themselves: **NK807 addresses him by name and refers to "all the other ads you've done for us"**, so he is experienced and was only new to this play. That correction is written up above; the earlier onboarding concern was overstated. **NK767 had been sitting since 2026-11-03** — same creation block as NK762–766, which went out on 11-05 — so it was left behind in that batch rather than newly written. **Headline, and it is a metadata-vs-copy contradiction visible on the page: three briefs carry day-bound urgency on `Evergreen` inventory.** NK797 supers "ENDS TONIGHT 🚨" on all three hooks, NK799 makes the free discs conditional on "if you order today" twice, and NK806 has the narrator assert "I checked their site yesterday and it's almost gone again". An evergreen ad serves for weeks, so each is false on most of those days. **Second finding: the product's own stage architecture is described two ways in one batch** — four briefs say two-sided diamond roller (#400/#1000) plus ceramic and jade discs, while NK807 says four discs labelled #400/#1000/#6000/#10000, with an annotation that contradicts its own VO on which disc comes first. Waheed holds both versions. **Also: NK797 counts the lifetime warranty as one of its "three discounts"** (the `Offer` property names two components), **NK806 states "pull-through sharpeners don't work, they ruin your knife"** as flat fact about a competing category, and **NK796 opens H1 with "We fucked up, guys"** — the second profanity-in-a-hook of the day after NK779, and deliberate rather than a slip: H2 avoids it and H3 softens to "we messed up big time", so Andy wrote three escalating variants. **The "Japanese" count rose to thirteen across twelve briefs** (NK796/798/799/806), while NK767, NK797 and NK807 skip the beat entirely — more evidence it is droppable. **Useful lineage: NK796 shows the overstock premise flagged on NK665 is inherited** from NK383, itself built from a Hatori Knives ad ("We over-ordered. Badly."), so the question is whether the warehouse really is overstocked, not whether someone invented it. **Good practice to cite:** four briefs instruct *"Use a plain supermarket kitchen knife for the demo, never one of our knives"* (keeping the sharpener off NK's own edge-retention claim), NK799 adds *"Never show knives being thrown away — on this ad the dull knives get sharpened, not replaced"*, and NK796's instruction spells out CLAUDE.md's offer rule in Andy's own words: *"The offer lands as the fix for the overstock, keep the same subject through the transition."* NK767 is the cleanest brief in either of today's runs. |
| 2026-11-10 | **14** | — | — | — | **Run on "Assign task, due on friday".** Opening query returned 11, closing query found **3 more** — 14 in total. Posted, "Due on Friday" threaded, flipped. NK722/809→Naveed, NK723/728→Hasnain, NK726/730→Onyeka, NK727→Umar, NK729/808/810→Hammad, NK811→Renniel (his first since NK680), then the mid-run arrivals NK780→Naveed, NK813→Anas, NK816→Onyeka. Gate passed on all 14. **The closing re-query paid for itself a third time** (after NK708 and the 2026-11-05 sharpeners) — and this time the three arrivals were the batch's two best briefs and its worst-flagged one, so skipping it would have been expensive. **Connectors dropped twice mid-run**, once between posting and flipping; state was recovered from the posted-message record and the flips completed. **🔑 Headline: the new "10 Hooks" format multiplies every copy flag by ten.** NK808–811 each pair 10 hook lines with one LOCKED body (*"do not change a word"*, *"Deliver 10 files, H1 to H10"*) — **40 deliverables from 4 briefs**, all with exact H1–H10 file rows, which is a real mechanical improvement. But the NK184 body says **"A full feather etched from tip to handle"** plus the hand-hammer line, and the NK168 body says **"Free returns"** (banned by name in yesterday's briefs) and **"100,000 customers"** (superseded by 147,000). So the locked winners now stamp their defects ten times per brief, on `Evergreen`. Useful: the NK168 body is clean on "etched" — it says *"our sculpted, hand-forged blade"* — so one winner already demonstrates the fix for the other. **📌 Second: where "up to 67% off" comes from.** NK728's own AD INSPO says it is *"built around the 'six seven' meme (67% off)"* and a hook jokes that *"our brain-rotted intern"* suggested it — so the figure was picked for the meme, not calculated, and it is now in **six briefs** with three instructing a **"67%" on-screen super** against real tiers of 64% and 56%. **🚨 Third: NK810's H7 is the worst unhandled line in the corpus** (*"NorthernKnife, you can suck my balls"*) — in a hook, `Mkt-All`, `Evergreen`, with detailed direction for that hook and no censor note — while **NK722 and NK727 in the same batch show the handled form** (*"Bleep the word, censor it on screen"*). It is 1 of 10 hooks, so the fix is surgical. **Corrected a standing recommendation:** NK813 and NK816 call the Santoku's handle **ebony** (the Blackout's), not rosewood, so the rule line must be *name no wood at all* — written up above. **NK813 also contains the model answer to the Evergreen false-urgency flag**, refusing to fake a deadline and pivoting to stock scarcity; quote it rather than proposing wording. Also: the **Apple Watch** destruction clip in NK813/NK816 (trademark, and it is *her* watch on a SARAH brief); **NK816 carries both the cleared "new wife" line and the escalated "you're leaving"**, on a SARAH brief; the **Damascus 67-layer count in all seven Multi briefs**, still unruled since NK637; **the Multi set disagrees about whether Black Friday has started** (NK722/726 say live, NK727/728/730 say not yet) with four editors cutting simultaneously; and **stale briefs carry stale facts** — NK722–730 sat 11–13 days and NK730 still says 100,000 while NK722 is the batch's lone "copper bolster". **Callum's rows went 4→12 during the run**, all blank `Editor`, all untouched per the standing rule. Queue ends as Callum rows only. |
| 2026-11-11 | **6** | — | **0** | — | **Run on "assign task due on friday".** NK689→Umar, NK690/812/817→Hammad, NK814→Onyeka, NK815→Anas. Gate passed on all 6. Posted, "Due on Friday" threaded, flipped; closing query empty. **The SQL/rows query allowance ran out** before the opening query (`usage_limit_reached`, resets within the hour), so the queue was read through the `Ready to Edit` saved view and cross-checked against the `In Progress` table view — both written up above, including the board view's **blank-`Editor` blind spot**, which hid 12 rows that run. **Connectors dropped four times** during the run, twice between posting and flipping; recovered from the posted-message record each time, nothing double-sent. **✅ Callum's self-routing confirmed first-hand:** the twelve rows left alone yesterday (NK818–829, blank `Editor`) were all `Assigned to Editor` with editors filled in by this morning. **🚨 Headline: the gender ultimatum reached the hooks.** NK817's H3 is *"If you don't get me this, I'm leaving"* and its H2 is *"you're not a real man"* — so it is now the ad's opening line, `Mkt-All`, on a **SARAH-avatar** brief. Full trajectory table added above (body → close → hook, Oct 20 to Nov 11). **And it tracks the male narrator perfectly**: every ultimatum brief is `Voice-AI-M`, while **NK812, NK814 and NK815 — the female-VO versions of the same two concepts — are clean and lose nothing**. NK815 is NK817's direct counterpart. One ruling on the male-VO variants covers it. **Second: "etched" is no longer only inherited** — NK815 is newly written with no locked body and still says *"a full feather etched from tip to handle"*, so fixing the source winners is necessary but not sufficient; NK689 shows the same NK184 script adapted cleanly by dropping the feather content. **Third: the Apple Watch gag hardened from joke to proof beat** — NK690 (24 Oct) declines to cut it, NK816/NK817 (10 Nov) do it — four briefs and a dedicated clip now exist; NK817 also names two different clip IDs for that one beat. **Corrected my own prediction:** the Santoku "ebony" error has no sibling source — NK814 and NK817, both Blackout, never say ebony — so it is misremembering, not find-and-replace, which strengthens the *name no wood* rule. **Also: NK690 invents a pricing mistake** as its premise (an "intern ticked the wrong box") for what is simply the standing `40% + Free Gifts` offer, and promises the discs "go back to being paid"; **NK689 puts the industry-conspiracy allegation in its hook**; **NK815 adds a competitor food-safety claim** (coatings flaking into food); and the sharpener's time-to-sharp now has **four** different values across the corpus, with NK689 ("sixty seconds") and NK690 ("under five minutes") written the same day. **Clean and worth citing: NK812 and NK814 both carry the honest-urgency language** (*"We're not going to fake a deadline to make you hurry"*), so all three Sorry To The Wives briefs have it. |
| 2026-11-12 | **11** | — | **0** | — | **Run on "Assign task due on Saturday"** plus **"For NK855-NK859 tell them to prioritize this as we want to launch it before weekend"**. NK840/857/859/862→Hammad, NK841/855/856/858→Onyeka, NK842→Anas, NK863→Naveed, NK864→Hasnain. Gate passed on all 11. Posted in `createdTime` order, threaded, flipped; closing query **completely empty, no Callum rows**. Mark's extra instruction was carried in the **thread reply** on the five named briefs, alongside the due day, per the rule that a deadline he supplies goes in the reply and not the message: *"Due on Saturday. Please prioritize this one — we want to launch it before the weekend."* The other six got the plain `Due on Saturday`. **Largest single run of the play, and the first with `Strategist` = `Mark`** (NK862/863/864 are his own briefs). **🚨 Headline, and it is the reason this run needed a report rather than a count: the five briefs Mark asked to fast-track are built on the two lines he has not ruled on.** Both stopped being stray sentences and became **named concepts with their own IDs**, delivered **on camera by a real named creator** (`Voice-Creator-M`, Ryan Kirby): **NK857 "NK Suck My Balls (R14B2)"** has three uncensored-profanity hooks and no censor instruction, where NK722/NK727 bleep much milder words; **NK855/856/858/859 "New Wife Santa (R2B8)"** is the gender ultimatum Mark cleared on NK644 *explicitly as a one-off*. **🔑 Root cause found, and it is a one-place fix: the ultimatum line is pasted into the MIKE persona boilerplate** in every brief (*"For him we can do more hard marketing 'Ïf you're wife didn't get you this gift, you need a new wife'"*), so writers read it as approved house copy — editing that one sentence stops it at source for all future briefs. **🎯 Counterweight in the same queue: Mark's NK862–864 are the compliance model and fix by instruction.** Each carries an explicit `Do not:` line encoding exactly what this play keeps flagging — *never "etched"/"engraved"/"hand-finished"*, *the opener is in the handle, never the blade or spine*, *never "Japanese" or "Japan"*, *the bolster is brass*, **"No wood species for the handle"** (his own wording for the open Santoku rule — use it), and **"no 'up to' figures"**. They also annotate every changed line as a before→after diff with a reason, the only traceable briefs in the corpus. **The Apple Watch item closes**: all three swap *"your favorite lipstick"* → *"your Apple Watch"* annotated "Mark:", so the destruction gag is his own deliberate call, not a slip. **Two multipliers in one day**: NK855–859 say *"three times sharper"*, NK862–864 say *"five times sharper"* (carried unchanged from the NKEOFY005 winner, not marked Changed) — so the NK646-class fix has not reached the source winners. **"up to 67% off" reaches nine briefs** (NK840/841/842 add three) and is now contradicted inside its own batch by Mark's ban — nothing left to establish, it needs a decision. Also in those three: *"the number one Christmas gift in 2025"*, and NK840's *"feather etched from the tip to the handle"* sitting in the same queue as Mark's ban on the word. **NK841 gives the Santoku a "carved ebony handle"** — handle-wood error, third time in ebony, third wood overall. **NK842 clean** (finger loop is correct for the Blackout per NK801/NK803). **Good discipline worth naming:** all three `Better Call` briefs instruct *"Nothing about tariffs anywhere, on screen or in the VO"*, stripping the source NKFD071's tariff premise rather than letting it ride. Other flags on the fast-tracked five: *"those other bullshit knives"* (more uncensored profanity), a **garbled persona block** listing SARAH, two contradictory DONs, MIKE and COLE while `Avatar` is `VANCE`, NK856/858's stale *"100,000 customers"*, and NK858's non-catalog *"ODIN Chef Knife"*. |
| 2026-11-16 | **17** | — | **0** | — | **Run on "Assign task due on Thursday"**, repeated four times by Mark as worker restarts made the session look stalled — each repeat was the same signal, not a new one, and the queue was re-read before each wave rather than reusing a list. **Largest run of the play by a wide margin, and it arrived in three waves** as Andy and Mark released briefs while the run was in progress: **(1)** NK843/844/847/848/895→Hammad; **(2)** NK852→Hasnain, NK861→Naveed, NK865→Anas, NK871→Hammad, NK880→Umar, NK907→Anas; **(3)** NK849→Anas, NK851→Renniel, NK867→Hammad, **NK873→Fahad**, NK894→Anas, NK909→Hammad. Gate passed on all 17 (NK849 and NK851 have 7 hooks and 7 matching File naming rows). Posted in `createdTime` order per wave, "Due on Thursday" threaded under each, flipped; closing query **empty**, no Callum rows. **✅ NK873 is the first brief either new editor has received** — `#11-fahad-editing` (`C0CENMTDF9C`) took the post and the thread reply, so the 2026-11-09 verification holds live. **🆕 A `Mark` option now exists on the `Editor` property**; unused this run, and there is no editor channel for it (see the note above). **🚨🚨 Headline, and it reframes every copy flag this play has filed: Mark and Andy are now writing opposite rules into the same queue on the same day.** The full table is above. Mark's briefs encode, as explicit `Do not:` lines, the rules this spec has been reporting for two months — *never "etched"*, *the opener is in the handle not the blade or spine*, *no "up to" figures*, *no price in any market*, *never manufactured urgency*, *no wood species for the handle*, *the LOKI Viking is the bestseller not the Blackout* — while Andy's briefs in the same queue break them: **"etched" 10× across 5 briefs**, **"on the back" 6× across 4**, **"up to 67% off" now 18 briefs**, a price on `Mkt-All`, and two 7-hook concepts (NK849, NK851) built entirely on unverifiable stock scarcity on Evergreen. **The fix is to move Mark's `Do not:` block into the brief template** — he has written every line already; they just do not travel. **🔑 Two root causes found, both one-place fixes.** NK909 explains six runs of the opener error in a sentence: *"The LOKI Reaper is the one with the opener in the blade — do not mix them up"* — it is the wrong product's fact, not carelessness. And NK907 settles the NK654 uniqueness compound: *"The variation answer is the handle, not the blade. Rosewood grain and hammer marks vary. The feather does not. Do not let a visual imply 2 blades have different feathers."* **🎯 Mark went back into shipped winners and corrected them line by line.** NK844's Note column re-records four lines out of the NK222 winner — *"a tiger-striped face"* → *"a tiger across the face"*, *"dragon sculpted into the brass bolster"* → *"a textured brass bolster"*, *"notched into the blade"* → *"built into the handle"*, and *"Free returns."* cut — which closes the NK696/NK697 tiger-stripe flag and the NK168 free-returns flag at source. **And the single most-flagged line in the engagement is fixed: NK848 and NK861 both re-record *"A full feather etched from tip to handle"* → *"A full feather from tip to handle"*** out of the locked NK184/NK326 body, the line first flagged on NK569 on 2026-09-14. NK847 removes it by rewriting instead. **✅ Three open items answered by Mark's own wording** (Santoku handle rule, who the bestseller is, "black right through" now formally unverified with a verified-facts list). **🚨 But his rules do not reach all of his own briefs either**: *"most viral knife of 2026"*, which NK907 explicitly cuts, survives in NK848 and NK861; *"free returns"*, which NK844 cuts, appears in NK907 and NK909; and **the customer count forked the same morning** — NK843/NK847 say 147,000, NK907/NK909 say 100,000. **🚨 The queue also claims both sides of the brand's pricing integrity**: NK880 and NK894 are a public-apology concept whose hook SUPER reads *"NorthernKnife just admitted they lied to over 147,000 customers"* (3 cuts × 3 hooks = 9 assets, NK881 upstream), while NK849 and NK851 promise *"no secret discount"* and *"no secret code"*. Positioning call, not a copy nit. **⚠️ "No AI clips" against AI clips in the Visual column hit 7 instances in one day** (NK849, NK851, NK852, NK880, NK894) — and on NK880/NK894 the AI clip is a **synthetic brand owner delivering the apology**. Also: NK851 gives the Blackout two Feather facts (3-month batch, *"finger loop grip no other knife has"* — the Viking has it); NK894 says the Santoku dragon is **copper**; NK895 says *"carved ebony handle"* on the Santoku (4th ebony) and calls the Feather *"Our best seller"*; **"Japanese" returns** on NK871 and NK873; `Src-HexClad` on NK865/NK867 copies a named competitor's caption treatment on the same claim they market; **the lifetime warranty is now load-bearing** (NK865/NK867's three hooks collapse without it, four briefs add *"even the free ones"*, and a warranty badge asset is referenced); NK848/NK861 ship **three identical hooks** so their "winning hook" notes are meaningless; and *"3 months in the workshop"* recurs in NK844 while NK847 carries the correct form. |
| 2026-11-17 | **3** | — | **0** | — | **Run on "Assign task due on Due on thursday"** (typo for Thursday; read as the due day). NK917→Hammad, NK918→Anas, NK919→Onyeka. Gate passed on all 3 (3 hooks, 3 matching File naming rows each). Posted, "Due on Thursday" threaded, flipped; closing query empty. **All three are one concept — "Chinese Spy" — across the three focus products, all Andy, all `Mkt-All`, and it is the most serious thing this play has routed.** Written up in full above. It passed the editor gate, so it was posted per the editor-slot-only rule, **with the recommendation to Mark that he pull it before anyone cuts it** — and the note that nothing has been produced yet, so pulling costs nothing. Why it is different in kind from the earlier brand-risk flags (ultimatum, profanity, "we lied"), which were tone and positioning calls: **(1)** it attaches fabricated conduct to real identifiable people — it hooks on the real Nvidia espionage story and invents, in the narrator's voice and prefaced *"True story"*, that **the same woman also targeted NorthernKnife** (*"Nvidia's CEO got a Chinese spy. So did ours"*, *"Same girl... Nvidia during the week. Us on the weekends"*, NK918's *"two years seducing the Nvidia CEO"*), and although each brief carries the rule *"Never name the Nvidia CEO or the real woman... no photo of the CEO"*, **each one then breaks its own rule in the Visual column** — NK918 four times, instructing the editor to generate the real CEO at dinner and on a red carpet with her; **(2)** NK917 and NK919 both carry, verbatim, the production instruction *"Generate image of a gorgeous Chinese lady. But censored her face. Just show a hot sexy body"* — AI-generated sexualised imagery specified by ethnicity, standing in for a real woman accused of a crime, handed to two editors; **(3)** NK919's offer beat says *"If you want one, and not the Chinese one"* — a country-of-origin disparagement in the CTA, past the briefs' own *"no China jokes beyond the spy line"* limit. **And the payoff rests on a false product claim**: the resolution is *"there's no file, no formula, it's a guy... the feather design runs the whole length of the steel because he puts it there, one at a time"*, but the pattern is laser-applied — the NK654 hand-hammer error promoted to the load-bearing beat, so it cannot be word-swapped out without removing the punchline. NK918 does the same for the Santoku engravings and the dragon's scales. **🚨 Separately, NK919 breaks three of Mark's own NK909 rules one day after he wrote them**: it calls the Blackout *"Our best seller"* (NK909: the Viking is), puts the *"bottle opener tip"* in a Visual cell (NK909: *"Not the blade, not the spine... do not let a visual show the bottle meeting the steel"*), and says *"Finger hole in the blade"*. That is the sharpest evidence yet for yesterday's finding that the rules exist but do not travel. **The Santoku ebony count reaches 8** across these three. Also: **NK919's Feather block tells Onyeka to show the Tiger Cleaver** (same Visual cell as the next block) — a straight production error that will cost a re-cut; **the synthetic CEO is now a standing asset** (*"the guy in a black jacket... in the AI Animated Clips folder"*), with a biography and a *"MARRIED. AND LOYAL."* SUPER, after the AI brand owner delivered the apology in NK880/NK894; **"No AI clips" vs AI clips reaches 9 instances**, with NK919 adding the VO line *"No AI, no machine, comes close to this"* in an ad built from AI voice and AI imagery; and a new craft claim, *"only a handful of blacksmiths in the world can do it"*. **Good practice worth copying:** all three carry a pronunciation note for the AI voice (*"Say 'BJORN' as one syllable: type it 'Byorn' in ElevenLabs"*) and disambiguate two similar products (*"the ODIN 6\" Chef Knife, not the Hybrid Cleaver"*); **NK918 and NK919 are the first briefs to ban "Black Friday" outright**, which makes them Evergreen-safe on the event, though *"for the next few days"* and *"before the deal ends"* survive the fix. |
| 2026-11-17 | **10** | — | **0** | — | **Second run of the day, on "Assign task due on Due on Friday"** (typo; read as Friday). NK908→Naveed, NK910→Hammad, NK911→Anas, NK912→Onyeka, NK913→Umar, NK914→Fahad, **NK915 and NK916→Waheed**; then NK866→Fahad and NK896→Umar arrived mid-run and were caught by the closing re-query. Gate passed on all 10. Posted, "Due on Friday" threaded, flipped; closing query empty. **The first eight are all Mark's, and they are the best-constructed briefs this play has seen.** ✅✅ **The longest-running flag in the engagement is closed, with its reason.** NK916 states the Feather pattern rule in full — *"NEVER describe how the feather gets onto the blade. No laser, etched, engraved, printed, applied, laid, burned, stamped, coated, finished, inlaid"* — and explains both why the word recurs (*"the source is built on 'laser etch' — this is the page where that word is most likely to creep in, from an editor reading the inspo"*) and what the catalog actually requires (*"never describe the technique at all"*). Its companion line makes the rule usable: **"Describe how the STEEL is made. Never how the FEATHER is made"**, with *"hammered into shape by a blacksmith"* approved as house language. That retroactively settles earlier entries — NK910's *"hammered by hand"* is correct, NK917's *"because he puts it there, one at a time"* is not. The same rule now exists for the Santoku engravings in NK908, NK911 and NK914. ✅ **Three more open items closed.** **The customer count**: NK911 and NK912 carry *"147,000 customers — updated 2026-11-16 from 100,000. Customers, never reviews or stars"*, which explains yesterday's fork (NK907/NK909 predate the update inside the same day) and settles the figure. **The "Japanese" rule's mechanism**: NK914 — *"'It's called a santoku because...' can only be finished with its Japanese origin, and the brand never says that"*, so the rule is about never explaining the shape, not avoiding a word; NK908 adds the failure mode. The competitor-disparagement use is untouched and still open. **The invented multiplier**: NK911/NK912 refuse the source's "10 times faster" with the generalised principle **"a feeling, not a measurement. Never say it makes you faster."** And **"up to 67% off" gets its reasoning**: *"B2G2 is never converted into a percentage — it is a mechanic, not a discount"* (six briefs) — while NK866, in this same run, is the 19th brief to say it. 🆕 **Three product facts disclosed for the first time**, each as a scoping rule: **the Tiger Cleaver is not full tang** (NK913, with a beat-level rule so a 4-knife lineup cannot spread the claim), **the Santoku is not full tang** (NK914), and **the LOKI Reaper's two facts** — *"the opener is notched into the blade, and the tip runs straight"* (NK914), which is the product behind the recurring Blackout opener error. Fact budgets also appear: the Tiger Cleaver gets 2 facts in NK913 and 1 in NK914 with *"never its size... do not explain the 'Tiger' name"* — retiring the "over ten inches" and "tiger engraved" flags by forbidding both, which **NK896 then does anyway**. 🔑 **Second one-place fix found: "bottle opener tip" is boilerplate in the Visual-cell template.** The phrase appears in the Visual column of **five briefs across both strategists** (NK912, NK913, NK914, NK915, NK919) while the VO in each is correct — NK913 has the rule, the correct VO and the wrong Visual cell **in the same table row**. Nobody believes it; it is an unedited pasted snippet reaching editors as a shot instruction. Fix the string once. 🚨 **One real product error in Mark's eight: NK914 block 8 says "The LOKI blackout. The opener is notched right into the blade, and the tip runs straight"** — the Reaper's facts under the Blackout's name, which is exactly what NK909 was written to prevent, one day earlier. Its own roster note and red callout are correct, so it is a one-word VO fix plus the Visual cell; it matters because it went to Fahad, who has no history to catch it. ⚠️ **A dated rule change reached one brief in eight**: NK916 says *"'Black Friday Sale' is allowed, and wanted. The strategist lifted the house ban on the word 'sale' for Black Friday briefs on 2026-11-17"*, while NK908–915 all still ban it — so the editors hold seven briefs forbidding a word and one requiring it. 🚨 **NK866 arrived with a populated `Delivery Link`**, which no brief this play has had before; it most likely means the brief was already cut and returned to the queue (where `Revision needed` would fit), so it should be checked before Fahad starts. New edge case, outside the gate. ✅ **Both new editors are live**: NK915/NK916 are Waheed's first two and his channel took both posts and replies; Fahad is on his second and third. 🎯 **Two brief techniques worth naming**: the **collision guard** (Mark's briefs now cross-reference concepts by ID — NK135, NK214/NK762, NK421-423, NK388-389, NK175, NK461 and six named gift concepts — to stop a new brief duplicating an existing one) and the **inspo-hygiene block** (NK913 refuses the source's dishwasher, speed, health and testing claims one by one, quoting each; NK910 catches *"Ours is 30 days. The source says 60 — never inflate it"*). Also: NK911 justifies its avatar choice citing §C.3.1; NK908 refuses a durability claim on purpose (*"I'm not going to tell you it's indestructible"*, called *"the most important line on the page"*); NK916 states the correct scarcity form (*"runs of 500, 3 months to the next. Never 'sold out', never 'selling fast'"*). **Santoku ebony reaches 10** (NK866, NK896) while NK908/NK911/NK914 use the correct *"carved by hand"* form in the same queue; **NK866 asks for the forbidden two-units-side-by-side shot** and contradicts itself on whether the dragon is on the bolster or the handle; **NK896 invents the blacksmith's family and finances**. ✅ **Andy picked up two of Mark's production notes** (the BJORN pronunciation and the ODIN 6" disambiguation), so things do travel between them. **"Free returns" is in all ten of Mark's briefs this week** against NK844's single deliberate cut — downgraded from a contradiction to a one-line confirmation. Minor: seven briefs have `Category` = `Net New` with `Adapt` in the Batch name; "Northern Knife" is two words in eight VOs; five concepts now come from HexClad's library. |
| 2026-11-17 | **8** | — | **0** | — | **Third run of the day, on "Assign task. Due on thursday".** NK850→Onyeka, NK853→Naveed, NK854→Waheed, NK872→Hasnain, NK881→Hammad, NK920→Onyeka, NK921→Hammad, NK922→Hasnain. All eight Andy's. Gate passed on all 8. Posted, "Due on Thursday" threaded, flipped; closing query empty. 🚨 **The headline is that this run disproved, within the hour, the claim that the bottle-opener class was closed** — NK854 carries *"Black blade, black handle, finger loop, bottle opener on the back."*, near-verbatim the NK851 string fixed minutes earlier, and NK881 carries *"even one with a bottle opener on the back"*; both had been sitting in `Ready to edit` the whole time. Three more briefs carry the `bottle opener tip` Visual phrase (NK854, NK920, NK922), two authored today. The lesson is written up above: **the instance count was only ever the number visible from the briefs this play had read — stop counting and fix the template.** 🚨 **NK881 is the most serious product error logged so far**, not for novelty (it is the NK599 copper-bolster error, which has its own file in this repo) but for position: NK881 is a "we lied" public-apology ad whose entire device is certifying each claim **True** with a green check SUPER, and one of them is *"the dragon sculpted bolster is **copper**, not plastic. True"* with the SUPER **COPPER DRAGON**. It is brass. The same list certifies **REAL EBONY**. An ad built on the brand's own honesty, opening *"NorthernKnife just admitted they lied to over 147,000 customers"*, formally certifying a false material fact is an advertising-standards exposure rather than a taste call — a one-word fix before Hammad builds the supers. 🚨 **NK922's opener error is load-bearing**: *"A bottle opener built into the blade: he opens his beer and slices his steak with the same hand"* derives the benefit from the wrong placement, so unlike every earlier instance there is no word to swap — the beat needs rewriting; the same block claims *"so the knife never slips"*, an absolute safety guarantee, which is a new claim type. ⏰ **A scheduling finding worth as much as any copy note: NK850, NK853 and NK854 have sat in `Ready to edit` since 2026-11-12** and all three are saturated with Black Friday (NK850 says it ~15 times and its whole mechanic is *"the stock will not survive until Black Friday"*). Black Friday is 27 November, so the editors have ~10 days to cut, QA and launch creative whose premise expires on a fixed date — dated work held past the point where the date is comfortable, in a database called *Evergreen Video*. 🎵 **New risk class**: NK920/921/922 each instruct *"the same track as the TikTok (**Elf main theme**)"* plus the named creator's font style, on paid Meta ads — a copyrighted film score, cheap to fix now and expensive after three editors have cut to it. **Counts**: Santoku ebony 10→15, "up to 67% off" 19→25, NK price on `Mkt-All` 2→3 (NK872 *"for less than 200 bucks"*), Tiger Cleaver size-and-name 3 new instances after NK913/914 retired it by rule; NK872 also carries the still-open competitor use, *"\$1000 on an overpriced **Japanese** blade"*. **NK853 and NK854 repeat the NK852 fake sell-out** (*"there isn't any Santoku left. We're sold out." / "You're joking." / "I am."*) — one decision from Mark, not a flag per brief. ✅ **Two earlier flags got their counter-examples**: NK853 and NK854 both carry the Note **"bip the fuck off"**, so the NK769 unhandled-profanity flag is answered; and NK872/NK881 both state the originality gate in the brief (*"nothing from the source is quoted beyond the structure"*) — NK881 being the irony, since the gate held on the source and failed on the product facts. Also ✅ `Category` and the Batch name agree on all eight, and Andy has picked up Mark's collision-guard habit (*"Santoku twin of NK871 (Feather, Hammad)"*). Minor: NK854 *"The Blackout is our fastest seller"* against NK909's Viking rule; NK872 *"And it's still in stock"* (for *"if"*, inverting it into a stock assertion); NK881 instructs *"no vegetable montage"* then asks for a vegetable clip; "free shipping" in NK853/854/920 is as unconfirmed as the lifetime warranty. |
| 2026-11-23 | **2** | — | **0** | — | **Run on "Assign task now due on wednesday".** NK964→Umar, NK965→Umar, **both Mark's own**. Gate passed on both (Batch name and all 3 File naming rows read `Mark_Umar`). Posted, "Due on Wednesday" threaded, flipped; closing query empty. ✅ **The 11-17 scheduling finding was acted on.** That run flagged the queue holding Black Friday creative past the point where the date was comfortable; NK964 answers it in writing, with a date and an owner — *"The Feather cut, NK916, stays on Black Friday; this cut **moved to the Holiday Sale on 2026-11-23**, by the strategist's call"* — carried by a new `Specialty` value, `Holiday Sale`, on both briefs. The event was migrated rather than left to expire; nothing further is owed. ✅ **The "sale" fork resolves correctly**: *"'Holiday Sale' is allowed, and wanted. 'Discount' is still banned, and so is any superlative about the sale."* The ban was never on the word *sale* — it is on **discount** and superlatives, which is a usable rule rather than a word-list, and it closes the seven-vs-one inconsistency NK916 left. 🎯 **These two are the most compliant briefs in the corpus**: every rule this log has chased for two months appears as a pre-emptive red callout **with its reason** — the opener in the handle *plus* why (*"The LOKI Reaper is the blade one"*), the Viking as bestseller, "black right through" marked unverified, Full-Tang as Feather-only, the batch cap as a Feather fact so no scarcity on the Blackout, the feather-technique ban, scarcity stated exactly (*"runs of 500... and never that the sale makes it go faster"*), no price/percentage, 147,000, no invented deadline, and *"'Meat' — never a named cut"*. Offers land at ~72% and ~71% with beats after, and both briefs state the figure themselves. 🆕 **Four new rules, three of them pre-emptive**: **"No delivery promise — never 'in time for Christmas'"** (both briefs — the hardest claim a Christmas ad invites, banned in the week it is least safe); *"No weather claim in either direction"* (NK964, which a grill setting invites); *"Never call the Feather a carving knife"*; and **"No brand on the electric knife. It's the enemy, not a named one"** — which is **the answer to the open competitor-disparagement item**, doing NK872's job (*"\$1000 on an overpriced **Japanese** blade"*) without naming or disparaging anyone, in a form the next brief can copy. 🎯 **New technique worth copying**: NK964 is titled *"Under The Feather... - Blackout"* and pre-empts its own confusion — *"There is no feather on this knife — the name groups the trio"* — anticipating exactly the cross-product visual error NK919 made when its Feather block named the Tiger Cleaver. 🆕 **Mapping gap flagged before it bites: `Ali` and `Abdul` are now `Editor` options** and neither has a verified channel. Same shape as the Waheed/Fahad gap that sat open five days; the first brief assigned to either falls to Mark's fallback under the never-guess rule. Minor: `Category` reads `Net New` while both Batch names read `Adapt` and both briefs really are HexClad adaptations, so here the **property** is the wrong one — the inverse of the earlier seven-brief mismatch; NK964's Batch name says `6r-Blackout`, a landing page that does not exist in the schema; **"Free returns." is in both closes (12+ of Mark's briefs now — settled house copy, stop tracking it)**; **"Northern Knife" is two words in both**, which moves that item from an Andy slip to a house inconsistency; and the trio is split across sweeps (NK916 went 11-17, NK963 was not in this queue), so Umar holds one third of a set. |
| 2026-11-23 | **7** | — | **0** | — | **Second run of the day, on "Assign task due on Due on wednesday"** (typo; read as Wednesday). Three of Mark's Holiday Sale cuts and four of Andy's R2B8 Santa UGC cuts: NK963→Hasnain, NK966→Hasnain, NK967→Fahad, NK974→Hasnain, NK975→Hammad, NK976→Umar, NK977→Hammad. Gate passed on all 7 (NK975/NK976 have 6 hooks and 6 matching rows). Posted, "Due on Wednesday" threaded, flipped; closing query empty. 🚨🚨 **This run is the clearest evidence the rule-travel finding will ever get, because it has none of the earlier outs — same date, same products, both strategists, same editors.** Mark's NK964/NK967 say *"**No scarcity.** The batch cap and restock window are **Feather facts**"* while Andy's NK974/NK975 sell *"their **limited edition** Loki Blackouts"*; Mark's NK965 says *"**Never 'selling out', never how fast a run went**"* while NK975/NK976/NK977 all say *"**it always sold out in days**"*; Mark's three say *"No price, no percentage"* while NK977 says *"**up to 67% off**"*; Mark's three ban an invented deadline while NK975/NK976 say *"**might not be available when you watch this video**"*. **And one editor holds both sides** — Hasnain got NK963/NK966 (carrying the rules) and NK974 (breaking them) in the same sweep, minutes apart. Nothing is left to establish; the only open question is whether Mark's `Do not:` block reaches the template. 🚨 **The customer count forked again, backwards**: Mark's three say **147,000**, Andy's three say **100,000**, on the same day, after this was "resolved" on 11-09 and re-confirmed with a dated note on 11-17. Not a style question and not arguable — one number, in the proof stack of nearly every ad, 47,000 apart. 🚨 **NK976's fifth hook is an innuendo and it is in the hook**: *"So my wife finally got me a knife **as big as my.. You know what I mean**, for Christmas."* Different in kind from the earlier tone flags — a phallic innuendo with the punchline left to the viewer, in the **first three seconds** where it cannot be skipped, delivered on camera by a real named creator. Needs Mark's call before Umar cuts it. NK976 also adds three Tiger Cleaver size claims that NK913/NK914 retired by rule six days ago. 🔑 **The MIKE boilerplate is now 11 days old as a known one-place fix and produced 7 ultimatum hooks in one sweep** (NK974 3-of-3, NK975 3-of-6, NK976 3-of-6) from one unedited sentence in a pasted block; the same block still lists five personas, **two of them called DON**, while `Avatar` on all four is `VANCE`, who is not in it. ✅ **Mark answered the NK881 copper error forward, in the template**: NK963 states *"It's **brass**, with a dragon sculpted into it"* plus *"**'Sculpted'... is the only one.** Never 'solid', never 'cast'"*, and gives the handle as *"Wood, carved by hand"*. So his *"No need for that"* on 11-17 was not indifference to the fact but a refusal to re-touch a shipped page while fixing the cause next — **when he declines a page edit, check the next brief before calling the item unresolved.** ✅ **Two roster edge cases closed at source**: `Huzaifa` (off roster since 10-13) and `Mark` (added 11-16, never used, no channel) are both **gone from the `Editor` property**, which is now 11 names; the `#11-mark` fallback is unaffected. 🆕 **First colour spec in a brief**: Christmas subtitle pills with hex values (`#D7263D` red hook, `#1B6B3A` green offer, white neutral) and an image asset, on all three of Mark's, optional per hook. ✅ **Andy's VO got the opener right where his template did not** — all three extensions say *"a bottle opener **forged into the handle**"* while the Visual cell still reads *"bottle opener tip"*, so that error now lives **only** in boilerplate, nowhere a writer typed it fresh. **Counts**: `bottle opener tip` 3→6, "up to 67% off" 25→26, "three times sharper" 4 new (the NK646 class Mark ordered fixed on 10-20), uncensored profanity 2 new (*"those other bullshit knives"*, no bleep). Minor: **NK974 has no Visual direction at all** — every cell in both tables empty and an empty `<video />` inspo block, so Hasnain has copy and nothing else; NK975 names the non-catalog *"ODIN Chef Knife"*; NK975 keeps the "batman" descriptor; **NK967's "ebony handle" is correct** and worth saying plainly, since 15 Santoku-ebony instances could be misread as a ban on the word — the rule is ebony on the Blackout, hand-carved wood on the Santoku; "Northern Knife" is two words in all seven, both strategists, so it is the house spelling in practice and this log should stop counting it; `Iteration` is `__NO__` on all four of Andy's while `Category` reads `Iteration`. |
| 2026-11-24 | **0** | — | — | — | **Run on "Assign task due on thursday" — the first run under the Mark-only rule, and it assigned nothing.** Queue held **7 of Andy's and 0 of Mark's**, the rest out of scope. No posts, no flips, no page reads beyond the two count queries, no fallback posts. **This is the predicted consequence arriving on the first run**, one day after the scope narrowed — recorded so a future reader does not read a zero-post run as a broken query or a missed go signal. The detection query (`AND "Strategist" = 'Mark'`) returned empty and the pattern the hard rule calls for is to filter so a non-Mark page is never a candidate and act on nothing. (The breakdown recorded here originally counted the out-of-scope rows; that count has since been removed per the 2026-11-24 settlement.) **Andy's 7 arrived since the previous evening's sweep left the queue empty**, on top of the 26 then sitting in `Ready for visuals` — so his briefs are flowing in and accumulating with no route out, exactly as the scope entry said they would. Nothing further was raised to Mark beyond one line, per that entry. |
| 2026-11-24 | **4** | — | — | **3 (gate)** | **Second run of the day, after Mark restored Andy to scope** (*"Andy is fine since I also manage that only callum's work will never be touch"*). The Thursday go signal was still live, so the sweep was re-run rather than waiting for a new one; the spec, query and CLAUDE.md were reverted to the Callum-only rule first. **7 of Andy's in scope.** NK941→Renniel, NK944→Hammad, NK956→Naveed, NK961→Onyeka posted, "Due on Thursday" threaded, flipped. 🚨 **Three held on the gate, all the same cause: `Andy_EDITOR` left unreplaced** — NK968 (Hasnain), NK970 (Hammad), NK972 (Naveed), in the Batch name **and every** File naming row (3, 5 and 3 rows). This is the NK795 case of 2026-11-09 grown from one row to three whole briefs. All three carry a checklist line saying *"your name in place of EDITOR"*, so the placeholder may be addressed to the editor — but **NK956 and NK961 from the same batch have the real name filled in and carry that same checklist line anyway**, so it is boilerplate and the filled ones show the intended end state. Held per *never guess which side is right*; recommended fix is one token per row from the `Editor` property, as Mark ordered on NK795 (*"fix and assign"*). ✅ **Andy now writes the opener rule himself** — all five Santa briefs state *"the bottle opener is in the handle, never show it in the blade"* in the instruction **and** the upload checklist, and every VO says *"built into the handle"* correctly — **while the Visual cell in NK956, NK968, NK970 and NK972 still reads *"bottle opener tip"***. Four more instances on pages that forbid it twice each. The error now survives only in the pasted Visual snippet, nowhere a writer typed it fresh and nowhere a rule is missing: **the snippet is the whole remaining problem.** ✅ **Mark's Christmas subtitle pills reached Andy's briefs** (same hex table in NK961/968/970/972, three days on) — so conventions travel; it is the product facts that do not. 🚨 Stale **100,000** count in NK956/NK961/NK970 against Mark's 147,000; a new unverified *"Over five thousand five-star reviews"* in NK956/NK970 **while NK961 and NK968 instruct "No review counts on screen"**; **rosewood on the wrong knives** (NK956 gives the Santoku a rosewood handle and the Tiger Cleaver *"rosewood and copper"*, NK970 repeats it — NK968 gets it right with *"hand-carved wooden handle"*); **NK941 and NK944 put the opener "into the steel"** and both claim a finger hole *"so it never slips"*, the absolute safety claim from NK922 — these two are the only briefs in the batch with no rule callouts at all; NK944 *"five times sharper"*; NK941 invents an *"ODIN chef knife in Damascus steel"* (non-catalog name and a steel type in no product fact); Tiger Cleaver *"ten inches of tiger-striped steel"* in three briefs; Blackout batch-scarcity in NK961/968/970 against Mark's *"the batch cap is a Feather fact"*; *"the biggest deal we've ever put out"* in three. ✅ **Worth copying: every Santa brief names its winning hook with the spend behind it** (NK222 H1 took US \$84k at 1.80, NK651 H5 US \$48k, NK401 H2 AU \$35k) and says which hook it replaces and why — the clearest creative reasoning in the corpus. NK941 again has an entirely empty Visual column. |
| 2026-11-24 | **6** | **3** (blank editor) | — | 3 (gate, still held) | **Third run of the day, on a repeated "Assign task due on thursday".** SQL allowance spent again — ran on the saved-view fallback. **12 of Andy's in scope.** NK942→Onyeka, NK945→Onyeka, NK955→Hammad, **NK958→Ali**, NK959→Waheed, NK960→Waheed posted, threaded, flipped; closing query clean, no mid-run arrivals. 🔑 **NK958 is Ali's first brief ever, and it validates yesterday's channel check**: it went to `C0CJ8LNCDLP` from the live listing, **not** the `C0D4MN8PQR1` Mark supplied, and the channel accepted the post and the thread reply. Had the supplied ID gone into the mapping unchecked, the send would have failed a day later on a brief nobody was watching for, the flip would have followed it, and the brief would have left the queue unseen — the exact silent failure the never-guess rule exists for. One tool call, one brief saved. **NK989/990/991** (*Triple Discount Holiday*, all three products, all created today) have **no `Editor`** → one fallback post to `#11-mark` naming all three, status left at `Ready to edit`, nothing guessed. **NK968/970/972 stay held** on the `Andy_EDITOR` placeholder: a repeated go signal does not change that, since the spec defines a go signal as every brief *not Callum's **and not malformed***. ⚠️ **The saved-view blind spot did not reproduce** — the board returned blank-`Editor` rows this time (the out-of-scope rows plus NK989–991) and the table cross-check agreed exactly, 20 rows both. So `hideEmptyGroups` is unreliable in **both** directions (hid 12 on 11-11, hid none on 11-24): the fallback section now says run both reads every time regardless. ✅ **NK958 is the cleanest brief in the Santa set and the reason is instructive**: it is the only one with no stale count and no review count, and it is the one whose own instruction says *"No review counts on screen"* — it obeys itself, where NK955 and NK959 carry the same instruction family then assert *"five thousand five-star reviews, a hundred thousand customers"*. It also gets the Tiger Cleaver handle right where the other three say *"rosewood and copper"*. Same author, same day, same family — **the difference is whether the body was checked against the rules, not whether the rules exist.** 🎯 **NK945 has the best inspo documentation in the corpus**: source named with run dates, then *why it works* / *shape we keep* / *shape we change*, the last reading *"their discount is the last line. Ours lands at ~65% with three beats after it"* — the CLAUDE.md offer rule stated as a deliberate deviation **with the figure**, the first time the originality gate is reasoned rather than asserted. Copy that block structure. Repeats: *"five times sharper"* in NK942/NK945; stale 100,000 in NK945/NK955/NK959; *"ten inches"* on the Tiger Cleaver in four briefs; `bottle opener tip` in the Visual column of NK955/NK958/NK960 while **NK959 gets it right**, so one snippet, four pages, three wrong; Feather *"gone in two weeks"* in three, against Mark's NK965 rule; *"three months in the workshop"* in two; a new unverified *"more than twenty knife styles"* in NK945. NK959 introduces an *"As NK651"* Visual shorthand instead of shot descriptions. |
| 2026-11-24 | **15 total** | 3 (then assigned) | — | 0 | **Fourth run, the second "Assign task due on thursday", in three waves as Mark decided editors and the queue filled underneath it.** Opening read 20 rows → NK942/945→Onyeka, NK955→Hammad, NK958→Ali, NK959/960→Waheed. Then on Mark's decisions → NK968→Hasnain, NK970→Hammad, NK972→Naveed, NK989→Umar, NK990→Ali, NK991→Umar. Then three mid-run arrivals → NK969→Onyeka, NK971→Umar, NK973→Onyeka. All gate-clean after **9 placeholder fixes**; closing query clean. 🚨 **The `Andy_EDITOR` placeholder is template-level, not a slip: it was on nine briefs** — NK968/969/970/971/972/973/989/990/991, i.e. **every brief Andy created on 11-23 and 11-24** in the Santa and Triple Discount families. The escalation is NK795 (one row, 11-09) → three briefs (11-24 am) → nine (11-24 pm). All nine also ship the checklist line *"your name in place of EDITOR"*, and NK955/958/959/960 from the same family have real names filled in and carry that line too — **so the fix belongs where the Batch name is generated**, not in nine pages a day. 🚨 **"Copper bolster" is back four times** (NK969, NK971, NK973, NK991), three days after Mark's NK963 ruled *"It's **brass**, with a dragon sculpted into it"* and made "sculpted" the only word — and a week after he declined to fix NK881's copper with *"No need for that"*. The forward fix reached his template and not Andy's. Three of the four also give the Santoku a **rosewood handle** (the Feather's; it is hand-carved wood). All four carry their own correct rules in the same callout and obey them, **so the rules Andy writes hold and the two facts he does not name are the two that are wrong** — the 11-09 finding, unchanged two weeks on. 🔄 **Three mid-run arrivals needed three closing re-queries**: NK969/971/973 were all in `Ready for visuals` at the open and `Ready to edit` by the end, editors set, moved while the run was live. The NK708 pattern times three — **keep re-querying until a pass returns nothing new**; a single closing read would have left three briefs behind. 📝 **Process note**: Mark's *"Assign it to umar, hammad and ali"* did not match the editors on the held set, so it was ambiguous which three briefs he meant. Asked; he said *"You can decide then fix the baming afterwards"*; on deciding and starting the edits he stopped the run with *"ask me each concept so I can decide"*. **So "you can decide" did not survive contact with the actual decisions** — on anything that assigns work to named people, prefer the per-item question even when told to use judgement. Nothing had been posted when he stopped it, so the reversal cost one property change. His calls: NK989→Umar (I had proposed Hammad), NK990→Ali and NK991→Umar as proposed, and **keep Andy's editors** on the held three. ⚠️ Load: Umar now holds four of today's briefs and Onyeka four. Copy flags on the Triple Discount trio: **"ALMOST SOLD OUT" in all nine hooks** plus *"gone until next year"* and *"when it sells out, it stays sold out"*, against **Andy's own NK961/NK968 "No sold-out claims on the Blackout"**; the **delivery promise** *"in time for Christmas"* / *"before Christmas"* in all three, conditioned on a shipping cut-off **Mark's NK967 says does not exist**; NK990 *"every batch so far has sold out in days"*. ✅ All three carry a real holiday subtitle spec and the NK135 winner's numbers (A\$12.6k at 3.01 ROAS, 148 purchases). |
| 2026-11-24 | **10** | — | — | 0 | **Fifth run, a third "Assign task due on thursday".** NK938→Renniel, NK940→Onyeka, NK943/946→Waheed, NK957/962/993/995→Umar, NK994→Anas, NK992→Umar then **re-assigned to Hammad** on Mark's *"re-assign 992 to hamad"*. All gate-clean; **1 `Andy\_EDITOR` placeholder fix** (NK992, 4 rows, filled from the `Editor` property per the NK795 *"fix and assign"* precedent). SQL allowance spent on the closing query — ran the saved-view fallback, **both reads, which agreed exactly**. 🔄 **NK995 flapped `Ready to edit` → `Assigned to Editor` → `Ready to edit` during the run and had never been posted** — caught by the closing pass, channel checked for a duplicate first, then posted and flipped. See its section above. ⚠️ **A `update_content` call errored with "No matches found" after applying its change** — new tooling hazard, and the reason naming rows are now verified by fetch rather than by probe. 🔍 **Headline finding: five of six Santoku descriptions get the handle or bolster wrong, and the one that is right (NK962) is the only one not freshly written** — a word-for-word port of NK599. The Santoku handle appears as ebony (×3), rosewood (×2) and correctly hand-carved wood (×1) in one batch; NK992/NK994 add two more **copper** bolsters. 🚨 **NK995 carries the hand-work attribution for the Feather pattern** (*"no two hands hammer the same way"*) against the `CLAUDE.md` laser-applied hard rule — third flagging of the same line inherited from NK184, with a proposed replacement. Also NK995 *"the lightest, sharpest knife he will ever hold"* (NK579 weight ban) and *"the most viral knife of 2026"*. Repeats: stale **100,000** in NK946/NK957 **while NK940 uses the correct 147,000 in the same batch**; *"five times sharper"* in NK943/NK946/NK944-family; Feather batch-scarcity on the wrong product in NK940 (Santoku), NK994 (Santoku), NK992 (Blackout), **correctly on the Feather in NK993 and NK995**; *"the biggest deal"* superlative in NK957/NK995; `bottle opener tip` in the Visual cells of NK957/NK994 — **but NK992's Visual cell gets it right** (*"the opener in the handle"*), the first time that cell is correct, and its brief states the rule explicitly. ✅ **NK992/993/994 name Artlist for music**, the licensing-safe route, against the unresolved Elf-theme question on NK920/921/922. ✅ NK993 is clean throughout. ⚠️ Load: Umar took 4 of this run (9 across the day), Waheed 2. NK938 is Rolling Knife Sharpener, a non-focus product — flagged, not withheld. |
| 2026-11-25 | **3** | — | **3 (gate)** | 0 | **Run on "Assign task due on friday"** — a new Feather UGC batch (NK997–NK1002, created 23:41–23:51 the previous night), all Andy's, all `Avatar: VANCE`, creators Rick and Nathan. NK998→Umar, NK1000→Anas, NK1001→Waheed posted, "Due on Friday" threaded, flipped. Closing query clean, no mid-run arrivals. 🚨 **Three held, on two gate classes this play could not previously catch — both now rules.** (1) **NK997 and NK999 carry the identical script**, all 3 hooks and all 7 body beats verbatim, same creator (Rick), two different editors (Ali, Fahad) — two editors would cut the same ad. Held both: the duplicate could be either page, and the gate compares a page against itself, never against its siblings. (2) **NK1002's naming rows read `Mark\_Umar` while `Strategist` is Andy** — the *editor* token matches, so the gate as written passed it, which is why the check now covers every person-naming token. Held also for **seven unfilled `TBD` tokens** in the batch name where every sibling has them filled; an editor would put the literal `Angle-TBD` into every file name. 🔍 **The MIKE persona block is now a five-persona dump** pasted on all six: `DON` defined twice (Opportunist and Hunter), the Opportunist called DON while the schema option is VANCE, and none of the five is the brief's own avatar. 🚨 **Its wife-replacement line has graduated into live copy** — all three NK1000 hooks are variants of it. Raised rather than assumed cleared, per this file's own note that Mark's *"that's fine for now"* closed **NK644 specifically and set no standing rule**. Adjacent: NK1001's wife's-watch joke and its whips-it-out line, with NK976's innuendo hook still open — a wife-as-punchline cluster on a product whose main persona is the wife. ⚠️ **Opposite weight claims on the Feather one day apart**: NK998 calls it heavier than anything else in the kitchen, NK995 the lightest he will ever hold — both banned by NK579, and together proof the claim rests on no shared fact. Same shape in the multiplier **within one batch**: NK1000 three times sharper, NK1001 five times sharper; Mark already ordered NK646's *"three times the control"* fixed. ⚠️ **NK1001's offer is the final beat** with nothing after it, against the explicit `CLAUDE.md` rule (never first or last, 2–4 beats after) — its own batch name says `Off-Late`. ⚠️ **The body is duplicated below the tables on all six**, and **on NK1000 the two copies differ** — one template fix, not six. Profanity in NK998's hook and NK1000's body, flagged not withheld. ✅ **The Feather's own facts are right throughout** — rosewood on the Feather, small-batch scarcity on the Feather, no hand-work attribution on the pattern — the direct contrast with yesterday's Santoku batch, and support for the finding that accuracy tracks whether the hero is the product the writer knows. 📌 **Creative IDs rolled past NK999 to 4 digits**; this play reads the ID as text and was unaffected. |
| 2026-11-25 | **0** | — | **3 (gate, still held)** | 0 | **Repeated "Assign task due on friday"**, minutes after the previous run. **Nothing new in the queue and nothing assignable** — a repeated go signal does not release a gate hold, since a go signal covers every brief *not Callum's and not malformed*. No posts, no flips. ✅ **NK1002 had been edited between the two signals**: the `Mark\_Umar` strategist token is now `Andy\_Umar`, so that ground cleared within minutes of being reported — evidence that reporting a naming defect precisely (which token, which rows, what it would produce) gets it fixed. Its **seven `TBD` tokens remain**, so the hold stands on that ground alone. 📌 **Lesson: on a repeated go signal, re-read the held pages, not just the query** — the query showed NK1002 unchanged in `Status`, `Editor` and `createdTime`, and only the page body carried the fix, so a query-only re-check would have reported a stale hold. NK997 and NK999 re-read and **still byte-identical in copy** (same `page_last_edited_at`), so the duplicate is unresolved and still needs Mark's call on which page is real. Noted that the `TBD` tokens are strategist taxonomy choices and not Claude's to infer, and that an honest `Off-First` on NK1002 would document rather than fix its offer-opens-the-body structure — a judgement call, since NK957 used `Off-First` deliberately. |
| 2026-11-25 | **2** | — | **1 (gate, still held)** | 0 | **NK997 and NK999 released on Mark's answer** — *"997 amd 999 are same script but different content creator speaking"*. The collision was intentional: one script across two creators is two ads with real test value, which is the exception Class 1 already allowed for. NK997→Ali, NK999→Fahad posted, "Due on Friday" threaded, flipped. SQL allowance spent on the closing query — saved-view fallback, **both reads, which agreed exactly** (one in-scope row left). 📌 **Class 1 amended**: the question on a verbatim collision is not *"which is real?"* but **"one script across two creators, or the same brief twice?"** — different creators post, same creator holds. The pages could not settle it: **both briefs carry `Cre-Rick`** and both label their Frame.io link *"Rick talking head"*, with only the clip IDs differing. ⚠️ **Open consequence: one `Cre-` token is therefore wrong**, and it sits in that brief's Batch name and all 3 File naming rows — the same defect class as NK1002's `Mark\_Umar` token hours earlier. **The person-naming-token check now covers strategist, editor and creator.** Raised to Mark for one word. 📝 **Posted rather than held, deliberately**, and the reasoning is recorded: he had signalled go twice and just cleared the ground the hold rested on; a wrong `Cre-` token is misattribution inside a filename, fixable before delivery and invisible to the cut, against two editor-days lost; and both *editor* tokens match, so routing — what the gate is actually for — was never in doubt. New rule: hold on a token that decides who does the work or who is accountable; on the creator token, post and ask. **NK1002 stays held** on its seven unchanged `TBD` tokens. |
| 2026-11-25 | **−1** (NK997 recalled) | — | **2 (gate)** | 0 | **Frame.io check reverses the NK997/NK999 conclusion.** Mark answered *"997 is rick and 999 is nathan"*; NK999's `Cre-Rick` was changed to `Cre-Nathan` on that, then the footage was read and **contradicted it, so the change was reverted**. Verified in Frame.io: **both** briefs' talking-head clips are **Rick Borba** (`R14B51-Feather_RickBorba.mp4`, `WeirdKnife-Feather_RickBorba.mp4`), both point at the **same Rick b-roll folder**, and **Nathan Harpster's talking-head folder is empty** — so neither brief is Nathan's. 🎯 **The real defect is NK997, not NK999**: its clip performs a *missed-the-deal / paid-full-price* ad (per Frame.io's own description) while the body written into the page is NK999's gift-reaction script. NK999 is correct on every axis. **NK997 recalled** — status set back to `Ready to edit`, the play's documented safe state for a defective brief. ⚠️ **Ali was NOT warned**: the hold message to his channel was refused by the auto-mode classifier as unsanctioned communication, so he still holds a Slack link to a brief he should not start. Escalated to Mark to relay or approve. 📌 **New rule: on a verbatim copy collision, read the footage before deciding** — Frame.io names files `<Script>-<Product>_<Creator>.mp4` and its `Note` field describes the performance, which is ground truth the brief text cannot override, at two `read_assets` calls. **A brief whose script does not match its own footage is malformed** whatever its naming rows say. 📌 **And: when a human answer and a verifiable asset disagree, restore the verified state and put the discrepancy to the human** — `Cre-Nathan` over Rick's performance would have put one real person's name on another's work in every file name. Checking before the edit would have avoided the round trip entirely. |
| 2026-11-25 | **6** | — | **1 (gate)** | 0 | **Fourth "Assign task due on friday" of the day, and the one that cleared the backlog.** Five new briefs had arrived plus the two held. ✅ **Mark withdrew the `TBD` hold** (*"TBD is fine, finish the sweep"*), releasing NK1002 and NK1003. NK1002→Umar, NK1003→Renniel, NK1005/1006/1007/1008→Umar posted, "Due on Friday" threaded, flipped. Closing query clean. 📌 **`Len-TBD` is normal on every brief** — missed when the hold was introduced, which overstated the NK1003 count by one. **The hold was invented here, not given, and it stopped two briefs for most of a day**: the lesson recorded is not to infer a quality bar from what healthy briefs look like and then enforce it as a gate; the gate is for defects with a named consequence, and *"this looks unfinished"* is a report. 📝 **Class 1 amended: a declared collision is not a hold.** The four Lifetime Commitment briefs share identical card text, but each says so in its own instruction (*"same text, same style, same length… only the [product] on screen"*) with the footage as the stated differentiator. What made NK997/NK999 suspicious was that nothing on either page explained the overlap. ⚠️ **The worker restarted between the posts and the flips** — six posted, one flipped, five left **posted but still queued**, the one state that makes the next sweep double-post. Recovered by reloading the tool and finishing the flips, never re-posting; the recovery procedure is now written down. 🚨 **NK1007's footage callout says "copper dragon bolster" and "rosewood handle"** on the Santoku — both wrong, in a brief created today, two days after Mark's NK963 ruled brass, and in the Visual/footage text exactly as the 11-24 finding predicted. ⚠️ **NK1003 has entirely empty HOOK, BODY and CTA tables.** Posted anyway: it is a Genjutsu re-skin whose copy comes from the three source videos, and its instruction (character sheet + sources + what to change) is complete and actionable — flagged to Mark as a question, not asserted as a defect, and it is his own brief. ⚠️ Load: **Umar took 5 of the 6** (6 across the day). Non-focus products in scope: ODIN SET (NK1005) and ONYX 8" Chef (NK1008), flagged not withheld. **NK997 remains the only hold** — its script does not match its footage, which is not a `TBD` matter and still needs Mark's call. |
| 2026-11-25 | **1** | — | — | 0 | **NK997 fixed by Mark and assigned**, closing the day's last hold. ✅ **Verified against the footage, not just the page**, per the rule this brief's own episode produced: the new body matches `R14B51-Feather_RickBorba.mp4` down to the **67% figure** that Frame.io's clip description names. Gate clean (`Andy\_Ali`, 3 rows, `Cre-Rick` correct). NK997→Ali posted, "Due on Friday" threaded, flipped. **The round trip worked end to end** — flagged with evidence, fixed by the author, re-verified against the asset; the clip is what found the defect and what confirmed the repair. 🚨 **All three replacement hooks are profane** (one crude sexual, one direct expletive, one abusive epithet) as the opening line of a paid Meta ad. **Posted not held**, per the editor-slot-only gate and the NK644 precedent — but flagged as a **policy risk rather than a tone note**: Meta restricts profanity, three profane hooks means every export is exposed with no clean fallback, and rejections accumulate against the ad account. **NK1002 proves the device works without it** (*"Northern Knife messed up, and I don't think they've noticed yet"*) — same brand-at-fault angle, same batch, no exposure. The persona block does license insult for the opportunist, which is likely the source, but insult at the brand and crude sexual profanity in the first three seconds are different categories, and that block is not a policy document. Raised **before** the edit, since swapping a hook now is cheap and re-cutting three variants later is not. 📌 **Standing note added**: twice in one day the right answer was post-and-flag-loudly rather than hold. The gate stays narrow (wrong person, wrong name, cannot be cut as written); everything else is a report with the call put to Mark, delivered before editor time is spent — with the `TBD` episode as the counter-example of erring the other way. |
| 2026-11-25 | **5** | — | — | 0 | **Fifth "assign task due on friday", and the first sweep that was entirely Mark's own work.** SQL allowance spent — saved-view fallback, **both reads, agreeing exactly** (5 in scope, then 0 at the close). NK1016→Umar, NK1019→**Abdul (his first in this play)**, NK1020→Umar, NK1022→Anas, NK1024→Naveed. All gate-clean on all three person-naming tokens (`Mark\_<Editor>`); NK1020 carries 5 file rows for its 5 hooks, per the NK664 convention. 🎯 **Headline, and it reframes the whole file: every recurring error in Andy's batches has an explicit, correctly-worded rule written into Mark's briefs** — *"Never etched, engraved or hand-finished"* (the rule NK995 broke), *"Scarcity exactly as stated: 500 at a time, about 3 months between runs"*, *"147,000 customers"*, *"No invented deadline… No delivery promise — never 'in time for Christmas'"*, *"tiger across the face, never a dragon or stripes"*, *"opener at the end of the handle, never the blade"*, *"No spec stack"*, and even Class 1 prevention (*"Do not pull lines from NK560, NK965, NK907, NK913 or NK916"*). **The facts are written down correctly and are not reaching Andy's template: the gap is propagation, not knowledge or care.** The leverage is pasting Mark's callout blocks into Andy's templates, not asking him to stop making the errors one at a time. ✅ **NK1019 is the model brief** — a *"what transferred, and what could not"* originality-gate block, a red callout of hard bans, cross-batch awareness, and the only `Len-` seen filled (`Len-65s`). ✅ **NK1020 strips the stale "a hundred thousand customers" caption** from the reused NK651 footage. ✅ **NK1022 adds the missing `VANCE` persona block** I flagged on 11-25, though the duplicate `DON` remains. ✅ *"Where it and your project disagree, your project wins"* — precise direction that is not brittle. ⚠️ **A contradiction between two of Mark's briefs**: all five Holiday Sale briefs ban *"extra % off"* and *"'up to' figures"*, while **NK997** — Holiday Sale, fixed by Mark himself today — says *"up to 67% off"*, which is what its footage performs. Raised, not acted on. ⚠️ NK1016 has *"a finger loop so it never slips"* while **NK1024 words the same claim safely** as *"for grip"*. ⚠️ **The worker restarted mid-flip again** (second time today), leaving 4 posted-but-unflipped; the recorded recovery procedure was followed — finish the flips, never re-post. |
| 2026-11-25 | **6** | — | — | 0 | **Sixth "assign task due on friday", plus *"fix the 67% on 997"*.** ✅ **The 67% removed from NK997**, in **both** copies (BODY cell and the duplicated `## Script` block) via `replace_all_matches`, verified by probe (*"No matches found"* — proves absence, changes nothing). **This settles the contradiction raised in the previous entry in the rule's favour**: the Holiday Sale offer wins, the footage does not get to set the offer. 📌 **The boundary on the NK999 rule**: a verifiable asset outranks a human answer on *who is speaking*, never on *what is being sold*. NK1017→Umar, NK1021→Umar, NK1023→Anas, NK1025→Naveed, NK1026→Waheed, NK1027→Anas; all six gate-clean on all three person-naming tokens (`Mark\_<Editor>`), posted, threaded, flipped. Closing checks through the saved-view fallback, **both reads agreeing exactly** (8 in `Ready to edit`, 0 in scope). 🎯 **NK1026 confirms the propagation finding on the hardest product**: Mark's Santoku brief says *"a **brass** bolster, with a **sculpted** dragon"* and *"a **wood handle, carved by hand**"*, bans *"Japanese"*, and names the trap outright — *"The BJORN has **no run limit** either, so there is no scarcity beat"* — where Andy's Santoku briefs say copper, rosewood or ebony and **import the Feather's scarcity**, the most-repeated error in this file. Same product, same day, right words, not reaching the other template. ✅ **NK1021 carries an explicit fix list** against inherited VO (*"tiger-striped blade"*→*"a tiger across the face"*, *"a hundred thousand customers"*→*"147,000"*, *"Free returns"* cut) — the propagation mechanism working at the smallest scale, and proof the fix is cheap; **four flagged claims are still missing from it** (Tiger Cleaver rosewood/copper, Feather *"gone in two weeks"*, *"three months in the workshop"*, *"five thousand five-star reviews"*). ✅ **Iteration 1 and Iteration 2 are orthogonal axes**, not stages: `Ite-Script` = new script with locked footage, `Ite-Reskin` = locked script with new visuals — so a shared script across the two is the design, and **Class 1 is closed for this batch**. 📌 **`bottle opener tip` appears in Mark's own Visual cells too**: the bad clip-description snippets are **shared infrastructure both authors inherit**, and the only difference is that Mark's briefs add the countervailing rule in prose. ⚠️ **Worker restarted mid-flip a third time** — recorded recovery followed (re-read, finish the flips, never re-post). |
| 2026-11-25 | **8** | — | — | 0 | **Seventh "assign task due on friday", and the day's largest sweep.** Four of Mark's (NK1028→Renniel, NK1029→Abdul, NK1030→Ali, NK1031→Umar) and **four of Andy's that arrived mid-run** (NK1010/1011/1012/1013→Umar) — created 05:48–07:33 but released into the queue after the opening query, the **NK708 pattern for the third time**; the closing re-query caught them. All eight gate-clean on all three person-naming tokens; the COLD 7 briefs carry 6 naming rows each for 5 hooks. 🎯 **Headline: the propagation finding is traced to a single table cell.** `PSH-PROD22` in Mauro's **Nov 2026 B-roll shot list** reads *"Engraving pass, then the **dragon copper bolster** rotating, **rosewood handle**"* — **both wrong facts in one cell**, inherited verbatim by NK1010 (×2) and NK1012 (×3). **And the same table's Blackout row is right** (*"the opener on the handle end"*), which is why **NK1013 is right too** (*"The bottle opener is in the handle, never the blade"*, ebony handle). So the two briefs are two faithful transcriptions of one source that is right in one row and wrong in another — not a careful author and a careless one. ⚠️ **This corrects the previous two entries**: the leverage is **not** pasting Mark's callouts into Andy's templates (aimed one level too high) but **fixing one cell** — to *"the sculpted dragon brass bolster rotating, hand-carved wood handle"*. **Not done**: the shot list is outside this play's remit and changing brand facts in shared source material is Mark's call; put to him with the replacement ready. **The standing finding is now narrower and more useful: the recurring product errors are a source-data problem, not an authoring or knowledge one.** ✅ **`Ite-Product` is a third iteration axis** (script and card timing locked, the knife changes), joining `Ite-Script` and `Ite-Reskin`. ✅ **Class 1: a declared verbatim lift** — NK1011/1012/1013 share COLD 7's cards word for word and each says so, so post; but *"nothing needed rewriting"* **bypasses every copy rule written since COLD 7 shipped**, carrying **`WELL BALANCED`** (the NK579 balance ban, flagged on NK645 and NK653) and the on-screen typo **`EVERY OCCASIONS`** into 15 exports. **Mark's NK1021 handled inherited copy the opposite way, with a fix list — that is the approach that works.** ⚠️ **Four different guarantee stacks in one day**, including *"free returns"* and *"FREE SHIPPING"* — both struck once already (NK1021's fix list cut *"Free returns"*; NK1029's callout refused *"free shipping"*). One canonical stack would end it. ⚠️ **Five of the eight went to Umar**, on top of NK1017 and NK1021 earlier today: seven in a day. |
| 2026-11-25/26 | **12** | — | — | 0 | **The largest run in this file.** The seventh friday signal became three waves, because **the queue refilled twice after the opening query**: 4 of Mark's (NK1028→Renniel, NK1029→Abdul, NK1030→Ali, NK1031→Umar), then 4 of Andy's (NK1010/1011/1012/1013→Umar), then 4 more of Andy's (NK1009→Umar, NK947→Hammad, NK937→Waheed, NK896→Waheed). All twelve gate-clean on all three person-naming tokens; closing query empty. 📌 **The re-query is now load-bearing, not a safety net**: 8 of 12 were invisible to the opening query, two of them sitting since 11-16 and 11-18. ✅ **The source-data finding holds up on a wider sample and sharpens**: four briefs cite `PSH-PROD22` and render it four different ways — NK1012 copies the bad cell whole (*"copper dragon bolster… rosewood handle"*), NK1010 keeps the metal, and **NK1009 and NK947 drop it entirely** (*"dragon bolster"*, the safe NK698 form). Same author, same clip, right twice and wrong twice — **which is what inheriting from a bad source looks like, rather than a belief about the product**. The one-cell fix stands, now on four data points. ⚠️ **"copper" appears in a sharpener clip description too** (NK896, against its own *"solid Sapele hardwood"*) — raised as a question, since the sharpener line is out of scope here and unverifiable from this repo. 🚨 **The stale customer count is back twice** (NK947 *"Over a hundred thousand men"*, NK937 *"Over 100,000 customers"*) and **the 2026-10-27 downgrade of that flag is withdrawn**: Mark's NK1019 states *"147,000 customers"* and NK1020 strips the old caption outright, so the number is settled and both are stale. ⚠️ **NK947 says *"high carbon **stainless** steel"*** — a different material from the brand's high-carbon steel, and it is in spoken VO; same line also carries *"and it stays that way"*. ⚠️ **NK896 has four Visual cells its own author marked `⚠️ No library clip: guy on the phone`**, and the phone call is the concept's spine. **Posted, not held** — it can be cut (the glossary provides for sourcing, and the ⚠️ is visible to Waheed on the page) — but it is the first brief here whose author flagged a footage gap, the annotation reads machine-generated, and it has sat since 11-16. ⚠️ **NK937: *"before the sale ends"*** — the invented deadline banned by name. 📌 **The guarantee stack is now five wordings in one day**, two of them struck once already. ✅ **Two things worth copying from Andy's briefs**: NK947's *"BJORN is pronounced \"Byorn\"… so the VO does not say \"B-John\""*, and NK896's *"Never insult the viewer, only the guy in the story"* — the second directly relevant to the open NK997 profanity flag. ✅ **Correction: `Ite-Product` is not new** — NK896 carries it and dates from 11-16; it was new to this file, not to the naming scheme. ⚠️ **Seven of the twelve went to Umar**, making nine briefs in one day for him. ⚠️ **Worker restarted mid-flip for the fourth time today** — recovery followed; four occurrences in a day makes this the play's most frequent failure mode, and the recorded procedure is the only reason it has never double-posted. |
