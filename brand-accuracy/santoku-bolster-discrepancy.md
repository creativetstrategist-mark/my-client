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

**This is not yet resolved.** Mark's instruction on 2026-10-13 was "let's stick to
brass", and NK599 was corrected on that basis. But the physical product has not
been verified: `northernknife.com` is blocked by the cloud environment's egress
policy, so the product page could not be read from here. **If the bolster is
actually copper, then the catalog and CLAUDE.md are wrong and brass is the error
being propagated.** Settle that before any bulk change.

To check from here in future, `northernknife.com` needs adding under Allowed
domains in the environment's network settings.

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

## Already fixed

**NK599 "Worth The Money - Santoku"** (`3f34ac62-7aac-814c-8515-e16be8ea2927`),
on Mark's instruction, 2026-10-13:

- 3 × copper → brass (VO line, a second VO mention, and a visual direction
  "Closeup on the copper bolster")
- "Rosewood handle, carved by hand." → "A handle carved by hand."

It was with Umar at `Assigned to Editor` at the time.

## Recommended next steps

1. **Verify the product.** Check the bolster on
   <https://northernknife.com/products/bjorn-series-santoku-knife>. Everything
   below depends on the answer.
2. **Fix the source of truth first**, whichever way it goes — the catalog or the
   corpus — so new briefs stop inheriting the wrong word.
3. **Then fix forward only.** Briefs not yet produced (`Ready for visuals`,
   `Ready to edit`, `Assigned to Editor`) are worth correcting. Shipped work is a
   record; leave it.
4. **Hand-edit the four beat-dependent briefs**, or leave them. They need
   rewriting, not a word swap.
