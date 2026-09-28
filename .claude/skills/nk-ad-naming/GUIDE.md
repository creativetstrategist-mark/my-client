# NK ad naming: give it to your Claude

One folder, `nk-ad-naming`, makes any Claude name NorthernKnife ads exactly the way we do.
Three files inside: `SKILL.md` (the rules and how to read a brief), `vocab-video.json` and
`vocab-static.json` (every allowed value). Nothing else is needed.

## What it does once installed

Paste a brief, or a Notion brief link if your Claude has the Notion connector, and say
"name this". Claude returns the batch name, one file name per hook, the folder name, and a tag
sheet that quotes the brief line behind every judgement call (angle, hook tactic, structure,
tone, proof, offer timing, product reveal, voice, face). You check the tag sheet, done.

It also repairs old names: paste one, it maps the old labels and asks only for what is missing.

## Install, pick the one you use

### claude.ai (Projects), 3 minutes
1. Go to claude.ai → Projects → New project → name it "NK Naming".
2. Open the project's **Instructions** and paste the whole of `SKILL.md` into it.
3. Under **Project knowledge**, upload `vocab-video.json` and `vocab-static.json`.
4. Start a chat inside the project: "Name this brief:" and paste the brief. That is it.

### Claude Desktop app or Claude Code, 2 minutes
1. Copy the `nk-ad-naming` folder to `~/.claude/skills/nk-ad-naming/` (Mac: your home folder →
   `.claude` → `skills`). If the `.claude` or `skills` folder does not exist, create it.
2. In any chat type `/nk-ad-naming` followed by the brief, or just ask to name an ad; Claude
   picks the skill up by itself.

### Notion AI
Ask Andy to upload the skill to the workspace; it then appears in Notion AI for everyone and
can read the brief page directly.

## Updating

When a menu changes (a new format, a new creator, a new angle), Andy replaces the two JSON
files in the shared Drive folder `CLAUDE CODE / NK Name Builder`. Re-upload them to your
project, or copy them over the old ones in your skills folder. `SKILL.md` only changes when
a field is added or the order changes, which is rare and announced.

## Rules Claude follows, so you know what to expect

- Every value comes from the vocabulary. It never invents a format, angle or avatar.
- If a fact is missing (product, offer, editor…) it asks in one line instead of guessing.
- Judgement fields come with the quote from the brief that justifies them.
- One avatar, one angle, one structure per ad. Never "General".
- Under 400 characters, no `/ : ? * " < > |`, no trailing ` - Copy` or hash.
