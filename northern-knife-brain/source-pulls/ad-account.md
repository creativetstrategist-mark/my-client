---
scope_warning: "⚠️ UK META ACCOUNT ONLY — stamped 2026-09-10, after this doc was written. Every ad-account figure below covers the UK Meta account (act_1897335644135093 / AURORA | A12264703 | NorthernKnife_UK_3) and NOTHING ELSE. The US store carries a further $316,988.95 of Meta spend in the same 90 days at 1.68 ROAS, and no document in this brain has ever seen it. So every 'the account' statement here means 'the UK account', and every claim of the form 'this account has never run X' is unproven for the paid business as a whole. Read audits/2026-Q3/attribution-reconciliation.md before acting on anything below."
brand: northern-knife
doc: ad-account
generated_on: 2026-09-07
refresh_by: 2026-10-07
sources_read:
  - "Meta ad account `AURORA | A12264703 | NorthernKnife_UK_3` (id 1897335644135093), USD, Europe/London, the brand's only connected ad account, via Parker MCP `search_facebook_ads_sql`"
  - "Window A — last 90 days, 2026-06-09 to 2026-09-06: account totals, age/gender/device/platform delivery split, and the top 20 ad-name groups by spend"
  - "Window B — last 30 days, 2026-08-08 to 2026-09-06: account totals and delivery split, pulled to test whether the served audience is moving"
  - "Window C — account lifetime: account totals, delivery split, and the top 15 ad-name groups by spend"
  - "Four persona cuts over the 90-day window, filtered on the persona token inside the ad name: `MIKE`, `JOHN`, `SARAH`, `VANCE`, each returning its own spend, purchases, return and delivery split"
  - "Creative media: full video analysis of the account's number-one spender (NK222) from its playable media URL via Parker MCP `analyze_video_from_url`, giving transcript, on-screen text, shot description, on-camera talent and offer placement"
  - "Creative media: Parker's stored visual hook, text hook, verbal hook and angle fields for 11 further ads in the two top-spender lists"
  - "Ad copy as served: headline and primary text for all 20 ads in the 90-day top-spender list and all 15 in the lifetime list"
  - "running-notes/brand-rules.md, running-notes/brand-notes-from-org.md, running-notes/missing-context.md (all read 2026-09-07)"
ads_read: "Spend, return and delivery read across every ad running in the window — 1,864 ad-name groups over 90 days, 988 over 30 days, 2,431 over the account lifetime. Creative read in detail on 20 ad-name groups: 1 by full video analysis, 11 by Parker's stored hook and angle fields, and all 20 by their served headline and body copy. Attribution is Meta's own, per ad set, 7-day click and 1-day view."
data_limitations:
  - "Parker's AI creative analysis has not run on the account's newest and biggest ads. Every ad created from roughly late July 2026 onward came back with empty `ad_analysis`, `ad_summary`, `creator_demographic`, `script` and hook fields — that includes the top three spenders (NK222, NK168, NK284) and NK313, NK300, NK219 and NK214. Together those seven carry $63,500.46 of lifetime spend. I closed the gap on NK222 by analyzing its video directly, and left the other six read from served copy and performance only. Their on-screen talent and settings are unread. Anywhere this doc calls an August ad's casting, it says so."
  - "No post-purchase survey data exists for this brand — zero responses. So nothing in this doc can be checked against a buyer stating why they bought. Every served-audience read here stays inferred until the reviews, comments and reputation docs confirm or break it."
  - "The account exposes delivery demographics, not converter demographics. When this doc says an ad reached 80% men, that is where the spend went, not who bought. Meta does not break purchases out by age and gender at the ad level here."
  - "Persona spend is measured by matching the persona token inside the ad name. That is an inventory handle, not proof of who the ad serves, and it is the count only — it cannot tell you the creative actually spoke to that person. A name carrying two tokens would double-count; I saw none in the sets I read, but I did not check all 1,864."
  - "RESOLVED 2026-09-10: this doc's own pull was the right one. It flagged that `BUILD-STATUS.md` recorded 1,005 ads and $194,644.63 lifetime spend against its own 2,431 ad-name groups and $497,553.67, and did not resolve which was right. The 1,005 / $194,644.63 set was a 30-day query summary block misread as lifetime and is now discredited everywhere in this brain. The verified lifetime set is $497,553.67 spend, 2.03 ROAS, $143.15 AOV, 7,066 purchases across 2,431 ad-name groups — this doc's figures. Every number here is from its own pull on 2026-09-07 and stands."
  - "Northbeam is not connected and the team reads performance in Triple Whale, so these Meta figures will not tie out exactly against the dashboard the team looks at."
---

# Ad account — persona signal — Northern Knife

## Served-audience signals

