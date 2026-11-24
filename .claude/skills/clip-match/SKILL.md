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

| Brief `Product` / product named in the row | Library | View URL |
|---|---|---|
| Feather | 🪶 Feather B-roll | `view://41b4ac62-7aac-8165-b78f-000ccc436fc9` |
| LOKI Blackout | 🐈‍⬛ Loki Blackout B-roll | `view://41b4ac62-7aac-81a3-9b2d-000cf4d6eb0c` |
| SANTOKU (BJORN Series Santoku) | 🐲 Bjorn Santoku B-roll | `view://41b4ac62-7aac-8162-a57e-000c6b0b059f` |
| Tiger Cleaver (RAGNAR Tiger Cleaver) | 🐅 Tiger Cleaver B-roll | `view://41b4ac62-7aac-8151-b732-000c597624de` |
| Rolling Knife Sharpener | Knife Sharpener B-roll | `view://41b4ac62-7aac-818b-984d-000cfd29a696` |
| BJORN Utility | only the Santoku-library clips whose name says "Bjorn utility" | (same as Santoku) |
| anything else (LOKI original, ODIN, RAGNAR Butcher, VALHALLA, Gunnar, Dragon…) | **no library** → gap note, see step 5 | |

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
- **Clips already used** in filled Visual cells (Frame.io view IDs): don't reuse
  them.

### 3. List the empty Visual cells

- Find the HOOK and BODY tables. Find the Visual column from the header row
  (`<b>Visual</b>`), not by position.
- A Visual cell is empty when the fetched markdown shows it as `<td></td>`
  (or only whitespace). Anything else, even rough text like "Unboxing clip of
  blackout", counts as filled. Don't touch it.
- Skip rows whose copy cell is empty too.
- No empty Visual cells → tell the user and stop.

### 4. Load the libraries you need

Use the brief's `Product` library, plus the library of any other product a
row is about (see step 5). Query each view with `mode: "view"`,
`page_size: 100`, and follow `next_cursor` until `has_more` is false. Every
library currently has more than 100 clips, so expect at least 2 pages. Always
load live (the team adds clips every few days); don't cache.

### 5. Match each empty row

**Which library:** default to the brief's `Product`. If the row's copy is
about a different knife, using it as the subject ("The RAGNAR Tiger
Cleaver. Ten inches…", "And the LOKI Blackout…"), use that knife's library.
If that knife has no library → gap note. Never show a different knife than
the one the line talks about.

**How many clips:** the 3–4 second rule (the visual changes every 3–4 s). AI
VO runs at about 2.5 words a second, so clips = `ceil(words in the copy ÷ 9)`,
minimum 1. Rough guide: up to 9 words → 1 clip; 10–18 → 2; 19–27 → 3;
28–36 → 4; and so on. List them in the order they play, following the line's
beats.

**Picking clips:**
1. **Match the beat literally first.** Unboxing or "this is the…" → box-open or
   unboxing clip. Bottle opener → the beer-cap clips (Blackout's opener is in
   the handle). Gift, wife, Christmas morning → gifting, stocking, wrapping,
   under-the-tree clips. Steak, BBQ, sharpness → cutting and slicing clips.
   Craft, detail, engraving, handle, "hand-forged" → macro or detail clips
   (there's no forging footage in the libraries, so if the line needs the
   forge itself, add a gap note for it).
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
8. **Don't force it.** If nothing in the library fits the beat (phone screen,
   order page, warehouse, Santa on camera, a multi-knife montage), write a gap
   note instead of a weak clip: `⚠️ No library clip: <the shot needed>`. A row
   can mix clips and a gap note.

### 6. Write the cells

Cell content: clips in play order, each as `[Proper Name](Frame.io link)`,
separated by `<br />` (table cells are inline-only), with the gap note, if
any, as the last line. Keep the padding the existing cells use:

```
<td>
[Hand opens Blackout box, knife in foam tray, close-up](https://app.frame.io/…)<br />[Macro of Blackout etching, finger hole and brass pins](https://app.frame.io/…)
</td>
```

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
