# UGC Script Process — authoritative spec

This repo **feeds the Gen 2 system**: the `UGC Creator Library` in Notion and
its `🎬 Creator Script Library`. The output of this process is a **script row
in that database**, not a standalone document.

Read `observed-notion-structure.md` alongside this. That file is the field
record of how the live pages look; this file is how we write into them.

Sections: **A** the unit of work · **B** script identity · **C** the page body
· **D** database properties · **E** b-roll packages · **F** copy rulebook ·
**G** pre-flight · **H** delivery · **I** known breakage.

---

## Section A — The unit of work

**One script = one row.** Not a batch, not a pair of scripts.

A script row carries a **long form** and a **short form** of the *same*
script, plus **three hooks** for the edit to choose between. The short form is
a compressed cut of the long one — same argument, same order, fewer words. It
is not a second creative idea.

Two scripts is the **per-creator-per-shoot-day limit**, not the unit of
production: *"Never send one creator more than two scripts for a single shoot
day. Two long forms plus their short cuts plus the b-roll package is already a
full day."*

The holiday matrix is **6 formats × 4 products = 24 rows**. Scaling happens by
filling cells in that matrix, not by writing variants inside one page.

---

## Section B — Script identity

### Script ID

Stable, and **never renumbered** — creators put it in filenames.

- Campaign scripts: `<CAMPAIGN>-<FORMAT>-<PRODUCT>` → `XM-GT-FTH`,
  `XM-MAD-BLK`, `XM-OB-BJO`
- Verbatim iterations: `ITER-<SOURCE AD>-<PRODUCT>` → `ITER-R2B8-BLK`,
  `ITER-R7B8-FTH`

Observed codes — format: `GT` Gift Testimonial · `OB` Obsessed Listicle ·
`WG` Worst Christmas Gift · `GR` Gift Reveal POV · `LM` Last-Minute Gift ·
`MAD` I am Mad. Product: `LOKI` · `BLK` Blackout · `FTH` Feather ·
`BJO` BJORN Santoku.

### Page title

`<Format name without its number> · <Product>` → `Gift Testimonial · Feather`.
The `Script` title property carries the same string.

### Source winner

Free text naming the proven ad and its real numbers, e.g. *"NORTH_R2B8 V4.
$118,539, ROAS 1.99, 2,121 purchases. Highest-spend ad in the 365-day
dataset."* **Never invent a figure here.** If the number isn't known, name the
ad and say the spend is unknown.

---

## Section C — The page body

Five H2 sections, in this exact order, and nothing else.

```markdown
## Hooks
Shoot all three. We pick in the edit.
**H1** <line>
**H2** <line>
**H3** <line>

## Long form
<prose paragraphs>

## Short form
<prose, roughly a third the length>

## B-roll package
- KNF-XM63 Talking head, tree behind
- KNF-PS05 Blade macro pass (evergreen library)

## Filming notes
- <rules for this script>
```

Hard format rules, all taken from the live pages:

- Hooks are **bold `**H1**` labels in prose**. Not a table. The literal line
  *"Shoot all three. We pick in the edit."* sits under the heading.
- Long form and short form are **plain prose with no visual column**. Visuals
  live in the b-roll package. Do not build a beat table.
- Long form runs ~9 short paragraphs; short form ~4 lines.
- B-roll package is a **bullet list of `<SHOT ID> <shot title>`**, pulled from
  the library. Add a parenthetical only to flag provenance, e.g.
  `(evergreen library)`.
- Filming notes are **bullets**, and carry the hard "never" guards for this
  product.

### What the long form does

Observed on `XM-GT-FTH`, which adapts the highest-spend ad in the dataset:

1. Open on the hook line, extended by one beat.
2. Name the product and the circumstance.
3. Concede the doubt, then answer it with a demonstration.
4. Plain materials, one sentence. *"High-carbon steel, hand-forged, rosewood
   handle."*
5. **The offer.** ~55–60% in.
6. Proof stack: customers, warranty, money back, shipping.
7. CTA.
8. Close on the cost of waiting.

