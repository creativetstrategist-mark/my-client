# Winner iterations: Iteration 1 and Iteration 2

Authoritative spec for turning one of our own winning ads into new briefs in the
Notion **Evergreen Video** database. Read it before running or changing this
play.

**This is on demand, not an automation.** There is no Routine, no schedule and
no automatic winner selection. Mark names the creative IDs in a session; the run
pulls each one's brief from Notion and its delivered cut from Frame.io, then
writes **both iteration types for every ID**. Nothing is picked from
`Test Results`, Triple Whale or anywhere else.

---

## 0. The two types

| | **Iteration 1** | **Iteration 2** |
|---|---|---|
| **Locked** | The footage: every clip, in its slot, in order | The script: every hook and body word, and the VO audio itself |
| **New** | The script: every hook line and every body line | The visuals: every shot, and none of them similar to the source |
| **VO** | New ElevenLabs read, same voice settings as the source | **Reuse the source's VO track.** No new recording, except lines changed by the fix list (§4.3) |
| **Music** | Reuse the source's track | Reuse the source's track |
| **What the test isolates** | The words | The look |
| Naming `iteration` field | `Ite-Script` (new value, see §6) | `Ite-Reskin` |
| `Concept Name` | `<Short concept> Iteration 1 (<ID>) - <Product>` | `<Short concept> Iteration 2 (<ID>) - <Product>` |
| Editor | **The source cut's editor** (§5) | **The source cut's editor** (§5) |

**Every winner Mark names gets both types, every time: one Iteration 1 and
one Iteration 2.** The pair is the unit; never write one without the other.

Both types stay on the source's **product** and **persona**. Changing either is a
different iteration (`Ite-Product`, `Ite-Persona`) and is not this play.

Examples: NK284's pair is `Big Brain Return Iteration 1 (NK284) - Santoku` and
`Big Brain Return Iteration 2 (NK284) - Santoku`. This matches the live
convention Andy uses for iterations: `What if 10 Hooks (NK184) - Feather`.

**Names and pages always say `Iteration 1` and `Iteration 2`**, never "Rewrite"
or "Reskin" (Mark, 2026-11-11). **The strategist on every iteration is `Mark`**,
in the `Strategist` property and in the name's strategist field (Mark,
2026-11-11). This overrides the process doc's `Claude` for briefs this play
writes.

---

## 1. The command

| Mark says | Run does |
|---|---|
| `Iterate NK284` | Iteration 1 + Iteration 2 for NK284 (2 briefs) |
| `Iterate NK284, NK222` | Iteration 1 + Iteration 2 for each (4 briefs) |
| `Iterate NK184 H3` | Both, and treat hook row 3 as the winning hook: Iteration 2 gives it the strongest new opening |
| `Iterate NK222 Black Friday` | Both, written for that event (§8.3) |
| `… again` / `round 2` | Allowed to repeat a winner already in the ledger (§7) |

- **No creative ID in the command → stop and ask.** Never choose a winner.
- **A winner tag is not required.** Mark's command is the authority. A creative
  with no `Test Results` tag, or one whose page is outside Evergreen Video (NKEOFY005's is in the Holiday
  Brief Database), is still in scope if he names it.
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
   `R12B6 Adaptation`, not an Evergreen row. NKEOFY005 is `Worth it ? (NKFD046)` in the Holiday Brief
   Database's `EOFY` data source; search by the ID, which is in its batch name.
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
   version. **The stacks' own names are the key, not the folder's name:**
   NK222's stacks sit in Hammad's folder `NK 222` (with a space), while a
   separate folder named `NK222` is not readable from this account. Use the
   folder that holds the matching stacks.
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

**Always look at the scrub sheet.** `get_version_stack` returns a
`scrub_sheet_url` for the head version: 100 frames on a 10×10 WebP from the media
host. Download it, crop it into halves and look. It does two jobs no other source
does:

- **A partial script check.** Source cuts carry burned-in captions, so the frames
  can be read against the brief line by line, even when audio transcription is
  blocked (on 2026-11-11 the model hosts were).
