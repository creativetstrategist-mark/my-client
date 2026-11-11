# Winner iterations: Iteration 1 (Rewrite) and Iteration 2 (Reskin)

Authoritative spec for turning one of our own winning ads into new briefs in the
Notion **Evergreen Video** database. Read it before running or changing this
play.

**This runs on Mark's command only. There is no schedule and no automatic winner
selection.** Mark names the creative IDs; the run pulls each one's brief from
Notion and its delivered cut from Frame.io, then writes the iterations he asked
for. Nothing is picked from `Test Results`, Triple Whale or anywhere else.

---

## 0. The two types

| | **Iteration 1: Rewrite** | **Iteration 2: Reskin** |
|---|---|---|
| **Locked** | The footage: every clip, in its slot, in order | The script: every hook and body word, and the VO audio itself |
| **New** | The script: every hook line and every body line | The visuals: every shot, and none of them similar to the source |
| **VO** | New ElevenLabs read, same voice settings as the source | **Reuse the source's VO track.** No new recording, except lines changed by the fix list (§4.3) |
| **Music** | Reuse the source's track | Reuse the source's track |
| **What the test isolates** | The words | The look |
| Naming `iteration` field | `Ite-Script` (new value, see §6) | `Ite-Reskin` |
| `Concept Name` | `<Short concept> Rewrite (<ID>) - <Product>` | `<Short concept> Reskin (<ID>) - <Product>` |
| Editor | The source cut's editor, by default | Anyone **except** the source cut's editor |

Both types stay on the source's **product** and **persona**. Changing either is a
different iteration (`Ite-Product`, `Ite-Persona`) and is not this play.

Examples: NK284's Rewrite is `Big Brain Return Rewrite (NK284) - Santoku`; its
Reskin is `Big Brain Return Reskin (NK284) - Santoku`. This matches the live
convention Andy uses for iterations: `What if 10 Hooks (NK184) - Feather`.

---

## 1. The command

| Mark says | Run does |
|---|---|
| `Iterate NK284` | Both types for NK284 (2 briefs) |
| `Iterate NK284, NK222` | Both types for each (4 briefs) |
| `Iteration 1 NK184` | Rewrite only |
| `Iteration 2 NK184` | Reskin only |
| `Iteration 2 NK184 H3` | Reskin, and treat hook row 3 as the winning hook (it gets the strongest new hook visual) |
| `… editor Umar` | That editor, overriding §5 (never Huzaifa) |
| `… again` / `round 2` | Allowed to repeat a type already in the ledger (§7) |

- **No creative ID in the command → stop and ask.** Never choose a winner.
- **A winner tag is not required.** Mark's command is the authority. A creative
  with no `Test Results` tag, or one with no Notion page at all (NKEOFY005 has
  none), is still in scope if he names it.
- **Any product is in scope here**, not only the 3 focus products, because naming
  the ID is the explicit request the root `CLAUDE.md` asks for. The product facts
  in §4.3 still apply to whatever the product is.

---

## 2. Pull the source

### 2.1 The brief, from Notion

1. Query Evergreen Video, `collection://2cf4ac62-7aac-81a8-86bf-000b96778943`:
   `WHERE "Creative ID" = ?` with the ID as the bound value.
2. **More than one page** (NK284 has a second page titled `… Santoku (1)`): use
   the earliest `createdTime` that has a filled HOOK and BODY table, and name the
   duplicate in the report.
3. **No page in Evergreen Video:** run `notion-search` for the ID across the
   workspace. Seasonal series live elsewhere; NKFD071's script is the page
   `R12B6 Adaptation`, not an Evergreen row.
4. **Still nothing:** stop for that ID and ask Mark for the brief or the script.
   **Never rebuild a script from memory or from the ad name.**

Read and keep: `Product`, `Avatar`, `Offer`, `Landing Page`, `Content`, `Editor`,
`Strategist`, `Test Results`, `Delivery Link`; the persona callout; the Creative
Brief Instruction; and the full HOOK and BODY tables, Visual, Copy and Note
columns.

**The source page is read-only.** Never write to it: no property, no comment, no
body edit. This applies to every strategist's page, Callum's included. Reading a
page Mark named is fine; touching it is not.

### 2.2 The cut, from Frame.io

Account `b0bc19f9-4a80-4ae4-9768-4b151edb5a40`, project
`b37ff928-5b11-4860-8204-f102af43f3ec`. In order:

1. **`Delivery Link`** on the source page, when it is filled in (NK284 and NK272
   have one; NK184, NK222 and NK133 do not).
