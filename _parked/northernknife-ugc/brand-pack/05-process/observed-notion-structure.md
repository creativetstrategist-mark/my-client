# Observed Notion structure — field notes

Read from the live workspace on **2026-10-08**. This is what the briefs and
scripts in Notion *actually* look like, recorded because
`ugc-script-process.md` in this repo was written from the `chopper` skill and
the `my-client` copy rulebook, not from the live pages — and it is wrong in
several places as a result. **Where this file and `ugc-script-process.md`
disagree, this file is what Notion does.**

Sources:
- `NK Creative Strategy Lab / UGC Creator Brief / May - July Campaign`
  (29 pages, May–Jul 2026) — read "Pissed Off - Dustin | Father's Day" and
  "Unboxing Feather - Dustin | Father's Day" in full.
- `UGC Creator Library` (top-level page, last edited 2026-10-08) and its
  `🎬 Creator Script Library` database — read the schema, all 24 rows, and
  `XM-GT-FTH Gift Testimonial · Feather` in full.

There are **two generations**, and the newer one is live.

---

## Generation 2 — current (Oct 2026)

`UGC Creator Library`. Its own header says the markdown in
**`briefs/ugc-broll-library/`** is the source of truth and the Notion copy is
"for filtering, assigning and tracking." So a repo already drives this.

### Shot IDs

`PRODUCT-CATEGORY##` — `KNF-XM63`, `KNF-PS05`, `SHP-BF03`.
**Never renumber**: creators put these IDs in filenames and messages.
Every shot carries Priority (P1 must-have / P2 strongly wanted / P3 bonus),
Cast (Hands only / Solo / Couple), Funnel role (Hook / Problem / Proof /
Payoff / CTA) and Campaign.

### `🎬 Creator Script Library` — one row is one shootable script

24 rows = **6 formats × 4 products**. Script ID is stable and never
renumbered: `XM-GT-FTH` (campaign-format-product), or `ITER-R2B8-BLK` for a
verbatim iteration keyed to its source ad.

Schema: Script ID · Format · Product · Avatar · Cast · Lengths · Offer ·
Mode · Campaign · Wave · Markets · Landing page · Source winner ·
B-roll IDs (text) + B-roll shots (relation) · Creator · Status ·
Status 1 · Delivery link · Sort.

- **Format** (12 options): 1 Gift Testimonial · 2 Obsessed Listicle ·
  3 Worst Christmas Gift · 4 Gift Reveal POV · 5 Last-Minute Gift ·
  6 I am Mad · 7 Straight Announcement · Scamming you · Comparison ·
  Trying the viral knife · Do NOT buy this · Story telling
- **Product** (7): LOKI Viking · LOKI Blackout · Feather · BJORN Santoku ·
  RAGNAR Tiger Cleaver · ODIN · Multi / Lineup
- **Avatar** (6): SARAH · MIKE · VANCE · JOHN · **STEVE** · **DARIEN**
- **Mode**: Verbatim iteration · Adapted · From your UGC Script Library
- **Lengths**: Long + Short · Long only · Short only
- **Offer**: B2G2 · None in script
- **Status**: Ready to assign → Assigned → Filming → Delivered → Live → Retired
- **Source winner** is free text carrying the proven ad and its numbers, e.g.
  "NORTH_R2B8 V4. $118,539, ROAS 1.99, 2,121 purchases. Highest-spend ad in
  the 365-day dataset."

### The script page body — five sections, in this order

```
## Hooks
Shoot all three. We pick in the edit.
**H1** <line>
**H2** <line>
**H3** <line>

## Long form
<prose paragraphs, ~9 lines>

## Short form
<prose, ~4 lines — a compressed cut of the same script>

## B-roll package
- KNF-XM63 Talking head, tree behind
- KNF-XM64 Talking head, Christmas sweater, kitchen, knife in hand
  …

## Filming notes
- <per-script rules, including the hard "never" guards>
```

Hooks are **bold labels in prose, not a table**. Long and short form are
**plain prose, with no per-line visual column**. The b-roll package is a
**bullet list of IDs pulled from the library**, not bespoke shot descriptions.

### Assignment workflow