---

## Section D — Database properties

Set every one of these. Values are the live enumerations — do not invent new
options, and do not use an option the schema does not list.

| Property | Values |
|---|---|
| `Script ID` | per Section B. Never renumber |
| `Script` | title, per Section B |
| `Status` | Ready to assign → Assigned → Filming → Delivered → Live → Retired |
| `Status 1` | Idea · Rejected · In progress · Assigned to creator · Needs revisions · Script Approved · Uploaded to Drive |
| `Format` | 1 Gift Testimonial · 2 Obsessed Listicle · 3 Worst Christmas Gift · 4 Gift Reveal POV · 5 Last-Minute Gift · 6 I am Mad · 7 Straight Announcement · Scamming you · Comparison · Trying the viral knife · Do NOT buy this · Story telling |
| `Product` | LOKI Viking · LOKI Blackout · Feather · BJORN Santoku · RAGNAR Tiger Cleaver · ODIN · Multi / Lineup |
| `Avatar` | SARAH · MIKE · VANCE · JOHN · STEVE · DARIEN |
| `Cast` | Solo man · Solo woman · Couple · Hands only |
| `Lengths` | Long + Short · Long only · Short only |
| `Offer` | B2G2 · None in script |
| `Mode` | Verbatim iteration · Adapted · From your UGC Script Library |
| `Campaign` | Holiday Sale 2026 · Evergreen (multi) |
| `Wave` | W1 Early Access - live Nov 6 · W2 - live Nov 20 · W3 Christmas Delivery - live Dec 2 |
| `Markets` | US · UK · AU · CA · DE (multi) |
| `Landing page` | 6 Reasons - General · Gift Guide |
| `Source winner` | free text, per Section B |
| `B-roll IDs` | flat text list — see Section E |
| `B-roll shots` | relation into `Knives — B-Roll Library` |
| `Creator`, `Delivery link`, `Sort` | filled at assignment and delivery |

### Format → Avatar → Cast

**The avatar follows the format, not the product.** This is the single thing
most likely to be got wrong, because it is the opposite of how the
ad-rewriting routine in `my-client` works.

| Format | Avatar | Cast |
|---|---|---|
| 1 Gift Testimonial | MIKE | Solo man |
| 2 Obsessed Listicle | SARAH | Solo woman |
| 3 Worst Christmas Gift | SARAH | Solo woman |
| 4 Gift Reveal POV | MIKE | Solo man |
| 5 Last-Minute Gift | SARAH | Solo woman |
| 6 I am Mad | VANCE | Solo man |

Every one of the four products runs through every one of those formats. The
holiday wave puts **Feather in front of MIKE, SARAH and VANCE**, and uses
**JOHN for none of it**. Do not re-derive an avatar from the product.

Casting at assignment: a solo man takes Formats 1, 4 and 6; a solo woman takes
2, 3 and 5; a couple can take any of them plus the Couple-cast b-roll.

---

## Section E — B-roll packages

The b-roll library is the source of truth for shots. This process **selects
from it and never writes into it**.

- **Never mint a shot ID.** Query `Knives — B-Roll Library`
  (`collection://ca66767d-35ce-4318-9c3d-84398122de68`) and use IDs that come
  back. See Section I — the existing rows cite IDs that no longer resolve.
- **Check the row is live.** A fetched page flagged `deleted` is archived; an
  archived shot is not a shot. SQL over the collection returns only live rows,
  so prefer a query over trusting an ID you read somewhere.
- **ID grammar is `KNF-<CODE><NN>`** and the code is *historical, not derived
  from the category*. Live codes: `ACT` · `BF` · `CT` · `CUT` · `DM` · `GF` ·
  `OF` · `PROD` · `PS` · `RX` · `SK` · `XM`. Both `CUT` and `DM` sit under
  Cutting Demos; both `PROD` and `PS` under Product & Packaging; `XM` spans
  four categories. Sharpener shots use `SHP-`.