2. **`search_assets`**, engine `lexical`, query = the ID, scoped to the project.
   **Keep only results whose name's first `_` segment equals the ID exactly, as a
   whole segment.** The search also returns other creatives that only mention
   it: `NK485_VID_Why NK184_…` and `NK405_VID_What if  CTA  Feather NK184_…` are
   NK485 and NK405, not NK184. Prefer a **folder named exactly the ID** (NK184
   has one); inside it, one version stack per hook. Take each stack's newest
   version.
3. **The clip links in the source brief's Visual column.** These are the footage
   library Iteration 1 is built from.

Record the folder URL and one view URL per hook.

**No cut found → stop both types for that ID and report it.** Iteration 1 needs
the footage, and Iteration 2 needs the VO track and needs to know what it must
not look like.

### 2.3 Which words are "the script"

The source brief's HOOK and BODY copy. Delivered cuts can drift from the brief
(editors trim lines). If this session can reach the media host and transcribe
the cut (the QA play's `creative-qa/setup-qa-tools.sh`, branch
`claude/bold-carson-13rfs2`, installs `faster-whisper`; exit `3` means the host is
blocked), compare and use the delivered wording where it differs, because
Iteration 2 reuses that exact audio. If it cannot, use the brief's copy and say
in the report that the script was not checked against the cut. Either way, this
does not block the run.

---

## 3. Iteration 1: Rewrite (same footage, new script)

1. **The footage is locked.** Copy every Visual cell from the source, hook rows
   included, verbatim: same rows, same order, same Frame.io links. The editor
   rebuilds from the **source project and raw clips, not the exported cut**,
   because source exports carry the old script burned in as captions (NK284's
   own hook note says "cover the existing text from visual").
2. **Footage swaps are allowed only for these,** each named in that row's Note
   as `Changed: <what> → <replacement>`:
   - a clip with old copy, an old offer or a price burned into the picture that
     cannot be covered;
   - a clip that breaks a standing visual rule: a price visible on a PDP, a
     second NorthernKnife knife before the offer beat, bread.

   Replace it with the nearest equivalent from the creative bank. Nothing else
   moves.
3. **Every line fits its clip.** What a row says must be true of what is on
   screen in that row. A phone-call clip carries a phone-call line, not a forge
   line. Write the line for the clip, never the clip for the line.
4. **Length budget.** Each row's new copy stays within **±20% of the source row's
   word count**, and the whole script within **±10%** of the source. The footage
   is fixed, so a longer script needs clips that do not exist.
5. **Every word is new.** Run the originality gate (process doc §F) against the
   source script, hooks included: **6 or more consecutive shared words fails.**
   This is the gate's commonest failure mode, reusing our own copy. House
   language is exempt: the proof stack, `Buy 2, get 2 free`,
   `4 knives for the price of 2`, `Link's below`, and full product names.
6. **Hooks:** the same number of rows as the source, each written over its own
   source hook clip. The second sentence turns against the first (§C.2).
7. **The angle may change** when the footage supports it. Record the new angle in
   the name (§6). Product and persona do not change.
8. **All copy rules apply in full,** because this is new copy: process doc §C,
   §E and §F, plus the 2026-11 updates in §4.3. The offer line sits on the
   source's offer clip, which places it where the winner had it; it must still
   land 60–80% through with 2–4 beats after it, said as `Buy 2, get 2 free`.

---

## 4. Iteration 2: Reskin (same script, new visuals)

### 4.1 The script is locked

- Every hook row and every body row is copied **word for word** from the source
  (§2.3), in the same order. Keep all of the source's hook rows.
- **Reuse the source's VO track and music bed.** The editor pulls the VO from the
  source project or the ElevenLabs history. If neither has it, regenerate with
  the same voice and settings, and say so in the report: a different read
  changes the test.
- The only words that may change are the fix list in §4.3. Register, offer
  phrasing, numerals versus words, line length and hook mechanics **stay exactly
  as the winner had them.** The script is the control; tidying it ruins the
  test.

### 4.2 The visual difference gate

The point of a Reskin is a cut that a viewer, and Meta, sees as a different ad.
Meta groups ads that look alike and lets them compete for the same delivery, so
a reskin that resembles its source tests nothing. Every row and the whole cut
must pass this gate.

**Per row.** Compare the new visual against the source row (its Visual cell, and
the delivered cut):

1. **No source clip, in any form.** No Frame.io link from the source's Visual
   column or from the source cut. A mirrored, re-graded, re-cropped or
   speed-changed source clip **is** the source clip.
