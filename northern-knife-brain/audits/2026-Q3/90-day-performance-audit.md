---
scope_warning: "⚠️ UK META ACCOUNT ONLY — stamped 2026-09-10, after this doc was written. Every ad-account figure below covers the UK Meta account (act_1897335644135093 / AURORA | A12264703 | NorthernKnife_UK_3) and NOTHING ELSE. The US store carries a further $316,988.95 of Meta spend in the same 90 days at 1.68 ROAS, and no document in this brain has ever seen it. So every 'the account' statement here means 'the UK account', and every claim of the form 'this account has never run X' is unproven for the paid business as a whole. Read audits/2026-Q3/attribution-reconciliation.md before acting on anything below."
brand: northern-knife
doc: 90-day-performance-audit
quarter: 2026-Q3
generated_on: 2026-09-07
refresh_by: 2026-12-06
date_range: 2026-06-09 to 2026-09-07
comparison_range: 2026-03-11 to 2026-06-08
data_sources_read: [Parker MCP search_facebook_ads_sql on ad account AURORA | A12264703 | NorthernKnife_UK_3 (act_1897335644135093), Meta reporting under per-ad-set attribution 7-day click / 1-day view, running-notes/brand-rules.md, running-notes/success-definition.md, running-notes/brand-notes-from-org.md, running-notes/missing-context.md]
prior_quarter_baseline: "none. No prior 90-day performance audit exists in audits/. The prior-quarter baseline in this doc was rebuilt by re-pulling the 2026-03-11 to 2026-06-08 window from the same source, not carried forward from an earlier doc."
data_limitations:
  - "Placement-position breakdown is not available. Parker's account breakdown exposes publisher platform and device, not placement position. The Meta Ads connector login reaches only act_8557554027677317 and act_1771028750359089, so a platform_position pull on act_1897335644135093 was refused. Section five is data-limited and reads platform instead of placement."
  - "Reach and frequency are not exposed in either the aggregate summary or the per-ad rows, so no frequency or cost-per-1,000-accounts-reached read is possible this quarter. Every audience-saturation claim here is inferred from CPM and spend growth, not measured."
  - "Gross margin was not provided. Every profitability statement in this doc is a revenue statement, not a profit statement."
  - "No brand marketing calendar doc exists in the brain. The calendar overlay in this audit was rebuilt from creative launch dates, campaign names and ad copy in the account itself."
  - "Stored AI creative analysis is missing for the five highest-spending ads in the window. Their visual hook, first frame and on-screen talent could not be read. Creative claims about those five are copy-level only and are marked as such. Creative read unavailable for their visuals."
  - "CORRECTED 2026-09-09. Three different lifetime figure sets appeared during this build and only one is verified. The run brief carried $194,644.63 spend / 2.26 ROAS / $174.07 AOV — discredited: that block was a 30-day query summary misread as lifetime. This doc originally substituted $404,808.64 / 2.17 / $148.20 from its own 2026-09-07 pull and called it the live pull — also unverified, and superseded: that pull did not scope to lifetime explicitly and returned a partial set. The VERIFIED lifetime figures, from an explicit lifetime-only query, are $497,553.67 spend, 2.03 ROAS, $143.15 AOV, 7,066 purchases across 2,431 ad-name groups. Reject $194,644.63, 2.26, $174.07, 2,531, 1,005, $404,808.64, 2.17 and $148.20 on sight. This correction touches lifetime figures only. Every figure in the body of this doc is a 90-day window figure (2026-06-09 to 2026-09-07) pulled directly and is unaffected."
  - "The account reports 4,897 leads in the window against 4,887 purchases, and 0 leads in the prior window. The lead event looks mis-mapped, so no lead metric is used in this audit."
  - "Northbeam is not connected and the team reads performance in Triple Whale. Every number here is Meta's own, under the account's per-ad-set attribution of 7-day click and 1-day view, and will not tie out against Triple Whale's pixel attribution."
---

# 90-day performance and delivery audit — Northern Knife — 2026-Q3

## Executive summary