- **Package size** runs 12–25 shots, mixing campaign and evergreen.
- **Fill both fields.** `B-roll IDs` is free text for reading; `B-roll shots`
  is the relation that makes the Pipeline board honest. They must agree.
- **Shot properties to respect when selecting:** Priority (P1 must-have / P2 /
  P3), Cast (Hands only / Solo / Couple / No cast), Funnel (Hook / Problem /
  Proof / Payoff / CTA), Category (8), Block (A Set dressing → B Wrapping →
  C Reveal → D Cooking → E Offer → F Skits → G A-Roll), Campaign, `Knives`
  (23 options, `All knives` means no re-shoot needed), `Andy Approved`.
- **Skip Couple shots for a solo creator.** Cast on the shot has to be
  compatible with the creator.

### Shoot-order constraint

Holiday blocks run **A → B → C, then D–G in any order**. Block B wraps **TWO
boxes**, one to open on camera and one sealed for pickups. Same sweater, same
light, same tree through B and C or the reveal will not cut together.

> **The wrapped box is a one-way door.**

---

## Section F — Copy rulebook

### F.1 — Product guards (these go in Filming notes)

- **Feather — never describe how the pattern got onto the blade.** Not etched,
  not hand-finished, not engraved, **and not laser-applied**. *"It is simply
  there."* This supersedes the `my-client` rule, which says to call it
  laser-applied; saying that on camera is a violation. The pattern is still
  the hero of the visuals — it just never gets a process word.
- **BJORN Santoku — the word "Japanese" never appears**, nor any nod to
  Japanese origin, tradition or technique. Describe the shape by what it does
  on a board. This extends to styling: no kanji packaging, no sushi plating.
- **LOKI Blackout — the bottle opener is in the handle.** $79.90.
- **Feather — $99.90**, ~500 a drop, ~3 months to restock. Hedge both numbers
  for speech: "around five hundred at a time", "about three months".
- **Never name a specific delivery cutoff date on camera.** "Before
  Christmas" only.
- **Only the offer in the `Offer` property exists** — B2G2, or none. Never
  invent an offer, a code, a shipping threshold or a deadline.

### F.2 — Voice

The live register is **much blunter than a brand doc would suggest**. Shipped
hooks include "SON OF A B\*TCH" and "WTF is wrong with you?". Write to the
creator's mouth, not to a brand guideline.

- Contractions always. One idea per sentence. Read every line out loud.
- Plain material + the consequence. Never a spec sheet: no alloy codes, no
  HRC/Rockwell, no "edge retention", no "blade geometry", no mm or grams.
  The Gen 2 scripts get this right — *"High-carbon steel, hand-forged,
  rosewood handle"* — and the Gen 1 briefs got it badly wrong.
- No ad-voice: no "introducing", "look no further", "game-changer".
- Never script a claim the creator can't personally stand behind.

### F.3 — Offer placement

The offer **resolves** what the hook raised. In Gift Testimonial it lands
~55–60% through with proof and CTA after it.

**But offer-first is a sanctioned format.** `6 I am Mad` puts the offer in the
hook — *"Buy 2, get 2 free. This deal PISSES me off."* Follow the format, not
a global rule.

Never reuse the identical offer paragraph across the products of one format.

### F.4 — Social proof

The approved figure has drifted and the archive contradicts itself: "over a
thousand five-star reviews", "over a 100,000 thousands reviews" (garbled), and
currently "a hundred thousand customers" alongside lifetime warranty, 30-day
money back and free shipping. **Confirm the current figure before using it.**

### F.5 — Originality

Mechanic transfers, words never do. `Mode` says how far that goes:
`Verbatim iteration` keeps the source ad's structure line-for-line in shape;
`Adapted` rebuilds it for a new product or avatar. Either way no sentence is
copied from the source ad, from an approved script, or between the products of
one format.

---

## Section G — Pre-flight

