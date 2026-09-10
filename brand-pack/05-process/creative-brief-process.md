# Creative brief process

Authoritative for how a NorthernKnife video brief is written and how it is
built as a page in the Notion **Video Brief Database** (the inline database is
titled **Evergreen Video**; Andy calls the whole thing either name).

> **This document drifts.** The live Notion template is edited faster than this
> file is updated. Section D is a transcription with a date on it, not a spec.
> Open the live default template page and diff before every batch. See C.7.

---

## A. Scope and sources

| | |
|---|---|
| Live database | Evergreen Video, `collection://2cf4ac62-7aac-81a8-86bf-000b96778943` |
| Parent page | Video Brief Database, `2cf4ac62-7aac-80bb-9f71-e0542c06ef30` |
| Default page template | `2d64ac62-7aac-808e-8149-d1026291f47c` |
| Workspace root | NK Creative Strategy Lab, `2e84ac62-7aac-805a-bde8-f04e1820d4ea` |
| Section D transcribed | 2026-09-10 (template last edited 2026-09-03) |

---

## B. The daily routine

1. Search the TrendTrack "inspo" favorites folder for ad inspiration.
2. Pick 5 ads **not already in `daily-ad-rewrites/processed-inspo-log.md`**.
3. Rewrite each of the 5 for all 3 focus products — 15 briefs.
4. Create one Notion page per brief in Evergreen Video, matching Section D.
5. Append the day's ad ids to the dedup log; commit and push.

If the Notion connector is unavailable in a run, **say so explicitly**. Do not
silently skip delivery.

---

## C. Copy voice rulebook

### C.1 Banned spec-sheet language

Zero of these appear in any ad the brand has shipped. They are banned outright.

| Never write | Write instead |
|---|---|
| Alloy codes — `5Cr15MoV`, `AUS-10V`, `VG10`, `1080` | "high-carbon steel" |
| `HRC` / Rockwell numbers | "holds that edge" |
| "edge retention" | "stays sharp for months" |
| "blade geometry" | "the shape of the edge" — or cut the sentence |
| Gram weights, mm dimensions | "light as air" / "10-inch" only where it is a product name |
| "offer page" | name the offer itself |

The substitution pattern is always **plain material + the consequence**:

> "hand-forged from high-carbon steel with a razor's edge that stays sharp for
> months."

Two persona pages list banned terms in their own "words that convert" lists —
JOHN has `blade geometry`, MIKE has `edge retention`. **Those pages are wrong.**
See C.6.

### C.2 Hooks

- 2–3 sentences, ~19–30 words.
- **The second sentence must turn against the first.** This is the load-bearing
  mechanic, not a preference.

> "We had a customer send back his LOKI Viking yesterday. Not because it was
> bad — because our timing was."

### C.3 The offer resolves the subject, it never replaces it

- Whatever the hook raises, the body pays off **before** any offer appears.
- The offer lands **~60–80% through**. Never first. Never last.
- **2–4 more beats must follow it.**
- Only real offers exist: **B2G2, B2G1, B1G1, 64% off, 56% off,
  40% + Free Gifts**. Never invent one.
- Current storewide as of the last performance review: **Buy 2 Get 2 Free +
  free shipping**. **Verify per campaign — never carry a previous offer over.**
- **No discount codes in copy.**
- An offer *tag* on the page does not mean the offer goes in the script. NK130
  is B2G2-tagged and states no offer in copy at all — at 2.70 ROAS.
- **Never reuse the identical offer paragraph across product versions in the
  same batch.**

B2G2 beats B2G1 by ~48% on video (1.84 vs 1.24) and B2G1 is still the largest
bucket in the account. Prefer B2G2 unless told otherwise.

### C.4 Closes

Fixed shape: **CTA → proof stack → parting jab that loops back to the hook.**

The proof stack is house language, used close to verbatim:

> "100,000 customers. Lifetime warranty. 30-day money-back trial. Free returns.
> Free shipping."

### C.5 Register