The account did not drift this quarter. It changed shape. Northern Knife spent $341,183.20 across 91 days from 2026-06-09 to 2026-09-07, against $131,538.58 in the 90 days before it. That is 2.59 times the money, or $209,644.62 more, and it did not come at the usual price. ROAS went from 1.70 to 2.23, revenue went from $223,523.49 to $760,803.50, and cost per purchase held almost exactly flat at $69.81 against $69.19. `verified` from the Parker pull of the connected account on 2026-09-07, both windows read the same way. For a brand whose stated objective is to scale acquisition and whose north star is ROAS, this is the rare quarter where the two moved together instead of trading against each other.

The largest shift in distribution is gender, and it is not close. Male share of spend went from 48.9 percent to 73.1 percent, which is $64,282.72 becoming $249,310.54. Female share fell from 50.3 percent to 25.9 percent. `verified` from the age and gender breakdown in both windows. The cause is not a targeting change, because the account runs broad. It is a creative change with a season under it. The prior window held the Father's Day push, whose top spender NKFD046 opens its body copy with "Tired Of Buying Him Things He Never Uses?" and closes with "Solve his gift, your dad's gift, done." That ad is written to a wife buying for a husband. The current window is written the other way. NK168, the second-highest spender at $14,254.90, says the Loki Blackout is "a blade forged for the men who cook like they mean it: brisket over fire, ribs in the smoker, steak on the cast iron every Sunday." `verified` from the ad copy of both ads. The auction followed the copy. This is the seasonal ICP flip in its textbook form, and it means the flip back into Q4 gifting has to be built now rather than in November.

Delivery itself moved less than the audience did. Facebook still takes most of the money at 67.7 percent, or $230,933.69, with Instagram at 32.3 percent, or $110,061.24. Instagram gained 3.5 points of share and grew 2.90 times in absolute dollars against Facebook's 2.47 times. Mobile is 98.6 percent of spend. Messenger, Audience Network and Threads together took $195.42, which is six hundredths of one percent, so they are noise, not a lane. The real gap in this section is that placement position is not readable from either connected source this quarter, so the account can be described by platform but not by feed against Reels against Stories. That blank is named rather than guessed at, and it is the one thing most worth fixing before the next run.

Nothing in the baseline set is outside a healthy range, and two things are worth watching. Hook rate across the ten highest-spending ads, weighted by their spend, is 39.1 percent, which clears the 30 percent floor but sits under the 45 to 50 percent band that good looks like now. Hold rate is 14.4 percent, inside the 12 to 15 percent band and near the top of it. CPM rose 19.2 percent from $11.60 to $13.83, which is the ordinary price of buying 2.59 times more impressions, and CTR rose from 1.23 percent to 1.77 percent at the same time, so the account is paying more for attention and getting more of it. The one live problem is not a metric. NK222, the single largest spender in the account at $15,056.46, carries an effective status of DISAPPROVED, as does NK184 at $5,523.54. `verified` from the status fields on 2026-09-07. That is $20,580.00 of proven delivery sitting on a policy hold, and it sits next to the copy conflict the team already flagged, because NK222 says the Feather is "hand-forged with an insane feather etching down the spine" when the brand's own rule says the pattern is laser-applied and must never be called etched or hand-finished.

## Totals

The reference block for the window of 2026-06-09 to 2026-09-07, 91 days, from the connected Meta account AURORA | A12264703 | NorthernKnife_UK_3, in USD, under 7-day click and 1-day view attribution. Prior-window figures cover 2026-03-11 to 2026-06-08, 90 days, from the same source.

- Total spend: **$341,183.20**, against $131,538.58 prior. Up 159.4 percent.
- Average daily spend: **$3,749.27**, against $1,461.54 prior.
- Total ads with delivery: **1,980**, against 475 prior. Of these, 1,107 are video and 873 are static.
- Total purchases: **4,887**, against 1,901 prior. Up 157.1 percent.
- Total purchase value: **$760,803.50**, against $223,523.49 prior. Up 240.4 percent.
- Total impressions: **24,669,871**, against 11,343,256 prior. Up 117.5 percent.
- Total link clicks: **302,305**, against 91,456 prior.
- Total add to carts: **161,467**, against 32,147 prior.
- Total checkouts initiated: **14,143**, against 4,845 prior.
- Account ROAS: **2.23**, against 1.70 prior.
- Account CPA: **$69.81**, against $69.19 prior.
- Account AOV: **$155.68**, against $117.58 prior.
- Account CPM: **$13.83**, against $11.60 prior.
- Account CTR: **1.77 percent**, against 1.23 percent prior.
- Cost per link click: **$1.13**, against $1.44 prior.
- Reach and frequency: **not exposed by the source**. Data-limited.

