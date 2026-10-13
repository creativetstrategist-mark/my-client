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

## ⚠️ This is a poll, not a real-time trigger

Notion does **not** push status changes to Claude — there is no Notion→Claude
webhook in this setup. So "when the status flips" is really "the next time the
routine looks." The routine runs on a cron schedule and sweeps for anything
sitting in `Ready to edit`.

The practical floor on Routine frequency is **hourly**, so an editor can wait up
to an hour before being told. If assignments ever need to be instant, Notion's
own database automation (Evergreen Video → Automations → "When Status is set to
Ready to edit → send Slack notification") fires on the edit itself — but it
cannot do the per-editor channel routing, the Callum exclusion, the roster
validation, or the status flip that this routine does.

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
*<PAGE_URL|NK###_Concept Name_Content_Product>*
```

A real example, built from live row NK612:

```
*<https://app.notion.com/3f84ac627aac819683b3d3321994ea35|NK612_4 Ways To Get It Wrong - Santoku_AI VO_SANTOKU>*
```

…which renders in Slack as one bold clickable line:
**NK612_4 Ways To Get It Wrong - Santoku_AI VO_SANTOKU**

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
<@U0BMUAWCEG5> *<https://app.notion.com/3f84ac627aac819683b3d3321994ea35|NK612_4 Ways To Get It Wrong - Santoku_AI VO_SANTOKU>*
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
- Never append a "sent using" footer or any other automation signature.

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
| NK584 | Stop Sawing - Blackout | LOKI Blackout | Onyeka | `3f24ac627aac813ba030fb35ba42fc15` | |
| _(none)_ | _(raw frame.io URL — malformed)_ | — | _(none)_ | `3e94ac627aac80d7be8df2fc97539316` | malformed row |

**The 11 non-Callum assigned briefs above still need telling their editors by
hand** — the baseline suppresses the automation, it does not do the work. The
oldest (NK584) has been waiting since 2026-10-07. To hand any of them to the
routine instead, delete its row from this table and set its `Status` back to
`Ready to edit`.

## Decisions on record (Mark, 2026-10-13)

| Question | Decision |
|---|---|
| How to reach Slack | **Slack connector.** Not an incoming webhook — connector traffic is not subject to the environment's egress policy, resolves real user mentions, and stores no secret in the environment. |
| Where assignments land | **One shared channel per editor** (`#11-<editor>-editing`) — not a single team channel, not DMs. |
| Dedup | **Flip `Status` to `Assigned to Editor`** after posting. No repo ledger. |
| Pre-existing backlog | **Suppress** — announce only new briefs. See the baseline table. |
| Callum's work | **Never touch it.** See the hard rule at the top. |

## Environment note for whoever maintains this

Raw `curl` to Slack does **not** work from the cloud environment —
`slack.com:443` returns 403 at the egress gateway (verified 2026-10-13). That is
why the connector path was chosen. A webhook-based rewrite would additionally
need `hooks.slack.com` added under the environment's Allowed domains.

### ⚠️ The Routine must be created from the claude.ai Routines UI

**Verified the hard way on 2026-10-13.** A Routine created with the
`create_trigger` MCP tool on this organization **cannot carry connectors**:

- Passing `connectors: ["Notion", "Slack"]` is rejected outright —
  *"the connectors parameter is not available for this organization."*
- Creating it without that parameter succeeds but returns a warning that the
  trigger stores no MCP connectors.
- Firing such a trigger manually confirmed it: the fired session's init
  reported `mcp_servers: []`, and the run itself reported that
  `mcp__Notion__*`, `mcp__Slack__*` **and** `mcp__github__*` were all
  unavailable. It posted nothing and changed no statuses.

So this Routine has to be created (or have its connectors attached) in the
**claude.ai Routines UI**, with **Notion, Slack and GitHub** all enabled for the
scheduled run — GitHub included, because the routine reads this spec file from
the repo. `trig_01X5NCbaMaYWJpq8yb8XoxAD` exists and is **disabled**; either
attach the three connectors to it there and re-enable, or delete it and recreate
it from the UI using the prompt below.

Do not re-enable it until the connectors are attached — without them every
hourly run is a session that can only report its own failure.

Because the Routine prompt points at this file rather than inlining the rules,
**changing the message format or the mapping table here changes the routine's
behaviour on its next run** — no trigger edit needed.

## The Routine prompt (paste into the claude.ai Routines UI)

Schedule: hourly. Attach **Notion + Slack + GitHub**. Fresh session per run.
Narrow the hours to the editors' working window if hourly round-the-clock is
more than needed — the editors span Pakistan, Nigeria and the Philippines, so
"working hours" is most of the day.

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
   brief. Match Mark's existing format exactly — a single bold masked link,
   label "NK###_Concept Name_Content_Product" built verbatim from that page's
   own properties, targeting the url the query returned for that row. No
   @-mention unless the spec says to add one, no greeting, no extra fields, no
   automation footer.
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
| 2026-10-13 | — | — | — | — | Spec written, mapping verified live, baseline of 15 recorded. Trigger `trig_01X5NCbaMaYWJpq8yb8XoxAD` created but **disabled**: a manual test fire proved MCP-created triggers get no connectors on this org. Blocked on recreating it in the claude.ai Routines UI. |