- Blunter and more fragmented than feels safe.
- Contractions always.
- Name concrete enemies — "dollar-store knives", never "inferior knives".
- Brand in third person is allowed: "those crazy hooligans at Northern Knife."
- Food cuts **"like butter"** — every time.
- **Delete on sight:** "here's the best part" · "let's do the math" · any
  sentence that explains our own pricing to the viewer.

### C.6 Where the persona docs are wrong

`What's Worked YTD 2026` §9 states the standing rule directly: the persona
pages contain evidence-free claims, and **where they conflict with the real ad
corpus, the corpus wins.** Known conflicts, carried into `02-personas/` as
inline warnings:

| Persona page says | Corpus says |
|---|---|
| JOHN converts on "blade geometry" | Banned term (C.1). Never appeared in a shipped ad. |
| MIKE converts on "edge retention" | Banned term (C.1). Same. |
| MIKE responds to "1080 carbon steel" | Alloy codes banned (C.1). Say "high-carbon steel". |
| VANCE's mechanism is B2G1 | B2G2 outperforms B2G1 by ~48% on video. |
| Feather is JOHN-only (repo `CLAUDE.md`) | NK222 is a Feather × MIKE US Winner. |
| JOHN "recoils from aggressive multi-unit / B2G1 framing" | NK133 and NK184 are both JOHN × Feather × **B2G2** winners. Multi-unit framing is not disqualifying for him; *discount-led* framing is. |

Treat the persona pages as register and vocabulary guides. Treat the corpus as
the authority on what actually converts.

### C.7 Template drift — documented history

This section exists because the drift is real and recurring.

- The live default template's persona callout labels the Opportunist
  **"DON - OPPORTUNIST"**. The actual Opportunist avatar is **VANCE**; DON is
  The Hunter, a separate and newer persona in the same callout, further down the
  same block. Two different people under one name in one callout.
- That same callout still describes the Opportunist offer as **B2G1**
  ("Buy 2 Get 1 Free — only this persona have this offer") while the shipped
  VANCE briefs and the storewide offer are both **B2G2**.
- The template's `HOOK` table has **3 columns** (Visual / Copy / Note). Shipped
  briefs frequently add a 4th **Variant** column to carry 1D/2D/3D — see
  NK420 in `04-winning-briefs/`. The `BODY` table sometimes gains a leading
  **Block** column — see NK306.
- The template ends with a bare bolded **`CTA`** label and no table. No shipped
  brief in the current sample uses a separate CTA table; the CTA is the last row
  of the BODY table.

**None of these are errors to correct in the live template.** They are drift to
be aware of when reading it. Match the *shipped briefs* for table shape, and
match the *live template* for block order.

---

## D. The live Notion video-brief template — block by block

Transcribed from the default page template `2d64ac62-7aac-808e-8149-d1026291f47c`
on 2026-09-10.

### D0. Exact block order

Build a new page's content in this order. Blocks marked *(optional)* are absent
from some shipped briefs.

1. **Untitled 2-column table** — 2 rows:
   - `Batch name` | *(the full batch string, see D.3)*
   - `Folder name` | *(ID_Concept_Specialty_Product)*
2. Plain text line: **`File naming`**
3. **Single-column table** — one row per deliverable variant (see D.3).
   Template ships 5 empty rows; use as many as you have variants.
4. `### AD INSPO` — heading 3, followed by the inspo embed
   (`<video src="">` in the template; shipped briefs use an
   `<embed>` of the TrendTrack share link).
5. **Persona callout** — 💡 grey background. Carries the avatar notice for
   whichever persona the brief targets. Trim to the one persona in play; the
   template ships with several stacked.
6. `### GENERAL INSTRUCTION` — heading 3, then the standing bullets:
   - Always apply the 3-4 sec rule: changing of visual every 3-4 sec to avoid
     boring moment.
   - Avoid awkward moment, remove dead air on the audio.