The short version: this account is written for four people and delivered to roughly one.

Northern Knife names four personas and stamps them into every ad name, which makes the served-audience read unusually easy to run here. Most accounts make you guess who the creative courts. This one tells you, then the delivery data tells you whether the guess landed. Running those two against each other is the whole finding.

Here is the 90-day picture, 2026-06-09 to 2026-09-06, against an account that spent $339,477.28 and bought 4,864 purchases at a 2.23 return and a $69.79 cost per purchase. `verified` from the account, all five rows pulled the same way.

| Cohort | Ad-name groups | Spend | Share of spend | Purchases | ROAS | CPA | AOV | Male share of spend | Aged 35-44 |
|---|---|---|---|---|---|---|---|---|---|
| MIKE - BBQ KING | 480 | $124,421.04 | 36.7% | 1,517 | 2.12 | $82.02 | $173.56 | 80.4% | 32.7% |
| JOHN - KNIFE COLLECTOR | 381 | $74,104.24 | 21.8% | 973 | 2.22 | $76.16 | $168.94 | 76.0% | 32.6% |
| VANCE - VALUE OPPORTUNIST | 190 | $44,717.58 | 13.2% | 663 | 2.10 | $67.45 | $141.33 | 69.6% | 37.7% |
| SARAH - WIFE | 130 | $16,535.07 | 4.9% | 289 | 1.64 | $57.21 | $94.08 | 14.5% | 46.5% |
| No persona token in the name | 683 | $79,699.35 | 23.5% | 1,422 | 2.61 | $56.05 | $146.55 | not pulled | not pulled |
| **Account** | **1,864** | **$339,477.28** | **100%** | **4,864** | **2.23** | **$69.79** | **$155.62** | **73.0%** | **35.0%** |

The residual row is arithmetic: the account total minus the four persona cuts. Spend and purchases both reconcile, so the 683 groups with no persona token are a real cohort, not a rounding artifact.

**Served audience 1 — the man 35 to 54 who cooks over fire, reached broadly on a phone.** `inferred`, strong, and this is where nearly all the money goes.

MIKE, JOHN and VANCE are written as three different men. Meta delivers them to what looks like the same one. The gender split runs 80.4%, 76.0% and 69.6% male. The age concentration runs 32.7%, 32.6% and 37.7% in the 35-44 bracket. Add 45-54 and each cohort sits near 55% of spend in that twenty-year band. Device is 98.6%, 98.7% and 99.2% mobile. Platform is 66%, 67.8% and 68.1% Facebook. Those are not three audiences. Those are three labels on one audience, and the spread between them is smaller than the noise you would expect from three genuinely different targets.

There is a plain mechanical reason for that. Every named-persona ad in the 90-day top 20 carries `Generalist` in the targeting slot of its own name. The team is not asking Meta to find MIKE and then separately find JOHN. It is running broad and letting the auction choose, which is the right posture under the current delivery system, but it means the persona has to live entirely in the creative. If the creative does not look and sound different, the algorithm has nothing to split on, and it will hand all of it to whoever converts cheapest. That is what the numbers show it did.

What that man is being sold, read from the creative rather than the label: hand-forged steel, Norse and Viking naming, a blade heavy enough for brisket and pretty enough to hang on a wall, and four knives for the price of two. From the full video analysis of NK222, the account's biggest ad, the on-camera presence is "an average-build male with fair skin, dark hair, and a short beard, wearing casual black t-shirts," apparently late twenties to late thirties, plus a second middle-aged man in an office scene. Settings run modern kitchen, campfire, grass, office. Every visible person in that ad is a man. `verified` from the video.

**Served audience 2 — the woman buying for a man, and only in a gifting window.** `inferred`, strong, and it is the one place the account genuinely reaches somebody else.

SARAH is the only cohort whose delivery flips. She took 84.8% of her spend on women against 14.5% on men, and she concentrates harder on 35-44 than anyone else at 46.5%. She is a real, separate audience and the account proved it. She is also the smallest bet at 4.9% of 90-day spend, she runs a different offer to everyone else at buy two get one rather than buy two get two, and her orders are much smaller: $94.08 average order value against the account's $155.62.

But read what she is actually served. NKFD046's primary text opens "Tired Of Buying Him Things He Never Uses?" and continues "You know the look. The polite 'thanks babe' smile. The drawer where good intentions go to die." NKFD020's verbal hook is "My dad loves to cook. I believed this is exactly what he needed," over a visual of a daughter and dad on a couch with a branded black box. NKFD054 opens "3 Reasons NOT to buy your husband the Loki Knife this Father's Day." `verified` from Parker's stored hook and copy fields. The persona is not even called SARAH the gift buyer in the account. It is called `SARAH - WIFE`. In every piece of creative I read, she is buying for him. There is nothing here that speaks to a woman who wants the knife for her own kitchen.