- **The source's real look**, which the Iteration 2 gate (§4.2) and Iteration 1's
  "line fits the clip" rule (§3.3) both depend on. NK222's Visual column says
  "Montage clip of loki"; its scrub sheet shows a bearded creator in a kitchen,
  a blue sky and an onion. It also showed the Blackout clip already had the
  opener in the handle, so only the words were wrong.

---

## 3. Iteration 1 (same footage, new script)

1. **The footage is locked.** Copy every Visual cell from the source, hook rows
   included, verbatim: same rows, same order, same Frame.io links. The editor
   rebuilds from the **source project and raw clips, not the exported cut**,
   because source exports carry the old script burned in as captions (NK284's
   own hook note says "cover the existing text from visual").
   **If the source brief's Visual column is empty** (NK326's is), write each
   row as its span in the winning export plus a one-line list of the clips in
   it, read off the scrub sheet (100 frames, so one frame is the duration / 100),
   and send the editor to their own project for the clips themselves.
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
   source's offer clip, which places it where the winner had it, said as
   `BUY 2 GET 2 FREE`. **If that is outside the 60–80% window, leave it there**
   (the footage is locked, and the placement is part of what won) and say so in
   the report. NK222 resolves its offer at about 53%; NK306 does at 58%.

---

## 4. Iteration 2 (same script, new visuals)

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

The point of Iteration 2 is a cut that a viewer, and Meta, sees as a different ad.
Meta groups ads that look alike and lets them compete for the same delivery, so
an Iteration 2 that resembles its source tests nothing. Every row and the whole cut
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

**A ready-made different look:** the creative bank's `KF - <product> - Slow 50`
folders (Feather, Viking Knife, Blackout Edition, Reaper, Berserker, BJORN
Utility) are locked-off 4K slow-motion product films in forest and dusk light,
with no hands and no faces. Most winners are handheld daylight UGC, so these
pass the gate easily. Still check them against the source's settings: one KF
Feather set plants the knife in a tree stump, and NK222 already has a stump.

**Same script, another cut.** Some winners share a script with another winner:
NK326 is Naveed's editor-trial cut of NK184's script, word for word. Their
Iteration 2s then carry the same locked words, so the new look must also differ
from the other winner's Iteration 2, not only from the source. NK848 (NK184) is
night on a black tabletop, so NK861 (NK326) is a bright white studio. Name the
other Iteration 2 in the instruction block so the editor avoids it too.

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

Winning scripts predate some current rules, and Iteration 2 must not re-ship a
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
| Tiger Cleaver described as "tiger-striped" or "stripes" | The blade carries a tiger image: "a tiger across the face" | NK827 accuracy guard ("No dragon, no stripes") |
| A price figure in any currency | "for what it costs" form | Process doc §C.3.2 |
| "Free returns" | Cut it from the proof stack | Andy's rule block, 2026-11-09 |
| "100,000 customers" | "147,000 customers" | Settled 2026-11-09 (editor-assignment log) |
| Profanity with no bleep instruction | Keep the word, add `Bleep it, censor it on screen` in the Note | Editor-assignment log, NK779 and NK810 |

**Flag, do not change:** an offer other than B2G2 in the locked copy (in an
event version the deal line is re-recorded anyway, so §8.3 applies), any claim you
cannot verify, and anything else that reads wrong. These go in the report for
Mark to decide.

The same list applies to Iteration 1, where it is simply part of writing new
copy.

---

## 5. Editor: the source's editor, for both

**Both iterations go to the editor who cut the source** (Mark, 2026-11-11). They
hold the project, the raw clips and the VO stems, and they know the cut. This
deliberately overrides the "one concept, one editor" spread in process doc
§D.1.1, which is for net-new trios, not iterations.

Where the editor comes from, in order:

1. The source page's `Editor` property (NK184 → Hammad, NK284 → Hasnain).
2. If that is blank, the editor segment of the delivered file names on Frame.io:
   the field right after the strategist
   (`…_B2G2_Iteration_Andy_Hammad_PDP_072026` → Hammad).
