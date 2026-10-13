# BJORN Santoku: "copper bolster" vs "brass bolster" — unresolved

*Found 2026-10-13 while running the editor-assignment pre-send gate, which reads
each brief's full body. Swept the whole `Evergreen Video` database with Notion
search afterwards.*

## The problem

**The brand pack says brass. About 24 briefs say copper. One brief says both.**

- `brand-pack/01-brand/product-catalog.md`: *"Norse engravings etched into the
  blade, dragon-sculpted **brass** bolster (the metal collar between blade and
  handle), hand-carved wooden handle."*
- `CLAUDE.md` hard rules: *"dragon-sculpted **brass** bolster"*.
- The live corpus overwhelmingly says **copper**, consistently, from 2026-07-14
  through 2026-10-13.

## ✅ RESOLVED: it is brass

**Mark confirmed on 2026-10-13: the bolster is brass.** The catalog and CLAUDE.md
are correct; the corpus's "copper" is a long-running error.

Note the product page itself was never readable from here —
`northernknife.com` is blocked by the environment's egress policy — so this rests
on Mark's confirmation, not an independent check. To verify from here in future,
`northernknife.com` needs adding under Allowed domains in the environment's
network settings.

**Decision: fix unproduced briefs only.** Produced work (`Uploaded on Drive`) is
a record of what shipped and is left as-is.

## ⚠️ Why a find-and-replace would do damage

### 1. One brief contains both words

- **You Get What You Pay For** (`3cf4ac62-7aac-819d-83b6-e3e561b7c2b8`) — visual
  says "the dragon in the **copper** bolster", VO says "a dragon in the **brass**
  bolster".

### 2. Some briefs build a creative beat on the metal

Replacing the word breaks the writing, not just the spec:

- **Cross Examination** (`3c84ac62-7aac-81d5-b26a-f009d82b97e8`) — a whole
  "Reason #2: It doesn't look like the photo" beat: *"The bolster's darker than
  the one on the website. Man. That's copper…"* The argument **depends** on
  copper's colour behaviour.
- **A Year, Then Fourteen Hours** (`3c44ac62-7aac-81ee-9ecf-dcd6e10b3d2c`) — a
  forging beat: *"Then the bolster. Copper, sculpted, seated by hand until it
  sits flush with the handle."*
- **What if - Santoku..** (`3bd4ac62-7aac-8080-b03f-f05932ea514e`) — *"sculpted in
  solid copper. Every scale, every claw, every curve set into the bolster."*
- Four briefs carry the accuracy guard *"The copper is the bolster only. The
  blade is high-carbon steel."* — that line exists **to prevent** a viewer
  thinking the blade is copper. If the metal changes, the guard needs rewriting,
  not swapping.

### 3. Most are already produced

July and August briefs have long since shipped. Editing them rewrites the record
of work that already ran, rather than fixing anything upcoming.

## The affected briefs

### "copper" on Santoku briefs (~24)

| Brief | Page ID | Note |
|---|---|---|
| The Diva Return - Santoku | `3e94ac62-7aac-8187-91cf-c844c5024173` | "The bolster is copper. Shoot it close." |
| We're sorry - ASMR - Santoku (NK300) | `3ef4ac62-7aac-81c2-8191-f41375a7b6f6` | also "rosewood handle" |
| Made Too Many Whisper - Santoku | `3eb4ac62-7aac-8104-8423-edb63f1264bd` | also "carved rosewood handle" |
| Made Too Many - Santoku | `3eb4ac62-7aac-819b-b46f-f8a49fef2994` | also rosewood |
| Return To Stack - Santoku | `3e94ac62-7aac-8126-a71c-c9aa36f68861` | |
| The Furious Return - Santoku | `3e94ac62-7aac-8131-b559-d855c2112579` | "Copper bolster against the rosewood" |
| What If Short - Santoku | `3e94ac62-7aac-81d2-94da-cab81ff5db30` | "copper bolster set against a rosewood handle" |
| Do Not Buy This Knife | `3c84ac62-7aac-81e4-9f4f-f25c8dd5e8ae` | carries the "copper is the bolster only" guard |
| Four For Half The Price | `3d44ac62-7aac-8169-8604-cf195d8ce45c` | |
| What cheap knives cost | `3d74ac62-7aac-819d-9bc8-c68e006be5d3` | |
| What cheap knives cost (2nd page) | `3d74ac62-7aac-819f-a55a-d86fd12c33c0` | |
| Pack Your Order | `3d14ac62-7aac-811a-a4f6-e97bef2bf0a7` | |
| You Get What You Pay For | `3cf4ac62-7aac-819d-83b6-e3e561b7c2b8` | **says both copper and brass** |
| Your Lucky Day | `3cf4ac62-7aac-811b-80bb-f8ea3637fd0c` | |
| Three Return Forms | `3cb4ac62-7aac-81e7-98b8-eea5443f6762` | |
| Cross Examination | `3c84ac62-7aac-81d5-b26a-f009d82b97e8` | **creative beat depends on copper** |
| Red Flags | `3c84ac62-7aac-81c5-9e37-f6cd47d21678` | carries the "copper is the bolster only" guard |
| A Year, Then Fourteen Hours | `3c44ac62-7aac-81ee-9ecf-dcd6e10b3d2c` | **forging beat depends on copper** |
| Why We Started | `3c74ac62-7aac-8194-8def-f0a010c58a19` | carries the guard |
| The Last One | `3c74ac62-7aac-8192-bfc5-c3286a41d882` | carries the guard |
| Ruined for Ordinary - Santoku | `3c74ac62-7aac-804f-a770-f0f032945303` | also rosewood |
| I tried everything, this won - Santoku | `3c74ac62-7aac-8013-b3c9-fcadf7679b14` | also rosewood |
| What if - Santoku.. | `3bd4ac62-7aac-8080-b03f-f05932ea514e` | **"sculpted in solid copper"** |
| 5 Reasons Why - Santoku | `3974ac62-7aac-8090-bfcb-f898229596c7` | shipped July |
| Negative (NK130 Iteration) - Santoku | `3974ac62-7aac-802a-9a47-f2cbe11ffec8` | shipped July |