**Served audience 3 — the deal hunter, who the account keeps finding whether it means to or not.** `inferred`, mixed confidence, because the label and the behavior are tangled.

VANCE is named as a persona, but the deal message is not confined to VANCE. It runs through almost everything. The offer sits in 16 of the 20 top-spending ads. It sits inside MIKE ads, JOHN ads and SARAH ads. So the account is courting the deal hunter continuously and only sometimes admitting it. More on that under the message map.

**What the whole body serves, said plainly.** Across 1,864 ad-name groups and $339,477.28 in 90 days, this is a near-single-audience account with one real second lane that only opens for a few weeks a year. The breadth the four-persona naming implies is not in the delivery.

## Message-to-buyer map, frequency-ranked

Ranked by how heavily each message recurs across the winning creative and how much spend sits behind it. Recurrence counted against the 20 ad-name groups in the 90-day top-spender list, which together carry $120,102.21, or 35.4% of 90-day spend.

**1. "Four blades for the price of two." Recurs in 16 of 20 top spenders.** The single biggest real bet in the account by a wide margin, and it is not a persona message at all. Buy two get two free plus up to 64% off appears in the copy or headline of 16 of the top 20, across all three products and all four personas. `verified` from the served ad copy.

Which buyer it wins: the deal-led one, and here is the part that matters. The four ad-name groups in the top 20 with **no persona token at all** are all offer-led statics, and they are the best-returning creative in the list. P466 "UP TO 64% OFF!!" returned 3.77 at $41.66 a purchase. Z090 "PICK ANY 4" returned 3.47 at $51.36. U088 "LAST CALL" returned 3.18 at $47.93. Across the whole 683-group residual, the return is 2.61 at $56.05, better than every named persona. `verified`.

**Read that with the funnel caveat or you will read it wrong.** Those statics are bottom-of-funnel demand capture. They lead with the offer, they close people who already knew the brand, and statics skew that way as a rule. The MIKE and JOHN videos are doing the harder cold-audience job. Comparing them straight is comparing a closer to a prospector. What the number does prove is narrower and still useful: when this account stops writing to a persona and just states the offer, it converts more cheaply than any of its four personas do. Whether that is the offer working or the persona writing not working is the open question, and it is genuinely open.

**2. "This is the knife your friends ask about." Recurs in 10 of 20.** The display and status message. NK222's copy: "It's the blade you keep visible on your kitchen wall, the one your friends ask about the second they walk in." NK284, selling the BJORN Santoku, uses the same sentence with the wall swapped in. NK222's video calls the RAGNAR "the piece that stops conversation when someone walks into the kitchen." N090's headline is "SOME PIECES DESERVE A BETTER PLACE." `verified` from served copy and the NK222 video.

Which buyer it wins: `inferred`, the man who wants the object seen. In the Life Force 8 frame this is running on *to be superior, winning, keeping up with others* and *social approval*, not on any pain. Northern Knife is not a problem-solution brand and the winning copy already knows it. Nobody has a knife problem. They want the feeling of owning the thing, and the account sells the transformation and the craft story rather than agitating a pain, which is the right instinct for this category.

**3. "Forged for the guy who runs the grill." Recurs in 6 of 20.** The heaviest MIKE message and the most spend behind any single persona voice. NK168's copy: "a blade forged for the men who cook like they mean it: brisket over fire, ribs in the smoker, steak on the cast iron every Sunday." NK313 and NK219 run near-identical lines. `verified`.

Which buyer it wins: `inferred`, the weekend cook. And this is the message the brand runs heaviest that returns worst. NK168 is the standout at 2.39 and $80.99, but NK313 returns 1.75 at $106.94 and NK219 returns 1.85 at $107.17. The MIKE cohort as a whole returns 2.12 against the account's 2.23, on 36.7% of spend. So the brand's biggest persona bet is its weakest-returning one. That mismatch is the highest-value line in this section.

**4. The story hook that resolves into the offer. Recurs in 6 of 20, and it is the format behind the two biggest ads.** NK222, NK194, NK284, NK313, NK219 and NK127 all run some version of a customer who tried to return a knife. NK194's verbal hook: "Hey, look, I love your Feather Knife, but I think you might have made a mistake with my order." NK222 opens on a close-up of the Feather beside its black box with the text "Alright / This absolute lunatic," then tells a three-minute story about a customer who shipped his knife back because he missed the deal by 96 hours. `verified` from full video analysis.

