# Full buildout — Northern Knife brain

Build started 2026-09-07. Method version `v15`.
One entry per prompt run: source pulled, date, review verdict.

## Phase 0 — repo, scaffold, method mount

| Step | Result | Date |
|---|---|---|
| Brand locked (`2ec32316-1da9-4563-a86f-d4e811e89469`) | done | 2026-09-07 |
| MCP operability check across 6 surfaces | done — surveys dark, all others live | 2026-09-07 |
| Competitive set decided (Parker picks) | done — Coolina, Dalstrong, Odin's Treasures | 2026-09-07 |
| Flat scaffold created | done | 2026-09-07 |
| Method mounted at `parker-system/`, pinned `v15` | done | 2026-09-07 |
| Executable layer shipped (26 skills, 2 agents, 2 scripts, output style, 6 schedules) | done | 2026-09-07 |
| Intake captured to `running-notes/` | done — partial, gaps logged | 2026-09-07 |

## Phase 1E — audit baseline

| Prompt | Source pulled | Date | Verdict |
|---|---|---|---|
| audits-quarterly/90-day-performance-audit | Meta ad account via Parker MCP; 2026-06-09→2026-09-07 (91d) vs 2026-03-11→2026-06-08 (90d) | 2026-09-07 | written, ~5,300 words, six sections + open loops + media appendix |

### Provenance note on the lifetime figures

The run brief handed to the early Phase-1 agents carried **incorrect** account-wide
lifetime figures — $194,644.63 spend / 2.26 ROAS / $174.07 AOV / 1,005 ads. Those came
from the `lifetime_summary` block of a **30-day** query, where that block is scoped to the
rows returned rather than the account. The performance-audit agent caught the mismatch and
flagged it rather than laundering it, which is the review discipline working.

Corrected by an account-wide `metricsMode: lifetime_only` pull on 2026-09-07:

- spend **$497,553.67**, ROAS **2.03**, AOV **$143.15**, purchases **7,066**,
  impressions 38,847,631, CPA $70.42, across **2,431** ad-name groups.
- lifetime demographics: 66.4% male spend, 36.1% on ages 35-44, 98.7% mobile,
  68.4% Facebook / 31.6% Instagram.

`running-notes/brand-rules.md`, `running-notes/missing-context.md` and `BUILD-STATUS.md`
were corrected, and every agent brief from the customer-review audit onward carries the
right numbers plus an explicit instruction to reject the old ones.

The performance audit itself reported a third figure ($404,808.64) for lifetime spend from
its own pull. Its **period** numbers are its own evidence and stand; its lifetime reference
does not match the clean account-wide pull above and should be read as window-scoped.
Resolving that discrepancy is an open item for the next audit refresh.

### Gaps this audit surfaced, now recorded in missing-context.md

- **Placement position is unavailable.** Parker exposes platform and device but not
  `platform_position`, and the connected Meta login does not reach ad account
  `act_1897335644135093`. Feed vs Reels vs Stories reads are not possible.
- **Reach and frequency are not exposed**, so fatigue is inferred from hook-rate and spend
  decay rather than measured.
- Stored AI creative analysis is missing for the five top spenders, so claims about them
  are copy-level only.
- The account reports 4,897 "leads" against 4,887 purchases, which looks mis-mapped; the
  audit declined to use the lead metric.

| personas/ad-account | Meta ad account via Parker MCP; three windows — last 90d, last 30d, and account lifetime | 2026-09-07 | written, ~41KB, frontmatter + sign-off blocks present |

**Note on this doc's figures:** `source-pulls/ad-account.md` was generated from a brief issued
*before* the lifetime-figure correction above, so it cites the old reference points (2.18 /
2.26 ROAS). Its own three-window pulls are its own live evidence and stand; only the quoted
lifetime reference is stale. Re-stamp it on the next refresh.

### Second product-rule conflict, found independently

The ad-account pull surfaced a conflict the build had not yet seen: the account's copy places
the **LOKI Blackout's bottle opener in the blade**, while the brand's hard rules place it in
the **handle**. Together with the Feather laser-applied-versus-hand-etched conflict, that is
two of the three focus products whose live ad copy contradicts the brand's own product law.
Both are for a human to settle. Both carry into `brand-lens.md` at the stamp step.

### The finding worth acting on

The pull's central claim: the account runs a four-persona creative operation, but the
*delivery* does not reflect four personas — a persona label attached to the same headline,
the same body-copy opener, the same offer and the same voice treatment does not differentiate
anything, and differentiation is what buys incremental reach. Product moves the reached
audience by about 15 points; the persona label barely moves it at all.

## Usage-limit stalls

| When | What happened |
|---|---|
| First wave | 12 parallel prompts, all failed on the session cap before writing. Nothing lost. |
| Second wave | 4 parallel prompts. 2 completed and are saved; 3 were killed mid-flight by a second cap (resets 17:10 UTC). The 3 wrote nothing and are back to `pending`. |

The ledger in `BUILD-STATUS.md` is the resume point. Re-running a `pending` prompt costs
nothing extra — none of them had produced output when they died.

## Stamp and close-out — 2026-09-07

| Artifact | State |
|---|---|
| `CLAUDE.md` | stamped from the v15 template, all slots filled, no placeholders. Carries the brand hard rules first, both live product-rule contradictions, the honest phase status (no roadmap exists), and a build-status section listing exactly which docs exist and which were never generated. |
| `README.md` | stamped. Separates the complete working system from the thin knowledge base, so a reader is not misled by a full-looking folder tree. |
| `brand-lens.md` | seeded with the brand's stated voice rules, both unsettled product conflicts, and the four findings the two built documents produced. |
| `running-notes/refresh-schedule.md` | stamped with a `not built` section — a doc that was never generated is distinguished from one that is fresh, which the standard template does not do because it assumes a complete build. |
| `running-notes/routine-log.md` | stamped empty, ready for the first routine run. |
| `competitors/INDEX.md`, `audits/INDEX.md` | not generated — `competitors/` is empty and `audits/` holds one doc. |
| Routines | stamped, **not armed**. See `running-notes/standard-sync.md`. |
| `BUILD-STATUS.md` | archived here as `2026-09-07-BUILD-STATUS-final.md`; repo root left clean. |

**Final state: 2 of 61 in-scope prompt runs completed.** The system layer is complete and verified;
the knowledge layer is two documents deep. The resume point is the archived ledger.