## Age group breakdown by spend

Spend by age bracket for the window runs like this. The 35-44 bracket takes the most at $119,268.79, or 35.0 percent. Next is 45-54 at $76,335.65, or 22.4 percent, then 25-34 at $73,684.69, or 21.6 percent. Then 55-64 at $42,505.71, or 12.5 percent, 18-24 at $18,669.07, or 5.5 percent, and 65+ at $10,722.17, or 3.1 percent. `verified` from the account's own age breakdown across all 1,980 delivering ads. Against the prior window the share picture barely moved in the middle and moved at the edges. The 35-44 bracket gave up 4.6 points of share, falling from 39.6 percent. The 55-64 bracket gained 2.5 points, rising from 10.0 percent. The 18-24 bracket gained 1.5 points, 65+ gained 0.5, 25-34 gained 0.4 and 45-54 lost 0.2.

Share is the wrong lens on a quarter where the budget nearly tripled, though, so read the absolute growth instead. Every bracket grew, and the ones that grew fastest are the ones at the ends. Spend on 18-24 grew 3.57 times, 55-64 grew 3.22 times and 65+ grew 3.16 times, against 2.29 times for the 35-44 core. The account did not shift away from its center. It kept the center and bought a lot more of the shoulders. Combined 45+ spend is now $129,563.53, or 38.0 percent of the account, up from $46,326.17 and 35.2 percent. `verified` from both windows. Under a scale objective this is exactly the movement you want to see, because the shoulders are where the next increment of budget has to live once the core saturates, and the shoulders absorbed it without the account CPA moving.

The interesting part is who those shoulders are, because the creative does not name them. The brand works in four personas and the account encodes them in ad names. Every one of the ten highest-spending name groups in the window carries either MIKE - BBQ KING or JOHN - KNIFE COLLECTOR in its name. `verified` from the ad names, which are inventory handles and are used here only to describe how the account is organized. Neither of those two is written as a 55-64 buyer, and neither is written as an 18-24 buyer. So the fastest-growing brackets in the account are being reached by creative built for somebody else and they are converting anyway. That is not a failure, it is an unclaimed lane, and it is the clean version of the "check what you think you know about the customer" problem that shows up at this spend level.

One more read the age data supports. At roughly $112,000 a month the account sits between the get-shots-on-goal band and the volume-and-new-audiences band. The plays that fit that middle are consistent output, founder-led creative while the founder is still relatable, and a hard focus on which ads actually reach fresh accounts rather than resell the same ones. The first two are visibly happening, since the account moved from 475 delivering ads to 1,980. The third cannot be checked this quarter, because reach and frequency are not exposed. Marked data-limited, and it is the single measurement most worth restoring before the next audit, because without it the 55-64 growth could be genuine new reach or it could be the same people seen more often, and those two call for opposite decisions.

## Gender breakdown by spend

Male took $249,310.54, or 73.1 percent of spend. Female took $88,276.29, or 25.9 percent. Unspecified took $3,602.76, or 1.1 percent. `verified` from the account breakdown across the full window. In the prior window the same three lines read $64,282.72 and 48.9 percent male, $66,139.18 and 50.3 percent female, and $1,116.68 and 0.8 percent unspecified. So male spend grew 3.88 times while female spend grew 1.33 times, and the split swung 24.2 points in one quarter. This is the largest single movement anywhere in this audit.

The account runs broad, so the auction did this, not a targeting setting. What steered the auction was the creative, and the creative changed with the calendar. The prior window carried the gifting run: NKFD046 is a Father's Day sale ad whose name carries the SARAH - WIFE persona token and whose copy speaks straight to a woman buying for a man, and P142 is a St. Patrick's Day static headlined "THIS ST. PATRICK'S DAY, GIVE A GIFT THAT DOESN'T GET RETURNED." `verified` from the copy and headline of both. The current window carries the grilling run, and its copy is addressed to the man doing the cooking. Read the two side by side and the auction's vote makes sense. It is not drift and it is not a problem. It is the ICP flipping with the season, which is what happens to a giftable product, and the honest read is that the brand has two different buyers who trade places twice a year.