3. **No clear single name, the name is `Huzaifa`, or the editor is not on the
   active roster → stop for that ID and ask Mark.** Never substitute someone.

Active roster as of 2026-11-11: Umar, Hammad, Onyeka, Hasnain, Anas, Naveed,
Renniel, Waheed, Fahad. Never Huzaifa. Runtime caps (Hammad 90 seconds, Onyeka
72 seconds) do not come into it: both cuts track the source's length, which that
editor already cut.

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
| `strategist` | `Mark`, always |
| `source` | `Src-None` (iterations never carry the source ID in the name) |
| `iteration` | `Ite-Script` for Iteration 1, `Ite-Reskin` for Iteration 2. These are vocabulary values and stay as they are; the concept is where `Iteration 1` and `Iteration 2` appear |
| `concept` | A short form of the Concept Name ending in `Iteration 1` or `Iteration 2`, at most 30 characters, **and short enough that every file name plus `.mp4` is at most 255 characters** (Frame.io's cap, which the QA play hit on NK604 and NK580). Andy shortens the same way (`Better Call` for "Better Call Black Friday (NKFD071)"). NK843 is `Lunatic Iteration 1`. |
| `type`, `product`, `avatar`, `offer`, `lp` | The source's values, in vocabulary spelling |
| `market` | The market it won (`US Winner` → `Mkt-US`); more than one, or none → `Mkt-All`. Mark can override |
| `event` | `Evergreen` unless Mark names one; then its vocabulary value (`Black Friday`) and §8.3 |
| `hook`, `body` | `H1` to `Hn`, one per hook row; body `A` |
| `date` | Today, `MM.DD.YY` |
| `length` | `Len-TBD` |
| Judgement fields | **Iteration 1:** judge them from the new script; they may change. **Iteration 2:** take them from the source's name (the script has not changed), except `face`, which follows the new visuals. A source older than NK557 has no judgement fields; judge those from its script. |

**`Ite-Script` is a new vocabulary value.** The convention had no value for "same
footage, new script": `Ite-Hook` keeps the body, `Ite-Body` keeps the hook, and
`Ite-Voice` keeps the words. It still has to be added to the `iteration` values
in `vocab-video.json` on `claude/vibrant-hopper-xg9l5l`, with the rule
`Script = same footage, new script`. Until then, a naming check against that
file reports `Ite-Script` as unknown. That report is expected.

---

## 7. Dedup

`winner-iterations/iteration-log.md` holds one row per brief this play creates.

Before writing, check both:

1. **The ledger.** Has this play already iterated this source ID? If so, and the
   command did not say `again` or `round 2`, **skip the ID and tell Mark**, with
   links to the existing pair.
2. **Notion.** Query Concept Names containing `(<ID>)` and note any iterations
   other people have made of it. These **do not block** the run, because Mark
   chose the winner knowing his pipeline. List them in the report so he sees
   them.

---

## 8. The page

### 8.1 Properties

| Property | Value |
|---|---|
| `Concept Name` | Per §0 |
| `Creative ID` | The next free `NK###`. Take the highest numeric `NK` code, ignoring `NKFD`, `NKMD` and `NKEOFY`, and **re-query right before each page**, because others add rows during the day |
| `Format` | `VID` |
| `Product`, `Avatar`, `Landing Page`, `Content` | The source's values |
| `Offer` | The offer the new script states. Usually the source's value; Iteration 1 uses `B2G2` |
| `Category` | `Iteration` |
| `Iteration` | ✔ checked |
| `Status` | `Ready for visuals` |
| `Strategist` | **`Mark`, always** (Mark, 2026-11-11) |
| `Specialty` | `Generalist` |
| `Date` | Today |
| `Editor` | Per §5 |
| `Test Results`, `Claude WR`, `Delivery Link` | Empty |

Icon 📽️.

### 8.2 Body: follow the live brief template

**Mark, 2026-11-11: every iteration follows the database's default page template**
(`2d64ac62-7aac-808e-8149-d1026291f47c`) block for block. Fetch it before each run,
because it is edited in place. As of 2026-11-11 the order is:

1. **Batch name / Folder name**: a plain two-column table (no header row, column
   widths 121 and 588), then an empty line.
2. `File naming`, then a plain one-column table (width 708) with **one row per
   hook row**, then an empty line. Not fewer rows than hooks: NK702 and NK703
   shipped four hooks with three file rows.
3. `### AD INSPO`, then a **video block** whose source is the winning cut's H1
   view URL on Frame.io, captioned `<ID> <source concept> (<winner tags>), H1 cut`.
   No callout here.
4. **💡 Gray persona callout**: `## IMPORTANT NOTICE ON PERSONA/AVATAR:`, then the
   template's own block for the persona in play, word for word (for MIKE:
   `### MIKE - GRILL MASTER` in blue and its bullet). Drop the template's other
   personas.