2. **Different on at least 3 of these 4:**

   | Axis | Means |
   |---|---|
   | Setting | Where it is: kitchen, grill, forge, workbench, outdoors, studio, dark backdrop |
   | Subject | Who or what is on screen besides the knife: talent, hands, objects, food |
   | Framing | Shot type and camera: macro, wide, top-down, handheld POV, locked-off, split-screen |
   | Action | What happens: cutting, unboxing, unsheathing, handing over, a reaction, a reveal |

   The product being the same knife is not similarity. It has to be.

**Whole cut.**

3. **The format device changes.** Name the source's dominant look in one phrase
   (`UGC phone-call b-roll with reverse clips`, `cinematic slow-motion product`,
   `split-screen dialogue`, `green screen`) and choose a different one. Write both
   into the red callout: `Source look: … This cut: …`.
4. **Hook first frames.** Every hook row opens on a frame unlike every source
   hook frame, different in both setting and framing, and no two hook rows
   share a visual (§C.2). When Mark names the winning hook (`H3`), that row gets
   the strongest, most different opening.
5. **Change the treatment as well:** lighting and grade. A cut with all-new clips
   in the same grade still reads as the same ad.

**Standing visual rules still hold:** hero knife alone until the offer beat
(§C.5.1); no bread; no named cut of meat; no price on a PDP in frame; product
shown correctly (the Blackout opener is in the handle); an AI VO cut has nobody
speaking to camera (`Face-Talking` is never valid).

**Where the new footage comes from**, using the glossary's three labels:
`Broll Clip…` from the creative bank (the `0- UGC 2026` folder,
`https://next.frame.io/project/b37ff928-5b11-4860-8204-f102af43f3ec/f3bad957-341b-42a0-bb18-1c2423325fce`),
`Clip of…` from Envato or YouTube, `Generate on Higgsfield` (check the Frame.io
folder first). **Say which one on every row, and never contradict it in the
instruction block.** "Real b-roll only" above rows that say "Generate on
Higgsfield" is a recurring defect in the live database (NK679, NK778, NK779): the
editor cannot satisfy both. If any row generates, the instruction block must not
say real b-roll only.

### 4.3 The fix list: the only edits allowed to a locked line

Winning scripts predate some current rules, and the Reskin must not re-ship a
known factual error. **Change only these, and only the offending words.** Mark
each in that row's Note as
`Changed: "<old>" → "<new>". Re-record this line only, same voice.`

| Locked line contains | Becomes | Source of the rule |
|---|---|---|
| Feather pattern described by technique: "etched", "hand-etched", "engraved", "hand-finished" | Name the pattern, not how it got there ("the feather running tip to handle") | Product catalog; Andy's rule block |
| "Japanese" or "Japan", in any use | Cut the reference | Product catalog; Andy's rule block |
| Santoku bolster as anything but brass ("copper") | "brass" | Product catalog |
| Santoku handle named as a wood species ("rosewood", "ebony") | "hand-carved wooden handle", no species | Catalog; editor-assignment log 2026-11-10 |
| Blackout bottle opener "in the blade" or "spine" | "in the handle" | Product catalog §E. **NK284's lineup has this error.** |
| Tiger Cleaver called full tang, or given a dragon | Cut the claim | Product catalog; Andy's rule block |
| A price figure in any currency | "for what it costs" form | Process doc §C.3.2 |
| "Free returns" | Cut it from the proof stack | Andy's rule block, 2026-11-09 |
| "100,000 customers" | "147,000 customers" | Settled 2026-11-09 (editor-assignment log) |
| Profanity with no bleep instruction | Keep the word, add `Bleep it, censor it on screen` in the Note | Editor-assignment log, NK779 and NK810 |

**Flag, do not change:** an offer other than B2G2 in the locked copy, any claim you
cannot verify, and anything else that reads wrong. These go in the report for
Mark to decide.

The same list applies to Iteration 1, where it is simply part of writing new
copy.

---

## 5. Editor

Active roster as of 2026-11-11: **Umar, Hammad, Onyeka, Hasnain, Anas, Naveed,
Renniel, Waheed, Fahad.** Renniel is taking work again (Mark, 2026-10-26 and
2026-11-04); Waheed and Fahad joined 2026-11-09. **Never Huzaifa.** If Mark has
paused someone since, his word wins.

Runtime caps: **Hammad 90 seconds, Onyeka 72 seconds**, everyone else
unrestricted. Estimate at about 175 words a minute (longest hook plus the whole
body). Anything within a few seconds of a cap goes to an unrestricted editor.

1. **Mark names one** → that editor.
2. **Iteration 1 → the source cut's editor.** They hold the project and the raw
   clips, and they know which clip sits in which slot. If that editor is blank,
   Huzaifa, paused, or over their cap, pick from the roster.