### "rosewood" wrongly on a Santoku (~7)

The catalog gives **rosewood to the Feather** and calls the Santoku's handle
"hand-carved wooden", naming no wood. The three clean Santoku cuts from the
2026-10-13 batch (NK603, NK606, NK609) all say "carved by hand" with no wood —
that is the house pattern.

Affected: `We're sorry - ASMR - Santoku`, `Made Too Many Whisper - Santoku`,
`Made Too Many - Santoku`, `The Furious Return - Santoku`,
`What If Short - Santoku`, `Ruined for Ordinary - Santoku`,
`I tried everything, this won - Santoku`.

**⚠️ Do not blind-replace "rosewood" either.** Several Santoku-titled briefs are
multi-product and describe the **Feather's** rosewood handle entirely correctly —
`Swear To Me - Santoku` and `Everyone's Been Had - Santoku` both do. Check which
product the sentence is about before changing anything.

## ⚠️ The first sweep was incomplete — search the material word, not the phrase

Searching `"copper bolster"` returned 25 pages and **missed six**, because they
phrase it differently: *"solid copper dragon bolster"*, *"Copper detail"*,
*"sculpted in solid copper"*, *"Copper was the one that did both"*, *"copper
dragon"*. Searching the bare word **`copper`** found them.

Real total: **~29 briefs**, not 24. It did not change the outcome — five of the
six extra pages were already produced and the sixth is Callum's — but any future
material-accuracy sweep should query the bare material word.

The six missed: `Add the Distinctive Piece` (NK296), `Stole It From My Brother -
Santoku` (NK571), `Legend - Santoku` (NK592), `We're sorry.` (NK303),
`3 Checks - Santoku` (NK588), and `Negative (NK130 Iteration) - Tiger Cleaver`
(NK163).

## Fixed (unproduced only)

| Creative ID | Concept | Status at fix | Change |
|---|---|---|---|
| **NK599** | Worth The Money - Santoku | `Assigned to Editor` (Umar) | 3 × copper → brass (VO line, 2nd VO mention, and the visual direction "Closeup on the copper bolster"), plus "Rosewood handle, carved by hand." → "A handle carved by hand." |
| **NK471** | What cheap knives cost (SANTOKU) | `Not started` (Onyeka) | 1 × "copper bolster with the dragon cut into it" → brass |
| **NK470** | What cheap knives cost (Feather) | `Not started` (Hammad) | 1 × same line → brass. A Feather brief whose lineup beat describes the Santoku. |

## 🚫 Left unfixed on purpose

- **NK588 "3 Checks - Santoku"** — `Ready to edit`, so it qualifies as unproduced,
  but **`Strategist = Callum`**. Mark's standing rule is never to touch Callum's
  work, so it was left alone and flagged instead. **It still needs the brass
  fix.**
- **NK163 "Negative (NK130 Iteration) - Tiger Cleaver"** — says "rosewood with
  copper detailing", but that is the **Tiger Cleaver**, a different product where
  copper may be correct. Out of scope for the Santoku rule, and produced anyway.
- **Everything else** (~26 briefs) is `Uploaded on Drive`. Left as the record of
  what shipped.
- **No rosewood-on-Santoku brief was unproduced**, so none needed fixing. The
  seven affected are all `Uploaded on Drive`.

## Superseded notes

**NK599 "Worth The Money - Santoku"** (`3f34ac62-7aac-814c-8515-e16be8ea2927`),
on Mark's instruction, 2026-10-13:

- 3 × copper → brass (VO line, a second VO mention, and a visual direction
  "Closeup on the copper bolster")
- "Rosewood handle, carved by hand." → "A handle carved by hand."

It was with Umar at `Assigned to Editor` at the time.

## Still open

1. **NK588 needs the brass fix** — blocked on the Callum rule. Mark or Callum.
2. **Why do new briefs keep inheriting "copper"?** The catalog says brass, so
   something else is feeding it — most likely older briefs being used as voice
   reference, since the corpus is overwhelmingly copper. Worth finding, or the
   error returns on the next Santoku batch written from precedent.
3. **The four beat-dependent briefs** would need rewriting rather than a word
   swap if they are ever revived (see above). All are produced, so no action now.