Filter the Wave → match cast to creator (solo man takes Formats 1, 4, 6;
solo woman takes 2, 3, 5; a couple can take any plus the Couple-cast b-roll)
→ set Creator, flip Status to Assigned, and do the same on the b-roll rows →
send three links (the script page, the campaign b-roll view, and the filming
rules in `briefs/ugc-broll-library/README.md`) → on delivery flip Status to
Delivered and name files with the `nk-ad-naming` skill.

**Never send one creator more than two scripts for a single shoot day.**

Holiday shoot order is a hard constraint: Block A set dressing → Block B
wrapping (**wrap TWO boxes**, one to open on camera, one sealed for pickups)
→ Block C the reveal → D–G in any order. Same sweater, same light, same tree
through B and C. *"The wrapped box is a one-way door."*

---

## Generation 1 — May–July Campaign (May–Jul 2026)

One page per creator × concept. Title: `<Concept> - <Creator> | <Event>`
plus a status emoji — ✅ done, 🛑 killed, none = WIP.

Page order:

1. **Metadata table** (2 columns, header column): Content Creator · Product ·
   Event · Inspo link · Offer. Product is often **several products at once**
   ("Loki Knife, Feather Knife, Odin 6" Chef Knife, Odin Hybrid Cleaver").
2. `# Content Brief` — fixed boilerplate: for ads, no organic posting,
   TikTok-style creative, "TIKTOK STRATEGY approach".
3. 🎥 callout **Shooting Specifications** — 8 fixed bullets: good lighting ·
   don't shoot directly in TikTok · vertical 9:16 · **add 1–3 seconds at the
   head and tail of every raw clip** · ACs and fans off · **no filters or
   colour grading** · no logos on clothing · clean background.
4. 💡 callout **HOW TO UPLOAD CONTENT** — A-roll and B-roll shot separately,
   sent with no overlays or text, upload link.
5. `# Storyboard / Shot List`
   - `## A-ROLL/SCRIPT` — yellow text marks gestures and the moments the
     product is held.
   - `## A-Roll (TALKING HEAD)` → `### Script 1` → `#### Hooks` (2-col table,
     Hook 1/2/3) → `#### Main Body` (prose, stage directions inline in
     backticks) → `---` → `### Script 2`, same shape.
   - `## B-ROLLS | SHOTLIST` — 3-column table: Shotlist · Visual description
     · INSPO. Section bands with counts, IDs prefixed per band:
     Bad Gifts B1–B4 · Wow Reaction/Gift Giving G1–G17 · Product Demo P1–P8 ·
     Cutting/Slicing C1–C6 · Others O1–O6. Shot title in backticks,
     highlighted yellow or orange; Frame.io reference in INSPO; shots
     cross-reference each other ("in the same sequence you can record G10
     and O6").
6. `## File Naming Convention` — A-roll: the three hooks filmed **separately
   from the body**, named `Talkinghead_hook1..3`. B-roll: `BRoll_<section>`.

**The Gen 1 shotlist is copy-pasted boilerplate.** The 41 rows are identical
across the two briefs read, including the LOKI-specific rows sitting inside a
Feather brief. The band counts (4+17+28+6+6 = 61) don't match the actual rows
(4+17+8+6+6 = 41), and the column header says "Visual description (60)" —
60 was a target nobody reconciled. Gen 2's tagged library exists to fix this.

---

## Where this repo's `ugc-script-process.md` is wrong

| `ugc-script-process.md` says | Notion actually does |
|---|---|
| 2 scripts per batch sharing one message and angle | **1 script per row**, in a long form + short form pair. Two scripts is the per-creator-per-day *limit*, not the unit |
| 3 hooks in a markdown table | 3 hooks as **bold H1/H2/H3 labels in prose** |
| Body as a beat table with "what's on screen" per row | Body is **plain prose**; visuals live in the separate b-roll package |
| Exactly 8 bespoke shared b-roll clips | **12–25 shot IDs** pulled from a tagged master library of 66+ |
| Offer lands 60–80% through, never first | True of Gift Testimonial, **but "6 I am Mad" puts the offer in the hook** — offer-first is a sanctioned format |
| Persona maps to product (JOHN → Feather/BJORN) | **Persona maps to format.** The holiday matrix runs Feather past MIKE, SARAH and VANCE, and uses JOHN for none of it |
| 4 personas | **6 avatars** — STEVE and DARIEN also exist |
| 3 focus products | **7 products** in the live schema |
| iPhone-only, no-kit framing | Not a stated constraint. The real rules are 9:16 4K raw, 10–20s minimum per clip, no filters/music/text, handles at head and tail |
| My own pre-flight checklist | No such thing. The equivalents are **Filming notes** on the script and the Status pipeline |
| Batch files named `YYYY-MM-DD-<product>-<persona>-<moment>.md` | Stable **Script IDs** (`XM-GT-FTH`) that creators reuse in filenames, plus the `nk-ad-naming` skill |

### The Feather pattern rule — three different positions

This one matters most, because this repo tells you to say the thing Notion
now forbids.

- **May 2026 brief** (Gen 1, Feather unboxing): *"every single groove on this
  blade is hand-finished. This isn't laser-etched."* — asserts hand work.
- **`my-client/CLAUDE.md` and this repo:** pattern is **laser-applied**;
  never hand-etched, hand-finished or engraved. This repo goes further and
  scripts the line *"The pattern's laser-applied — dead clean, every single
  one."*
- **Oct 2026 script library** (current, `XM-GT-FTH` filming notes):
  *"Never describe how the pattern got onto the blade. Not etched, not
  hand-finished, not engraved. It is simply there."*

The live rule is **say nothing about the process at all** — which makes this
repo's scripted "laser-applied" line a violation, not a fix. Gen 1 was
violating the rule in the opposite direction.

### Other live-copy observations

- **Spec jargon moved the right way.** The Gen 1 Feather script is full of it
  — *"8.3 inches of martensitic steel… 260 grams… extended tang
  construction… machined geometry."* The Gen 2 Feather script is clean:
  *"High-carbon steel, hand-forged, rosewood handle."* Scarcity is hedged for
  speech — "around five hundred at a time", "about three months". Gen 2 lines
  up with this repo's copy rules; Gen 1 did not.
- **Social proof has drifted and contradicts itself.** Gen 1 Script 1: "Over
  a thousand five-star reviews." Gen 1 Script 2: "Over a 100,000 thousands
  reviews" (garbled). Gen 2: "A hundred thousand customers." Alongside it:
  lifetime warranty, 30-day money back, free shipping. **Confirm the current
  approved figure before using any of them.**
- **Offer field vs. script can disagree.** "Pissed Off - Dustin" has Offer =
  "Buy 2 Get 1" in the metadata table while all three hooks say "Buy 2, get
  2 free."
- **"Japanese" appears in a live script.** Gen 1 Feather Script 2: *"I've
  collected everything from Japanese Damascus to hand-forged Bowies."* It
  describes the creator's other knives, not a NorthernKnife product, but the
  word is in a shipped NorthernKnife script. The BJORN rule bans it outright.
- **Voice is far blunter than this repo assumes.** Live hooks include
  "SON OF A B*TCH", "WTF is wrong with you?", and a brief titled
  "Shut the Fuck Up - Matt". This repo's "no ad-voice, contractions always"
  guidance is right but much too polite about the register.
- **Gen 2 adds a don't this repo never had:** never name a specific delivery
  cutoff date on camera — "before Christmas" only.

---

## Decision taken

**This repo feeds the Gen 2 system** (decided 2026-10-08). The process doc has
been rewritten accordingly: the unit of work is one row in the Creator Script
Library, the body is the five-section page, and b-roll is selected from the
shared library rather than invented per batch. See
`ugc-script-process.md` and `notion-integration.md`.

Two consequences worth keeping in view:

1. **Scope follows the live schema, not `my-client`.** 7 products and 6
   avatars on the script side, 23 knives in the b-roll library — against 3
   products and 4 personas inherited from the ad-rewriting routine. STEVE and
   DARIEN are names with nothing behind them.
2. **The b-roll source of truth is out of reach.** `briefs/ugc-broll-library/`
   is in neither reachable repo and isn't a Parker Brain, so this repo reaches
   Gen 2 **through Notion only**, and the general filming rules here are
   reconstructed rather than copied. Reconcile if it is ever attached.