That framing is what makes this finding actionable rather than just interesting. Q4 is the bigger gifting window and it starts inside the next quarter. If the Q3 creative stays on alone, the account walks into Black Friday and Christmas holding a library written for the self-buyer, and the female half of the buying base has to be rebuilt from cold. The pattern the account already proved in May and June is that gift-framed creative pulls the split back toward even within weeks. So the work is to build the gift-giver creative now, three to four months ahead of the peak, and layer it on top of the grilling winners instead of swapping them out. The evergreen carries proven value props and tends to hold up during the season, so the seasonal ads are additions, not replacements.

There is one caution worth stating plainly. Nothing in this data says the male buyer is more valuable than the female buyer. It says the male buyer is who the current creative reaches. AOV rose from $117.58 to $155.68 in the same window that the split flipped, which is consistent with a self-buyer who buys a bundle under the buy-two-get-two offer, but the two moves are tangled with the offer change and cannot be separated with what is here. `inferred`, and it rests on the offer copy and the AOV movement together, not on a clean test. Without gross margin, none of this can be turned into a profit statement either.

## Placement breakdown

The placement-position split this section is built for is not available this quarter. Parker's account breakdown exposes publisher platform and device but not position, and a direct Meta pull on act_1897335644135093 was refused because the connected login only reaches act_8557554027677317 and act_1771028750359089. So the Facebook Stories against Instagram Stories against Reels against Feed picture is a blank, and every read below is at the platform level instead. Marked data-limited. It is a real loss, because the account is 100 percent vertical video and static built for mobile, and format fit against position is exactly the check this section exists to run.

What can be read: Facebook took $230,933.69, or 67.7 percent of spend. Instagram took $110,061.24, or 32.3 percent. Messenger took $2.70, Audience Network took $61.91 and Threads took $130.81, which together come to $195.42, or 0.06 percent. Mobile took $336,565.68, or 98.6 percent, against desktop's $4,624.71 and 1.4 percent. `verified` from the account breakdown. Prior window read 71.2 percent Facebook, 28.8 percent Instagram and 99.0 percent mobile. So Instagram picked up 3.5 points of share and grew 2.90 times in dollars while Facebook grew 2.47 times, and desktop crept up four tenths of a point off a tiny base.

The platform mix says something useful even without position data. Heavy Facebook delivery points at an older, more deliberate audience in a lean-back browsing mode, and that lines up with the age picture, where 38.0 percent of spend lands on 45 and over. Instagram gaining share at the same time the 18-24 bracket grew 3.57 times is the same story from the other end. The account is not moving from one platform to another. It is widening, and the platform mix is following the age spread rather than leading it. There is a sharper version of this in the top-spending block: the five highest-spending ads in the window take 40.5 percent of their spend on Instagram against the account's 32.3 percent, and skew 80.5 percent male against the account's 73.1 percent. `verified` from the five-ad breakdown pulled on 2026-09-07. The newest, hardest-working creative is the most Instagram-weighted and the most male-weighted thing in the account.

The format read has to stand in for the fit read this quarter. Video took $257,101.18, or 75.4 percent of spend, across 1,107 ads, returning 2.10 ROAS at a $75.22 CPA. Statics took $84,082.02, or 24.6 percent, across 873 ads, returning 2.64 ROAS at a $57.24 CPA. `verified`, computed from the all-ads and static-only pulls on both windows. On the surface the statics look like the better buy, and that read is a trap. The top static in the window is P466, headlined "UP TO 64% OFF!!" with body copy that leads on "BUY 2 GET 2 FREE across the entire site." `verified` from the creative. That is bottom-of-funnel demand capture. It closes people who were already close, and it should not be judged on the same field as a video built to reach somebody who has never heard of the brand. Grouped by the job they do, the video block is carrying the growth and the static block is harvesting it, and both numbers are healthy for their own job. Statics did move from 20.7 percent to 24.6 percent of spend, which is worth watching, because an account that keeps drifting toward offer statics is quietly trading reach for efficiency, and that is the wrong trade under a scale objective.

## Baseline account metrics, last 90 days

