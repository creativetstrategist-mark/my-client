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
as Strategist.**

Any page with `Strategist = Callum` is out of scope for this routine
completely:
- do **not** post it to an editor,
- do **not** post it to the fallback channel,
- do **not** change its `Status`,
- do **not** flag it for triage.

Filter on `Strategist` in the detection query itself so a Callum page is never
even a candidate. Count them in the run summary if useful, but take no action.
This rule outranks every other rule in this doc, including the blank-editor
handling below. Note that Callum is a member of every editor channel and does
these handoffs himself — his briefs are his to route.

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

Checked so far: **NK601** (`Andy_Hammad`, property `Hammad`) ✅ and **NK612**
(`Mark_Hasnain`, property `Hasnain`) ✅ — both match.

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
| `Huzaifa` | — none — | — | — | **off roster, never assign** |
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
  urgency language would be fabricated.
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
| **`Strategist = Callum`** | Out of scope entirely. No post, no flip, no triage. See the hard rule at the top — it wins over everything else in this table. |
| **`Editor` is blank** (and strategist is not Callum) | Do **not** guess, and do **not** apply the daily routine's editor-assignment rules — those govern brief *creation*, and silently picking someone here would hide a real gap. Post to the fallback channel for Mark saying it needs an owner, and **leave `Status` as `Ready to edit`** so it stays queued until a human assigns it. |
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
rule** rather than by this table — the 3 Callum briefs by the hard rule at the
top, the malformed row by the no-`Creative ID` rule. So a suppression list is no
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
| NK589 | 3 Checks - Blackout | LOKI Blackout | _(none)_ | `3f24ac627aac81388c02ec17be794ae5` | Callum — excluded by rule anyway |
| NK587 | 3 Checks - Feather | Feather | _(none)_ | `3f24ac627aac8169b4bde41354fa97d4` | Callum — excluded by rule anyway |
| NK588 | 3 Checks - Santoku | SANTOKU | _(none)_ | `3f24ac627aac817cb6efe135a9dc7e64` | Callum — excluded by rule anyway |
| NK584 | Stop Sawing - Blackout | LOKI Blackout | Onyeka | `3f24ac627aac813ba030fb35ba42fc15` | ✅ **done 2026-10-13** — posted to `#11-onyeka-editing` and flipped to `Assigned to Editor` during the first live test. No longer in `Ready to edit`, so it cannot resurface. |
| _(none)_ | _(raw frame.io URL — malformed)_ | — | _(none)_ | `3e94ac627aac80d7be8df2fc97539316` | malformed row |

**All 11 non-Callum briefs above are done** — NK584 during the first live test,
then the remaining 10 on Mark's "go, clear the 10". Each was posted to its
editor's channel and flipped to `Assigned to Editor`, verified by re-query:
`Ready to edit` went from 15 rows to 4 (the 3 Callum briefs plus the malformed
row). To hand any of them to the
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

- Never touch work with Strategist = Callum — standing instruction from Mark
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


## Run history

| Date | Posted | Fallback | Skipped (Callum) | Skipped (other) | Notes |
|---|---|---|---|---|---|
| 2026-10-13 | — | — | — | — | Spec written, mapping verified live, baseline of 15 recorded. A scheduled trigger was built and test-fired, which proved MCP-created triggers get no connectors on this org; it was then **deleted** when Mark said he has no scheduled Routines and will give a go signal instead. See the scheduling appendix. |
| 2026-10-13 | 10 (corrections) | — | — | — | **Reposted all 10 links** as thread replies with channel broadcast, after the originals went out malformed (missing `/p/`). Mark had enabled public access on the `Evergreen Video` database. Statuses already `Assigned to Editor`, so none were re-flipped. |
| 2026-10-13 | **10** | — | 3 (NK587/588/589) | 1 (malformed row) | **Backlog cleared on Mark's "go, clear the 10".** NK601→Umar… full list: NK601/604/609/613→Hammad, NK599→Umar, NK603→Anas, NK606/612→Hasnain, NK607→Naveed, NK610→Onyeka. Direct `slack_send_message` was permitted this time (the earlier refusal did not recur), so no drafts were needed. All 10 posted, then all 10 flipped to `Assigned to Editor`; re-query confirmed `Ready to edit` dropped 15→4. Baseline discharged. |
| 2026-10-13 | 1 (NK584) | — | — | — | **First live end-to-end test**, run by hand from a session with both connectors. Detect → format → post to `#11-onyeka-editing` → flip to `Assigned to Editor`, all verified. Two findings: bold needs `**` not `*` (the first attempt rendered italic), and direct Slack sends are blocked by the Claude Code auto-mode classifier, so the message went out as a draft Mark sent. The italic first attempt is a duplicate in that channel and can be deleted. |
