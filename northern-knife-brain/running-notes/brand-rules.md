# Brand rules — Northern Knife

## How this brand defines winning

- **Primary campaign objective:** Sales. `inferred` from the account itself, 2026-09-07 —
  every campaign in the connected account optimizes to purchase (7,066 lifetime purchases,
  $1,011,464.66 purchase value). Not separately confirmed by the brand in the intake.
- **North-star metric:** **ROAS.** `stated` by the account owner, 2026-09-07. Current
  reference points: **2.18 over the last 30 days, 2.03 lifetime** (`verified`, account-wide
  lifetime pull 2026-09-07). Lifetime spend $497,553.67 on 38,847,631 impressions.
- **Lifetime figures, refreshed 2026-09-10** (`verified`, same account, `lifetime_only` pull):
  **$507,487.66 spend, 2.03 ROAS, $143.74 AOV, 7,169 purchases, $1,030,457.99 purchase value,
  2,526 ad-name groups, 39,500,116 impressions, $70.79 CPA.**

  > **Both sets are correct — do not treat this as a discrepancy.** The 2026-09-07 numbers
  > ($497,553.67 / 7,066 / 2,431) are the anchor most documents in this brain were built on and
  > they stay valid *as of that date*. The 2026-09-10 set is three days of normal accrual on top:
  > **+$9,933.99 spend (~$3,311/day), +103 purchases, +95 ad-name groups**, with ROAS unmoved at
  > 2.03. A sweep that flags the older set as "wrong" is a false alarm — the discredited sets are
  > still only $194,644.63 / 2.26 / $174.07 / 2,531 / 1,005 and $404,808.64 / 2.17 / $148.20.
  > **Cite the pull date alongside any lifetime figure**, because this account moves ~$3.3k a day.
- **Efficiency target: 2.0 ROAS.** `stated` by the brand owner, 2026-09-10 — *"below 2 ROAS is
  not profitable."* Never present a ROAS figure in this account without saying where it sits
  against 2.0, **and say which ROAS you mean** (see the next line — it changes the answer).
- **True contribution breakeven: ~1.68 (UK) / ~1.74 (US).** `verified from Triple Whale`,
  2026-09-10. Contribution margin is **59.68% (UK)** and **57.48% (US)**, configured in Triple
  Whale and pulled live. So the stated 2.0 is a **target carrying overhead and profit**, not a
  break-even line, and an earlier inference in this brain that put the margin near 50% was
  8–10 points too pessimistic — corrected everywhere. Quote both numbers: 2.0 is where the brand
  wants to be, ~1.7 is where a Meta dollar stops paying for its own goods.
- **Meta ROAS and blended ROAS are not the same number, and blended reads HIGHER.** 90 days to
  2026-09-07: UK 2.23 on Meta against 2.39 blended; US **1.68** on Meta against 2.83 blended.
  `verified from Triple Whale`. On the US store that gap decides the answer, so a bare "ROAS"
  with no metric named is not a usable statement in this account. Full reconciliation:
  `audits/2026-Q3/attribution-reconciliation.md`.
- **Secondary metrics they still weigh:** not stated — see `missing-context.md`.
  Parker will read CPA ($79.57 last 30 days, $70.42 lifetime), AOV ($173.60 last 30 days,
  $143.15 lifetime) and hook rate alongside ROAS until told otherwise, and will label that
  choice as its own. Note the AOV gap between the recent window and lifetime — the last 30
  days run about 21% above the lifetime average, which is worth a look on its own.
- **When two ads in one ad set diverge on spend:** rule not stated — see `missing-context.md`.
- **Where performance gets read:** **Triple Whale.** `stated` 2026-09-07 (Northbeam was
  checked and is not connected). Note the consequence: the numbers in this brain's audits
  come from Meta's own reporting through the Parker MCP, under the account's per-ad-set
  attribution (7-day click / 1-day view). Those will not tie out exactly against Triple
  Whale's pixel attribution. Where a read cites a number, it cites Meta's.

## How the account is organized

- **Ad naming convention:** not walked through in the intake, but the account uses a
  consistent and unusually rich pattern that Parker has parsed from the ad names themselves
  (`inferred`, 2026-09-07). Observed structure:

  `NK[id]_[FORMAT]_[concept name]_[variant code]_[targeting]_[product]_[voice]_[PERSONA]_[offer]_[iteration or net-new]_[strategist]_[editor]_[landing page]_[date]`

  Worked example — `NK222_VID_Return Feather Lunatic_1B_Generalist_Feather_AI VO_MIKE - BBQ KING_B2G2_Iteration_Andy_Hammad_PDP_080326`:

  | Segment | Meaning |
  |---|---|
  | `NK222` | sequential concept id |
  | `VID` | format — video |
  | `Return Feather Lunatic` | concept / hook name |
  | `1B` | variant code within the concept |
  | `Generalist` | targeting or audience treatment |
  | `Feather` | product — Feather, Santoku, LOKI Blackout |
  | `AI VO` | voice treatment — AI voiceover |
  | `MIKE - BBQ KING` | persona the creative targets |
  | `B2G2` | offer — buy 2 get 2 |
  | `Iteration` / `Net New` | whether it is a new concept or an iteration |
  | `Andy` | strategist |
  | `Hammad` / `Renniel` | editor |
  | `PDP` / `6 Reasons - Santoku` | landing page |
  | `080326` | date |

  This is a well-structured account, and the convention is a real asset — but it is **not
  a reliable substitute for reading the creative.** Two limits, both found in the data:

  > ⚠️ **The offer field is unreliable.** `verified` 2026-09-08, from the creative-strategy
  > audit. `NK300`'s name carries `NA` in the offer position while its third on-screen card
  > reads "Buy 2 Get 2 FREE." Any offer-level read taken from ad names alone will be wrong,
  > and wrong in a predictable direction — it will under-count offer-led creative. Read the
  > creative, or treat name-derived offer figures as a floor.
  >
  > ⚠️ **The persona field records intent, not outcome.** The names say which persona a
  > creative was written for. They say nothing about who it actually reached — and the
  > ad-account pull found the two diverge badly (product moves the reached audience about
  > 15 points; the persona label barely moves it). Never read the persona field as delivery.

  Worth confirming the whole reading with the brand; logged in `missing-context.md`.

## Unit economics (optional — sharpens every performance read)

- **AOV:** $173.60 last 30 days, **$143.15 lifetime**. `verified` from the connected
  account (account-wide lifetime pull, 2026-09-07).

  > **Correction, 2026-09-07.** An earlier version of this file cited $174.07 lifetime AOV,
  > $194,644.63 lifetime spend and 2.26 lifetime ROAS. Those were wrong: they came from the
  > `lifetime_summary` block of a 30-day query, where that block covers only the rows
  > returned, not the whole account. Any doc in this brain generated before this correction
  > and citing those figures is citing a three-ad sample as if it were the account. The
  > correct account-wide lifetime figures are the ones above.
- **Gross margin, LTV / payback window, max tolerable CPA:** not provided —
  see `missing-context.md`. Without margin, every "is this profitable" read in this brain
  is a revenue read, not a profit read, and is labelled as such.

## Standing rules gathered since

- `stated` 2026-09-07 — Roadmap review happens **at the end** of the build, not as a
  mid-build pause. The Phase 2 gate honors this.