The core set for the window. ROAS 2.23, up from 1.70. CPA $69.81, up 62 cents from $69.19. AOV $155.68, up from $117.58. CPM $13.83, up from $11.60. CTR 1.77 percent, up from 1.23 percent. Cost per link click $1.13, down from $1.44. `verified` from the period summaries of both windows. On the video-behavior side, hook rate weighted by spend across the ten highest-spending ads is 39.1 percent and hold rate is 14.4 percent, on a base of $83,676.12 of spend, which is 24.5 percent of the account. Those two are a sample of the account's top block, not an account-wide figure, because the source does not expose an aggregate hook or hold rate. Reach and frequency are not exposed at all.

Read against the ordinary starting points, the account is healthy. CTR at 1.77 percent clears the one percent line comfortably and improved by 0.54 points while spend nearly tripled, which is the harder version of that achievement. Hold rate at 14.4 percent sits inside the 12 to 15 percent band. Hook rate at 39.1 percent clears the 30 percent minimum but does not reach the 45 to 50 percent band that strong openers hit now, and that is the clearest place to look for the next lift. The spread inside the top block tells you the ceiling is reachable with this account's own creative: NK284 opens at 61.13 percent and NK219 at 49.45 percent, while NK117 opens at 15.23 percent and NK194 at 17.65 percent. `verified` from per-ad video metrics. Nine hundred basis points of account-level hook rate are sitting in the gap between what this team's best openers already do and what its median opener does.

CPM rising 19.2 percent is the expected cost of buying 2.59 times the impressions, and it is worth reading calmly rather than as a warning. The account bought 13.3 million more impressions, pushed into wider age brackets and lifted CTR at the same time, which is what paying more for a bigger, colder pool looks like when the creative holds up. What cannot be said this quarter is whether those impressions are landing on new accounts or on the same ones more often, because frequency and cost per 1,000 accounts reached are both unavailable. That is the one genuine hole in the health picture, and it matters more here than usual, since the whole objective is reaching people the account has not reached yet.

Two things to carry into next quarter. First, the account is much less dependent on any single ad than it was: the largest spender takes 4.4 percent of window spend against 6.5 percent last quarter, and the top ten together take 24.5 percent. `verified`, computed from the top-ten spend of $83,676.12 against the account's $341,183.20. A scale plan survives on that kind of base. Second, the iteration engine is showing a warning sign. NK313 is named as a trial of NK168, runs the same product, the same concept, the same AI voiceover and the same persona, and it delivered a 30.31 percent hook rate against NK168's 42.95 percent and a $105.78 CPA against $80.99. `verified` on the metrics; `inferred` on the cause, which is that a close iteration of a winner is the shape Meta now groups with its parent instead of treating as a new ad, so the second one inherits the first one's audience rather than opening a new one. The account cannot confirm that directly, because entity grouping is not exposed. But the pattern is the one the 2026 delivery system produces, and the fix is known: iterate by changing format, vehicle or the person on screen rather than by re-cutting the same opener. Running 1,980 ads in 91 days is not the constraint here. The system will process far more than that. Differentiation is the constraint, and three of the four Feather ads in the top ten carry word-for-word identical body copy, which is the clearest kind of false differentiator there is.

## Open loops

**1. The gender split swung 24 points in one quarter.**
Male share of spend went from 48.9 percent to 73.1 percent between the two 90-day windows, while the account kept running broad. The creative changed from gift-framed to self-buyer-framed across the same weeks.
Pull: **Surprise.** A 24-point swing in who the auction pays to reach, with no targeting change behind it, is far outside what the rest of the context would have predicted.
Question: Who is actually buying Northern Knife right now, the man who cooks or the woman buying for him?
Why it is a loop: The answer decides whether Q4 creative rebuilds the gift-giver from scratch or simply extends what is already winning, and that is the largest creative decision in the next quarter.
Territory: **Personas.**

**2. The oldest and youngest brackets grew fastest, and nothing speaks to them.**
Spend on 55-64 grew 3.22 times and 18-24 grew 3.57 times, against 2.29 times for the 35-44 core, while all ten of the highest-spending name groups carry only MIKE - BBQ KING or JOHN - KNIFE COLLECTOR.
Pull: **Gap.** There is real, growing delivery into two brackets that no named persona was written for, and nothing has been built for either.
Question: What is drawing the 55-64 buyer to this account when no creative was written for her or him?
Why it is a loop: If something in the current work is accidentally landing with an older buyer, naming it turns an accident into a lane the account can deliberately buy into while scaling.
Territory: **Personas.**