5. `### GENERAL INSTRUCTION`: the template's two bullets.
6. `### GLOSSARY:` exactly as the template words it, including the "Code of
   visual" lines and the Higgsfield folder link.
7. `---`, then `## Creative Brief Instruction`: plain bullets, no callouts. The
   first bullet is the iteration line in bold
   (`ITERATION 1: NEW SCRIPT. THE FOOTAGE IS LOCKED.` or
   `ITERATION 2: SAME SCRIPT. NEW VISUALS.`). Then the winning-cut links (one per
   hook, the folder, a mention of the source page), what is locked and what is
   new, the voice and music, the on-screen text rules, the event rules (§8.3),
   the "Do not" list and the deliverables. Bans as flat lines, no reasoning
   (process doc §D.3.2).
8. The template's 💡 VO callout with the Loom link.
9. **`HOOK`**: three columns, `Visual` | `Copy/ Text Overlay` | `Note`, green
   header. The hook code (`H1`, `H2`…) goes in `Note`.
10. **`BODY`**: **three columns**, `Visual` | `Copy/ Text Overlay` | `Note`, orange
    header. **No `Block` column.** Every beat except the close.
11. **`CTA`**: the same three columns, holding the closing row (CTA → proof stack
    → jab → `Link's below`). Then an empty line. Nothing else follows.

The red 🚨 banner and the 🎬 reference callout that Andy's own iteration pages
use are **not** in the template, so this play does not add them. Their content
lives in the Creative Brief Instruction bullets.

**Supers** go in the `Copy/ Text Overlay` cell, written
`SUPER: <text><br /><br />VO: <line>`, as Andy does on NK840. The gate checks the
VO part only.

Note-column markers: the first body row carries
`Footage LOCKED from <ID>, clip for clip` (Iteration 1) or
`Script LOCKED from <ID>, word for word. Reuse the VO` (Iteration 2). Every
deviation carries `Changed: …` with the reason in brackets.

### 8.3 Event versions (Black Friday and the rest)

When Mark's command names an event (`Iterate NK222 Black Friday`), both briefs
are written for it:

- **Naming:** the `event` field takes the vocabulary value (`Black Friday`), and
  the Concept Name carries the event:
  `<Short concept> Iteration 1 Black Friday (<ID>) - <Product>`. Andy and Callum
  name theirs the same way (`Better Call Black Friday (NKFD071) - Feather`).
- **Iteration 1** writes the event into the new script: the hooks, the beat
  where the deal lands, and the close. It is new copy, so every gate applies.
- **Iteration 2** keeps the script locked and adds the event **only where the
  script names the deal**: the deal-launch line and the close. Each of those is
  marked `Changed:` and re-recorded. The hooks keep their VO and get an event
  Super (`SUPER: BLACK FRIDAY`) instead.
- **The offer stays B2G2.** Black Friday Super on every offer line:
  `BLACK FRIDAY · BUY 2 GET 2 FREE` (the house form on NK827). No end date, no
  countdown, no extra % off and no "up to 67%" (the figure Andy's batch took from
  a meme; see the editor-assignment log). Real scarcity, such as a few hundred
  per run on the Feather, is fine.