- [ ] Five sections, in order, nothing else.
- [ ] Hooks as `**H1**`/`**H2**`/`**H3**` prose with the "shoot all three" line.
- [ ] Three hooks are three different doors in.
- [ ] Short form is a cut of the long form, not a second idea.
- [ ] Offer matches the `Offer` property, and is placed as the format requires.
- [ ] Feather: no process word for the pattern, laser-applied included.
- [ ] BJORN: no "Japanese", spoken, captioned or styled.
- [ ] LOKI: opener in the handle.
- [ ] No specific delivery date on camera.
- [ ] No spec-sheet jargon; no invented claim, offer or figure.
- [ ] Every product claim traces to `01-brand/product-catalog.md`.
- [ ] **Every b-roll ID resolves to a live, non-archived library row.**
- [ ] `B-roll IDs` text and `B-roll shots` relation agree.
- [ ] Shot Cast is compatible with the creator's cast.
- [ ] Avatar and Cast follow the **format**, per Section D.
- [ ] Every property in Section D is set.
- [ ] `Source winner` cites a real ad; no invented spend.

---

## Section H — Delivery

### Page conventions

- **Icon: 🔪 on every page.** Always, for every new brief or script page,
  matching the rest of the `UGC Creator Brief` hub. Do not pick a
  topical icon (🎁, 🔁 or anything else) — the hub reads as one set.
- **Props needed: only what breaks the shoot if it is missing.** Four or five
  lines, not an inventory. A prop earns its place by being something the
  creator would not otherwise have, or would get wrong — the worst old knife,
  wrap for two boxes, a light board for dark handles. Ordinary kitchen stock
  is left to the shotlist; close with one line saying so.
- **Title:** `<Concept> - <Creator> | <Event>`, the hub's existing pattern.
  Escape the pipe as `\|` when writing it through the API.


1. Write the script into the `🎬 Creator Script Library` as a new row, with
   the Section C body and every Section D property. `Status` starts at
   **Ready to assign**.
2. Link the b-roll package in both fields.
3. Mirror the markdown into `ugc-scripts/<SCRIPT-ID>.md` in this repo and
   commit, so the script is reviewable in git and survives a Notion edit.
4. Assignment (done by a person, not this routine): filter the Wave → match
   cast → set `Creator`, flip `Status` to Assigned, and flip the b-roll rows
   too → send three links: the script page, the campaign b-roll view, and the
   filming rules in `briefs/ugc-broll-library/README.md`.
5. On delivery, flip `Status` to Delivered and name files with the
   `nk-ad-naming` skill.

**If the Notion connector isn't available in a run, say so explicitly** rather
than silently skipping delivery. A script that exists only in this repo has
not been delivered.

---

## Section I — Known breakage, as of 2026-10-08

Two things are wrong in the live system. Work around them; don't copy them.

1. **Most b-roll references on existing script rows are dead.** The library
   page advertises 66 Christmas shots `KNF-XM01`–`KNF-XM66`, added 2026-10-05.
   Only **9 `KNF-XM*` rows are live**; the rest are archived. Of the 15 IDs
   cited by `XM-GT-FTH`, **only `KNF-XM12` resolves** — `KNF-PS05`,
   `KNF-XM63`, `KNF-XM64` and 11 others are archived. The relation still
   points at them, so it resolves to archived pages and looks healthy.
   `B-roll IDs` is free text and nothing validated it.
   → **Re-resolve any package before a creator is sent it.**
2. **The library is mid-migration to "Trybe packs."** 102 live rows; 29 are
   assigned to `Include in:` packs (Trybe Holiday Pack of 15/10/5, Trybe Pack
   of 15/10/5) and 73 are unassigned. A sibling page is titled *"(merged into
   Trybe B-Roll Packs, safe to delete)"*. The XM numbering appears to have
   been superseded by curated packs drawn from the main library.
   → **Don't build new packages on `KNF-XM*` numbering.** Select from live
   rows and prefer the Trybe pack membership where a pack fits.

Neither is this repo's to fix unilaterally — both are Andy's call. Flag them
rather than silently re-pointing 24 script rows.