**3. A quarter of the spend is doing bottom-of-funnel work at a flattering price.**
Statics took 24.6 percent of spend at 2.64 ROAS and a $57.24 CPA, against video's 2.10 and $75.22, and the top static leads with "UP TO 64% OFF!!" and a buy-two-get-two offer. Static share also rose 3.9 points from last quarter.
Pull: **Tension.** The cheaper number belongs to the ads doing the easier job, so the account's efficiency and the account's growth are pointing in different directions.
Question: How much of the account's purchase volume would still happen if the offer statics stopped running?
Why it is a loop: It separates demand the advertising creates from demand it merely closes, and that is the number a scale plan actually has to grow. Only the brand can answer part of this, since it needs order-level and margin data Parker cannot see.
Territory: **Product.**

**4. The iteration of the winner underperformed its parent on every attention metric.**
NK313 is named as a trial of NK168 and shares its product, concept, voice treatment and persona. It opened at 30.31 percent against NK168's 42.95 percent and cost $105.78 per purchase against $80.99.
Pull: **Pattern.** The same shape shows up elsewhere in the top ten, where three of the four Feather ads carry word-for-word identical body copy.
Question: How different does an iteration have to be here before it reaches people the original never touched?
Why it is a loop: The team's whole scaling motion runs on iterating winners, so knowing where the line sits changes what every brief in the next sprint asks for.
Territory: **Messaging.**

**5. The three focus products are not separating on returns.**
Inside the ten highest-spending name groups, which carry 24.5 percent of window spend, Feather concepts took $32,693.39 at 2.35 ROAS, Loki concepts took $33,936.69 at 2.08, and Santoku concepts took $17,046.04 at 2.05. Product is read from each ad's own body copy, not from its name.
Pull: **Curiosity.** Three products at three different price points and three different stories land within 0.30 of each other on return, which is a tighter cluster than the differences between them would suggest.
Question: Which of the three products can absorb the next $50,000 of monthly budget without its return falling apart?
Why it is a loop: A scale plan has to put the incremental money somewhere, and right now the data gives no reason to prefer one product over another.
Territory: **Product.**

**6. Every top-spending ad is machine-voiced, and nobody can see who is on screen.**
All ten of the highest-spending name groups carry an AI VO token, and the stored creative analysis for the five biggest spenders is missing, so their visuals and on-screen talent could not be read at all.
Pull: **Gap.** An entire production choice sits under the account's whole spend base with no counter-example anywhere in the top block.
Question: What does a real human voice and face do for this account that the AI voiceover version does not?
Why it is a loop: It decides whether the next round of creative needs a creator roster and a budget line for one, or whether the current production model is the right one to scale.
Territory: **Creators and talent.**

## Method sign-offs

Loaded and reasoned through before the analysis: `ad-account-analysis.md` for the top-spender method, the breakdown effect, the profitability and user-behavior metric sets and the funnel-stage caveat; `ad-metrics-glossary.md` for the hook, hold, frequency and placement definitions and the rule-of-thumb benchmarks; `killer-performance-ads.md` for the bar the creative is graded against; `andromeda-v2.md` for entity grouping, the differentiation hierarchy and the false differentiators; `creative-strategy-by-brand-size.md` for the plays that fit this spend level; and `seasonality.md` for the gifting-window ICP flip. No brand lens exists at `brand-lens.md` yet, so the brand's own tribal knowledge was taken from `running-notes/brand-notes-from-org.md`, `running-notes/brand-rules.md` and `running-notes/success-definition.md`.

**Brand Context Applied:**

