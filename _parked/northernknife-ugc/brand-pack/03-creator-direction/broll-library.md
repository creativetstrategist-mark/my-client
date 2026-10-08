# B-roll — how selection works

**There is no b-roll list in this repo.** Shots live in the Gen 2 libraries
and this repo selects from them. The earlier "8 shared clips per batch" model
was wrong and is gone.

Authoritative behaviour: process doc **Section E**.

## The shape of the library

`Knives — B-Roll Library` — 102 live rows when last read (2026-10-08).
Each row carries:

- **Shot ID** — `KNF-<CODE><NN>`. Live codes: `ACT` `BF` `CT` `CUT` `DM`
  `GF` `OF` `PROD` `PS` `RX` `SK` `XM`. Sharpener shots use `SHP-`.
  The code is **historical, not derived from the category** — `CUT` and `DM`
  both sit under Cutting Demos, `PROD` and `PS` both under Product &
  Packaging, and `XM` spans four categories.
- **Category** (8): Bad-Gift Setup · Gifting · Cutting Demos ·
  Product & Packaging · Reactions · Skits / Comedy · Offer / Promo ·
  A-Roll / CTA
- **Priority**: P1 must-have · P2 strongly wanted · P3 bonus
- **Cast**: Hands only · Solo · Couple · No cast
- **Funnel**: Hook · Problem · Proof · Payoff · CTA
- **Block** (holiday shoot order): A Set dressing · B Wrapping · C Reveal ·
  D Cooking · E Offer · F Skits · G A-Roll
- **Knives** — 23 options mirroring every live knife on the site as of
  2026-10-06. `All knives` means the shot works with any of them, no re-shoot.
- **Campaign**, **Andy Approved**, **Status**, **Include in:** (Trybe packs)

## Rules for building a package

1. **Never mint a shot ID.** Query the library; use what comes back.
2. **Check the row is live.** A `notion-fetch` of an archived page still
   returns its properties and is only flagged `deleted` in the response
   header — easy to miss. SQL over the collection returns live rows only,
   so prefer a query.
3. **12–25 shots**, mixing campaign and evergreen.
4. **Respect Cast.** A solo creator can't shoot a Couple shot.
5. **Lead with P1.** Build from the P1 must-haves, then add P2/P3 that match
   the creator's situation.
6. **Fill both fields** on the script row — the `B-roll IDs` text and the
   `B-roll shots` relation must agree.

## Known breakage (2026-10-08)

Most b-roll references on the existing 24 script rows are **dead**. The
library page advertises `KNF-XM01`–`KNF-XM66`; only 9 `KNF-XM*` rows are live.
Of the 15 IDs on `XM-GT-FTH`, only `KNF-XM12` resolves.

The library also looks mid-migration: 29 of 102 rows are assigned to
`Include in:` Trybe packs and a sibling page is titled *"(merged into Trybe
B-Roll Packs, safe to delete)"*. **Don't build new packages on `KNF-XM*`
numbering.**

Re-resolve any package before a creator is sent it. Neither defect is this
repo's to fix unilaterally — flag them.

## Per-product framing notes

- **Feather** — the pattern is the hero: clean blade, no fingerprints, slow
  travel along the steel. **Never** stage anything implying hand work on it
  (no engraving tools, no workbench), and never explain it in words.
- **BJORN Santoku** — brass bolster with soft side light; carved handle
  showing the carving. **No styling that signals Japanese origin**: no kanji
  packaging, no sushi or sashimi plating, no Japanese ceramics.
- **LOKI Blackout** — ebony handle **against a light board**, or it vanishes.
  Frame the opener so the **handle** is unmistakably the opener. The black box
  and its magnetic closure are the gift beat.
