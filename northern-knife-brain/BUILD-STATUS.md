# Northern Knife — brain build status

**Brand:** Northern Knife (`2ec32316-1da9-4563-a86f-d4e811e89469`)
**Build started:** 2026-09-07
**Method version:** parker-system pinned to `v15`
**Scope:** foundation only — Phase 0 and Phase 1, then stamp and hand off
**Current phase:** Phase 1 — audit and foundation
**Right now:** Wave 4, running two prompts instead of four: the 90-day creative-strategy audit (the anchor) and the 90-day diversity audit. Both were lost mid-write to the last cap. Both briefs now carry an explicit instruction to write a draft to disk early and enrich it in place, so a cap costs an unfinished document rather than everything.

**Waiting on you:** nothing.

---

## The scope decision — read this before wondering where strategy went

This build stops after Phase 1, by the owner's decision on 2026-09-07, and the competitor
branch is trimmed. Two reasons, both practical:

1. **Usage.** A first wave of twelve parallel prompts hit the session cap and all twelve
   failed at once, before writing anything. The build now runs four at a time. The full
   97-run build would have spanned several usage windows.
2. **Value density.** Phase 1 is what makes every later skill smarter — it is the brand
   knowledge the craft skills read from. Strategy and briefs can be produced on demand
   afterwards, by a person, using skills that are already installed and working.

**What is deliberately NOT built here**, and how to get it later:

| Not built | How to get it |
|---|---|
| `strategy/` — persona / product / messaging / creator inputs, and the strategic roadmap | Re-run `parker-system/prompts/strategic-roadmap/*` when you want a committed direction. Everything they read from will exist. |
| `idea-bank/` — the captured, graded idea pile | Run `/harvest-ideas`, then `/evaluate-ideas`. Both are installed and armed on a weekly schedule. |
| `sprints/`, `briefs/` — the sprint plan and the briefs | Run the `scriptwriting`, `hooks`, `headlines` and `iterations` skills directly, or re-run `parker-system/prompts/ideas-and-briefs/*`. |

None of this is a dead end. The folders exist, the prompts that fill them are mounted at
`parker-system/prompts/`, and the routines that would call them are armed. The one real
consequence is that no strategic roadmap has been written, so anything that claims to
follow "the approved direction" has no direction to follow yet.

**Competitor branch, trimmed:** Coolina USA and Dalstrong get a full `competitor-snapshot`
rather than nine deep slices each; Odin's Treasures gets one as inspo; the cross-rival
`working-thesis-synthesis` still runs. Twenty-one runs become four. The reason is honest —
only two rivals are tracked in this brand's Meta library, so nine slices each would be deep
analysis of a thin set. Widen the tracked set in the Parker app and the full slice set
becomes worth running.

---

## Scoreboard

| Phase / branch | Done | Total |
|---|---|---|
| Phase 0 — repo, scaffold, method mount | 7 | 7 |
| Phase 1E — audit baseline | 2 | 17 |
| Phase 1A — brand foundation | 0 | 14 |
| Phase 1B — competitors (trimmed) | 0 | 4 |
| Phase 1C — personas | 2 | 12 |
| Phase 1D — voice of customer | 0 | 12 |
| Phase 1 — synthesis (gaps, open loops) | 0 | 2 |
| Stamp, verify, arm routines, hand off | 5 | 6 |

**61 prompt runs in scope**, down from 97.

---

## What the data check found

Run before the build, so the ledger below is honest about what each prompt can reach.

| Surface | State | What it means |
|---|---|---|
| Meta ad account | **live** | 2,431 ad-name groups, $497,553.67 lifetime spend, 2.03 lifetime ROAS, $143.15 lifetime AOV, 7,066 purchases, one account (`NorthernKnife_UK_3`, USD, Europe/London). Placement position and frequency are not exposed. |
| Customer reviews | **live** | 4,028 reviews, 4.93 average |
| Facebook ad comments | **live** | current through 2026-09-06 |
| TikTok / organic inspiration | **live** | 50 videos in the library |
| Competitor ad library | **live, thin** | 2 tracked brands only: Coolina USA (297 ads), Dalstrong (496 ads) |
| Post-purchase surveys | **dark** | zero responses — logged in `running-notes/missing-context.md` |
| Parker chat history | **none** | no prior web or Slack threads to read in |
| Northbeam | **not connected** | performance is read in Triple Whale instead |

---

## Prompt ledger

`pending` → `running` → `done`, or `blocked` with a reason.

### Phase 1E — audit baseline (the t0 read of the account)

| Prompt | Status |
|---|---|
| audits-quarterly/90-day-creative-strategy-audit | running |
| audits-quarterly/90-day-performance-audit | done |
| audits-quarterly/90-day-diversity-audit | running |
| audits-quarterly/customer-review-audit | done |
| audits-quarterly/quarterly-whitespace-analysis | pending |
| audits-monthly/monthly-hook-audit | pending |
| audits-monthly/monthly-performance-report | pending |
| audits-monthly/monthly-organic-tiktok-audit | pending |
| audits-monthly/monthly-tiktok-mining | pending |
| audits-biweekly/biweekly-iterations-report | pending |
| audits-weekly/weekly-performance-snapshot | pending |
| audits-quarterly-external/90-day-creative-strategy-audit-external | pending |
| audits-quarterly-external/90-day-performance-audit-external | pending |
| audits-quarterly-external/90-day-diversity-audit-external | pending |
| audits-quarterly-external/single-competitor-ad-analysis (Coolina) | pending |
| audits-monthly-external/monthly-creative-landscape | pending |
| audits-monthly-external/monthly-top-impressions-report | pending |

