# _parked

Holding area. **Nothing in here is part of the daily ad-rewriting routine.**
The routine should ignore this directory entirely.

## northernknife-ugc

A complete scaffold for a separate repo — the NorthernKnife **UGC scripting**
routine (creator talking-head scripts, iPhone shoot direction, b-roll briefs).

It's parked here only because the Claude GitHub App installed on this account
can't create repositories (403 on the user account, 404 as an org), so the
real repo didn't exist yet and the work had nowhere else to live.

### Why it's parked, not merged

This is a **sibling repo's content**, not a subdirectory of `my-client`. It
has its own `CLAUDE.md`, its own `brand-pack/`, and its own output folder. The
two routines share a brand and a copy rulebook but produce different
deliverables, and mixing them would make both ambiguous.

### One deliberate change

`CLAUDE.md` is parked as **`CLAUDE.md.parked`**. A nested `CLAUDE.md` would be
picked up as project instructions while working inside `my-client`, which
would feed UGC rules into the ad-rewriting routine. `extract.sh` renames it
back.

### To promote it to a real repo

1. Create an empty private repo — no README, no .gitignore:
   https://github.com/new → name it `northernknife-ugc`
2. Install the Claude GitHub App on it (or reconnect GitHub) so a session can
   push to it.
3. Extract and push:

   ```sh
   ./_parked/extract.sh ~/northernknife-ugc
   cd ~/northernknife-ugc
   git init -b main && git add -A && git commit -m "Scaffold NorthernKnife UGC scripting repo"
   git remote add origin https://github.com/creativetstrategist-mark/northernknife-ugc
   git push -u origin main
   ```

4. Delete `_parked/` from this repo and commit. It has served its purpose.

### What state the scaffold is in

Product hard rules and the universal copy rules are **authoritative and
final** — carried over from this repo's `CLAUDE.md`.
`brand-pack/05-process/ugc-script-process.md` is the authoritative deliverable
spec (Sections A–H).

The brand-voice, persona, and creator-direction docs are **structured stubs**.
Every field that needed content from the source brand pack is marked
`TODO(brand-pack)` rather than invented. Note that this repo's own
`brand-pack/` and `daily-ad-rewrites/` aren't committed either, so there was
no pack on disk to copy from — those TODOs need the source material.

BJORN Series Santoku has no price in the hard-rules set, so the catalog marks
it TODO rather than guessing.
