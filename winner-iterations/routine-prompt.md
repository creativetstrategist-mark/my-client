# Winner iterations: the run instruction

This is the instruction the winner-iteration Routine runs on, kept here so it
can be read, reviewed and diffed. The Routine has **no schedule**: it fires only
when Mark cues it with creative IDs. **If you change the Routine's prompt, change
this file too.** The Routine is what actually fires; this file is the readable
copy.

You can also run it without the Routine: in any session on this repo, say
`Iterate NK284` (or `Iteration 1 NK184`, `Iteration 2 NK222 H3`). The root
`CLAUDE.md` routes that command to the spec.

---

Run the NorthernKnife winner-iteration play. It runs only on Mark's command, and the command is the scope. The text after this instruction is the command: creative IDs, optionally which iteration (`Iteration 1` = Rewrite, `Iteration 2` = Reskin; neither named = both), an optional winning hook (`H3`), an optional editor, and optionally `again` or `round 2`. **If the command names no creative ID, stop and ask Mark for one. Never choose a winner yourself.**

## Read first

GitHub repo `creativetstrategist-mark/my-client`. Read with `mcp__github__get_file_contents` and the `ref` shown, or a local checkout if this session has one.

1. Branch `claude/epic-knuth-yzvigf`: `winner-iterations/iteration-process.md`. **This is the AUTHORITATIVE spec. Follow it.** Also read `winner-iterations/iteration-log.md`, the dedup ledger.
2. Branch `claude/vibrant-hopper-xg9l5l`: `brand-pack/05-process/creative-brief-process.md` (§C copy rules, §D page template, §E product accuracy, §F originality gate), `brand-pack/01-brand/product-catalog.md`, the persona file under `brand-pack/02-personas/` for the source's avatar, and `.claude/skills/nk-ad-naming/SKILL.md` plus `vocab-video.json`.

The summary below is so you know the shape of the job before you open the spec. It does not replace reading it.

## The two types

- **Iteration 1, Rewrite (`Ite-Script`):** the footage is LOCKED, with every Visual cell copied from the source clip for clip, Frame.io links included. Every hook and body line is NEW, each line fits the clip it plays over, each row stays within ±20% of the source row's word count, and the originality gate fails any run of 6+ consecutive words shared with the source. Default editor: the source cut's editor.
- **Iteration 2, Reskin (`Ite-Reskin`):** the script is LOCKED word for word, and the source's VO track and music are reused. Every visual is NEW and must pass the visual difference gate: no source clip in any form (flipped, re-graded or cropped counts as the source clip), every row different on at least 3 of setting, subject, framing and action, a different format device for the whole cut, new hook first frames, and a new grade. Only the fix list (spec §4.3) may change a locked word, and each change is marked `Changed:` in the Note. Editor: never the source cut's editor.

Both stay on the source's product and persona.

## The job

1. **Source brief:** Evergreen Video `collection://2cf4ac62-7aac-81a8-86bf-000b96778943`, `WHERE "Creative ID" = ?`. Not there → `notion-search` the workspace. Still nothing → stop for that ID and ask Mark. The source page is READ-ONLY.
2. **Source cut:** the page's `Delivery Link`, else Frame.io `search_assets` (account `b0bc19f9-4a80-4ae4-9768-4b151edb5a40`, project `b37ff928-5b11-4860-8204-f102af43f3ec`). Keep only names whose FIRST `_` segment equals the ID as a whole segment: `NK485_VID_Why NK184_…` is NK485, not NK184. Prefer the folder named exactly the ID, and take the newest version in each hook stack. No cut → stop both types for that ID and report it.
3. **Dedup:** skip a type already in the ledger, or already present in Notion as an `Ite-Script` or `Ite-Reskin` of this source (Concept Name contains `(<ID>)`; read the Batch name's iteration field), unless the command says `again` or `round 2`. Tell Mark what exists, with the link.
4. **Write, gate, name:** per spec §3, §4 and §6. Every gate passes before a page is created.
5. **Create:** the next free `NK###` (re-query right before each page), properties per spec §8.1 (`Category` `Iteration`, `Iteration` checked, `Status` `Ready for visuals`, `Strategist` `Claude`), body in the spec §8.2 block order, icon 📽️. Fetch each page back and confirm it landed.
6. **Ledger:** one row per brief in `winner-iterations/iteration-log.md`, plus a Run history line in the spec. Commit and push to branch `claude/epic-knuth-yzvigf`. If local `git commit` is blocked, use `mcp__github__get_file_contents` for the sha and then `mcp__github__create_or_update_file`.

## Never

Pick a winner yourself. Write to the source page. Change the product or the persona. Use a source clip in a Reskin. Change a locked Reskin word outside the fix list. Move Status past `Ready for visuals`. Message an editor. Invent a script, a Frame.io link or a page link.

## Report

Per ID: the source page and Frame.io folder used; the briefs created (ID, Concept Name, type, editor, Notion link); every fix-list change, quoted old → new; flags for Mark (an offer other than B2G2, unverifiable claims, a VO track that could not be found, a script not checked against the cut); anything skipped and why. If the Notion or Frame.io connector is unavailable, say so explicitly. A silent empty run reads like a clean one.