- **What I used:** The stated objective of scaling acquisition and ROAS as the north star, which set headroom over efficiency as the ranking rule throughout. The four named personas and their encoding in the ad naming convention, used only to describe how the account is organized. The three focus products and their hard rules. The team's stated reading of performance in Triple Whale, which is why the attribution source is named wherever a number matters. The absence of gross margin, which is why no profit claim appears anywhere in this doc.
- **What I avoided:** No spec-sheet jargon, in line with the brand's standing copy rule. The Feather copy conflict is reported as a conflict rather than repeated as fact, since the brand's rule says the pattern is laser-applied and must never be called etched, hand-etched or hand-finished. No claim is made about the Santoku's origin. No creative claim rests on an ad name, and no visual claim is made about the five top spenders whose stored creative analysis is missing.
- **Why this fits:** Northern Knife is trying to scale acquisition, and this quarter it did, nearly tripling spend while lifting ROAS from 1.70 to 2.23. The findings that matter most are the ones that decide whether that keeps working: the audience flipped male with the season and has to flip back for Q4 gifting, the iteration engine is showing signs of feeding Meta ads it treats as the same ad, and the account's own top opener proves there are 20 points of hook rate available inside the current creative team's range. All three are inside the team's control before the next quarter starts.

This is everything I know about Andromeda v2.

This is everything I know about tailoring creative strategy to brand size.

This is everything I know about seasonality in creative.

## Appendix - Parker media links

Every ad named in the body of this audit, indexed so a strategist can reopen it without searching. All links preserved exactly as returned by Parker MCP on 2026-09-07.

**M001 — NK222_VID_Return Feather Lunatic_1B_Generalist_Feather_AI VO_MIKE - BBQ KING_B2G2_Iteration_Andy_Hammad_PDP_080326.** Discussed in: executive summary, baseline metrics, open loop 4. Highest-spending ad in the window at $15,056.46, currently DISAPPROVED.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120252508701740631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/e62d62f2e37efddd0ee0b0f1184e702e20612ea8b472bcd3e3a7fc4940dd9a70.mp4
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife

**M002 — NK168_VID_Return Box_2D_Generalist_LOKI Blackout_AI VO_MIKE - BBQ KING_B2G2_New_Andy_Hammad_PDP_072326.** Discussed in: executive summary, gender breakdown, baseline metrics, open loop 4. Second-highest spender at $14,254.90.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120252175748810631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/9179a1843ac41623c23e7573bfda7ec6eeb6bdedad05d3c4a4e5c88f7216e931.mp4
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife-2

**M003 — NK284_VID_Big Brain Return His Knife - Santoku_3B_Generalist_Santoku_AI VO_JOHN - KNIFE COLLECTO.** Discussed in: baseline metrics, open loop 5. Highest hook rate in the top block at 61.13 percent.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120252866023940631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/9e0c13cdc9acdec4d4d8d6cae6379ed9e5dd53297731dd4b378ba022122de1ae.mp4
Landing page: https://northernknife.co.uk/pages/6r-santoku

**M004 — NK313_VID_Return Box - Trial (NK168)_3D_Generalist_LOKI Blackout_AI VO_MIKE - BBQ KING_B2G2_Ite_Andy_Renniel_PDP_082026.** Discussed in: baseline metrics, open loop 4. The iteration of M002.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120252930351150631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/7c2bcd4428b76e69c3f9be4bb26ddef0c3b30cc44351c4bc1859d5a068fbbf54.mp4
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife-2

**M005 — NK194_VID_Wrong Order_1D_Generalist_Feather_AI VO_JOHN - KNIFE COLLECTOR_B2G2_New_Andy_Onyeka_PDP_072026 - Copy.** Discussed in: baseline metrics, open loop 5. Text and verbal hook: "Hey, look, I love your Feather Knife, but I think you might have made a mistake with my order." Visual hook: several black Northern Knives boxes arranged on a gray marble countertop with a voice message overlay.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120252351143760631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/3fa6a1ff5b03604df1534b912e5dda30eeba217aed95db9a6a2ed70efe02af09.mp4
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife

**M006 — NK219_VID_Return Box - Iteration 3_1D_Generalist_Multi_AI VO_MIKE - BBQ KING_B2G2_New_Mark_Onyeka_PDP_073026.** Discussed in: baseline metrics, open loop 5. Hook rate 49.45 percent.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120252435217980631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/01d911809bfd7eb5d545da94ad502bba30c3e5801705ed70cc4f1f9db8e4d358.mp4
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife-2

**M007 — NK184_VID_What if CTA Feather_3D_Generalist_Feather_AI VO_JOHN - KNIFE COLLECTOR_B2G2_Iteration_Andy_Hammad_PDP_072026 - Copy.** Discussed in: executive summary, open loops 4 and 5. Currently DISAPPROVED.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120252351105020631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/613fcec01e27920aad152a1449ca303d28a2129913f82bd56f9ed57938f05c34.mp4
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife

