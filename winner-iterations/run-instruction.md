# Winner iterations: the run instruction

**On demand only.** There is no Routine and no schedule. Mark decides which
winners get iterated and gives the IDs in a session.

- **In a session on branch `claude/epic-knuth-yzvigf`:** just say
  `Iterate NK284` (or `Iterate NK284, NK222`). The root `CLAUDE.md` routes the
  command to the spec.
- **In any other session** (another branch, Cowork, no checkout): paste
  everything below the line, then put the IDs at the end.

The session needs the Notion and Frame.io connectors.

---

Run the NorthernKnife winner-iteration play, on demand. The IDs after this instruction are the winners Mark chose; they are the whole scope. **Every ID gets both iteration types: one Iteration 1 and one Iteration 2.** Name them that way, never "Rewrite" or "Reskin". **The strategist is always Mark.** Optional: an event (`Black Friday`, spec §8.3), a winning hook (`H3`), and `again` or `round 2` to repeat a winner already in the ledger. **If no creative ID is given, stop and ask Mark. Never choose a winner yourself.**

## Read first

GitHub repo `creativetstrategist-mark/my-client`. Read with `mcp__github__get_file_contents` and the `ref` shown, or a local checkout.

1. Branch `claude/epic-knuth-yzvigf`: `winner-iterations/iteration-process.md`. **This is the AUTHORITATIVE spec. Follow it.** Also read `winner-iterations/iteration-log.md`, the dedup ledger.
2. Branch `claude/vibrant-hopper-xg9l5l`: `brand-pack/05-process/creative-brief-process.md` (§C copy rules, §D page template, §E product accuracy, §F originality gate), `brand-pack/01-brand/product-catalog.md`, the persona file under `brand-pack/02-personas/` for the source's avatar, and `.claude/skills/nk-ad-naming/SKILL.md` plus `vocab-video.json`.

## The two types, both for every ID

- **Iteration 1 (`Ite-Script`):** the footage is LOCKED, with every Visual cell copied from the source clip for clip, Frame.io links included. Every hook and body line is NEW, each line fits the clip it plays over, each row stays within ±20% of the source row's word count, and the originality gate fails any run of 6+ consecutive words shared with the source.
- **Iteration 2 (`Ite-Reskin`):** the script is LOCKED word for word, and the source's VO track and music are reused. Every visual is NEW and must pass the visual difference gate: no source clip in any form (flipped, re-graded or cropped counts as the source clip), every row different on at least 3 of setting, subject, framing and action, a different format device for the whole cut, new hook first frames, and a new grade. Only the fix list (spec §4.3) may change a locked word, and each change is marked `Changed:` in the Note.
- **Editor for BOTH: the source cut's editor.** Take it from the source page's `Editor` property, else the editor segment of the delivered file names. If there is no clear name, or it is Huzaifa or off the roster, stop for that ID and ask Mark.

Both stay on the source's product and persona.

## The job

1. **Source brief:** Evergreen Video `collection://2cf4ac62-7aac-81a8-86bf-000b96778943`, `WHERE "Creative ID" = ?`. Not there → `notion-search` the workspace. Still nothing → stop for that ID and ask Mark. The source page is READ-ONLY.
2. **Source cut:** the page's `Delivery Link`, else Frame.io `search_assets` (account `b0bc19f9-4a80-4ae4-9768-4b151edb5a40`, project `b37ff928-5b11-4860-8204-f102af43f3ec`). Keep only names whose FIRST `_` segment equals the ID as a whole segment: `NK485_VID_Why NK184_…` is NK485, not NK184. Prefer the folder named exactly the ID, and take the newest version in each hook stack. No cut → stop that ID and report it.
3. **Dedup:** an ID already in the ledger is skipped unless the command says `again` or `round 2`; tell Mark, with links. Other people's iterations of the source in Notion do not block; list them in the report.
4. **Look, write, gate, name:** view the source cut's Frame.io scrub sheet first (spec §2.3). Write per spec §3 and §4, name per §6. Run the mechanical gates with `winner-iterations/gate_check.py` (spec §9.6). Every gate passes before a page is created.
5. **Create:** two consecutive `NK###` numbers, Iteration 1 first (re-query right before each page). Properties per spec §8.1 (`Category` `Iteration`, `Iteration` checked, `Status` `Ready for visuals`, `Strategist` `Mark`, always; Concept Name `<Short concept> Iteration 1 (<ID>) - <Product>` and `… Iteration 2 …`), body **in the live brief template's structure** (spec §8.2: fetch template `2d64ac62-7aac-808e-8149-d1026291f47c` first; video block under AD INSPO, template persona and glossary, 3-column HOOK, BODY and CTA tables, no banner callouts), icon 📽️. Fetch each page back and confirm it landed.
6. **Ledger:** one row per brief in `winner-iterations/iteration-log.md`, plus a Run history line in the spec. Commit and push to branch `claude/epic-knuth-yzvigf`. If local `git commit` is blocked, use `mcp__github__get_file_contents` for the sha and then `mcp__github__create_or_update_file`.

## Never

Pick a winner yourself. Write only one of the two types. Give an iteration to anyone but the source's editor. Write to the source page. Change the product or the persona. Use a source clip in Iteration 2. Change a locked Iteration 2 word outside the fix list. Move Status past `Ready for visuals`. Message an editor. Invent a script, a Frame.io link or a page link.

## Report

Per ID: the source page and Frame.io folder used; the two briefs created (ID, Concept Name, type, editor, Notion link); every fix-list change, quoted old → new; flags for Mark (an offer other than B2G2, unverifiable claims, a VO track that could not be found, a script not checked against the cut); other people's iterations of the same source; anything skipped and why. If the Notion or Frame.io connector is unavailable, say so explicitly. A silent empty run reads like a clean one.
