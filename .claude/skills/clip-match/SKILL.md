---
name: clip-match
description: Fill the empty Visual cells of a NorthernKnife video brief in Notion with matching b-roll clips from the "Mark Broll Selection" libraries (Feather, LOKI Blackout, Bjorn Santoku, Tiger Cleaver, Knife Sharpener). Use when the user gives a Creative ID (e.g. NK955) or a brief URL and asks to match clips, fill visuals, or find b-roll for a brief.
---

# Clip Match

Input: one **Creative ID** (`NK###`) or a brief URL. Never pick a brief yourself —
wait for the user to name one. Several IDs = run the steps once per brief.

Goal: every **empty** Visual cell in the brief's HOOK and BODY tables gets the
library clips that best fit that row's copy. Cells that already have anything
in them are left exactly as they are.

## Notion map

**Brief database:** Evergreen Video ("Video Brief Database"),
data source `collection://2cf4ac62-7aac-81a8-86bf-000b96778943`.

| View | URL | Note |
|---|---|---|
| Ready for visuals | `view://3b84ac62-7aac-80b5-9b32-000ca23876da` | small, check first |
| In Progress | `view://2fe4ac62-7aac-8072-8273-000c75d5dd3e` | sorted Creative ID desc |
| All Concept | `view://2cf4ac62-7aac-8153-a087-000cebf17200` | everything, sorted Creative ID desc |

**B-roll libraries** (all under the "Mark Broll Selection" page,
`41b4ac627aac80009438cdfebfccf002`):

Library clips are only ever used for the **brief's own `Product`**. Other
knives a line features get a fixed visual instead (step 5).

| Brief `Product` | Library | View URL |
|---|---|---|
| Feather | 🪶 Feather B-roll | `view://41b4ac62-7aac-8165-b78f-000ccc436fc9` |
| LOKI Blackout | 🐈‍⬛ Loki Blackout B-roll | `view://41b4ac62-7aac-81a3-9b2d-000cf4d6eb0c` |
| SANTOKU (BJORN Series Santoku) | 🐲 Bjorn Santoku B-roll | `view://41b4ac62-7aac-8162-a57e-000c6b0b059f` |
| Tiger Cleaver (RAGNAR Tiger Cleaver) | 🐅 Tiger Cleaver B-roll | `view://41b4ac62-7aac-8151-b732-000c597624de` |
| Rolling Knife Sharpener | Knife Sharpener B-roll | `view://41b4ac62-7aac-818b-984d-000cfd29a696` |
| BJORN Utility | only the Santoku-library clips whose name says "Bjorn utility" | (same as Santoku) |
| anything else (LOKI Viking, ODIN, RAGNAR Butcher, VALHALLA, Gunnar, Dragon…) | **no library**: fixed visuals still apply, other beats get gap notes (step 5) | |

Each clip row has: `Proper Name` (title, the only description; clip pages are
blank), `Frame.io link`, `Person` (Solo / Couple / Family / Group / Hands only /
No person), `Seasonality` (Evergreen / Christmas).

**Tool limits on this workspace:** `notion-query-data-sources` in SQL or rows
mode is refused (needs a Notion Business plan). Use `mode: "view"` only; it
works. `notion-search` for an ID is fuzzy (matches any "NK…"), so never trust
its top hit without checking the `Creative ID` property.

## Steps

### 1. Find the brief

- URL given → fetch it.
- ID given → query the **Ready for visuals** view, then **In Progress**, then
  **All Concept** (`mode: "view"`, `page_size: 100`, follow `next_cursor` while
  `has_more`). Take the row whose `Creative ID` equals the ID exactly. The
  views sort Creative ID as text, so stop paging All Concept once the IDs on
  a page are lower than the target (fine while IDs are 3 digits).
- Last resort: `notion-search` with the ID and
  `data_source_url` = the brief data source, then fetch candidates and check
  `Creative ID`.
- Not found, or more than one page with that ID → stop and tell the user.

### 2. Read the brief

Fetch the page and note:
- `Product`, `Avatar`, `Offer`, `Status`.
- **Season**: Christmas if the batch name has `_Christmas_` (the tag after
  `Mkt-XX_`) or the instructions/concept are Christmas or Santa themed;
  otherwise evergreen.