**M008 — NK127_VID_Return his knife - Too big_1D_Generalist_Multi_AI VO_MIKE - BBQ KING_NA_New_Andy_Hammad_PDP_061726.** Discussed in: open loop 5.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120250522538180631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/25d8f3c45d724931ad552d4d2afb53b374917dfa8241dfd92f2bde835674ac8d.mp4
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife-2

**M009 — NK300_VID_We're sorry - ASMR_3B_Generalist_Feather_AI VO_JOHN - KNIFE COLLECTOR_NA_New_Mark_Hasnain_Listicle_081826.** Discussed in: open loops 4 and 5. Hook rate 42.19 percent against a hold rate of 5.67 percent, the widest gap in the top block.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120252913341010631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/32fe03df1108fd3ef02b6898dd631c2a08c55d9bd64149fddc25a16b0474391a.mp4
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife

**M010 — NK117_VID_NK023 Santoku_3D_Generalist_Santoku_AI VO_JOHN - KNIFE COLLECTOR_NA_Ite_Mark_Umar_PDP_061726.** Discussed in: baseline metrics, open loop 5. Text and verbal hook: "I almost didn't get one of these." Visual hook: a Norse-etched Santoku stuck into a tree trunk in a blurred forest. Lowest hook rate in the top block at 15.23 percent.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120251424160670631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/be3c197065bf7b4d4154c27ee6db907fd9ec006f7bc31ef2377b9ae5f53c0eea.mp4
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife

**M011 — P466_IMG_06302026_Grilling Season_Offer_V1_LOKI_Grill_Knife_64%OFF_Ite_Pam_Pam_PDP - Copy.** Discussed in: placement breakdown, open loop 3. Highest-spending static in the window at $3,874.46. Headline: "UP TO 64% OFF!!"
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120251349667150631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Image: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/dfdfb7d2dd6ecf148b921c17d137ba7a4ec2fafd08a629075203b2b22e33320d.jpg
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife-2

**M012 — NKFD046_VID_Fathers Day Sale_1D_Worth it _LOKI_AI VO_SARAH - WIFE_B2G1_New_Andy_Hammad_051826.** Prior-window comparison. Discussed in: executive summary, gender breakdown. Text hook: "NorthernKnife is on sale for Father's Day." Verbal hook: "NorthernKnife is on sale for Father's Day. But is it really worth it as a gift?" Visual hook: close-up of Northern Knife Ragnarok Rising boxes on a plain surface.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120249008768220631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/42750b4baa71ae4d1fa544e2f9af19857590aa01ee1f3c0be8da471dbf22554e.mp4

**M013 — P142_IMG_02262026_St. Patrick's Day_Gifting_V1_Multi_Green Box_Husband_56%OFF_Ite_Pam_Pam_PDP.** Prior-window comparison. Discussed in: gender breakdown. Headline: "THIS ST. PATRICK'S DAY, GIVE A GIFT THAT DOESN'T GET RETURNED."
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120243901814750631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Image: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/282161af27431bf3f78682e2e8ca4705557b357651436dfb81c180c30733502a.jpg
Landing page: https://northernknife.co.uk/pages/6-reasons-why-millions-are-switching-to-northernknife

**M014 — NK080_VID_Collection Last Piece_1D_Genaralist_Feather_AI VO_JOHN - KNIFE COLLECTOR_NA_New_Mark_Jason_Listicle_032626.** Prior-window comparison, third-highest spender in that window. Text and verbal hook: "Every collector who touched this said the same thing." Visual hook: an older man with gray hair in a pink polo shirt holding two feather-shaped knives in a kitchen.
Parker dashboard: https://app.heyparker.ai/dashboard/facebook-ads/performance?adId=120250854443380631&brandId=2ec32316-1da9-4563-a86f-d4e811e89469
Video: https://auth.heyparker.ai/storage/v1/object/public/internal-facebook-ads/2ec32316-1da9-4563-a86f-d4e811e89469/930fe8940a9b92e622c2c6057abf44b1f69080b1dfa98b1af9231a6b6fb4ca14.mp4
Landing page: https://northernknife.co.uk/products/the-feather-knife
