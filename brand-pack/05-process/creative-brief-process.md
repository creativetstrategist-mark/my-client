# Creative Brief Process — Instructions

This is the exact process for turning ad inspiration into a usable NorthernKnife creative brief. Static and video follow **different processes** — don't mix them. This routine only ever produces **video briefs** (Section D/D0) for the Notion Video Brief Database, for our 3 focus products: Feather Knife, BJORN Series Santoku, LOKI Blackout Edition.

Source material is swipe inspiration pulled from TrendTrack's "inspo" folder. The output is a concrete, ready-to-produce Notion brief.

## Before starting any brief batch
- **Propose 3 alternative hooks for every brief — but every hook MUST be a drop-in opener for the exact same script that follows, not a different ad concept.** The 3 hooks are not 3 different ideas for the ad — they're 3 different ways to *open* the one script the brief is building.
 - **Same format, same speaker(s), same setting as the rest of the brief.** Don't mix formats across the 3 options.
 - **Each one must lead into the same rest-of-script content with no rewrite required.**
 - **Vary the specific angle within that constraint.**
 A test for whether 3 hooks are actually usable: read hook #2 out loud, then read the very next line of the existing script after it — does it sound like the same conversation continuing, or does it sound like two different ads spliced together? If it's the latter, the hook is wrong.
- **Match the length of the script to the original inspo source, measured in words/characters — not estimated from runtime, and not compressed to a fixed NorthernKnife format.** Count the actual word count and character count of the source's spoken transcript. Target the adapted script's own word/character count within **±20%** of that source count. A 330-word source targets a 264-396 word adaptation; a 99-word source targets a 79-119 word adaptation. Short sources stay short, long sources stay long.

---

## B. Video Ads — the process for adapting an inspo ad

For every inspo video/ad:

**1. Analyze the whole video/ad.**
The hook (first 1-3 seconds), the structure/pacing, the actual dialogue, any comedic beat, how it resolves, the offer mechanic.

**2. Adapt the logic, not the words.**
Never reuse the dialogue verbatim. Keep the structural shape — the hook type, the pacing, the type of humor if there was one, how it handles objections, how it closes.

**3. Produce separate, product-specific versions — always all 3 of our focus products** (Feather Knife, BJORN Santoku, LOKI Blackout), each its own task and its own output — never one generic script with placeholders swapped in.

**4. Each output includes:**
- The source's word/character count and this script's word/character count, stated side by side, confirming the ±20% match — plus the resulting approximate runtime as a downstream note.
- 3 alternative hooks, clearly labeled, before the full script.
- Ad copy — the actual line-by-line script/voiceover, in NorthernKnife's voice.
- Script structure — scene-by-scene: what's shown, what's said, pacing/beats.

**5. Production standards:**
- **3-4 second rule:** change the visual every 3-4 seconds — a firm production constraint, so scene-by-scene breakdowns should reflect cuts at that pace rather than long static holds.
- No dead air — avoid awkward pauses in the audio track; every beat should flow directly into the next.
- **Persona voice/music specifics** (fuller detail in `02-personas/personas-in-full.md`): Mike = deeper/darker VO, rock and hard rock both fine. Sarah = upbeat/happy, occasional soft rock, never hard rock.
- **Glossary:** TC = Time Clips (a timestamp range in a reference video); Super = black text on a white textbox; Caption = white text on a black textbox.
- **VO generation:** ElevenLabs, V3 model, use the "Enhance" button to inject emotion tags.

---

## C. Copy voice — hard rules for every brief

### C.1 Never write a spec sheet. State the material, then what it does.

**BANNED — zero occurrences in any shipped NK ad, ever. Never write these in any brief:**
`5Cr15MoV` · `AUS-10V` · `VG10` · `440C` · `8Cr` · any `HRC`/Rockwell number · `Martensitic` · `edge retention` (as a noun phrase) · `bevel` · `edge geometry` / `blade geometry` · `quench` / `temper` / `annealed` / `cryogenic` · edge angle in degrees · `carbon content %` · `tensile` / `hardness rating` · `mm` blade thickness · exact gram weights · **`offer page`** (internal jargon — real scripts say "the link below," "the site," "their website").

**What the real corpus actually says:** "hand-forged" (58×) · "full tang" / "full-tang rosewood" (27×) · "high-carbon steel" (26×) · "razor sharp" / "razor-sharp out of the box" (19×) · "three times more control" (15×) · "premium rosewood handle" (13×).