- **Instruction constraints** from the "Creative Brief Instruction" section,
  its callouts, and the AD INSPO / persona callouts. These override the
  defaults below. Examples: "Nobody on camera after the hook" → body clips
  must be `Hands only` or `No person`; "Higgsfield Santa for the hook" → the
  hook is AI footage, not library; a named shoot or a specific Frame.io link
  → that footage wins for the beat it names.
- **Clips already used** in filled Visual cells (by scene name): don't reuse
  them.

### 3. List the empty Visual cells

- Find the HOOK and BODY tables. Find the Visual column from the header row
  (`<b>Visual</b>`), not by position.
- A Visual cell is empty when the fetched markdown shows it as `<td></td>`
  (or only whitespace). Anything else, even rough text like "Unboxing clip of
  blackout", counts as filled. Don't touch it.
- **Hard rule, HOOK and BODY alike:** a filled Visual cell is never edited,
  added to, reformatted or "improved", whoever wrote it, including cells
  filled by an earlier run of this skill. A brief whose hooks are all filled
  gets body-only work, and the reverse. The only exception is when the user
  explicitly asks to redo a specific brief's visuals.
- Skip rows whose copy cell is empty too.
- No empty Visual cells → tell the user and stop.

### 4. Load the libraries you need

Load only the brief's own `Product` library (other knives get fixed visuals,
step 5). Query the view with `mode: "view"`,
`page_size: 100`, and follow `next_cursor` until `has_more` is false. Every
library currently has more than 100 clips, so expect at least 2 pages. Always
load live (the team adds clips every few days); don't cache.

### 5. Match each empty row

**Fixed visuals come first.** These are the user's house rules. Write the
text exactly as shown, as a plain line (no link):

