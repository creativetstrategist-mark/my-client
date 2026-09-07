# Refresh schedule — Northern Knife

This is the one place that tracks when every standing doc was last run and when it is due to be
re-run. Each doc's own `generated_on` / `refresh_by` frontmatter is the source of truth; this file
aggregates them so the whole brain's freshness reads at a glance. The cadence policy lives in
`parker-system/system/refresh-cadence.md`.

## How Parker uses this

- On loading this brain or consulting a standing doc, compare each `due` date to today. Past due is
  overdue; within roughly two weeks is due soon.
- Surface what is overdue plainly and offer to re-run the generating prompt by name. Never silently
  use a doc past its due date, and never re-run without surfacing the recommendation first.
- A refresh re-runs the generating prompt, carries forward what is still true, and re-stamps the
  dates. Update that doc's line here afterwards.
- The triggers in `parker-system/system/refresh-cadence.md` outrank the calendar — a rebrand, a new
  SKU, a pricing move, a new competitor, an attribution change, or a validated finding makes a doc
  due early regardless of date.

## ⚠️ Read this before using the schedule

**This brain is partially built.** Only two standing docs exist. Everything else in the normal
schedule was never generated, so it has no "last run" date — it has a **not built** state, which is
a different thing and must not be read as "fresh."

A doc that was never built cannot go stale, and it also cannot be relied on. When Parker needs one
of the `not built` docs below, the honest move is to say it does not exist and offer to run its
prompt — not to work around the absence silently.

## The schedule

### Built — tracked normally

| Doc | Cadence | Last run | Due |
|---|---|---|---|
| `audits/2026-Q3/90-day-performance-audit.md` | quarterly | 2026-09-07 | 2026-12-06 |
| `source-pulls/ad-account.md` | monthly | 2026-09-07 | 2026-10-07 |

### Intake docs — refreshed when the brand says something new, not on a clock

| Doc | Last updated |
|---|---|
| `running-notes/brand-rules.md` | 2026-09-07 |
| `running-notes/success-definition.md` | 2026-09-07 |
| `running-notes/brand-notes-from-org.md` | 2026-09-07 |
| `running-notes/missing-context.md` | 2026-09-07 |
| `running-notes/standard-sync.md` | 2026-09-07 |
| `brand-lens.md` | 2026-09-07 |

### Not built — no date, because they were never generated

Run `/refresh-context`, or the named prompt under `parker-system/prompts/`, to create any of these.

| Doc | Its prompt |
|---|---|
| `sub-context-docs/brand-profile-narrative.md` (the always-loaded one-pager) | `brand-profile/brand-profile-narrative` |
| the eleven other `sub-context-docs/` slices | `brand-profile/*` |
| the remaining 16 audits, internal and external | `audits-quarterly/*`, `audits-monthly/*`, `audits-biweekly/*`, `audits-weekly/*`, `audits-*-external/*` |
| `competitors/` — all of it, plus `_competitive-set.md` and `INDEX.md` | `competitor-profile/*` |
| `personas/personas-profile.md`, the voice library, lifecycle maps, bias notes | `personas/*` |
| `personas/voice-of-customer/` — corpus profile, ten slices, assembly | `voice-of-customer/*` |
| the seven other persona source pulls | `personas/*` |
| `open-loops/` roll-up | `open-loops/open-loops-roll-up` |
| `strategy/` — the four inputs and the roadmap | `strategic-roadmap/*` |
| `idea-bank/`, `sprints/`, `briefs/` | `ideas-and-briefs/*`, or `/harvest-ideas` |

**Permanently blocked, not merely unbuilt:** `personas/post-purchase-surveys` — the brand has zero
survey responses. It needs data before it needs a prompt run.

### Folder indexes

`competitors/INDEX.md` and `audits/INDEX.md` are generated when their folders have contents worth
indexing. `audits/` currently holds one document and `competitors/` is empty, so neither index has
been generated yet.