3. **Iteration 2 → never the source cut's editor.** A fresh eye is half of "not
   similar". Also never the editor who has this run's Iteration 1 of the same
   source.
4. Otherwise pick from the eligible names, and read the last few ledger rows so
   the same name does not land every time.

Then `Status` = `Ready for visuals`. That status is the human gate: nothing
reaches an editor until Mark or Andy moves the page to `Ready to edit` and the
editor-assignment play posts it. **This play never messages an editor.**

---

## 6. Naming

Build every name with the `nk-ad-naming` skill: `SKILL.md` and `vocab-video.json`
under `.claude/skills/nk-ad-naming/` on branch `claude/vibrant-hopper-xg9l5l`.
Every field it lists, in its order, from its vocabulary. For an iteration:

| Field | Value |
|---|---|
| `category` | `Ite` |
| `source` | `Src-None` (iterations never carry the source ID in the name) |
| `iteration` | `Ite-Script` for a Rewrite, `Ite-Reskin` for a Reskin |
| `concept` | The Concept Name without the `(ID) - Product` tail, at most 30 characters: `Big Brain Return Rewrite` |
| `type`, `product`, `avatar`, `offer`, `lp` | The source's values, in vocabulary spelling |
| `market` | The market it won (`US Winner` → `Mkt-US`); more than one, or none → `Mkt-All`. Mark can override |
| `event` | `Evergreen` unless Mark names one |
| `hook`, `body` | `H1` to `Hn`, one per hook row; body `A` |
| `date` | Today, `MM.DD.YY` |
| `length` | `Len-TBD` |
| Judgement fields | **Rewrite:** judge them from the new script; they may change. **Reskin:** take them from the source's name (the script has not changed), except `face`, which follows the new visuals. A source older than NK557 has no judgement fields; judge those from its script. |

**`Ite-Script` is a new vocabulary value.** The convention had no value for "same
footage, new script": `Ite-Hook` keeps the body, `Ite-Body` keeps the hook, and
`Ite-Voice` keeps the words. It still has to be added to the `iteration` values
in `vocab-video.json` on `claude/vibrant-hopper-xg9l5l`, with the rule
`Script = same footage, new script`. Until then, a naming check against that
file reports `Ite-Script` as unknown. That report is expected.

---

## 7. Dedup

`winner-iterations/iteration-log.md` holds one row per brief this play creates.

Before writing a brief, check both:

1. **The ledger.** Is there already a row for this source ID with this type?
2. **Notion.** Query Concept Names containing `(<ID>)`, fetch each match, and
   read the `iteration` field from its Batch name. Is there already an
   `Ite-Script` or `Ite-Reskin` of this source, whoever made it?

If either answers yes and the command did not say `again` or `round 2`, **skip
that type for that ID and tell Mark what already exists**, with the link. Other
strategists' iterations of other types (`Ite-Hook`, `Ite-Voice`, `Ite-Editor`)
do not block anything.

---

## 8. The page

### 8.1 Properties

| Property | Value |
|---|---|
| `Concept Name` | Per §0 |
| `Creative ID` | The next free `NK###`. Take the highest numeric `NK` code, ignoring `NKFD`, `NKMD` and `NKEOFY`, and **re-query right before each page**, because others add rows during the day |
| `Format` | `VID` |
| `Product`, `Avatar`, `Landing Page`, `Content` | The source's values |
| `Offer` | The offer the new script states. Usually the source's value; a Rewrite uses `B2G2` |
| `Category` | `Iteration` |
| `Iteration` | ✔ checked |
| `Status` | `Ready for visuals` |
| `Strategist` | `Claude` |
| `Specialty` | `Generalist` |
| `Date` | Today |
| `Editor` | Per §5 |
| `Test Results`, `Claude WR`, `Delivery Link` | Empty |

Icon 📽️.

### 8.2 Body, in this order

This matches the live iteration pages Andy builds (NK808, NK840) and the block
order in process doc §D0.

1. **Batch name / Folder name** table.
2. `File naming`, then a one-column table with **one row per hook row**. Not
   fewer: NK702 and NK703 shipped four hooks with three file rows.
3. **🚨 Red callout**, the iteration banner:
   - Rewrite: `## ITERATION 1: NEW SCRIPT. THE FOOTAGE IS LOCKED.` Then: the
     source is a winner and its cut is reused clip for clip; work from the source
     project, not the export; every line is new, so re-record the full VO with
     the same voice; any swapped clip is marked `Changed:` in its row; deliver H1
     to Hn on body A.
   - Reskin: `## ITERATION 2: RESKIN. THE SCRIPT IS LOCKED.` Then: reuse the
     source VO track and music, re-recording only the `Changed:` lines; every
     visual is new; no clip from the source cut, flipped, re-graded or cropped
     included; `Source look: … This cut: …`; change the grade too.
