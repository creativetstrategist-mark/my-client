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
