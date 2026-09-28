---
name: nk-ad-naming
description: Build NorthernKnife ad names (static IMG and video VID) from a brief, a Notion page or a few answers, following the NK naming convention exactly. Use whenever someone asks to name an ad, generate file names, batch names, hook file names, tag a brief, or check or fix an existing ad name.
---

# NK ad naming

You produce ad names for NorthernKnife. A name is a fixed sequence of fields joined by `_`.
Every field except the concept comes from a closed list in the vocabulary files next to this
file. Never invent a value. Never leave a field out. Never reorder. Every value can be overridden
by the person asking, including the ID, date, hook count, body letter and length: apply what they say.

- `vocab-video.json` is the video convention. Video names start `ID_VID_`: write `VID` right after the ID every time, it is not a field anyone picks.
- `vocab-static.json` is the static convention (files ending in `_IMG_…`).

## What to output

For a **video brief**, output three things, in this order:

1. **Batch name**: the full name with `HOOK` and `BODY` written as `H1_A` for the first row
   (the batch is identified by its first hook).
2. **File names**: one line per row of the brief's HOOK table, identical except the hook token
   (`H1`, `H2`, `H3`…) and, if given, the body letter.
3. **Folder name**: `ID_Concept_Type_Product` (example: `NK497_The Only Thing Stopping You_AI-VO_LOKI Blackout`).

For a **static**, output the two names, `…_1x1` and `…_9x16` (and `…_4x5` only if asked).

Then a short **tag sheet**: one line per judgement field with the value and the sentence in the
brief that justifies it. This is how the strategist checks you in ten seconds.

## How to fill each field

Read the whole brief first. Then:

- **Facts** (product, avatar, offer, category, strategist, editor, landing page, market, event,
  type, creator, date): take them from the brief's properties or its text. If a fact is missing,
  ask for it in one line, do not guess. The one exception is the editor: if unknown, write
  `EDITOR` so the editor can replace it.
- **Judgement fields** (angle, hook tactic, structure, tone, proof, offer timing, product reveal,
  voice, face, funnel, source, iteration type): decide from the script using the `rule` text in
  the vocabulary, pick the single best value, and quote the line that justifies it in the tag
  sheet. If two values fit, take the one the brief's own instruction line names (the "inherited
  mechanism" or "persona" callout usually says it outright).
- **Hook tactic** is per hook row: read each hook line separately.
- **Length**: `Len-TBD` until the delivered file's duration is known; then `Len-<seconds>`.
- **Hook and body**: the number is the hook row, the letter is the body cut. A brief with 3 hook
  rows and a first cut gives `H1_A`, `H2_A`, `H3_A`. A hook-only iteration on a locked body
  keeps the body letter of the original.

## Hard rules

1. Delimiter is `_` and only `_`. No underscore inside a value.
2. Never `/ \ : ? * " < > |` inside a value. Replace `/` with `-`, drop the rest. Write `NA`, not `N/A`.
3. Use the exact spelling and capitalisation from the vocabulary. `MIKE`, not `MIKE - BBQ KING`; `6r-General`, not `6 Reasons - General`; `NoOffer`, not `None` or `NA`.
4. Avatar is always one named person. Never `General`, `Multi` or two avatars.
5. Every "none" value has its own spelling: `NoOffer`, `Src-None`, `Ite-None`, `Cre-None`, `Prf-None`, `Off-Absent`, `Face-None`, `Voice-None`. Never bare `None`.
6. Category `New` implies `Src-None` and `Ite-None`. Category `Ite` keeps `Src-None` and requires an `Ite-` type (never put our own ID in the name). Category `Adapt` requires a `Src-` brand.
7. Date is `MM.DD.YY`. If the brief holds a date in another form, convert it.
8. The full name must stay under 400 characters. If it does not, shorten the concept, nothing else.
9. Do not append anything after the last field. No `- Copy`, no `(1)`, no hash, no notes.

## Fixing an old name

When given an existing name to repair: split on `_`, map old labels to new values with the
`rule` text in the vocabulary (the avatar and landing-page rules list the old spellings), keep
the ID, and fill the fields that did not exist by reading the brief. Strip trailing ` - Copy`,
`-1`, `(1)` and 8-character hashes first. Never change the ID.

## Worked example

Brief NK497, "The Only Thing Stopping You - Blackout", AI VO, LOKI Blackout, VANCE, B2G2, Net New,
Mark, Anas, 6 Reasons - General, delivered 09.15.26, three hooks, US, evergreen, adapted from Holo,
offer stated in the first 8 seconds, product named at beat 4, ~105 seconds, male AI voice, no
person on screen.

Batch name:
`NK497_VID_AI-VO_The Only Thing Stopping You_H1_A_LOKI Blackout_VANCE_B2G2_Adapt_Mark_Anas_6r-General_09.15.26_Mkt-US_Evergreen_Fun-TOF_Src-Holo_Ite-None_Cre-None_Objection_Bold Claim_Str-Offer-First_Tone-Urgent_Prf-Count_Off-First_Rev-Mid_Voice-AI-M_Face-None_Len-105`

File names: same with `H1_A`, `H2_A`, `H3_A`. Hook tactic per row: H1 Bold Claim, H2 Callout,
H3 Doubt, so each file name carries its own tactic token.

Tag sheet:
- Angle Objection: "the price objection is inverted on this product… 'that's too cheap to be the real thing'"
- Structure Str-Offer-First: "offer stated immediately, as news"
- Offer timing Off-First: "the offer is live by second 8"
- Product reveal Rev-Mid: "product named" is beat 4 of 13
- Proof Prf-Count: "Over 100,000 people have bought from them"
- Voice Voice-AI-M, Face Face-None: AI VO, no talent on screen
- Source Src-Holo, Category Adapt: "Holo — alpaca compression socks" in AD INSPO

## Self-check before answering

- [ ] Field count equals the `order` list in the vocabulary.
- [ ] Every value exists in the vocabulary (or is the concept, the ID, the date, the length).
- [ ] One avatar, one angle, one structure.
- [ ] No banned characters, no trailing junk, under 400 characters.
- [ ] The tag sheet quotes the brief for every judgement field.
