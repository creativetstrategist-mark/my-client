# Northern Knife — brand brain

Built 2026-09-07. Method version `v15`.

**Start here: open this folder in Claude Code and run `/get-started`.** It reads the brain's
current state and walks you through what's here, what it can do, and what to do first. It works
for anyone, any time — a teammate next month gets the same tour.

## Read this first — the brain is partially built

This is a **foundation-only build, stopped early.** It has a complete, working *system* and a
thin *knowledge base*. Both halves matter, so be clear which is which:

**Complete and working:**

- All **26 skills** in `.claude/skills/` — scriptwriting, hooks, headlines, iterations,
  ad-account analysis, AI ad generation, the open-loops pipeline, plus the standing routines.
  They load automatically when you open the folder.
- The full Parker **method**, mounted read-only at `parker-system/` and pinned to release `v15` —
  every prompt, every craft doc, the whole system.
- The two **creative review gates** (`.claude/agents/`) and their checkers (`scripts/`), both verified runnable.
- The **six routine schedules** in `schedules/`, and the Parker voice layer.

**Thin — only two documents were produced before the build hit its usage limit:**

| Doc | What it is |
|---|---|
| `audits/2026-Q3/90-day-performance-audit.md` | ~5,300 words. The account's present tense: spend, efficiency, delivery, format, fatigue, 2026-06-09→2026-09-07 against the prior 90 days. |
| `source-pulls/ad-account.md` | ~41KB. Who the account actually reaches versus who the creative is written for. |

Everything else — the brand profile one-pager, the sub-context slices, competitors, personas,
voice-of-customer, open loops, strategy, ideas, briefs — is **scaffolded and empty.**
`prompts-run-log/` is the record of what ran; `running-notes/missing-context.md` is the live gap list.

**To keep building:** run `/refresh-context`, or re-run any prompt directly from
`parker-system/prompts/`. Nothing is blocked — it simply hasn't been run yet.

## The two things a human needs to decide

1. **The Feather claim.** The brand's rules say the blade pattern is laser-applied and must never
   be called hand-etched. The account's biggest ad by spend calls it hand-etched.
2. **The LOKI Blackout bottle opener.** The rules put it in the handle. Live copy puts it in the blade.

Both are in `CLAUDE.md` and `brand-lens.md`. Until someone settles them, Parker writes to the rule.

## Data surfaces

| Surface | State |
|---|---|
| Meta ad account | **live** — 2,431 ad-name groups, $497,553.67 lifetime spend, 2.03 ROAS, $143.15 AOV |
| Customer reviews | **live** — 4,028 reviews, 4.93 average |
| Facebook ad comments | **live** |
| TikTok inspiration library | **live** — 50 videos |
| Competitor ad library | **thin** — 2 tracked: Coolina USA, Dalstrong |
| Post-purchase surveys | **dark** — zero responses |
| Placement position, reach/frequency | **not exposed** by the connector |
| Gross margin | **not provided** — so every return figure here is revenue, not profit |

## How the method travels

The skills live in `.claude/skills/` because that is the only directory Claude Code loads skills
from — so they work the moment this folder is opened, on any machine. The factory method is a git
submodule pinned to a named release, which means this brain can refresh, rebuild and re-run the
exact prompts that produced it. Updates arrive only when `/update-brain` offers a newer release and
the team says yes.

**After a fresh clone, run `git submodule update --init parker-system`** — otherwise the mount is an
empty directory and every method path resolves to nothing.

## Where this brain lives

In `creativetstrategist-mark/my-client`, under `northern-knife-brain/`. Parker provisioned a
dedicated repo for it, but the cloud session that built it could not reach that repo across
account tiers. `running-notes/standard-sync.md` explains the three ways to move it into its own
home later.