7. `### GLOSSARY:` *(optional — present in template and in NK306, absent from
   NK420)* — heading 3, then:
   - TC = Time Clips
   - Super = Black text with White textbox
   - Caption = White text with Black textbox
   - "Broll Clip…" = we have this in our creative bank
   - "Clip of…" = source via Envato / YouTube / any platform
   - "Generate on Higgsfield" = generate it, but check the Frame.io folder first
8. `---` divider
9. `## Creative Brief Instruction` — heading 2. Free prose: the strategic
   instruction to the editor. Voice direction, what is locked, what is new.
10. **VO callout** — 💡 grey background, standing note:
    *"For VO generation on elevenlabs use the V3 model and click enhance to
    inject emotion tags."* plus the Loom link.
11. Bold text: **`HOOK`**
12. **HOOK table**, header row, **green** header background.
    Template columns: `Visual` | `Copy/ Text Overlay` | `Note`.
    Shipped multi-variant briefs prepend a `Variant` column (`1D — Drama`,
    `2D — Curiosity`, `3D — Benefit`). One row per hook variant.
13. Bold text: **`BODY`**
14. **BODY table**, header row, **orange** header background.
    Template columns: `Visual` | `Copy/ Text Overlay` | `Note`.
    NK306 prepends a `Block` column. One row per beat.
15. Bold text: **`CTA`** *(template only — shipped briefs fold the CTA into the
    final BODY row instead; follow the shipped pattern)*

### D.1 Page properties

Set on creation. `Concept Name` is the title property.

| Property | Type | Notes |
|---|---|---|
| `Concept Name` | title | Short, 2–3 words, memorable. "Yeah Guy", "Already Paying", "Red Flags". |
| `Creative ID` | text | `NK###`. Template default is the bare string `NK`. Series was at NK420 on 2026-09-05. Take the next unused number. |
| `Format` | select | `VID` (also `GIF`, `LFC`). Template default `VID`. |
| `Product` | select | `Feather` · `SANTOKU` · `LOKI Blackout` for this routine. |
| `Avatar` | select | Exact strings: `JOHN - KNIFE COLLECTOR` · `MIKE- BBQ KING` · `SARAH - THE WIFE` · `VANCE- The Opportunist`. **Note the irregular spacing — these are the literal option names.** |
| `Offer` | select | `B2G2` · `B2G1` · `B1G1` · `64%OFF` · `56%OFF` · `40% + Free Gifts` · `NA` |
| `Category` | select | `Net New` · `Iteration` · `Adaptation`. A TrendTrack rewrite is `Adaptation`. |
| `Status` | status | Start at `Not started`. |
| `Strategist` | select | `Claude` when the routine authors it. |
| `Specialty` | text | Free text. `Generalist` is the common value. |
| `Content` | text | e.g. `AI VO`. |
| `Landing Page` | select | `PDP` · `Offer Page` · `6 Reasons - General` · `6 Reasons - Outdoor` · `6 Reasons - Sharpener` · `6 Reasons - Santoku` |
| `Date` | date | Brief date. |
| `Editor` | select | Leave empty — assigned by a human. |
| `Iteration`, `German 🇩🇪` | checkbox | Default unchecked. |
| `Test Results`, `Claude WR`, `Delivery Link` | — | Leave empty. Filled after the ad runs. |

Page icon: **📽️** — every page in the database uses it.

### D.2 Creative ID series

Video is `NK###`. Seasonal prefixes exist and are **not** for this routine:
`NKFD` Father's Day · `NKMD` Memorial Day · `NKEOFY` Australian EOFY. Statics
use a separate 3-digit series.

### D.3 Naming strings

**Batch name** — underscore-joined. The concept slot takes the `Concept Name`
property **verbatim**, including any ` - Product` suffix it carries:

```
NK###_Concept_Specialty_Product_Content_Avatar_Offer_New_Strategist_Editor_LandingPage
```

> `NK455_A Day vs Three Months - Feather_Generalist_Feather_AI VO_JOHN - KNIFE COLLECTOR_B2G2_New_Callum_Naveed_6 Reasons - General`