In the hook taxonomy this is a Storytelling hook with a Trigger Word planted in the first two seconds. It is genuinely good. It builds a curiosity gap, it makes the offer the *resolution* of a story rather than an announcement, and it earns a 38.8% hook rate and 13.23% hold rate on a 2:37 runtime, both of which clear the bar.

Which buyer it wins: `inferred`, the man already circling the purchase who needs the math made obvious. In the buying-phase frame this is Evaluation creative, not Trigger creative. It does not make anyone want a knife. It resolves the one hesitation of someone who already does.

**5. "Every collector who touched this said the same thing." Recurs in 3 of 20, thin but interesting.** The only genuine JOHN-as-collector message in the set. NK080's visual hook is "Older man with gray hair in a pink polo shirt holding two large feather-shaped knives in a kitchen," angle logged as "The 'Collector's Choice' angle." NK117 opens "I almost didn't get one of these" over a Norse-etched Santoku stuck into a tree trunk, angle "Limited Edition / Collector Scarcity." NK222's video carries the scarcity beat too: "This is the knife that sold out inside two weeks last drop." `verified`.

Which buyer it wins: `inferred`, and the economics are good. NK080 bought purchases at $46.48 and NK117 at $56.05, against a lifetime account CPA of $70.42. Both beat the account. Both are small. This is the message the account under-runs relative to how well it does.

**6. The gifting message. Recurs in 4 of 20 and it is seasonal.** Father's Day and St. Patrick's Day creative, always framed to a woman buying for a man. P142's headline: "THIS ST. PATRICK'S DAY, GIVE A GIFT THAT DOESN'T GET RETURNED." P272's: "A GIFT THAT STANDS OUT." `verified`. Returns are middling to good on cost, weak on return because the orders are small.

**The message nobody is running.** Across every ad I read, in copy and in hook fields, I found no message built for a woman buying the knife for herself, no message built for a man over 55, and no message that treats the knife as a serious tool for someone who is neither a griller nor a collector. More on that below.

## Spend concentration and what it serves

**Concentration is low. This account spreads its money.** The number-one ad takes 4.4% of 90-day spend. The top three take 12.2%. The top five take 16.8%. The top 20 take 35.4% of $339,477.28, spread over 1,864 ad-name groups. `verified`. That is a real testing operation, not a one-winner account. Under the current delivery system, which rewards genuinely different ads rather than more ads, volume at this level is only an asset if the ads are actually distinct — and that is exactly where this account has a problem, covered under the gap below.

**Where the money actually sits, and who it serves.**

MIKE takes 36.7% of spend on 25.8% of the creative variants. Meta is pushing MIKE creative harder than the team built it, which under the breakdown effect is the system saying MIKE creative is where the cheap results are on the margin, even though MIKE's blended return is below the account. Both things can be true at once and usually are. The system optimizes toward the next result, not toward the best average.

JOHN takes 21.8% on 20.4% of variants — proportional, and JOHN returns at the account average with a better cost per purchase than MIKE, $76.16 against $82.02.

VANCE takes 13.2% and returns 2.10 at $67.45.

SARAH takes 4.9% in the last 90 days but was the account's fourth-biggest lifetime spender at $11,105.98 on a single ad-name group, NKFD046. So the SARAH bet is not small. It is seasonal, and this window catches its tail.

The 683 groups with no persona token take 23.5% and return best.

**The audience the allocation serves without appearing to intend to: the deal hunter.** Nearly a quarter of spend sits on creative that names no persona and leads with the discount, and it is the cheapest-converting money in the account. Meanwhile the offer is stapled into 16 of the 20 top-spending persona ads as well. Whatever the team believes it is buying, a large share of this budget is buying discount-motivated purchases.

**The audience the allocation is starving: everybody over 55, and every woman not framed as a gift-giver.** Men and women aged 55 and over took $52,889.45, or 15.5% of 90-day spend, rising to 18.0% in the last 30 days. That is real money finding real people. The creative aimed at them is one ad. Women took 25.9% of 90-day spend, and the only creative that speaks to a woman speaks to her about a man.

**One thing worth flagging on account health.** Three of the 20 top spenders show a status of DISAPPROVED or paused while still holding position in the list, including NK222 at number one and NK184 at number seven. The two disapproved ads carry $20,580.00 of 90-day spend between them. That is a delivery question rather than a persona question, so it does not belong in this doc's findings, but a doc reading spend concentration should say when the top of the list is not cleanly live.

## Unserved audiences

Named as absences, because each one is a kind of buyer this account's creative never addresses.

**The woman who wants the knife for herself.** The single clearest gap. Women took $87,911.76 of 90-day spend, 25.9% of the account. The only creative built for a woman casts her as a wife or a daughter solving a man's gift. The persona is named `SARAH - WIFE`. Her copy asks "Tired Of Buying Him Things He Never Uses?" She is never the cook. `verified` on the creative, `inferred` on the absence, and the absence is what makes it a finding: a quarter of the delivery goes to women and none of the message does.