| When the line… | Write |
|---|---|
| says "hand forge" in any form: hand-forged, hand forged, hand-forging (any case) | `Hand forging clip` |
| has social proof: customer counts, review counts, star ratings ("147,000 customers…", "over five thousand five-star reviews") | `12 tiles collage of men holding their knives from NK` |
| features the Feather (and Feather isn't the brief's `Product`) | `Montage clip of feather showing the blade and handle` |
| features the LOKI Blackout (not the brief's `Product`) | `Montage clip of blackout showing the blade and handle and bottle opener tip` |
| features the Santoku (not the brief's `Product`) | `Montage clip of Santoku showing the norse blade design and dragon bolster` |
| features the Tiger Cleaver (not the brief's `Product`) | `Montage clip tiger cleaver` |
| features the RAGNAR Butcher | `Montage clip ragnar butcher` |
| features the LOKI Viking (the original LOKI) | `Montage clip of Loki showing the blade, the handle, and the finger hole` |

- **"Features"** means the knife is the line's subject (named and described:
  "The RAGNAR Tiger Cleaver. Ten inches of tiger-striped blade…"). A passing
  mention doesn't count ("…when the Feather feels like too much for an
  onion" in a LOKI line gets no Feather montage).
- **Cutting:** if a featured knife's line has it cutting something, also add
  `broll clip of cutting using <knife>` (for example `broll clip of cutting
  using LOKI Viking`) where the cutting words fall.
- **One beat each:** a fixed visual covers only its own words. The rest of
  the line keeps library shots of the brief's own product, in VO order. Each
  fixed visual appears once per cell, at its first mention, even if the line
  says "hand-forged" twice.
- **The brief's own product** never gets a montage. Its lines use library
  shots, plus `Hand forging clip` and the collage where the rules above fire.
- **Featured knife not in the table** (ODIN, VALHALLA, Gunnar, Dragon, LOKI
  Reaper or Berserker, BJORN Utility…): write a gap note,
  `⚠️ No fixed visual: <knife> montage`.
- **`Product` = Multi:** no knife is the brief's own product, so every
  featured knife gets its montage. Beats that aren't about one knife get a gap
  note. Confirm this reading with the user on the first Multi brief.

**How many clips:** 1–2 library clips per Visual cell, by line length:
1 clip for a line of up to about 20 words, 2 clips for anything longer. Never
more than 2; the editor fills out the 3–4 s cuts from there. Fixed visuals
come on top of that where their rule fires, once per kind per cell. List
everything in the order it plays.

**Picking clips:**
1. **Match the beat literally first.** Unboxing or "this is the…" → box-open or
   unboxing clip. Bottle opener → the beer-cap clips (Blackout's opener is in
   the handle). Gift, wife, Christmas morning → gifting, stocking, wrapping,
   under-the-tree clips. Steak, BBQ, sharpness → cutting and slicing clips.
   Craft, detail, design, handle → macro or detail clips. ("Hand-forged" is a
   fixed visual, see above.)
2. **First body row:** the first clip is a clear hero shot of the product
   (most briefs cut to the knife on the first word of the body).
3. **Hook rows:** the most arresting clip for the hook's subject. The first
   frame has to earn the scroll stop.
4. **Season:** for a Christmas brief, prefer `Christmas` clips for
   lifestyle and gift beats; `Evergreen` is fine for product details. For an
   evergreen brief, **never** use `Christmas` clips.
5. **Person:** follow the instruction constraints. If there are none, lean on
   the persona: SARAH → wife or couple and gift clips; MIKE → grill, steak and
   campfire clips; JOHN → macro, detail and display clips; VANCE → box,
   unboxing and value clips.
6. **Name hygiene:** prefer clips whose name names the product. Names without
   the product ("Small campfire burns…", "Overhead, steak and corn cobs…") are
   cutaways: fine for mood or food beats, never for a product-feature beat.
   In the Santoku library, "Bjorn utility" clips are a different knife; never
   use them on a Santoku line.
7. **No repeats** anywhere in the brief (hooks + body + clips already in
   filled cells). Don't stack near-identical shots back to back (three "planted
   in a mossy log" in a row); vary detail → action → lifestyle.
8. **Don't force it.** If neither a fixed visual nor the library fits the beat
   (phone screen, order page, warehouse, Santa on camera), write a gap note
   instead of a weak clip: `⚠️ No library clip: <the shot needed>`. A row can
   mix clips, fixed visuals and gap notes.

### 6. Write the cells

Cell content: everything in play order, with a blank line between entries
(`<br /><br />`; table cells are inline-only) so the editor doesn't get one
long paragraph. **No links.** Each library clip is written as
`Broll clip of <Proper Name>`: the clip's scene name from the library, with
its first letter lowercased unless it starts with a proper noun (Feather,
Santa, POV…), and with the shot tags removed. Drop framing, angle and camera
moves (medium, medium-wide, wide, close-up, extreme close-up, full-body,
overhead, top-down, high-angle, low, eye-level, macro, push-in, pull-back,
tilt-up/down, pan…, orbit, drift, slow-motion, static, rack focus); keep what
is in the shot (selfie, POV, the action). For example, "Feather box among
gifts under the tree, push-in" becomes
`Broll clip of Feather box among gifts under the tree`. Fixed visuals use their exact text, and gap notes start with
`⚠️ …`. Library clips never repeat within a brief; fixed visuals may (the
editor picks different footage each time). Keep the padding the existing
cells use:

```
<td>
Hand forging clip<br /><br />Broll clip of hand opens Blackout box, knife in foam tray<br /><br />Montage clip of Loki showing the blade, the handle, and the finger hole
</td>
```

Because the scene name lands in the brief as text, skip any Feather clip
whose name says "etched" or "engraved" when another clip covers the beat
(the Feather pattern is laser-applied; the brief must never call it etched).

Apply every cell in **one** `notion-update-page` call, `command: "update_content"`,
one `content_updates` entry per row:
- `old_str` = the whole `<tr>…</tr>` of that row, copied exactly from the
  fetched markdown (keep escapes like `\_`, `\|`, `<br />`). The copy makes it
  unique.
- `new_str` = the same row with only the Visual cell changed from `<td></td>`
  to the filled cell.

Never change other cells, the copy, the Notes, page properties, or `Status`.

### 7. Verify and report

- Fetch the page again. Check that each target cell is filled and no other
  row changed. Quote any `warnings` from the update verbatim and re-apply the
  rows that missed (usually an escape mismatch in `old_str`).
- Reply with: the brief (ID, concept, link); a short table (row, first words
  of the copy, clips filled); and the list of ⚠️ gaps the editor has to source.
- Don't move `Status` (e.g. to "Ready to edit") unless the user asks.