**The pattern is always `[plain material noun] + [consequence]`:**
> "It's hand-forged from high-carbon steel with a razor's edge that stays sharp for months." — NK025
> "It arrives razor-sharp out of the box and holds that edge, so it goes through brisket, ribs, or a pile of vegetables like they're not even there." — NK136
> "Full tang. Rosewood handle. Lifetime warranty. Because we don't expect you to ever need a second one." — NK145

**Substitution table:**

| Instead of | Write |
|---|---|
| "HRC 54-56" / "edge retention" | "holds that edge" · "stays sharp for months" · "I've been using mine for 4 months and it's still like the first day" |
| "5Cr15MoV" / "Martensitic stainless" | "hand-forged high-carbon steel" · "hand-forged by actual blacksmiths. Not stamped in a factory." |
| "ergonomic finger aperture" / bare "3x control" | "See, most knives keep your finger on the handle, away from the blade. That means less control. The Loki puts your index finger *through* the blade." |
| "260g, lightweight design" | "Lighter doesn't mean weaker" · "weighs less than your phone" |
| "precision-forged blade geometry" | "The blade curve lets you rock through cuts like a pro chef" |
| "hardened blade, superior durability" | "Built to outlast your kitchen" · "damn near indestructible" |
| "manufacturing lead time" | "restocks take three months" |

Comparison claims are always **ratios against a named enemy**, never absolutes: "five times stronger than stainless steel," "three times sharper than those other bullshit knives." Named enemies in the real corpus are concrete: "dollar-store knives," "garage sale rejects," "that sad nonsense in your drawer," "stainless junk" — never "inferior knives," and never a named real competitor brand or public figure (see C.6 for the celebrity-reference flag).

**Note:** `01-brand/product-catalog.md` contains scraped spec-sheet facts for factual accuracy. Reading a spec there does not make it writable in a brief.

### C.2 Hooks: setup-then-turn, 19–30 words.

Every hook from NK173 onward uses a **two-or-three-sentence setup-then-turn hook**, 19–30 words:
> *"We had a customer send back his LOKI Viking yesterday. Not because it was bad — because our timing was."* (19 words)
> *"Guy in my DMs called me a straight-up liar this week. Said no single knife replaces a whole kitchen setup. Fine — let me lie to your face on camera."* (30 words)

**The real constraint is not length — it's that the second sentence must TURN AGAINST the first.** `Not because it was bad — because our timing was.` / `Fine —`. A long hook that turns is correct; a short hook that just states is weaker. Write the turn; let the word count fall where it falls.

The five real hook families (older, still valid as devices, just apply the setup-then-turn shape to them):
1. **Numbered promise** — "5 reasons why the Feather Knife broke the internet."
2. **Reverse psychology** — "For God's sake, do NOT buy this knife if you're comfortable with your old dull knife."
3. **Comedic third-party story** — "Okay guys listen, this dumbass returned his knife yesterday. Said it was too big."
4. **Confession / self-indictment** — "I almost missed this one — and I've been collecting for over a decade."
5. **Craft-time contrast** — "Three months. That's how long it takes to make these knives. And they're gone in weeks."

First-person and second-person both work; **never mix them inside one hook.**

### C.3 The offer: never first, always bridged, never a swerve.

> ### 🚫 NEVER INVENT AN OFFER. The only offers that exist are B2G2, B1G1 and the % tiers.
> The failure mode is subtle: the invented offer usually arrives as a **narrative device**, not as an offer badge — "so they're sending one to everyone who bought last month", "we refunded them all", "we're replacing them free". It reads as generous storytelling; it is a **public commitment the business then has to honour**, and it costs real money.
>
> **Never write any of these unless they are a live, confirmed offer:** retroactive gifts to past buyers · free replacements · blanket refunds · price-drop rebates · free upgrades · "we'll send you another one" · anything that promises value to customers who have already purchased.
>
> Scarcity and generosity in NK copy come from **forge time and the standing offer only**. If a script needs a goodwill beat, use what is already true: lifetime warranty, 30-day money-back, free returns, free shipping.

**Three findings:**

**(a) An offer tag on a brief does NOT mean the offer goes in the script.** NK130 and NK147 are both tagged B2G2 and **state no offer anywhere in the copy** — the offer lives on the badge and landing page. Forcing B2G2 into every script is itself an error.