**The man over 55.** 55-64 plus 65+ took 15.5% of 90-day spend and 18.0% of the last 30 days. One winner in either top-spender list casts an older man on screen, NK080, and it bought purchases at $46.48 against a $70.42 lifetime account average. The account has one data point saying older talent works and has not run a second. `verified` on the numbers, `inferred` on the read.

**The serious cook who is not a griller and not a collector.** Every message in this account routes to fire or to display. There is nothing for the person who just wants a very good knife and cooks on a stove on a Wednesday. NK214 gets closest — "Weeknight dinner in the kitchen. Sunday BBQ with the family. Camping trip prep by the fire" — and it returns the best of any video in the top 20 at 3.08 with a $59.23 cost per purchase. It is one ad and it still hangs the message off the BBQ. `verified`.

**The buyer under 25.** 5.5% of spend, no creative aimed there. At $79.90 to $99.90 this is probably the right call, and I would not treat it as an opportunity without a reason from the buyer sources.

**The gift-giver outside a holiday window.** Gifting creative appears only around Father's Day and St. Patrick's Day. A knife in a black box with a magnetic closure is a gift all year — birthdays, weddings, housewarmings, Christmas. The account only ever says so in March and June.

## Served-versus-stated gap

**What the brand appears to think it is targeting.** Four personas, stated directly in `brand-notes-from-org.md` and stamped into every ad name: JOHN the knife collector, MIKE the BBQ King, SARAH the gift buyer, VANCE the deal-led generalist. Products are mapped to them — Feather to JOHN, BJORN Santoku to JOHN, LOKI Blackout to MIKE with SARAH for gift framing and VANCE for deal-led. `stated`.

**What the winners reveal it is reaching.** One audience of men 35 to 54 on a phone, on Facebook, found broadly, and closed with a bundle discount. Plus one genuinely separate audience of women 35 to 44, live for a few weeks a year, and only ever addressed as somebody's wife.

Four gaps sit inside that, and I am leaving all four unresolved for the synthesis to weigh against the actual-buyer sources.

**Gap 1 — MIKE and JOHN are not two personas in this account. They are two labels on one served audience.** This is the load-bearing one. Set the two side by side. Delivery: 80.4% versus 76.0% male, 32.7% versus 32.6% aged 35-44, 98.6% versus 98.7% mobile, 66.0% versus 67.8% Facebook. Creative: they share the same two headlines, rotating "⚔️ Some Knives are Tools. This one is Art." and "🔪 The Blade Built To Replace 5 Kitchen Knives" across both. They share a body-copy opener — the sentence "If You Invest in One Cooking Tool, This Should Be It!" appears in 16 of the top 20, across three products and all four personas. They share the same offer, the same `AI VO` voice treatment, the same `Generalist` targeting, and the same two landing pages. `verified` on every one of those.

Under the differentiation hierarchy, format matters most, then vehicle and hook, then persona and angle, then messaging. A persona swap only creates real separation when it comes with a visual change in the first three seconds. Here the persona swap comes with a name change and almost nothing else. The account is asking the algorithm to treat these as different ads while handing it the same format, the same voice, the same headline and the same offer. It should not be a surprise that they reach the same people. Two labels, one entity, one crowd.

**Gap 2 — two of the four named personas are behavioral overlays wearing persona clothes.** A persona is a trigger-anchored identity: who somebody is plus the moment that activates them. A behavioral overlay is a buying behavior that cuts across every persona — deal-motivated, gifting, travel. Every persona can exhibit an overlay, which is exactly why an overlay is never itself a persona.

`VANCE - VALUE OPPORTUNIST` is the deal-motivated buyer. `SARAH - WIFE` is the gifting buyer. Both are textbook overlays. The account's own data says so: the deal message runs through 16 of the 20 top spenders including every MIKE and JOHN ad, which is the definition of a behavior that cuts across personas rather than a person. And SARAH's delivery only separates during a gifting window, which is a season doing the work, not an identity.

This is not a naming complaint. It has a consequence. Treating a discount behavior as a person means the account never has to ask who the discount buyer actually *is*, and it lets promotional creative quietly skew the read of who buys. The honest version is that Northern Knife has one or two real trigger-anchored identities and two overlays sitting on top of them, and the synthesis should hold that against what the reviews and comments say. `inferred`, and I hold it as mine.

**Gap 3 — the served audience is narrowing, and nobody appears to have called it.** Male share of spend runs 66.4% lifetime, 73.0% over 90 days, 76.9% over the last 30. Female share runs the other way: 32.6%, then 25.9%, then 22.0%. `verified` across three separate pulls. That is a ten-point swing toward men since the account's lifetime average, moving steadily.