### Phase 1A — brand foundation

| Prompt | Status |
|---|---|
| brand-profile/brand-identity-analysis | pending |
| brand-profile/website-and-product-audit | pending |
| brand-profile/category-and-market-research | pending |
| brand-profile/competitive-landscape | pending |
| brand-profile/customer-journey-and-persona-discovery | pending |
| brand-profile/reputation-analysis | pending |
| brand-profile/community-and-forums | pending |
| brand-profile/visual-vocabulary | pending |
| brand-profile/marketing-calendar-and-campaigns | pending |
| brand-profile/operations-and-team | pending |
| brand-profile/ad-account-evaluation (← audits) | pending |
| brand-profile/performance-targets-and-metrics (← audits) | pending |
| brand-profile/organic-channels-inventory (← audits) | pending |
| brand-profile/brand-profile-narrative (← all of 1A) | pending |

### Phase 1B — competitors (trimmed to 4)

| Prompt | Status |
|---|---|
| competitor-profile/competitor-snapshot — Coolina USA | pending |
| competitor-profile/competitor-snapshot — Dalstrong | pending |
| competitor-profile/competitor-snapshot — Odin's Treasures (inspo) | pending |
| competitor-profile/working-thesis-synthesis + `_competitive-set.md` | pending |

### Phase 1C — personas

| Prompt | Status |
|---|---|
| personas/ad-account | done |
| personas/ad-comments | pending |
| personas/customer-reviews | done |
| personas/other-reviews | pending |
| personas/post-purchase-surveys | blocked — no survey responses exist for this brand |
| personas/reddit | pending |
| personas/brand-reputation | pending |
| personas/brand-self-echo-detection | pending |
| personas/personas-profile (← all sources) | pending |
| personas/persona-voice-library | pending |
| personas/lifecycle-journey-maps | pending |
| personas/cross-persona-bias-notes | pending |

### Phase 1D — voice of customer

| Prompt | Status |
|---|---|
| voice-of-customer/voc-corpus-profile | pending |
| voice-of-customer/voc-pain-phrase | pending |
| voice-of-customer/voc-outcome-phrase | pending |
| voice-of-customer/voc-trigger-moment | pending |
| voice-of-customer/voc-objection | pending |
| voice-of-customer/voc-surprise-delight | pending |
| voice-of-customer/voc-aspirational | pending |
| voice-of-customer/voc-metaphor | pending |
| voice-of-customer/voc-category-jargon | pending |
| voice-of-customer/voc-anti-language | pending |
| voice-of-customer/voice-of-customer-assembly | pending |

### Phase 1 — synthesis

| Prompt | Status |
|---|---|
| market-synthesis/gaps-opportunities-inspo | pending |
| open-loops/open-loops-roll-up | pending |

---

## Build history — three sessions of the same wall

| Wave | Concurrency | Outcome |
|---|---|---|
| 1 | 12 | all 12 killed by the session cap before writing. Nothing lost. |
| 2 | 4 | 2 completed and saved; 3 killed by a second cap (reset 17:10 UTC). |
| 3 | 4 | 2 completed and saved; 2 killed by a third cap (reset 22:30 UTC) *while writing* — they finished their research and lost it. |

**The pattern is now clear and worth acting on next time.** Four agents in parallel exhaust the
window before any of them can finish writing. Waves 2 and 3 each produced exactly two documents and
threw away the research of the others. **Next resume should run one or two prompts at a time, not
four** — fewer completed documents per window beats four abandoned ones.

Between waves 2 and 3 the brain was stamped — contract, README, lens, freshness ledger — so it was
coherent and openable rather than a half-built folder. That stamping stands; this wave adds
knowledge to an already-working system. `CLAUDE.md` and `README.md` describe which docs exist, so
**they need re-checking each time a wave lands** — they currently name only two documents.

## Needs attention

- **The build is usage-limited, and that is the pacing constraint.** The first wave of
  twelve parallel prompts hit the session cap and all twelve failed at once. Nothing was
  corrupted and nothing was lost — they failed before writing. Four at a time now. If the
  cap is hit again the fix is the same: wait for the window, resume from this ledger.
  Every `pending` item is still to do; every `done` item is safe on disk.
- **Post-purchase surveys are empty.** `personas/post-purchase-surveys` is blocked and
  everything downstream is one source thinner. Upload a CSV or connect a survey platform
  in Parker, then re-run that prompt.
- **Only two competitors are tracked.** Which is why the competitor branch is trimmed.
  Add your real rival set in the Parker app to make the full slice set worth running.
- **A live contradiction on the Feather, for a human to settle.** The brand's own rules say
  the blade pattern is laser-applied and must never be called hand-etched. The account's
  top-spending ad (`NK222`, $15,050.74 in 30 days) says *"hand-forged with an insane feather
  etching down the spine, no two blades identical. Each one takes hours to create by hand."*
  Either the rule moved or the ad is off-brief. Carried in
  `running-notes/brand-notes-from-org.md`, due to land in `brand-lens.md` at the stamp step.
- **This brain is not in its own repo.** Parker provisioned
  `parker-brain/nebula-studio-northern-knife`, but this cloud session cannot reach it — its
  GitHub access is locked to the `creativetstrategist-mark` tier and cross-tier attachment
  is refused outright. The brain lives in the `my-client` repo instead. See
  `running-notes/standard-sync.md` for the three ways to move it later.

## What happens next

The audit baseline finishes first, because the account one-pagers are defined as syntheses
of it. Personas, voice-of-customer and the foundation slices run alongside. Then the two
synthesis nodes, then the contract gets stamped, the routines armed, and the brain handed
over with a walkthrough.
