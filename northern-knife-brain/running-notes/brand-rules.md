# Brand rules — Northern Knife

## How this brand defines winning

- **Primary campaign objective:** Sales. `inferred` from the account itself, 2026-09-07 —
  every campaign in the connected account optimizes to purchase (2,531 lifetime purchases,
  $440,583.28 purchase value). Not separately confirmed by the brand in the intake.
- **North-star metric:** **ROAS.** `stated` by the account owner, 2026-09-07. Current
  reference points: 2.18 over the last 30 days, 2.26 lifetime.
- **Secondary metrics they still weigh:** not stated — see `missing-context.md`.
  Parker will read CPA ($79.57 last 30 days), AOV ($173.60) and hook rate alongside ROAS
  until told otherwise, and will label that choice as its own.
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

  This is a genuinely well-structured account. It means the diversity, iteration and
  persona audits can read strategy directly off the names rather than guessing — the
  personas (`MIKE - BBQ KING`, `JOHN - KNIFE COLLECTOR`) and the offer (`B2G2`) are
  already encoded. Worth confirming with the brand that Parker has read the fields
  correctly; logged as a pending confirmation in `missing-context.md`.

## Unit economics (optional — sharpens every performance read)

- **AOV:** $173.60 last 30 days, $174.07 lifetime. `verified` from the connected account.
- **Gross margin, LTV / payback window, max tolerable CPA:** not provided —
  see `missing-context.md`. Without margin, every "is this profitable" read in this brain
  is a revenue read, not a profit read, and is labelled as such.

## Standing rules gathered since

- `stated` 2026-09-07 — Roadmap review happens **at the end** of the build, not as a
  mid-build pause. The Phase 2 gate honors this.