The likely cause is plain: the female share was inflated by Father's Day gifting creative in May and June, and as that creative wound down the account snapped back to men. This is exactly the pattern where the whole ideal customer profile flips for a season rather than the message needing a tweak. The consequence is a planning one. Q4 gifting is the next window, it is roughly three months out, and the evidence says this brand's buyer genuinely changes shape when it opens. The account is currently at its most male right before the season that makes it least male.

**Gap 4 — the product a winner sells is not always the product in its name.** NK222 is named for the Feather and is the account's biggest ad. Its back half walks through four different knives: the Feather, the LOKI Viking, the RAGNAR Tiger Cleaver and the LOKI Blackout Edition, then closes "Four blades, price of two." Roughly a third of a 2:37 runtime is a catalog tour. `verified` from the video. Five more of the top 20 carry `Multi` in the product slot. So the account's biggest bets are frequently collection ads with a single product's name on them, which means product-level reads taken off the ad names will be wrong in a predictable direction.

> ⚠️ **Two product hard rules are broken inside the account's number-one ad, and one of them is new.** `brand-notes-from-org.md` already flags that NK222's body copy says the Feather is "hand-forged with an insane feather etching," against the rule that the pattern is laser-applied. The video transcript makes it worse and adds a second break. On the Feather it says "Rosewood handle, hand-fitted. Three months in the workshop, one blacksmith per blade." On the LOKI Blackout it says "a bottle opener notched **into the blade**," where the hard rule is that the opener is built into the **handle**. `verified` from the transcript at 2:12. This is the ad carrying $15,056.46 of 90-day spend and it is currently DISAPPROVED. Somebody at the brand needs to answer whether the rules moved or the ad is off-brief, before any new Feather or LOKI copy gets written off it.

## Behavioral-signal states the creative leans on

Captured as situational states layered on a buyer, not as identities, so the synthesis can attach them to whichever personas survive.

**Missing out on a deal by a hair.** The strongest state in the account and the engine of its best story creative. NK222's whole narrative is a man who "realized he'd missed it by 96 hours" and shipped his knife back rather than eat the loss. `verified` from transcript. High intensity, negative going positive, and it is resolved rather than left open — the brand fixes it for him in the story. That resolution is what makes it work rather than just making the viewer anxious.

**Doubting the offer is real.** NKFD040's verbal hook: "Does Northern knife really give away free knives?" That is a Scam hook, and it returned 3.95 at a $39.01 cost per purchase, the best economics in the lifetime top 15. `verified`. The state is suspicion, and inviting it converts better here than asserting past it.

**Wanting the object seen.** Running through ten of the top 20. "The one your friends ask about the second they walk in." "The piece that stops conversation when someone walks into the kitchen." Low intensity, positive, aspirational. In the mindstate frame this is Esteem and Belonging, not Security or Competence.

**Cooking over fire on a weekend.** Brisket low and slow, ribs in the smoker, Sunday steak on cast iron, campfire settings in the NK222 footage. A time and a place more than a person, which is part of why MIKE reads as a moment rather than an identity.

**Completing a collection before it sells out.** "Sold out inside two weeks last drop." "Every collector who touched this said the same thing." NK117's Limited Edition scarcity angle. The Feather's roughly 500-unit drops give this state a real basis rather than a manufactured one, and the two ads carrying it are among the cheapest converters in the account.

**Owing somebody a gift he will actually use.** "The drawer where good intentions go to die." "GIVE A GIFT THAT DOESN'T GET RETURNED." A deadline state, seasonal, and the only one that reliably reaches women.

## Recurrence and spread

**What was read.** Every ad running in three windows, by spend and delivery: 1,864 ad-name groups over 90 days carrying $339,477.28, 988 groups over 30 days carrying $160,265.18, and 2,431 groups over the account lifetime carrying $497,553.67. Creative was read in detail on 20 ad-name groups — the 90-day top 20 by spend, which together carry 35.4% of 90-day spend, plus the lifetime top 15, which overlap heavily.

**How the creative was read, and how much rests on what.** One ad, NK222, was read from full video analysis: transcript, every on-screen text card with its timecode, shot description, on-camera talent, and offer placement. Eleven ads were read from Parker's stored visual hook, text hook, verbal hook and angle fields. All 20 were read from the headline and body copy as served. Six of the top spenders — NK168, NK284, NK313, NK300, NK219, NK214 — have no creative analysis in Parker at all, so for those the read rests on served copy and performance only, and their casting and settings are unread. Those six carry $49,047.29 of 90-day spend, so a meaningful slice of the top of this account has had its copy read and its pictures not.