**(b) The offer is never the first VO line** for narrative/story formats. It lands at ~60–80% of runtime, after product proof, and is **always followed by 2–4 more beats** (urgency → guarantees → CTA). It is never the last line either. Offer-led/holiday formats can legitimately open on the deal instead — that's a distinct, deliberate format choice, not the default.

**(c) The offer is never a lone sentence** — it always carries an immediate restatement of what you actually get: "Your choice on all four" · "That's four hand-forged Viking knives shipped to your door for the price of two. You pick the other 2 yourself. No mystery. No guessing."

**The five approved bridges into the offer:**
1. **"Right now…"** — "…and right now, the crazy hooligans at Northern Knife are giving away one of their limited edition Loki series knives when you order two."
2. **"Here's the deal —"** — "Here's the deal — buy any two knives, get two more completely free. Your choice on all four."
3. **Offer as the punchline of the story already running.**
4. **Premise escalation** — "Suddenly you're that guy with the Viking blade… **And we're making it worse with** Buy 2, Get 1 Free."
5. **Hook-promise fulfilment** — hook raises a want → offer resolves it as "the cheat code."

**THE RULE THAT WAS BROKEN — write this on the wall:**
> **A transition breaks when the offer *replaces* the subject instead of *resolving* it.** Every real transition keeps the same grammatical subject or narrative thread across the seam. And: **the hook's setup must be paid off by the body before the offer is allowed to appear.** If a hook raises a question, the script answers that question first. The offer then arrives as a consequence of the answer.

### C.4 Register: blunter and more fragmented than it feels safe to write.

The real corpus is markedly cruder and more clipped than any AI-written brief tends to default to. Confirmed-shipped, confirmed-winning lines:
> "Stop messing around in the kitchen with shitty store-bought knives and get yourself something fit for a king." — VIKINGSALE_H2
> "Okay guys listen, this dumbass returned his knife yesterday." — NK127

Mechanical tics of the real voice — use them:
- **Fragments as complete beats.** "Heavy. Sharp. Well-balanced." · "Slice your meat, pop your beer, never miss a beat."
- **Contractions always.** No "do not"/"cannot"/"it is" in spoken copy except deliberate emphasis ("Do NOT buy this knife").
- **The brand refers to itself in third person, informally** — "those crazy hooligans at Northern Knife," "they're running…". The speaker is a customer relaying news, not the brand announcing.
- **Mid-sentence self-interruption** — "Too big for what? Does it hurt? Your wrist, I mean."

**Announcer scaffolding to delete on sight** (appears in AI briefs, zero real ones): "here's the best part" · "let's do the math" · "and here's the thing" · "it's a crime to only own one" · any sentence explaining the brand's own pricing logic to the viewer. Food cuts "like butter" — never "like water."