4. `### AD INSPO`, then a **🎬 blue callout**:
   `## REFERENCE AD: <ID> <source concept> (<winner tags, or "named by Mark">)`.
   The Frame.io folder link, one link per hook stack, and a mention of the source
   Notion page. For a Rewrite: "Original lines are for reference only. Do not
   reuse them." For a Reskin: "Watch it to know what NOT to repeat."
5. **💡 Gray persona callout**: the one persona in play, 3–4 bullets.
6. `### GENERAL INSTRUCTION`: the 3–4 second rule and no dead air.
7. `### GLOSSARY:` TC, Super, Caption, plus the three footage-source labels.
8. `---`
9. `## Creative Brief Instruction`: short bullets only, with no reasoning on the
   page (§D.3.2). Then the 💡 VO callout with the Loom link. A Reskin's VO
   callout says to reuse the source track.
10. **`HOOK`** table, green header: `Visual` | `Copy/ Text Overlay` | `Note`. The
    hook code (`H1`, `H2`…) goes in `Note`, as on the live pages.
11. **`BODY`** table, orange header: `Block` | `Visual` | `Copy/ Text Overlay` |
    `Note`. **Nothing follows it.** No full-script section.

Note-column markers: the first body row carries
`Footage LOCKED from <ID>, clip for clip` (Rewrite) or
`Script LOCKED from <ID>, word for word. Reuse the VO` (Reskin). Every deviation
carries `Changed: …`.

---

## 9. The run

1. **Parse the command** into (ID, types, overrides). No ID → ask.
2. **Read:** this file; on `claude/vibrant-hopper-xg9l5l`,
   `brand-pack/05-process/creative-brief-process.md` (§C, §D, §E, §F),
   `brand-pack/01-brand/product-catalog.md`, the persona file for the source's
   avatar, and `.claude/skills/nk-ad-naming/`.
3. **Per ID:** pull the brief (§2.1) and the cut (§2.2). A failure stops that ID
   only. Report it and go to the next.
4. **Dedup** (§7).
5. **Write** each requested type (§3, §4).
6. **Gates.** All of them pass before a page is created:
   - Rewrite: originality (§3.5), length budget (§3.4), every line fits its clip
     (§3.3).
   - Reskin: no source clip (§4.2.1), the 3-of-4 axes on every row (§4.2.2), a
     changed format device (§4.2.3), new hook first frames (§4.2.4), and no word
     changed outside the fix list (§4.3).
   - Both: product accuracy and the fix list (§4.3), the standing visual rules,
     and the naming self-check from `SKILL.md`.
7. **Creative ID and editor** (§8.1, §5).
8. **Create the page** with `notion-create-pages`, parent
   `data_source_id: 2cf4ac62-7aac-81a8-86bf-000b96778943`. **Fetch it back** and
   confirm the properties landed and the HOOK and BODY tables have the right row
   counts. A create that did not land is not a brief.
9. **Ledger:** one row per brief in `winner-iterations/iteration-log.md`. Commit
   and push to `claude/epic-knuth-yzvigf`. If local `git commit` is blocked, write
   through `mcp__github__get_file_contents` (for the sha) and then
   `mcp__github__create_or_update_file`.
10. **Report** (§10).

### Never

- Pick a winner yourself, or run without an ID from Mark.
- Write to the source page.
- Change the product or the persona.
- Use a source clip in a Reskin, in any form.
- Change a locked word in a Reskin outside the fix list.
- Move `Status` past `Ready for visuals`, or message an editor on Slack.
- Invent a script, a Frame.io link, or a page link that a tool did not return.

---

## 10. Report

Per ID:

- **Source:** the Notion page and the Frame.io folder used, any duplicate page,
  and whether the script was checked against the cut (§2.3).
- **Briefs created:** Creative ID, Concept Name, type, editor, Notion link.
- **Fix-list changes**, quoted old → new, and every **flag** for Mark (an offer
  other than B2G2, an unverifiable claim, a VO track that could not be found).
- **Skipped**, and why: already iterated (with a link), no page, no cut.

If the Notion or Frame.io connector is unavailable, **say so explicitly**. Never
report an empty run as "nothing to do".

---

## Run history

| Date | Command | Briefs | Notes |
|---|---|---|---|
| — | — | — | No runs yet. Spec written 2026-11-11. |