**How heavily each message recurs, against the 20-ad denominator.** Offer, 16 of 20. Shared body-copy opener "If You Invest in One Cooking Tool, This Should Be It!", 16 of 20. Display and status, 10 of 20. Two headlines covering the whole list, split 5 and 5 across the video winners. Grill and fire, 6 of 20. Return-story hook, 6 of 20. Gifting, 4 of 20. Collector scarcity, 3 of 20.

**How heavily each audience recurs, against the 1,864-group denominator.** MIKE 480 groups, JOHN 381, VANCE 190, SARAH 130, no token 683.

**Format spread in the top 20.** Fifteen video, five static. The statics carry $17,850.03 and returned 3.00 at $52.04. The videos carry $102,252.18 and returned 2.24 at $78.47. Every one of the five statics is offer-led, so read that split as demand capture against cold reach rather than as static beating video.

**Hook and hold, and a caution.** Hook rate on the video winners runs 14.86% to 61.23%. A hook rate above 30% is the working floor and hold above 12% is the working floor, so most of this set clears both. But hook rate and return do not travel together here. NK284 has the best hook rate in the account at 61.23% with a 21.76% hold, and it still buys purchases at $97.33 against the account's $69.79. NK214 stops only 20.33% of viewers and returns the best of any video in the list at 3.08 with a $59.23 cost per purchase. A high hook rate proves the ad is interesting. It does not prove it is selling.

**Confidence, stated honestly.** The delivery reads are strong: real spend, real breakdowns, three windows agreeing on direction. The message recurrence reads are strong, counted directly off served copy. The reads of who each ad is *built to serve* are inferred from creative and delivery together, and they are only as good as the creative I could see, which for six top spenders was copy without pictures. Nothing here has been checked against a buyer saying why they bought, because this brand has zero post-purchase survey responses. Until the reviews, comments and reputation docs land, every persona claim in this doc is a served-audience claim and not a buyer claim.

## Open loops

**1. Three personas, one crowd.**
MIKE, JOHN and VANCE are written as three different men and Meta delivers them to what looks like one: 80.4%, 76.0% and 69.6% male, and 32.7%, 32.6% and 37.7% aged 35 to 44, across $243,242.86 of 90-day spend.
*Pull — Surprise.* Three separately written personas landing on a single indistinguishable audience is not what a four-persona account is supposed to look like, and the size of that sameness is the signal.
**What actually separates the person who buys the Feather from the person who buys the LOKI Blackout?**
If the buyer sources say one person, the team can stop paying to write four voices and put that effort into formats and casting instead. If they say three, the creative has to start looking as different as the labels claim. Either answer changes the next quarter of production.
*Territory: Personas.*

**2. The women in the delivery are never the cook.**
A quarter of 90-day spend, $87,911.76, went to women, and the only creative built for a woman frames her as a wife or daughter solving a man's gift. The persona is literally named `SARAH - WIFE`.
*Pull — Gap.* There is a quarter of the account's delivery going to women and nothing has ever been made for a woman who wants the knife herself.
**How many women buy a Northern Knife for their own kitchen, and what do they say they wanted it for?**
If a real share of buyers are women cooking for themselves, the account has never once spoken to them, and that is the cheapest new lane available. If they genuinely are almost all gift buyers, then SARAH is a seasonal overlay and should be planned as one instead of staffed as a persona.
*Territory: Personas.*

**3. The one older face in the account is one of its cheapest buyers.**
NK080 opens on "an older man with gray hair in a pink polo shirt holding two large feather-shaped knives" and bought purchases at $46.48 against a $70.42 lifetime account average. Men and women over 55 took 18.0% of the last 30 days of spend. That is the only ad in either top-spender list casting an older person.
*Pull — Gap.* Real money is finding people over 55 every day and one piece of creative has ever acknowledged them.
**Who are the buyers over 55, and what made them buy?**
Casting older talent is a cheap, fast change with one encouraging data point already behind it. Knowing whether the over-55 buyer is a collector, a gift-giver or something else decides what that creative should say.
*Territory: Creators and talent.*

**4. The best-returning money in the account has no persona on it.**
The 683 ad-name groups with no persona token took 23.5% of 90-day spend and returned 2.61 at a $56.05 cost per purchase, better than all four named personas. They are also all offer-led, which is a different job from the persona videos.
*Pull — Tension.* The account's own numbers say persona writing underperforms no persona writing, and the funnel difference could explain all of it or none of it.
**How much of that gap is the discount doing the work rather than the audience?**
If persona-written creative is not beating a plain offer statement once the funnel job is matched, the whole four-persona operation is costing more than it earns and the roadmap should shift toward formats. If it is beating it, the offer statics are simply cheap closers and both should keep running.
*Territory: Messaging.*