**Recent closes run 25–30 words: directive + offer restatement + guarantee.** The current shape is CTA → **proof stack** → **parting jab** (loops back to the hook's premise):
> *"Click the link. Build your four."* → *"Or keep believing this is the scam. Not the $400 knife block you never touch. Up to you."*
> *"Whatever you decide — at least don't drop two hundred bucks on one blade."*
> *"Thanks for being smarter than the other guy."*

The proof stack is a near-verbatim house asset: *"100,000 customers. Lifetime warranty. 30-day money-back trial. Free returns. Free shipping."*

**House transition markers** (this is the connective tissue — every seam is a discourse marker plus a *retained subject*, never a subject swap): `Now —` · `So —` · `But here's the catch` · `That said` · `Here's the reason it works` · `Because right now` · `Turns out` · `Which means` · `That's the point` · `Fair question` · `Answer's no` · `Just move fast`. **The seam always answers a question the previous beat just raised**, and the offer arrives as the *consequence* of that answer.

Money is always spoken, never symbolic (`forty bucks a knife`, `Four hundred bucks for a full set` — `$` appears only in a parting jab). No brief anywhere contains a timestamp, runtime target, or word count in the copy itself — pacing is governed entirely by the 3–4 second rule.

### C.5 Never reuse the same offer paragraph across product versions.

If the same sentence appears in two product versions of one batch (e.g. identical offer paragraph copy-pasted across Feather/Blackout/Santoku), rewrite one of them.

### C.6 Compliance flags — treat as hard stops, not style notes.

- **Never name a real public figure/celebrity in ad copy**, even as a flattering comparison ("hotter than [named celebrity]"). This is a legal/right-of-publicity concern, confirmed flagged in the real corpus (NK141) — stop and note it rather than writing it, even if a structurally similar device appears in an inspo ad.
- **Never invent a customer/review-count figure.** Default to the two confirmed ad-safe figures: "5,000+ reviews" and "100,000+ happy customers" (`02-personas/00-START-persona-overview.md`).
- **Never write a live inventory count** ("6 left") for Feather — these are point-in-time snapshots that go stale. Default to the evergreen "restocks take three months" cadence instead.

---

## D0. ⚠️ THE STATIC BRIEF IS TINY — for context only, this routine writes VIDEO briefs (Section D)

A Notion **production** brief is a work order for a designer/editor, not a chat-reply concept pitch — it is short, with no prose sections, no "Concept"/"What worked"/rationale blocks. The same discipline applies to the video brief format below: work order, not essay.

## D. THE VIDEO BRIEF — the real Notion production format

**The real video brief**, block by block:

```
Batch name
<table> Batch name | NK212_Customer Return_Generalist_Multi_AI VO_MIKE- BBQ KING_B2G2_New_Andy_Umar_PDP
 (blank) | NK212_Customer Return_Generalist_Multi
</table>

File naming
<table> NK212_VID_Customer Return_1D_Generalist_Multi_AI VO_MIKE- BBQ KING_B2G2_New_Andy_Umar_PDP_072826
 NK212_VID_Customer Return_2D_...
 NK212_VID_Customer Return_3D_...
 (blank row)
 (blank row)
</table>

### AD INSPO
<video src=""></video> ← or an <embed> of the TrendTrack share URL

<callout 💡 gray_bg> IMPORTANT NOTICE ON PERSONA/AVATAR:... </callout>

### GENERAL INSTRUCTION
- Always apply the 3-4 sec rule:
 - Changing of visual every 3-4 sec to avoid boring moment.
- Avoid awkward moment, remove dead air on the audio.

### GLOSSARY:
- TC= Time Clips
- Super = Black text with White textbox
- Caption= White text with Black textbox
---
## Creative Brief Instruction
- 1
<callout 💡 gray_bg> ElevenLabs V3 + Enhance + Loom link </callout>

**HOOK**
<table header-row> header green_bg: **Visual** | **Copy/ Text Overlay** | **Note**
 3 rows — one per hook. Visual = Frame.io link or a short shot note. Note usually blank.
</table>

**BODY**
<table header-row> header orange_bg: Block | **Visual** | Copy/ Text **Overlay** | **Note**
 one row per cut. Block is usually left EMPTY. Visual = Frame.io link or short shot note.
 Copy = the spoken VO, using <br> for breath/cut breaks. Note usually blank.
</table>
```

**That is the entire brief. There is no prose anywhere on the page.**

### NEVER put these on a video brief page
`### Concept` / concept explainer · `Main Body:` clean-read block · `### Details` 4-column table · `Production guardrails` · `A/B testing protocol` · `SOURCE AD REFERENCE` / source description · `CATEGORY DECISION` · `WIN RATE SCORE` section · `Transfer tier` · "Our angle" · any adaptation rationale in a Note cell.

**Win Rate Score, Category, Iteration Of, Source Ad ID/Advertiser/URL are database PROPERTIES.** They already exist as columns. They never appear as page sections.

### Column details that matter
- **HOOK is 3 columns** (`Visual | Copy/ Text Overlay | Note`) — there is no `Block` column on the hook table.
- **BODY is 4 columns** (`Block | Visual | Copy/ Text Overlay | Note`) — `Block` exists but is **left empty** in every recent brief.
- The **VO lives in the "Copy/ Text Overlay" column**, not a separate VO column.
- ⚠️ **That column contains ONLY the spoken ad copy — the script, nothing else.** **Never write `SUPER:` / `Caption:` / `Graphic:` labels or any on-screen-text directive into it.** Deciding which lines become supers or captions is the creative strategist's call at production time, not something the brief pre-empts.
- **Visual direction goes in the Visual column** — short notes in house vocabulary: `Talking head` · `Montage clip of X` · `Broll clip of X` · `Unboxing clip of X` · `Forging clip` · `Splitscreen: Top… Bottom…`. When adapting from a TrendTrack inspo ad and no Frame.io footage exists yet, describe the shot needed in plain language instead of leaving it blank.
- **Note column is almost always blank.** Use it only for an audio instruction, a VO exclusion, or a whole-brief directive.
- **No timestamps, no runtime, no word counts** anywhere on the page. Pacing is governed by the 3-4 sec rule alone.

### Multi-product draft briefs
When one draft page carries several product versions, give **each product its own `**HOOK**` table + `**BODY**` table** under a plain heading naming the product. The shared blocks — persona callout, GENERAL INSTRUCTION, GLOSSARY, Creative Brief Instruction, ElevenLabs callout — appear **once**, at the top, not repeated per product. **This routine always writes all 3 focus products on one draft page per inspo ad**, one HOOK/BODY pair each, named `## Feather Knife`, `## BJORN Series Santoku`, `## LOKI Blackout Edition`.

**Avatar × product pairing (hard rule):**
- **JOHN → Feather Knife and BJORN Santoku** — both sections must exist on every draft page that includes either product. In JOHN's spoken copy, don't call the narrator a "collector" line after line — he's a man who knows knives; the word earns at most one appearance per page.
- **MIKE → LOKI Blackout Edition.**

### Default database property values for this routine
Set on every page this routine creates (per Andy's standing instruction — do not vary these without being told otherwise):
- **Status:** `Ready for visual`
- **Strategist:** `Mark`
- **Format:** `VID`
- **Content:** `AI VO`
- **Avatar:** `JOHN` for Feather Knife or BJORN Santoku pages · `MIKE` for LOKI Blackout Edition pages
- **Editor:** pick any name from the team roster at random per page — this one field does vary page to page, unlike the rest.
- **Source Ad ID / Advertiser / URL:** fill from the actual TrendTrack inspo ad.
- **Iteration Of / Category:** leave as the database's own default unless the inspo ad is clearly a direct iteration of an existing brief.

### Emoji
**Page icon carries it: `📽️` for video. Headings are plain text — no emoji.** Set the icon on every page.

## E. Product accuracy — load-bearing facts, not style preferences

Product specs are load-bearing. Incorrect product details are not style issues — they are factual errors with real consequences. Default to explicit product rules over inference.

| Product | Rule |
|---|---|
| **Feather Knife** | Blade pattern is **laser-applied**. **Never describe the technique**, and never call it hand-finished, hand-etched, or engraved. Limited drops (~500 units), ~3-month restock, rosewood handle. |
| **BJORN Series Santoku** | Norse engravings on blade, dragon-sculpted **brass** bolster, hand-carved wooden handle. **Never reference Japanese origins or use the word "Japanese"** — not even as a comparison. |
| **LOKI Blackout Edition** | Bottle opener built into the **handle**. Ebony wood handle, high-carbon steel, full tang. |

**Persona corrections (supersede anything conflicting in `02-personas/`):**
- **JOHN** — scarcity framed around **manufacturing complexity, never deadlines.** **No deal or discount language at all.**
- **MIKE** — outdoor/grill/BBQ self-buyer, Viking-heritage angle. No gift framing.

## F. Originality gate — the mechanic transfers, the words never do

**This is the single most-repeated correction in this project's history:**

> *"No verbatim copying when adapting winning ads — structural mechanics can be preserved, but every sentence must be freshly written. No source ad language carried over, even when the structural beat is identical."*
> *"Structural adaptation ≠ language reuse. When a winning ad is adapted for a new product, every line must be rewritten from scratch. The mechanic transfers; the words do not."*

Before finalizing any brief, mentally check: does any run of 6+ consecutive words match the inspo ad's actual script? If so, rewrite that line. Does any run of 6+ words match one of our own existing briefs (in `04-what-works/real-briefs/` or a brief already written earlier in the same batch)? If so, rewrite it — don't let the same paragraph get copy-pasted across product versions.

**Allowlist** — offer mechanics, guarantees, brand claims and standard CTAs ("Buy 2 Get 2 Free", "lifetime warranty", "hand-forged", "cuts like butter") are excluded. Those *should* be identical every time; matching them is correct, not copying.

**The one exception:** if a specific line from the inspo ad is explicitly called out as worth keeping verbatim (rare, and only when it's core to the whole concept), keep it and state plainly in the brief which line is a deliberate kept line, so it reads as intentional rather than sloppy. Absent that, the default is always: rewrite every line.
"