**Folder name** — the first four fields only:

```
NK###_Concept_Specialty_Product
```

**File naming** — one row per variant. Format and the variant code go in after
the ID. The last two fields are **date, then landing page**:

```
NK###_VID_Concept_<variant>_Specialty_Product_Content_Avatar_Offer_New_Strategist_Editor_MMDDYY_LandingPage
```

The field order in full: ID · format · concept · variant · specialty · product ·
content type · avatar · offer · new/iteration · strategist · editor · **date** ·
**landing page**.

> ⚠️ **The shipped corpus contradicts this.** NK420 and NK455 both end
> `..._Editor_LandingPage_MMDDYY` — landing page *then* date. The order above is
> the standard as given by the strategist on 2026-09-10. Follow it, and expect
> the old order in anything before NK458.

**Editor slot.** When no editor is assigned yet, write the literal string
`EDITOR` into the naming strings and leave the `Editor` property blank. The
producer fills both when the brief is assigned.

### D.3.1 The variant code

Each variant is a **number plus a letter**. Neither is a sequential label — both
carry meaning.

- **Number** — the hook variation ID. 1, 2, 3 for the first, second, third hook.
- **Letter** — the **awareness level** that hook is written for.

| Letter | Awareness level |
|---|---|
| A | Unaware |
| B | Problem aware |
| C | Solution aware |
| D | Product aware |
| E | Most aware |

So `1B` is hook variation 1 written at problem aware; `3D` is hook variation 3
at product aware.

Letters that match across a concept mean three angles tested at one awareness
level — NK420 ships 1D/2D/3D, all product aware, because the ad answers price
objections from people who already know the brand. Letters that differ mean the
same story tested across the funnel.

In the HOOK table's `Variant` column, write **the code alone** — `1A`, `2C`,
`3D`. No angle label, no awareness label. Older briefs append the angle (NK420
ships `1D — Drama`); the bare code is the current standard. The angle belongs in
the `Note` column with the rest of the direction.

### D.4 A real brief is short

No strategy prose on the page. Rationale goes in conversation, not the work
order. The `Creative Brief Instruction` block is direction to the editor — what
to lock, what voice, what device — not an argument for the concept.

---

## E. Product accuracy

See `01-brand/product-catalog.md` for the full table. The three that govern this
routine:

- **Feather** — laser-applied pattern; never describe the technique.
- **BJORN Santoku** — never the word "Japanese", in any usage.
- **LOKI Blackout** — opener in the **handle**.

Brand-level claims ("100,000+ customers") are portable across products.
Per-SKU review counts are not.

---

## F. The originality gate

**The mechanic transfers. The words never do.**

Take the inspo ad's structure — hook type, pacing, beat order, the device. Every
sentence gets rewritten fresh. No verbatim source language, not even for an
identical beat. This is the most-repeated correction in the brand's history.

The live gate is a script, `check_originality.py`, which **hard-fails on 6+
consecutive shared words**. It checks against the inspo *and* against
NorthernKnife's own live copy — and reuse of our own copy is the more common
failure of the two.

**If no script is available to run, apply the same test by hand:**

1. Take each sentence of the draft.
2. Compare against (a) the inspo transcript, (b) any brief in
   `04-winning-briefs/`, (c) the other two product versions in the same batch.
3. Any run of **6 or more consecutive identical words** fails. Rewrite the beat.
4. House language is the deliberate exception: the proof stack (C.4) and the
   offer mechanics are meant to repeat. The *sentences around them* are not.

Check the offer paragraph specifically — writing three product versions off one
inspo in one sitting is exactly the condition that produces three identical
offer paragraphs. That is banned outright (C.3).

---

*Sources: Notion default page template `2d64ac62-7aac-808e-8149-d1026291f47c` (last edited 2026-09-03); Evergreen Video schema; `What's Worked YTD 2026` §6 and §8; shipped briefs NK420 and NK306. Transcribed 2026-09-10.*