**5. The best hook in the account is one of its worst buys.**
NK284 stops 61.23% of viewers, holds 21.76% of them, and still buys purchases at $97.33 against the account's $69.79. NK214 stops 20.33% and returns 3.08 at $59.23.
*Pull — Curiosity.* An ad that is this good at getting attention and this bad at converting it is doing something specific between the hook and the checkout, and the numbers alone will not say what.
**What is happening between the hook and the cart on the Santoku?**
The Santoku is one of the three focus products and the account's third-biggest bet. If the drop-off is the landing page, that is a fast fix. If it is the promise the hook makes, the whole Santoku angle needs rewriting.
*Territory: Messaging.*

**6. Gift buyers spend barely half of what everyone else spends.**
SARAH's average order value is $94.08 against the account's $155.62, and her return is 1.64 against 2.23. She converts cheaply at $57.21 a purchase and then buys small.
*Pull — Surprise.* A gift buyer paying less than a self-buyer runs against the usual pattern, where people spend more on a present than on themselves.
**What does a gift buyer actually put in the cart?**
Q4 is the next gifting window and it is about three months out. If gift buyers are taking the smallest bundle, the offer and the bundle structure aimed at them need rethinking before the season, not during it.
*Territory: Product.*

**7. The biggest ad in the account sells four knives under one knife's name.**
NK222 is named for the Feather and spends roughly a third of its 2:37 runtime walking through the Feather, the LOKI Viking, the RAGNAR Tiger Cleaver and the LOKI Blackout before closing on "four blades, price of two."
*Pull — Pattern.* Six of the top 20 are collection ads carrying a single product's name, so the same shape keeps recurring at the top of the account.
**Which knife is actually closing the sale when an ad shows four of them?**
Every product-level read taken off ad names is wrong in the same direction until this is answered, including which of the three focus products deserves the next round of creative.
*Territory: Product.*

**8. The top-spending ad contradicts two of the brand's own hard product rules.** `Brand-only — routes to the brand.`
NK222's transcript says the Feather is "hand-forged" and "hand-fitted," "three months in the workshop, one blacksmith per blade," where the rule is that the pattern is laser-applied. It also says the LOKI Blackout has "a bottle opener notched into the blade," where the rule is the opener is in the handle. This ad carries $15,056.46 of 90-day spend and is currently DISAPPROVED.
*Pull — Tension.* The brand's written product law and the brand's best-performing ad cannot both be right, and the ad is the one spending the money.
**Which is current: the hard rules as written, or the claims running in the top ad?**
Every piece of Feather and LOKI copy this brain writes depends on the answer, and the daily rewriting routine is generating from these rules right now.
*Territory: Product.*

---

## Method sign-offs

Proof-of-read for the expertise docs loaded before this analysis. No `brand-lens.md` exists in this brain yet, so no brand overlay was available to bend the generic method — worth creating, since the product hard rules and the naming convention are exactly the tribal knowledge a lens should hold.

*This is everything I know about non-problem-solution creative.*

*This is everything I know about seasonality in creative.*

*This is based on everything I have learned about luxury and high-priced brands.*

**Brand Context Applied:**

- **What I used:** The four named personas and the ad naming convention from `brand-rules.md`; the product hard rules, copy rules and team names from `brand-notes-from-org.md`; the stated north-star metric of ROAS with its reference points (2.18 over the last 30 days and **2.03** lifetime — corrected 2026-09-10; this line previously cited 2.26 lifetime, which is one of the discredited figures); the known dark surfaces from `missing-context.md`, above all the zero post-purchase survey responses, which set the confidence ceiling on every persona claim here.
- **What I avoided:** I did not repeat or normalize the product claims that break the brand's hard rules. Where the top-spending ad says the Feather is hand-forged and hand-etched, and says the LOKI Blackout's bottle opener sits in the blade, I quoted it as evidence of a conflict and flagged it for a human answer rather than carrying it forward as fact. I did not use the word "Japanese" anywhere near the BJORN Santoku. I did not state any profitability conclusion, because gross margin is not known, so every return figure here is a revenue read and not a profit read.
- **Why this fits:** Northern Knife is scaling on a stated ROAS goal while running a four-persona creative operation, and this pull says the delivery does not yet reflect four personas. Under the current Meta delivery system, differentiation is what buys incremental reach, and a persona label that comes with the same headline, the same body-copy opener, the same offer and the same voice treatment does not differentiate anything. That is a solvable problem and it sits directly on top of the team's daily rewriting routine, which currently writes three product versions of every source ad off the same three rules. The next gifting window is roughly three months out, and the account is at its most male right before the season that reliably makes it least male.

*This is everything I know about Andromeda v2.*
