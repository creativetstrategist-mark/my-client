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
  run. The whole reason the go-live baseline exists — stopping a scheduled first
  run from blasting a six-day backlog at seven editors — is moot under this
  model. Keep the baseline table as the record of what was already waiting, but
  the thing it was defending against cannot now happen by surprise.
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
**<https://app.notion.com/3f84ac627aac819683b3d3321994ea35|NK612_4 Ways To Get It Wrong - Santoku_AI VO_SANTOKU>**
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

- Use the `url` the detection query returned for that row, exactly as returned.
  Never reconstruct a Notion URL from a page ID, and never reuse the URL from a
  neighbouring row — the three products of one concept are three separate pages
  with near-identical titles, so a copy-paste slip sends an editor to the wrong
  brief's script.
- The short form (`https://app.notion.com/<id>`) and the long "Copy link" form
  Mark's hand-posted links carry (`…/p/northernknife/<slug>-<id>?v=…&source=copy_link`)
  resolve to the same page. The short form is fine; it is masked behind the link
  text either way.
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
<@U0BMUAWCEG5> **<https://app.notion.com/3f84ac627aac819683b3d3321994ea35|NK612_4 Ways To Get It Wrong - Santoku_AI VO_SANTOKU>**
```

That is a one-line change here and takes effect on the routine's next run.

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

In every "no flip" case the brief deliberately stays in `Ready to edit` and
resurfaces next sweep. That repetition is intended — it is a standing reminder of
an unresolved gap. Report these each run rather than suppressing them.

## Go-live baseline — the 15 pre-existing briefs

Mark's decision on 2026-10-13: **announce only new briefs from now on.** These 15
pages were already in `Ready to edit` at go-live and must **never** be announced.
Skip any page whose ID appears here.

| Creative ID | Concept Name | Product | Editor | Page ID | Note |
|---|---|---|---|---|---|
| NK612 | 4 Ways To Get It Wrong - Santoku | SANTOKU | Hasnain | `3f84ac627aac819683b3d3321994ea35` | |
| NK613 | 4 Ways To Get It Wrong - Blackout | LOKI Blackout | Hammad | `3f84ac627aac8143867df6b2ebddf550` | |
| NK610 | Not For Everyone - Blackout | LOKI Blackout | Onyeka | `3f84ac627aac81019a8ee65490c885cd` | |
| NK609 | Not For Everyone - Santoku | SANTOKU | Hammad | `3f84ac627aac81cb9fa8d2f20a54361e` | |
| NK607 | Didn't Buy It Myself - Blackout | LOKI Blackout | Naveed | `3f84ac627aac814687cef0e2b375115f` | |
| NK606 | Didn't Buy It Myself - Santoku | SANTOKU | Hasnain | `3f84ac627aac81cf8acfdfca6daff7eb` | |
| NK603 | Too Nice To Use - Santoku | SANTOKU | Anas | `3f84ac627aac81999628eb6c75815e6d` | |
| NK604 | Too Nice To Use - Blackout | LOKI Blackout | Hammad | `3f84ac627aac81c3bc04e80ef68f3721` | |
| NK599 | Worth The Money - Santoku | SANTOKU | Umar | `3f34ac627aac814c8515e16be8ea2927` | |
| NK601 | Worth The Money - Blackout | LOKI Blackout | Hammad | `3f34ac627aac81db86cde95e400d0828` | |
| NK589 | 3 Checks - Blackout | LOKI Blackout | _(none)_ | `3f24ac627aac81388c02ec17be794ae5` | Callum — excluded by rule anyway |
| NK587 | 3 Checks - Feather | Feather | _(none)_ | `3f24ac627aac8169b4bde41354fa97d4` | Callum — excluded by rule anyway |
| NK588 | 3 Checks - Santoku | SANTOKU | _(none)_ | `3f24ac627aac817cb6efe135a9dc7e64` | Callum — excluded by rule anyway |
| NK584 | Stop Sawing - Blackout | LOKI Blackout | Onyeka | `3f24ac627aac813ba030fb35ba42fc15` | ✅ **done 2026-10-13** — posted to `#11-onyeka-editing` and flipped to `Assigned to Editor` during the first live test. No longer in `Ready to edit`, so it cannot resurface. |
| _(none)_ | _(raw frame.io URL — malformed)_ | — | _(none)_ | `3e94ac627aac80d7be8df2fc97539316` | malformed row |

**10 of the 11 non-Callum assigned briefs above still need telling their editors
by hand** — the baseline suppresses the automation, it does not do the work.
NK584 was cleared during the first live test; the rest are still waiting, the
oldest from 2026-10-07. To hand any of them to the
routine instead, delete its row from this table and set its `Status` back to
`Ready to edit`.

## Decisions on record (Mark, 2026-10-13)

| Question | Decision |
|---|---|
| How to reach Slack | **Slack connector.** Not an incoming webhook — connector traffic is not subject to the environment's egress policy, resolves real user mentions, and stores no secret in the environment. |
| Where assignments land | **One shared channel per editor** (`#11-<editor>-editing`) — not a single team channel, not DMs. |
| Dedup | **Flip `Status` to `Assigned to Editor`** after posting. No repo ledger. |
| Pre-existing backlog | **Suppress** — announce only new briefs. See the baseline table. Largely moot under the on-demand model, since Mark controls every run. |
| Callum's work | **Never touch it.** See the hard rule at the top. |
| Scheduling | **None.** No cron, no trigger. Mark gives a go signal and the sweep runs then. The trigger built on 2026-10-13 was deleted. |

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
baseline of pages that must never be announced. Follow it exactly — it is kept
more current than this prompt, so where they disagree, the file wins. Do not
proceed from this summary alone; the mapping table and baseline list are only in
the file.

## The job

1. Query data source collection://2cf4ac62-7aac-81a8-86bf-000b96778943 for
   Status = 'Ready to edit' (exact string — lowercase "edit"), excluding
   Strategist = 'Callum' in the query itself, oldest first.
2. Drop any page whose ID appears in the spec's go-live baseline table, and any
   page with no Creative ID.
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
- Never announce a page listed in the baseline table.

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
| 2026-10-13 | 1 (NK584) | — | — | — | **First live end-to-end test**, run by hand from a session with both connectors. Detect → format → post to `#11-onyeka-editing` → flip to `Assigned to Editor`, all verified. Two findings: bold needs `**` not `*` (the first attempt rendered italic), and direct Slack sends are blocked by the Claude Code auto-mode classifier, so the message went out as a draft Mark sent. The italic first attempt is a duplicate in that channel and can be deleted. |
