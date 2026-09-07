# Standard sync — the update ledger

## Where this brain stands

- **Factory remote:** https://github.com/real-simple-labs/parker-brain
- **Posture:** `follow`
- **Pinned release:** `v15` — matches `parker_config.json`'s `parker_brain_version`.
  Note: `v14` and `v15` point at the same commit (`b55c441`), so `git describe` reports
  `v14`. The pin is v15.
- **Migrations applied through:** `v15` (built at this release; no migrations to apply)
- **Last compared:** 2026-09-07 against `v15`, the newest tag at build time.

## Sync is self-managed — read this before running /save-brain

This brain is **not** managed by the Parker Desktop app, and the normal "your folder is
watched and synced automatically" guidance does not apply to it.

Parker provisioned a private repo for this brand at
`https://github.com/parker-brain/nebula-studio-northern-knife`, but the cloud session that
built the brain could not reach it: that session's GitHub access is scoped to the
`creativetstrategist-mark` tier, and cross-tier attachment is refused outright
(`add_repo: cross-tier adds are not supported in v1`). Direct authenticated git push to
the Parker repo failed for the same reason.

So the brain was built inside the **`creativetstrategist-mark/my-client`** repo, in
`northern-knife-brain/`, on branch `claude/northern-knife-brain-setup-qu4eb5`. It is saved
by ordinary commits and pushes to that repo — that is what keeps it durable.

**To move it into its own Parker repo later**, either:

1. Start a fresh Claude Code session with `parker-brain/nebula-studio-northern-knife` as its
   initial source, then copy this folder's contents in and push; or
2. Clone the Parker repo on a local machine (a human collaborator can be invited to it via
   `setup_parker_brain` with their GitHub username) and copy the folder across; or
3. Install Parker Desktop, set the brand's repository up there, and drop this folder in —
   the app takes over syncing from that point and this note stops applying.

`parker-system/` is a git submodule pinned to `v15`. After any fresh clone, run
`git submodule update --init` or the mount will be an empty directory and every method
path in this brain will resolve to nothing.

## Offer history

No offers yet — the first `/update-brain` run fills this in.

## Routine arming status — stamped, NOT armed

**Read this before assuming the brain runs itself.** The six schedule recipes are stamped into
`schedules/` and their skills are installed in `.claude/skills/`, so every routine is ready to run.
**None of them is actually registered to fire on a clock.**

Schedules are per-account and cannot be committed to a repo, so they have to be armed on whatever
instance the brain lives on. The session that built this brain could only offer in-memory,
session-lifetime scheduling that expires after seven days and vanishes when the session ends —
which would have looked armed without being armed. That was declined deliberately.

| Routine | Intended cadence | State |
|---|---|---|
| `/refresh-context` | weekly | not armed |
| `/dream` | daily | not armed |
| `/harvest-ideas` + `/evaluate-ideas` | weekly | not armed |
| `/research-loops` | weekly, mid-week | not armed |
| `/self-improve` | weekly | not armed |
| `/update-brain` | weekly, early Monday | not armed |

**To arm them:** open this brain in a persistent Claude Code cloud instance and run
`/setup-routines`. It registers all six at their default cadences and reconciles rather than
duplicating. Run it again any time to change a cadence or turn one off.

Every routine also works on demand right now — just invoke it by name. Arming only decides whether
it happens without being asked.