- **Originality:** also run Iteration 1 against any existing event version of
  the same winner (NK827 is Callum's Black Friday NK222).
- **An old offer on the deal line becomes B2G2.** Iteration 2 re-records that
  line for the event anyway, so a locked `Buy 2, Get 1 Free` (NKEOFY005) is said
  as `Buy 2, Get 2 Free` and marked `Changed:`. Mark made the same change to this
  script on NKFD104 and NK121. Burned-in offer text in a locked Iteration 1 clip
  is rebuilt the same way (§3.2).
- **No old event end cards.** A seasonal CTA card says its season (every card
  in the `EOFY CTA` folder reads End of Financial Year). End on the event Super
  instead.

---

## 9. The run

1. **Parse the command** into IDs, plus an optional winning hook and `again`. No
   ID → ask.
2. **Read:** this file; on `claude/vibrant-hopper-xg9l5l`,
   `brand-pack/05-process/creative-brief-process.md` (§C, §D, §E, §F),
   `brand-pack/01-brand/product-catalog.md`, the persona file for the source's
   avatar, and `.claude/skills/nk-ad-naming/`.
3. **Per ID:** pull the brief (§2.1) and the cut (§2.2). A failure stops that ID
   only. Report it and go to the next.
4. **Dedup** (§7).
5. **Write** both types (§3, §4).
6. **Gates.** All of them pass before a page is created. The mechanical ones
   (Iteration 1 length and originality, Iteration 2 lock) are scripted: put the three
   scripts in a JSON file and run
   `python3 -I winner-iterations/gate_check.py RUN.json` with the brand pack's
   winning briefs and approved-copy file as extra arguments. Exit 0 = pass. The
   rest are judgement and stay manual:
   - Iteration 1: originality (§3.5), length budget (§3.4), every line fits its clip
     (§3.3).
   - Iteration 2: no source clip (§4.2.1), the 3-of-4 axes on every row (§4.2.2), a
     changed format device (§4.2.3), new hook first frames (§4.2.4), and no word
     changed outside the fix list (§4.3).
   - Both: product accuracy and the fix list (§4.3), the standing visual rules,
     and the naming self-check from `SKILL.md`.
7. **Creative IDs and editor** (§8.1, §5). The pair takes two consecutive
   numbers, Iteration 1 first.
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
- Write only one of the two types for a winner.
- Give either iteration to anyone but the source's editor.
- Write to the source page.
- Change the product or the persona.
- Use a source clip in Iteration 2, in any form.
- Change a locked word in Iteration 2 outside the fix list.
- Name a type "Rewrite" or "Reskin", or put any strategist but `Mark` on an iteration.
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
- **Skipped**, and why: already iterated (with a link), no page, no cut, no
  usable editor.
- **Other people's iterations** of the same source found in Notion (§7.2).

If the Notion or Frame.io connector is unavailable, **say so explicitly**. Never
report an empty run as "nothing to do".

---

## Run history

| Date | Command | Briefs | Notes |
|---|---|---|---|
| 2026-11-11 | `Iterate NK222` | NK843 Iteration 1, NK844 Iteration 2, both Hammad | First run. Cut found in Hammad's `NK 222` folder (158 s, Frame.io-tagged Winner). Script checked against the cut's burned-in captions on the scrub sheet; no audio transcript (speech-model hosts blocked). Iteration 1: NK222's story retold by the customer in first person, angle Return → Regret; offer resolves at ~53%, same as NK222. Iteration 2: after-dark KF look; fix list changed B11 (dragon on the Tiger Cleaver), B12 (opener "in the blade") and cut "Free returns" from B13. Shortened the naming concept to fit Frame.io's 255-character cap. Same day, on Mark's instruction: both pages renamed from Rewrite/Reskin to Iteration 1/2 and the strategist changed from Claude to Mark, in the properties and all names. Then, also on Mark's instruction: both rewritten as **Black Friday** versions (§8.3; Iteration 2 re-records B2, B11, B12 and the CTA) and rebuilt on the live brief template's structure (§8.2: video block, 3-column tables, CTA section, template persona and glossary). Callum's NK827 surfaced a second Tiger Cleaver error, "tiger-striped", now on the fix list. |
| 2026-11-11 | `Iterate NK184` + "tailored to Black Friday" | NK847 Iteration 1, NK848 Iteration 2, both Hammad | Cut in the `NK184` folder: three 107 s stacks, the 3D one tagged `Performance: Winner` on Frame.io, so H3 was treated as the winning hook. Brief has the VO MP3 attached; Iteration 2 points Hammad at it. Iteration 1 drops the "What if" device for flat statements; gate pass vs NK184, Callum's NK837 (its Black Friday version) and Andy's NK808 hooks. **KF sets were not usable for the Iteration 2 look**: NK184 already uses forest and stump product shots, so the reskin goes night and indoors with Higgsfield product shots checked against the real knife. NK184 closes on "Full tang", so the Iteration 2 lineup leaves out the RAGNAR Tiger Cleaver. Names hit Frame.io's 255 cap with the long tags (Craftsmanship, Str-Comparison, Black Friday), so the file-name concept is just `Iteration 1` / `Iteration 2`. Gate script bug fixed: its numeral map lacked 12. Flags left for Mark: "no two hands hammer the same way", "most viral knife of 2026", "biggest deal of the year", and the close not ending on "Link's below". |
| 2026-11-12 | `Iterate NK326` + "tailored for Black Friday" | NK860 Iteration 1, NK861 Iteration 2, both Naveed | NK326 is Naveed's editor-trial cut of the NK184 script (Andy, no `Test Results` tag; its 2D file is tagged `Performance: Winner` on Frame.io, so H2 is the winning hook). Cut in the `NK326` folder: three 107 s files, 1D/2D/3D; `NK326-DE` is the German version and was left out. The brief's Visual column is empty, so Iteration 1 lists each row's span in the 2D export from the scrub sheet (spec §3.1 now says so). Captions match the brief except "And hardened to steel", "Same stamp steel" and no "Click the link" caption; the brief's wording was kept. Iteration 1 gated against NK326, my NK847, Callum's NK837, Andy's NK808 and NK809 hooks, the approved copy and winning briefs; the gate now exempts the whole proof stack as one run, which NK847 tripped. "Bold Claim" pushed the H1 file name to 257 characters, so H1 became a Warning hook. Iteration 2 has the same locked words and changes as NK848, so its look is a white studio, unlike both NK326 and NK848 (spec §4.2 now covers shared scripts). Same flags as NK184 for the locked lines. |
| 2026-11-12 | `Iterate NKEOFY005` + "tailor it to Black Friday Sale" | NK862 Iteration 1, NK863 Iteration 2, both Hammad | Not in Evergreen Video: the brief is `Worth it ? (NKFD046)` in the Holiday Brief Database (EOFY), found by workspace search; the spec said it had no page, now corrected. Cut in the `NKEOFY005` folder: three files of about 40 s, the 3D one tagged `Performance: Winner`, so H3 is the winning hook; won in AU, so `Mkt-AU`. Persona: the page says SARAH and the old file names say VANCE; the script is a wife buying for him, so SARAH. Captions show the delivered hooks differ from the brief ("knife" not "blade" in H2, no "that" in H3); Iteration 2 locks the delivered wording. Voice is female (median pitch about 240 Hz, measured from the cut). The script's offer is Buy 2, Get 1 Free: Iteration 2 re-records it as Buy 2, Get 2 Free for Black Friday (spec §8.3 now says so, after Mark's NKFD104 and NK121), and Iteration 1's burned-in offer text on the last clip is rebuilt. The EOFY end cards all say End of Financial Year, so neither brief uses one. Offer lands at about 87%, outside 60-80%, as in the winner. Flags: "five times sharper than average knives", "pro chefs and pitmasters use these knives", and "stays that way, thanks to a full tang" (the tang does not keep an edge) stay in the locked script. |
