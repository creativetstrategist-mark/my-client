---
brand: northern-knife
doc: voc-corpus-profile
generated_on: 2026-09-08
refresh_by: 2026-12-08
raw_records_received: 3486
normalized_records: 3486
deduplicated_records_removed: 0
date_range: 2022-03-11 to 2026-09-08
sources_read:
  - "First-party customer reviews via Parker MCP `search_customer_reviews_sql` and `search_customer_reviews_semantic`, brand_id 2ec32316-1da9-4563-a86f-d4e811e89469 — 2,135 records, 4.94 average, pulled 2026-09-08"
  - "Facebook ad comments via Parker MCP `search_facebook_ad_comments_sql` — the complete corpus, all 1,351 records read in full, pulled 2026-09-08"
  - "Brand ad copy via Parker MCP `search_facebook_ads_sql` — 2,603 ads, $502,032.18 lifetime spend, read only as the brand-language control set, never as customer language. NOTE added 2026-09-10: these two figures differ from the brain's verified lifetime set (2,431 ad-name groups, $497,553.67) because this pull ran a day later, on 2026-09-08, and counts ads rather than ad-name groups. The $4,478.51 delta sits inside this account's daily run rate, so both are most likely honest reads of different moments and different units — but this doc is NOT the source for lifetime figures. For any lifetime number cite running-notes/brand-rules.md: $497,553.67 spend, 2.03 ROAS, $143.15 AOV, 7,066 purchases, 2,431 ad-name groups."
  - "Post-purchase surveys via Parker MCP `semantic_search_post_purchase_survey` — checked 2026-09-08, zero responses"
  - "Prior brand docs read 2026-09-08: CLAUDE.md, brand-lens.md, running-notes/brand-rules.md, running-notes/missing-context.md, source-pulls/customer-reviews.md, source-pulls/ad-account.md, audits/2026-Q3/customer-review-audit.md"
expected_sources_missing:
  - "Post-purchase surveys — zero responses. Purchase motivation is inferred everywhere in this brain, never measured."
  - "Marketplace and retail reviews — none. No Amazon, no retailer listing, no third-party review platform."
  - "Organic social comments on the brand's own accounts — not tracked."
  - "Reddit, forum and community pulls — none available."
  - "Support tickets and customer-service exports — none available."
  - "NPS — none."
  - "Prior voc-corpus-profile.md and voice-of-customer.md — this is the first run, so there is no history to carry forward."
structured_fields_available:
  - "reviews: id, created_at (date only), score (1-5), title, content, reviewer_name, product_id"
  - "comments: comment_id, message, created_time (full timestamp), like_count, comment_count, parent_comment_ids, ad_names, ad_ids, post_ids, comment_length"
model_applied_tags:
  - sentiment_band
  - purchase_direction (gift / self / both / unknown)
  - recipient_relationship
  - usage_occasion
  - objection_type
  - product_experience
  - outcome_or_transformation
  - emotion
  - social_proof
  - loyalty_or_repeat
  - ad_or_creative_mention
  - comparison_mention
  - product_confusion
  - price_concern
  - shipping_or_service_issue
  - improvement_suggestion
  - quote_candidate
  - persona_signal
  - brand_self_echo_candidate
  - comment_substance (substantive / bare tag / emoji only / empty)
  - comment_author_side (customer / brand reply)
data_limitations:
  - "The review corpus shrank by 47.0% between 2026-09-07 and 2026-09-08, from 4,028 records to 2,135, with no change to this brain's other data. Every count in the two prior review docs is against a denominator that no longer exists."
  - "Reviews are 99.0% four and five star (2,113 of 2,135). This corpus cannot be read as sentiment."
  - "The review corpus stops on 2026-03-11. The last six months of trading have zero review coverage."
  - "20.7% of the ad-comment corpus (279 of 1,351) is the brand replying to customers, not customers talking. It has to be stripped before any phrase is lifted."
  - "14.1% of the ad-comment corpus (190 of 1,351) is bare friend-tagging, emoji or empty text with no liftable language."
  - "No age, gender, region, income or first-time-buyer field exists on any record in either corpus."
  - "Review product_id is present on every row but is not reliable at the theme level, because one review can be stored against several products."
  - "The two corpora barely overlap in time. Reviews run 2022-03 to 2026-03; comments run 2024-06 to 2026-09. Only 21 months of the five-year span carry both."
---

# VoC corpus profile - Northern Knife

## Executive summary

**1. The review corpus is half the size it was yesterday, and nobody has been told.** Yesterday's
pull, on 2026-09-07, returned 4,028 reviews at a 4.93 average. Today's pull, on 2026-09-08, returns
**2,135 reviews at a 4.94 average** — 1,893 fewer records, a 47.0% drop, `verified` from the same
tool against the same brand id. The most likely cause is that the source deduplicated itself, and
the evidence is direct: Brian Chapin's non-delivery complaint used to sit in the corpus **8 times**,
once per product in his order, and today it appears **once**. The same nine repeated boilerplate strings
that matched 861 of 4,028 records yesterday (21.4%) match **151 of 2,135 today (7.1%)**. The shrinkage is
concentrated in the oldest years, exactly where the duplicates lived. `inferred`, and it needs a
human to confirm rather than a model to assume. Either way the consequence is the same and it is not
small: **every count in `source-pulls/customer-reviews.md` and `audits/2026-Q3/customer-review-audit.md`
carries a denominator of 4,028 that no longer exists.** Their reads still hold. Their arithmetic
does not.

**2. The reviews cannot carry pain or objection language, and that is a property of the corpus, not
a fact about the customer.** 2,113 of 2,135 reviews are four or five star, which is 99.0%. Seven
records sit at one or two star, 0.3%, and every one of the seven is rated exactly 1. Fifteen sit at
three stars, 0.7%. `verified`. A corpus like this does not measure how people feel. It measures who
chose to write. Any VoC slice that goes looking for objections in the reviews alone will come back
with a handful of quotes and mistake the silence for satisfaction.

**3. The ad comments are the only place this brand gets argued with, and they are richer than
expected.** 1,351 comments, `verified`, running 2024-06-06 to 2026-09-08 — right up to today, which
makes this the **only customer-language surface that can see the current trading window at all.**
Strip the brand's own replies and the empty rows and 882 substantive customer comments remain. In
them: 39 comments about price (4.4% of 882), 39 challenging whether the knives are really hand
forged (4.4%), 35 raising knife crime, UK knife law or age checks (4.0%), 19 asking a direct
materials question the ads never answer (2.2%), and 14 attacking the ads for being made with AI
(1.6%). None of those five clusters exists in any meaningful volume in the reviews.

**4. The biggest single objection in the comments is one this brain has never recorded: the
knife-crime and legality argument.** 35 of 882 substantive comments, 4.0%, `verified`. It is
almost entirely a British argument, it is aimed at the brand's right to advertise rather than at the
product, and it is the loudest hostile voice in the corpus: *"Why is the is allowed on Facebook?
Disgusting with all the knife crimes going on!"* (2026-06-22). *"And we wonder how kids/people are
able to carry knives around our streets😡\nSurely these items should be sold from licensed premises
the same as shotguns are."* (2026-06-10). The review corpus surfaces this twice in four years, both
times politely, from buyers. The comments surface it 35 times, angrily, from the feed.

**5. The most important creative lever the corpus points at is the authenticity challenge, because
it lands on the brand's own biggest copy claim.** The account's top-spending ad, `NK222`, says the
Feather is *"hand-forged with an insane feather etching down the spine, no two blades identical.
Each one takes hours to create by hand."* In the comments, 39 of 882 people push back on some
version of exactly that: *"They ain't hand forged"* (2026-02-19), *"As a blacksmith and a
historian....this is 💯 🐂 💩"* (2026-03-09), *"£80 is about right for a mass produced piece of Indian
steel.\nNow if they are hand forged in the UK, they would be around £300-£500.\n\nSo show us the
smith actually making one. No Ai this time."* (2026-08-23). Meanwhile only **15 of 2,135 reviews
(0.7%)** use any of the brand's own craft words back. The brand's central claim is being contested
in the comments and ignored in the reviews. That is a creative problem with a specific shape and it
is currently invisible to every doc in this brain.

**The largest data limitation** stays what it has been since day one: **post-purchase surveys are
empty.** Zero responses, re-checked today. Everything this brain says about *why* someone bought is
reasoned backwards from what they wrote afterward. The corpus can tell you what people say. It
cannot tell you what moved them, and no slice downstream should pretend otherwise.

## Source and data profile

### What came in

| Corpus | Raw records | Normalized | Date range | Pulled | Role |
|---|---|---|---|---|---|
| Customer reviews | 2,135 | 2,135 | 2022-03-11 to 2026-03-11 | 2026-09-08 | Primary customer language |
| Facebook ad comments | 1,351 | 1,351 | 2024-06-06 to 2026-09-08 | 2026-09-08 | The only adversarial surface |
| Post-purchase surveys | 0 | 0 | none | 2026-09-08 | **Empty** |
| **Customer total** | **3,486** | **3,486** | 2022-03-11 to 2026-09-08 | | |
| Brand ad copy (control) | 2,603 ads | not merged | to 2026-09-08 | 2026-09-08 | **Brand language, held separate** |

The brand ad copy is counted here so the echo check has a denominator, and it is **never merged
into the customer corpus.** It sits in its own bucket for one reason: this brand's ads run a heavy
Viking and mythology register, so any phrase that appears on both sides has to be checked before a
slice treats it as the customer's own words.

### Reviews — the shape

`verified`, all from the 2026-09-08 pull.

| Year | Reviews | Average score |
|---|---|---|
| 2022 | 438 | 4.94 |
| 2023 | 366 | 4.86 |
| 2024 | 394 | 4.96 |
| 2025 | 685 | 4.96 |
| 2026 | 252 | 4.96 |
| **Total** | **2,135** | **4.94** |

The monthly tail is what matters most, because it shows where the corpus stops:

| Month | Reviews |
|---|---|
| 2025-09 | 30 |
| 2025-10 | 30 |
| 2025-11 | 39 |
| 2025-12 | 95 |
| 2026-01 | 206 |
| 2026-02 | 45 |
| 2026-03 | 1 |
| 2026-04 onward | 0 |

Two things fall out. The January spike is the Christmas gift buyer writing in — 206 reviews against
a baseline near 30, `verified` — so the calendar itself weights this corpus toward gifting. And the
corpus **stops on 2026-03-11.** Today is 2026-09-08. The whole 2026 grill season, the window the
ad account is actually spending in, has no review coverage at all.

### The 47% shrink, stated exactly

This is the single most consequential thing in this document, so here is the evidence side by side.
Left column from `source-pulls/customer-reviews.md` and `audits/2026-Q3/customer-review-audit.md`,
both generated from the 2026-09-07 pull. Right column pulled today.

| Measure | 2026-09-07 | 2026-09-08 | Change |
|---|---|---|---|
| Total records | 4,028 | 2,135 | −1,893 (−47.0%) |
| Average score | 4.93 | 4.94 | +0.01 |
| 1 and 2 star | 14 (0.3%) | 7 (0.3%) | −7 |
| Nine boilerplate strings | 861 (21.4%) | 151 (7.1%) | −710 |
| Brian Chapin "Never received them" | 8 rows | 1 row | −7 |
| Records dated 2022 | 2,021 | 438 | −1,583 |
| Records dated 2025 | 685 | 685 | 0 |
| Records dated 2026-01 | 206 | 206 | 0 |

`verified` on every figure. The 2025 and 2026 counts are **identical**, and the 2022 count fell by
78%. That is the fingerprint of a deduplication, not of a data loss: 2022 is where the duplicate
per-product rows lived, and recent months, where the review app stores one row per review, are
untouched. `inferred`, confidence strong, and still worth a human confirming with the review
platform.

**What it means for every later slice.** Theme *shares* went up, not down, because the padding came
out. Self-purchase language was 89 of 4,028 (2.2%) yesterday and is 63 of 2,135 (3.0%) today. Same
language, same customers, cleaner denominator. So the right reading is not that the brand lost
customers. It is that **the old percentages understated every real theme**, and the two prior review
docs should be re-run before anyone quotes a number out of them.

### Comments — the shape

`verified`, all 1,351 records read in full on 2026-09-08.

| Year | Comments |
|---|---|
| 2024 | 150 |
| 2025 | 99 |
| 2026 | 1,102 |

| Month, 2026 | Comments |
|---|---|
| 2026-02 | 48 |
| 2026-03 | 84 |
| 2026-04 | 60 |
| 2026-05 | 53 |
| 2026-06 | 159 |
| 2026-07 | 162 |
| 2026-08 | 371 |
| 2026-09 (to the 8th) | 165 |

The corpus is front-loaded onto right now. 1,102 of 1,351 comments, **81.6%**, are from 2026, and
536 of them, 39.7% of the whole corpus, land in August and the first eight days of September. There
are also two gaps with no comments at all: 2025-02 through 2025-08, and 2026-01. `verified`. Read
those as collection gaps, not as silence from customers, because the ad account was spending
through both.

### The two denominators inside the comment corpus

The brief for this doc was right to insist these stay apart. Here is the split, `verified` by
reading every row.

| Bucket | Records | Share of 1,351 |
|---|---|---|
| Brand replying to a customer | 279 | 20.7% |
| Customer, substantive text | 882 | 65.3% |
| Customer, bare friend-tag only | 177 | 13.1% |
| Customer, emoji only | 10 | 0.7% |
| Customer, empty | 3 | 0.2% |

**Use 882 as the denominator for any claim about what customers say.** Use 1,351 only for claims
about the comment section as a whole.

The brand-reply share is a finding in its own right. **The brand runs a live comment-response
operation and it has scaled hard this year:** 45 replies in 2024, 16 in 2025, 218 in 2026, with 69
in August alone. `verified`. Two things about those replies matter downstream. First, they are
written in full brand voice and would poison any phrase bank that swept them up, because they look
like enthusiastic customers at a glance: *"You will never go wrong with our knives, Nicole. Enjoy
shopping!"* Second, at least one of them **breaks the brand's own copy law in public**: on
2025-11-21 the brand answered a sharpening question with *"we recommend using a whetstone, ideally
at a 15° angle on each side,"* and on an earlier reply told a customer the knives are *"made with
1080 high carbon steel and have a Rockwell hardness rating of approximately 58–60 HRC."* The brand
rule in `CLAUDE.md` bans alloy codes and Rockwell numbers outright. Flagging it, not resolving it.

**Bare friend-tagging is a signal, just not a quote source.** 177 of 1,351 comments, 13.1%, are
nothing but a name: *"Mark Miles"*, *"Beccie Taylor"*, *"Hayley O'Hare"*. Nobody types a friend's
name under a knife ad by accident. That gesture is the gift and share intent showing up as behavior
rather than as language, and it is roughly **one comment in every eight.** Count it under
gifting signals. Never count it as a comment with content.

### Fields present, fields missing

**Reviews.** Present on 100% of rows: `id`, `created_at`, `score`, `title`, `content`,
`reviewer_name`, `product_id`. Absent entirely: age, gender, region, country, order value, channel,
repeat-buyer status, verified-purchase flag, review URL. The `platform` field returns the brand's
own collection channels (`judge-me`, `web`, `email`, `direct`, `wizard`) rather than a selling
surface, so it cannot be used to compare buyers.

**Comments.** Present on 100% of rows: `comment_id`, `message`, `created_time`, `like_count`,
`comment_count`, `parent_comment_ids`, `ad_ids`, `ad_names`, `comment_length`. `author_name` is
**null on every one of the 1,351 rows**, so no comment can be attributed to a person, and no
comment can be joined to a review by the same buyer. `permalink_url` is also null on every row, so
nothing here is linkable back to Facebook.

### Data-quality issues, named

1. **The review shrink.** Covered above. The largest single issue in the corpus.
2. **Review text duplicated across products, in the old pull.** Yesterday's corpus stored one row
   per product a review was left against, with the product name swapped inside otherwise identical
   text. Michael Rasmussen's 2024-06-20 review appeared eight times reading *"I love my Loki
   knife"*, *"I love my Bjorn knife"* and so on. Today's corpus appears to have collapsed those.
   `inferred` that the collapse is complete — I checked one known case, Brian Chapin, and it went
   from 8 rows to 1.
3. **Boilerplate.** 151 of 2,135 reviews (7.1%) still match one of nine short repeated strings
   such as `Really sharp`, `Delivery on point,` and `The perfect gift`. `verified` by sweep. They
   carry no identity or motivation signal at all, so the working denominator for identity reading is
   closer to **1,984** than 2,135. Note the direction of travel: boilerplate was 21.4% of the corpus
   yesterday and is 7.1% today, which is the cleanest single sign that what came out was duplication
   rather than real customers.
4. **Comment authorship is unknowable.** `author_name` is null everywhere, so brand replies had to
   be separated by reading the text. My classifier is described below and it is not perfect.
5. **No demographic field anywhere.** Any statement about a reviewer's or commenter's age, gender or
   country is a model inference from how they write.
6. **Sarcasm is invisible to rating filters.** Caitlin Gorman's 2023-12-11 review is filed at five
   stars and is a sustained sarcastic complaint that the knife is not for women. A star filter can
   never find it.
7. **Emoji and encoding artifacts.** Both corpora carry raw `\r\n` sequences and emoji inside text.
   Preserved as written wherever quoted.

## Normalized schema

Both corpora normalize into one record model. Nothing was invented to fill a gap.

| Field | Type | Reviews | Comments | Status |
|---|---|---|---|---|
| `row_id` | string | `id` | `comment_id` | structured fact |
| `source_type` | enum | `review` | `ad_comment` | structured fact |
| `platform` | string | brand's own review channels | facebook | structured fact, low value on reviews |
| `source_native_id` | string | `id` | `facebook_comment_ids[0]` | structured fact |
| `date` | date | `created_at`, day only | `created_time`, full timestamp | structured fact |
| `rating` | 1-5 | `score` | **not available** | structured fact on reviews only |
| `product` | string | `product_id` | inferred from `ad_names` | structured on reviews, model-inferred on comments |
| `text` | string | `title` + `content` | `message` | structured fact |
| `author` | string | `reviewer_name` | **null everywhere** | structured on reviews only |
| `url` | string | not available | **null everywhere** | missing on both |
| `is_reply` | bool | not applicable | `parent_comment_ids` non-empty | structured fact |
| `engagement` | int | not available | `like_count`, `comment_count` | structured fact on comments only |
| `ad_reference` | string | not available | `ad_ids`, `ad_names` | structured fact on comments only |
| `author_side` | enum | always customer | customer or brand | **model-applied on comments** |
| `substance` | enum | always substantive | substantive / bare tag / emoji / empty | **model-applied on comments** |
| every theme tag | enum | model judgment | model judgment | **model-applied** |

**Populated share for the fields later work will reach for:**

| Field | Reviews | Comments |
|---|---|---|
| date | 2,135 of 2,135, 100% | 1,351 of 1,351, 100% |
| rating | 2,135 of 2,135, 100% | 0 of 1,351, 0% |
| author name | 2,135 of 2,135, 100% | 0 of 1,351, 0% |
| product id | 2,135 of 2,135, 100% but unreliable | 0 direct; ad name on 1,351, 100% |
| url | 0 of 2,135, 0% | 0 of 1,351, 0% |
| age / gender / region | 0%, on both | 0%, on both |
| repeat-buyer flag | 0%, on both | 0%, on both |

**Deduplication I performed: none.** All 3,486 customer records are distinct row ids. The one
merge decision worth recording is the one I did **not** get to make: the review source appears to
have deduplicated itself upstream between yesterday and today, and I have no field that would let
me redo or verify that work per record. Comment rows are unique on `comment_id`, all 1,351 checked.

## Classification method

Every count in this document comes from one of three places, and the three are never blended.

**Structured facts.** Record counts, dates, star ratings, average scores, reply-versus-top-level,
like counts. These come straight off the fields and are marked `verified`.

**Keyword sweeps against the full corpus.** Every theme count on the review side is a case-insensitive
match run against all 2,135 records by the Parker tool, not a sample. Every theme count on the
comment side is a regular-expression match run in one pass over all 1,351 rows. Both are
reproducible and both are reported with their denominator in the same sentence or cell. A sweep is
not a judgment about meaning: it says the words are present, and where a sweep is contaminated by a
product name or a boilerplate string, I say so on the spot.

**Model-applied tags.** Everything else. The tag list is in the frontmatter. These are my judgments
about what a record means, and no downstream slice should treat one as a structured fact.

Two model-applied classifiers on the comment corpus need their method stated, because a lot rests
on them.

**The brand-reply classifier.** No field identifies the author, so I matched the text against brand
markers: the brand's own domains and support email, "lifetime warranty", "our knives", "our
collection", "Hello [Name]!", "Enjoy shopping", "the team will", "Buy 2 Get 2 Free is", and about
twenty more. It caught 279 of 1,351. Reading a sample back, it is close but not clean: it catches
one sarcastic customer whose joke quotes the brand's own line, *"One knife does the job of every
other knife so we've made 4 in our collection.\nSomething doesn't seem right."* The error runs in
one direction — a few customer comments get filed as brand — so **882 is a slightly conservative
floor for substantive customer comments, not a ceiling.**

**The substance classifier.** A comment counts as a bare tag when, after emoji and punctuation are
stripped, it is four words or fewer and every word looks like a proper name, with no question mark
or exclamation mark and no common word in it. That gives 177. It misses tags where the surname is
typed in lower case, so **177 is also a floor.** Emoji-only and empty rows are counted separately
so nobody has to guess what "no content" meant.

**Sample-size discipline.** Any theme, segment or quote cluster with fewer than ten supporting
records is marked **thin** where it appears. A thin cluster can still hand a strategist a usable
line. It is not a pattern.

## Sentiment and rating profile

### Reviews

`verified`, 2026-09-08 pull, denominator 2,135 throughout.

| Band | Records | Share | Average score |
|---|---|---|---|
| 4-5 star | 2,113 | 99.0% | 4.97 |
| 3 star | 15 | 0.7% | 3.00 (derived) |
| 1-2 star | 7 | 0.3% | 1.00 |
| **All** | **2,135** | **100%** | **4.94** |

Every one of the seven negative reviews is rated exactly 1 — the tool returns an average of 1.00 for
the whole negative band — so **there is no 2-star review in this corpus at all.** The 3-star row is
**derived by subtraction** (2,135 total minus 2,113 positive minus 7 negative), because the tool
exposes sentiment bands rather than a per-star histogram. Everything else in the table is read
directly off the field.

**Say this out loud in every downstream slice: 99.0% positive is a property of the collection
method, not a measurement of how customers feel.** Own-site review programs solicit at the moment of
delight and rarely chase the unhappy. The prior audit read all 14 of yesterday's negative rows in
full and found five or six distinct unhappy people in four years, four of them unhappy about
delivery rather than about the knife, and exactly one complaining about a blade. Today there are
seven rows and the same read applies.

**Where the real criticism actually lives is the 3-star and 4-star band**, not the 1-star tail. That
is where Leland Chambers wrote *"Lovely knife but it arrived dull (as dull as a 2 year-old knife
that's not been cared for). Couldn't cut a potato without pushing hard."* (2026-01-03, three stars)
and Joel Glidewell wrote *"the blade etching is a bit mottled on one side"* (2025-12-22, four stars).
Quotes carried from the 2026-09-07 pull.

**Sentiment by year.** 2023 is the only year that dips, at 4.86 against 4.94 overall. 2022 sits at
4.94, 2024 at 4.96, 2025 at 4.96 and 2026 at 4.96. `verified`. The dip is real but small, and with
366 records behind it, it is worth one sentence and no more.

**Sentiment by product.** Not reportable. `product_id` is populated on all 2,135 rows, but the same
review can be stored against several products with the name swapped inside the text, so a
per-product average would be measuring the storage pattern rather than the product. **Data-limited,
deliberately.**

### Comments

Comments carry no rating field, so sentiment here is a model judgment on 882 substantive customer
comments and nothing more. What can be counted cleanly is the argument, and the argument is
one-sided in a way the reviews never are.

| Signal | Comments | Share of 882 |
|---|---|---|
| Vouching for the knife they already own | 39 | 4.4% |
| Wanting one, out loud | 28 | 3.2% |
| Challenging the hand-forged claim | 39 | 4.4% |
| Raising knife crime, UK law or age checks | 35 | 4.0% |
| Price pushback or price question | 39 | 4.4% |
| Attacking the ad for being AI-made | 14 | 1.6% |
| Calling it a lie, a scam or nonsense | 10 | 1.1% |
| Doubting the sharpness on screen | 9 | 1.0% — **thin** |
| Origin doubt, China or dropshipping | 4 | 0.5% — **thin** |

`verified` by sweep. Those rows overlap, so the honest way to size the two sides is as **unions of
distinct comments**, not as a sum: **127 of 882 substantive comments (14.4%) push back on price,
authenticity, legality, AI or honesty, and 67 (7.6%) vouch for the product or ask for one.** Only
one comment falls in both. `verified`.

That ratio is the point. In the reviews, positive outnumbers negative 2,113 to 7. In the comments,
pushback outnumbers enthusiasm roughly two to one. Same brand, same window, opposite picture — and
it is exactly why price and objection language for Northern Knife can only be mined here.

## Motivation and trigger profile

Every claim in this section is `inferred`, because **the post-purchase survey is empty and the
review is written after the fact.** Nothing below is a measured purchase motivation.

### Counted motivation language, reviews

`verified` sweeps, denominator 2,135.

| Signal | Records | Share | Average score |
|---|---|---|---|
| Any gift word (gift, present, Christmas, Xmas, birthday, anniversary, Father's Day) | 496 | 23.2% | 4.96 |
| Names a partner (husband, hubby, wife, partner, boyfriend, fiancé) | 285 | 13.3% | 4.98 |
| Names a family recipient (my dad, my son, my brother, grandson, son-in-law, my daughter, my mum) | 184 | 8.6% | 5.00 |
| Explicit "bought this for my [person]" phrase | 95 | 4.4% | 4.99 |
| Packaging or box mentioned | 89 | 4.2% | 4.88 |
| Price or deal word | 87 | 4.1% | 4.87 |
| Collection, display, wall or magnetic | 72 | 3.4% | 4.93 |
| Explicit self-purchase phrase (for myself, treated myself, my own) | 63 | 3.0% | 4.97 |
| Grill or fire word (bbq, barbecue, grill, smoker, brisket, braai) | 62 | 2.9% | 4.98 |
| Scam, fake, skeptical, hesitant, doubted | 17 | 0.8% | 5.00 |
| Professional cook self-identification, clean count | 16 | 0.7% | 5.00 |
| Brand craft words echoed back (hand forged, work of art, heirloom) | 15 | 0.7% | 5.00 |
| Blade-pattern word (etch, engrav, laser, damascus, pattern) | 8 | 0.4% — **thin** | 4.63 |

The gift-word sweep is padded by the boilerplate string `The perfect gift`. The narrow
"bought this for my" count of 95 is made of real sentences and is the clean one.

### Counted motivation language, comments

`verified` sweeps, denominator 882 substantive customer comments.

| Signal | Comments | Share |
|---|---|---|
| Gift language | 34 | 3.9% |
| Desire, stated plainly ("I want one", "I need this") | 28 | 3.2% |
| Ownership or vouching | 39 | 4.4% |
| Sheath or cover interest | 27 | 3.1% |
| Care, sharpening, rust | 32 | 3.6% |

### The triggers the language actually names

**The impossible-to-buy-for man.** The strongest motivation in the review corpus and the one that
recurs across all four years. Jill Equi, 2025-12-28: *"Saw so many ads on this line so decided to
narrow it down to one for my Hub's Christmas gift.  He is SO picky so I had to made sure it had the
perfect grip, was sturdy, sharp and made with quality steel.  This knife exceeded in every detail!
Now I know what to get him for every occasion and build his collection!"* The trigger is not the
holiday. It is a recurring gift problem the buyer has just solved permanently.

**A dated deadline, almost always Christmas.** 206 reviews in January 2026 against a baseline near
30, `verified`. Reviews lag the purchase, so a January review spike is a December purchase spike.

**The ad itself.** Only one review in the entire corpus names the advertising, and it is Jill Equi's
*"Saw so many ads on this line."* On the comment side it is the opposite: the comment corpus **is**
the reaction to the ad, and people argue with the creative directly, which makes it the only place
this brain can read how the work is received. *"Got to love all the jump cuts"* (2026, undated in my
extract), *"Mispronounced: BJORN is pronounced B'YORN. So that is a giveaway that the narrative is
AI, not human."* (2026-08-28).

**The offer, as a trigger.** In the reviews the price language is almost entirely a verdict
delivered afterward rather than the reason for buying — *"well worth the money"*, *"great value"*.
In the comments the offer is live and contested: *"If it's the ONLY knife I need then why do I need
to buy two to get one free? \nSurely the one would be enough?"* (2024-11-22). *"If the knife is that
great… why do I need to buy 2? And then have a third one free?"* (2026-02-26). *"Starts banging on
that it is the only knife you need one knife to replace everything then at the end of the video
tells you the other ones you should get with it 🤔"* (2026-07-24). Three separate people, three
separate months, spotting the same logical hole in the offer. That is a pattern, not a heckle.

**Prior bad experience with online knife buying.** Small and specific. Timothee, 2022-07-07: *"I
usually get scammed or receive cheap knife when I order on facebook but this one was really good
quality and didn't took 3 month to come like other company. I get it in 7 days"* Carried from the
2026-09-07 pull.

## Gifting, usage, and occasion profile

### The counted share

`verified`, reviews, denominator 2,135.

| Signal | Records | Share |
|---|---|---|
| Any gift word | 496 | 23.2% |
| Names a partner as recipient | 285 | 13.3% |
| Names a family recipient | 184 | 8.6% |
| Explicit "bought for my [person]" | 95 | 4.4% |
| Explicit self-purchase phrase | 63 | 3.0% |

**The narrow gift phrase beats the self-purchase phrase 95 to 63, roughly three to two. The wide
gift signal beats it nearly eight to one.** `verified`. Both numbers are up on yesterday's
denominators, because the padding came out.

### Who receives

Across every gift review read in full in the prior pass, the named recipient is a husband, hubby,
partner, fiancé, dad, father, son, son-in-law, brother, grandson or "the other half" in all but
three cases. The exceptions were a daughter, a grandson-plus-sister-in-law pair, and one man buying
for his wife. `verified` on the reading, from the 2026-09-07 corpus, and worth re-running against
the deduplicated corpus before it is leaned on again.

### The occasions the corpus names

Christmas dominates. Birthdays recur, and **milestone birthdays recur specifically** — a 70th for a
retired butcher, a 50th, a grandson from a grandmother. Father's Day and Valentine's Day appear.
Weddings and housewarmings do not appear at all, which is a gap worth noticing given the product
ships in a presentation box.

### Recipient reactions

The recipient reaction is one of the strongest emotional registers in the corpus and it is almost
always reported second-hand by the buyer. Sarah Bedford, 2025-01-25: *"Genuinely the most
outstanding gift I've ever got my husband - I thought he was going to cry when he realised how sharp
it was and how barbecue ready he was purely to use the knife! Absolutely outstanding"* Pam Wallace,
2026-01-12: *"I won the award for best gift from my husband who has a thing for Viking knives!"*
Both carried from the 2026-09-07 pull.

### Friend-tagging as gift intent

The comment side adds a behavior the reviews cannot show. **177 of 1,351 comments, 13.1%, are a
bare friend tag** — one person putting another person's name under a knife ad. A further slice tags
a name and adds a line, which is where the intent becomes readable: *"Stephen Wood my birthday
soon!"*, *"Amber Holdroyd my Xmas gift"*, *"I want 1 ov these for Xmas Nicola Speed 😂😂"*, *"Can I
have one of these for Christmas plse Iain 😁😘 xx"*, *"Does someone's wife want to buy me one? 😂"*
`verified`, all from the 2026-09-08 pull. Note the direction: **in the comments the person most
often being tagged is the buyer, and the person tagging is the recipient asking for the gift.** That
is the reverse of the review corpus, where the buyer writes and the recipient is described. Two
surfaces, two ends of the same transaction.

### Usage settings

The grill shows up in 62 of 2,135 reviews, 2.9%, `verified` — and when it does, it almost never
appears alone. It sits inside a list with Sunday dinner, chopping veg and herbs. `inferred`: the
grill in this corpus is a **setting where the knife gets shown off**, not the reason it was bought.
That read agrees with `source-pulls/customer-reviews.md` and the underlying share has moved up only
slightly on the new denominator, from 2.5% to 2.9%.

## Objections and barriers profile

This is the section the two corpora disagree about most, and the disagreement is the finding.

### Reviews — what little there is

`verified`, denominator 2,135.

| Objection cluster | Records | Share |
|---|---|---|
| Shipping, delay, tracking, customs | 101 | 4.7% |
| Price or deal word (mostly a defence, not a complaint) | 87 | 4.1% |
| Scam, fake, skeptical, hesitant | 17 | 0.8% |
| 1-2 star reviews of any kind | 7 | 0.3% |

Shipping is the largest objection in the reviews by a wide margin, and its average score is 4.87,
which is the tell: **people report the delay inside a five-star review.** The prior audit found this
repeats every single year, 2022 through 2025, and that the Christmas deadline is what makes it
severe. Karen Dodge, 2025-02-01, one star, title *"Did not arrive for Christmas"*, whole review:
*"Won't order again"* Carried from the 2026-09-07 pull.

Price in the reviews is **not a barrier.** It reads as surprise that the price was low: *"1st off ,
amazed at the build quality, especially after the discounts/offers which turn this into a very cheap
knife in monetary terms."* (Neil H, 2025-03-01). That makes the price a trust risk here, not a
resistance point.

### Comments — where the real objections live

`verified`, denominator 882 substantive customer comments.

| Objection cluster | Comments | Share |
|---|---|---|
| Price pushback or price question | 39 | 4.4% |
| Hand-forged authenticity challenge | 39 | 4.4% |
| Knife crime, UK legality, age checks | 35 | 4.0% |
| Materials question (steel, carbon content, Rockwell, coating) | 19 | 2.2% |
| AI-made-ad complaint | 14 | 1.6% |
| Calling it a lie or a scam | 10 | 1.1% |
| Shipping, cancellation or refund trouble | 12 | 1.4% |
| Sharpness doubt from watching the ad | 9 | 1.0% — **thin** |
| Origin doubt, China, Temu, dropshipping | 4 | 0.5% — **thin** |
| Left-handedness, small hands, grip and arthritis | 4 | 0.5% — **thin** |

**1. Price.** 39 of 882, 4.4%. Three distinct shapes inside it. Plain refusal: *"Not for that fcking
price lol"* (2026-09-04), *"Pointless. Just get a normal knife, better knife, without paying the
ludicrous price. Block this advert."* (2026-08-19), *"Real price 8.99£ 😀🖕🏾"* (2026-08-26). A
never-full-price accusation: *"Are they ever full price?"* (2025-11-13), *"Definitely shows how much
mark up they are usually adding to the price.."* (2026-06-02), *"How come they never tell you the
PRICE"* (2026-03-17). And a checkout bug reported twice by two different people: *"Can you check
pricing for the feather on your site? States 79.90 then price changes to 94.90 after clicking on it
to view details"* (2026-08-13) and *"Feather knives are coming up at wrong price in checkout
£94.00"* (2026-08-05). That last pair is an operational problem sitting in the comment section, and
the brand's own reply says the £15 difference is an engraving add-on being pre-ticked.

**2. The hand-forged challenge.** 39 of 882, 4.4%, and it aims straight at the account's central
copy claim. *"They ain't hand forged"* (2026-02-19). *"Hand forged my fat hairy arse they are."*
(2026-06-09). *"100,000s of customers, hand forged- that's some going!"* (2026-08-07). *"As a
blacksmith and a historian....this is 💯 🐂 💩"* (2026-03-09). *"Hmmm\n...I suspect these may be mass
produced Chinesium"* (2026-08-10). *"Are they really forged and everyone hand made? Mmmm🤷"*
(2026-06-26). This cluster is worth reading next to the live contradiction already logged in
`brand-lens.md`: the brand rule says the Feather pattern is laser-applied, five top-spending ads say
it is etched by hand, and the comment section is calling the hand-forged claim out loud. Three
sources, three different stories. **Flagged, not resolved.**

**3. Knife crime and UK legality.** 35 of 882, 4.0%, and it is new to this brain. *"With all the
knife crime do you think this appropriate?"* (2026-02-16). *"This is so inappropriate at a time when
there are so many knife crimes !"* (2026-06-23). *"Do you vet who you sell them to or is it just fb
shop so they end another life to knife crime"* (2026-06-09). *"How do you verify the age of the
person you're sending these knives to?"* (2026-06-03). *"I thought advertising knives online was
banned?"* (2026-03-03). *"Yeah… then get arrested for carrying an offensive weapon…. 🤦‍♀️"*
(2026-05-31). The brand replies to these individually and calmly, which suggests somebody already
knows it is happening: *"Kitchen knives are perfectly legal to buy here if you're over 18, Stephen -
deliveries are age-checked on the doorstep."* Two reviews raised the same age-check worry politely
in 2023 and 2024. The comments raise it 35 times, most of them in the last four months.

**4. The materials question the ads refuse to answer.** 19 of 882, 2.2%, and it is remarkably
consistent. *"What is the Rockwell rating?"* appears verbatim at least four separate times across
2026-04, 2026-05 and 2026-07. Alongside it: *"What steel do you use"* (2026-06-02), *"Whats the
carbon content?"* (2026-09-03), *"So, what's the carbon content???"* (2026-09-05), *"What is the
Matt black finish made of? Is it a coating or paint that is going to flake off and contaminate the
food?"* (2026-08-12). This runs head-on into the brand's own rule banning alloy codes, HRC numbers
and spec language. **The buyer is asking for exactly the register the brand has forbidden itself**,
and the brand's comment team is answering with the numbers anyway. That is a genuine strategic
collision and it belongs in front of a human, not in a copywriter's hands.

**5. The AI backlash.** 14 of 882, 1.6%, and every instance is from 2026-07 onward. *"More ai
shite"* (2026-09-08). *"Ai slop. Stamped and mass produced."* (2026-09-05). *"Any company that uses
💩 ai for there adverts most definitely has 💩 products 🤣🤣"* (2026-08-27). *"Knives are hand forged
by a blacksmith but adverts AI haha"* (2026-08-31). And the most useful one, because it is a fan
complaining: *"I have the Loki knife and it is brilliant, but PLEASE don't use an AI voiceover, or
at least use one that knows Bjorn is pronounced \"Byawn\" and not \"Bi-jorn\""* (2026-08-28). Every
ad name in this account carries `AI VO` in the voice slot. Fourteen people in nine weeks have
noticed. `verified`, and it is a brand-new objection with a clear date of first appearance.

**6. The sharpness doubt, aimed at the creative rather than the product.** 9 of 882, **thin**, but
pointed: *"They look blunt. Far to much force needed for a sharp knife. The lemon was bending before
it cut ffs."* (2026-08-06). *"In many videos you display with these knifes, they seem to look dull,
the resistance in the food is too much. Definitely won't be buying."* (2026-08-06). *"It's pretty
bloody obvious the 'other' knives in the clip are blunt as F**k , so of course they won't cut !"*
(2026-07-23). These people are not doubting the knife. They are doubting the demo.

## Product experience and outcome profile

### What gets praised

**Sharpness, first and by a distance.** It is the single most common thing said about this product
across both corpora, and it usually arrives as a comparison rather than a rating. The everyday
phrasing is *"cuts like butter"*, *"goes through meat like butter"*, *"sharp as a lazer"*, all
carried from the prior pull.

**The object itself, before the function.** Aesthetic language runs independently of who bought or
why. Karen Bernal, 2026-01-24: *"This knife is so beautiful in design. When you open it , you just
are how'd."* Michael, 2026-02-14: *"just looks and feels like a lost (but well preserved) Viking
treasure being put to practical use in my kitchen."*

**The finger hole.** One of the most praised single features and also one of the few that some
buyers actively dislike. Both are true and both should survive into the phrase bank.

**The box.** 89 of 2,135 reviews, 4.2%, mention the box, packaging, presentation or case,
`verified`. Some of them treat it as part of the product: *"I hate to throw away the boxes since
they are a work of art themselves."* (Cathleen, 2026-01-07). *"Comes in a nice box which makes me
want to buy more knives and have a collection of the boxes too"* (Pearl, 2026-01-30). Carried from
the 2026-09-07 pull.

**The bottle opener.** Almost nobody knows it is there, and everybody who finds it is delighted.
**3 of 2,135 reviews mention it, 0.1%**, `verified` on the 2026-09-08 corpus, and all three are five
star. Two put it in the **handle**, one puts it "at the top of the knife", and **none puts it in the
blade.** That leans toward the brand rule and away from the live ad copy, and it is still **thin**
at three records, so it is flagged, not resolved.

> "It looks awesome and Is very sharp,  the bottle opener on the handle is a little pointed, so I rounded it a bit now it's perfect,  I really like it." — Douglas Hays, 2025-12-26, 5 stars, title "Very cool knife"

> "Cuts through Steak like butter ( raw & grilled) . Bottle opener on the handle is genius . Best Bbq tool on the Tool on the market . Well done Northern knife" — Graham Cunningham, 2025-08-12, 5 stars, title "Bring on the BBQ"

> "One of the most satisfying surprises is how versatile this knife is. It handles everyday prep just as well as tougher tasks, making it a true workhorse rather than a novelty blade.\r\nThe built-in bottle opener at the top of the knife  is a clever bonus that adds personality without sacrificing performance.\r\nThe knife is comfortable in hand, and secure even during long prep sessions. \r\nNothing feels decorative for the sake of it—every detail serves a purpose, functional art you'll actually want to display in your kitchen!" — Natalie Waterman, 2026-02-16, 5 stars, title "Quality knife!"

Note the first line of the third one. "One of the most satisfying **surprises**" is the customer
saying out loud that she did not know the feature was there. A feature that lands as a surprise on
arrival can be moved into the first three seconds instead of the last.

### What gets criticised

`verified`, from the sweeps and from the prior full read of the negative and mid-tail:

- **Shipping**, 101 of 2,135 reviews, 4.7% — the largest, and it repeats every year.
- **The sheath**, recurring across four years, praised knife and criticised sheath in the same
  breath. Also live in the comments: *"Nice ish knives but absolutely atrocious sheath's."*
  (2026-06-30).
- **Sheath confusion**, still unresolved after three years. 27 of 882 comments touch the sheath and
  several are simply asking whether it is included: *"Do any of these I knives come with sheaths ?"*
  (2026-08-10), *"They come with covers?"* (2026-06-27), *"Where do you get the leather case? Is
  that extra?"* (2026-07-04).
- **Arrived dull**, small in count and severe in consequence because sharpness is the whole pitch.
- **Care and rust**, 32 of 882 comments, 3.6%, and the pattern is that customers answer each other
  because the brand has not: *"What oil to use on the knives to prevent rusting!"* (2026-03-13),
  *"How do you recommend I sharpen it?"* (2026-03-05).
- **The black coating**, one clear review instance and now a live comment question: *"What's the
  coating on the black one?"* (2026-08-16). **Thin**, and it matters more than its count because it
  is the LOKI Blackout's defining feature.
- **Hand fit**, 4 of 882 comments, **thin** — left-handers, small hands, and grip pain.

### The three focus products, by evidence weight

`verified` counts against 2,135:

| Product or feature | Reviews mentioning | Share |
|---|---|---|
| BJORN or santoku | 60 | 2.8% |
| Feather | 15 | 0.7% — **thin** |
| LOKI Blackout | 14 | 0.7% — **thin** |
| Blade-pattern words of any kind (etch, engrav, laser, damascus, pattern) | 8 | 0.4% — **thin** |
| The word "laser" | **0** | **0.0%** |
| Bottle opener | 3 | 0.1% — **thin** |
| The word "Japanese", anywhere | 2 | 0.1% — **thin** |

The Feather has **15 reviews behind it and the account's single largest spending line in front of
it.** That imbalance is the most important product-level fact in this profile. And **not one review
in the corpus uses the word "laser"**, so the corpus cannot settle the Feather conflict logged in
`brand-lens.md`. What it can do now, which it could not yesterday, is show that the argument has
moved to the comments, where 39 people are challenging the hand-forged claim directly.

On the BJORN rule, the corpus is more interesting than "silent." **The word "Japanese" appears in 2
of 2,135 reviews, 0.1%**, `verified`, and neither attaches it to a BJORN product — but both treat
Japanese origin as a **risk**, not a selling point:

> "Very nice knife full tang blade feels good in the hand. I just hope it's not Japanese." — JOHN KING, 2024-10-26, 5 stars, title "Good ball made knife"

> "I purchased a knife and bought the surprise knife I am very happy with them and they were as advertised, for those that have seen the Japanese version beware they charge shipping and tariff tax with the knives I purchased from this USA company there were no shipping charges and no tariff tax. I'm very happy with my purchase I have used the several times while grilling ribs and pork tenderloins they are sharp and hold their edge!" — David Hummel, 2025-06-22, 5 stars, title "Very satisfied"

On the comment side the two Japanese mentions run the other way, both from cooks who rate Japanese
steel above this brand: *"Sorry but I only use Japanese folded Damascus. From sword makers."*
(2026-08-13) and *"Can you sharpen these on wet stones? As I'm seriously considering moving from
Japanese to these as a head chef"* (2026-09-01). **Thin at four records across both corpora**, and
worth noting anyway: the brand's rule against saying "Japanese" is not costing it anything visible,
and the one customer who raised origin unprompted hoped the answer was no.

## Transformation and impact profile

The corpus is thin here by nature. A knife is not a product people narrate a transformation around,
and the boilerplate reviews carry none. What does recur is worth naming, with the honest counts.

**The gift recipient turns into a buyer.** The strongest repeat-purchase pattern in the corpus and
the one no creative depicts. Three independent reviewers across three different years describe the
same arc, `verified` from the 2026-09-07 pull. Coreylee Furnival, 2024-12-30: *"I had this knife
gifted to me originally, which then started off my addiction with the collection."* Barry.H,
2026-01-19: *"My wife ordered me the Loki knife from Northern Knife, for Xmas and I loved it so
much, that I went on to order more!"* JOANNE DOLMAN, 2025-03-01: *"I had my first knife bought me as
a gift I liked it so much I bought two more."* The comment corpus adds a fourth instance from a
different year: *"I was given mine as a gift, after I had expressed interest. Well, I love it so
much, that my wife, who gave me the gift, bought 3 more for my Sons and I bought this one for my
brother in law."* (Dean Lategan, 2025-08-23, carried from the prior pull.)

**The buyer keeps it.** Women who bought the knife for a man and then took it back. Renee Mitchell,
2025-04-08: *"I actually got it for my husband. It looks pretty awesome. Thought he'd put it on
display in the garage but he left it in the kitchen. So I used it to slice up tri tip one night, and
NOW I can't stop using it!! Guess I better get him something different 🤣"* Emotional intensity is
high, volume is low. Kept as an intensity finding, not a volume one.

**Habit change, stated plainly.** *"I've been trying to cook more and this has made it fun"* is the
register, and the cleanest live instance is in the comments: *"I bought one last Christmas for my
partner & he said the other day it's the only knife he uses now!"* (2025-11-11). Also *"I didn't
know how to use a knife, before I bought this knife, too"* (2026-03-28).

**Accessibility.** One review, and it is a good one. Sue Lake, 2024-02-09: *"i have issues with pain
and grip and struggle cutting up food etc this knife is the best thing since sliced bread… I no
longer have to swear and shout at the food im trying to cut the knife just laughs at it for me."*
**Thin at one record**, logged because nobody at the brand has named this job.

**Repeat-purchase statements.** Common enough to be a real signal in both corpora. In the comments:
*"Brought the Loki love it that much I've just put a order in for another 3 knife's and there knife
sharpener too keep up the good work"* (2026-04-16). *"Wife biught me 3 for my birthday, and i just
ordered the feather and another one. Along with the sharpener"* (2026-05-10). *"I love mine!!! We
have a few now x"* (2026-03-23).

**Won't-buy-again statements.** Almost none in the reviews — one, Karen Dodge's *"Won't order
again"*. In the comments there are a handful and they are all about service rather than the knife:
*"i have been trying to cancel my order since an hour after it was made and they just ignore you. do
not buy from these people. the tracking number given also does not work."* (2026-09-01).

**Measurable result mentions.** None. No numbers, no before-and-after metrics. Correct for the
category; noted so nobody goes looking.

## Language and creative-asset index

Every quote below is verbatim, with source, date and corpus. Comment quotes are from my own
2026-09-08 pull. Review quotes marked `[2026-09-07 pull]` are carried from
`source-pulls/customer-reviews.md` or `audits/2026-Q3/customer-review-audit.md`, where they were
read in full against the pre-deduplication corpus, and their text is unchanged.

### Golden nuggets

- *"I thought it was all hype and camera tricks, but I was wrong."* — Cheryl Weir, review,
  2025-11-14 `[2026-09-07 pull]`. Aimed at the ad format itself.
- *"Cut myself opening it"* — Vince, review title, 2025-12-06 `[2026-09-07 pull]`.
- *"As sharp as my ex wife's tongue!"* — Stewart Howells, review title, 2023-09-30
  `[2026-09-07 pull]`.
- *"I promise this is a positive review."* — Stuart, review opener, 2026-01-19 `[2026-09-07 pull]`.
- *"I won the award for best gift from my husband who has a thing for Viking knives!"* — Pam
  Wallace, review, 2026-01-12 `[2026-09-07 pull]`.
- *"I have one of these and absolutely love it. Am not sponsored or anything and am a genuine user
  of this."* — comment, 2025-09-21. A customer pre-empting the accusation the comment section makes.

### Headline-worthy phrases

- *"Some pieces deserve a better place"* is the brand's. The customer's version is *"I'm never going
  to be placing these knives in a drawer again."* — Keith Grogan, review, 2026-01-18
  `[2026-09-07 pull]`.
- *"Thanks for making it easy to buy for the hard to buy for guys in my family."* — Sherry Adams,
  review, 2025-01-27 `[2026-09-07 pull]`.
- *"Now I know what to get him for every occasion and build his collection!"* — Jill Equi, review,
  2025-12-28 `[2026-09-07 pull]`.
- *"He's only cut himself twice 🤣🤣"* — Angela Stewart, review, 2025-04-13 `[2026-09-07 pull]`.

### Pain phrases

Scarce in the reviews by construction. The usable ones:

- *"Couldn't cut a potato without pushing hard."* — Leland Chambers, review, 2026-01-03, three stars
  `[2026-09-07 pull]`.
- *"Won't order again"* — KAREN DODGE, review, 2025-02-01, one star `[2026-09-07 pull]`.
- *"i have been trying to cancel my order since an hour after it was made and they just ignore you.
  do not buy from these people. the tracking number given also does not work."* — comment,
  2026-09-01.
- *"And the promise of \"full refund for any reason\" won't happen unless you pay to send it back."*
  — comment, 2026-08-04.
- *"Got a few of these as gifts and protect mine from the rest of the family ... but it is getting
  blunt from use - quite quickly really. How do you recommend I keep it sharp?"* — comment,
  2025-11-18.

### Outcome phrases

- *"I bought one last Christmas for my partner & he said the other day it's the only knife he uses
  now!"* — comment, 2025-11-11.
- *"Love mine…. It's my go too kitchen knife when my Miyabi's would be overkill, because that hole
  in the blade allows for a much more controlled cut on fine Dicing of veg, but also great for
  meat."* — comment, 2024-11-04. Note the unprompted comparison to a premium Japanese brand.
- *"Bought the set and leather cases for them he absolutely loves them! He uses them all the time
  and he said just last night these are soooo sharp !"* — comment, 2026-06-05.
- *"Received mine the other day, comes well presented but Damn this thing is sharp!"* — comment,
  2026-06-30.

### Objections, verbatim

**Price.**
- *"Not for that fcking price lol"* — comment, 2026-09-04.
- *"Really cool just quite pricey"* — comment, 2026-07-29.
- *"Are they ever full price?"* — comment, 2025-11-13.
- *"Definitely shows how much mark up they are usually adding to the price.."* — comment, 2026-06-02.
- *"They already make real kitchen knives at that price."* — comment, 2026-02-18.
- *"Wish I could afford one 🤗 (not complaining, I'm just a pauper lol)"* — comment, 2026-07-05.
- *"Pointless. Just get a normal knife, better knife, without paying the ludicrous price. Block this
  advert."* — comment, 2026-08-19.

**Authenticity.**
- *"They ain't hand forged"* — comment, 2026-02-19.
- *"It's not hand forged lol 😂😂😂😂"* — comment, 2026-08-26.
- *"As a blacksmith and a historian....this is 💯 🐂 💩"* — comment, 2026-03-09.
- *"100,000s of customers, hand forged- that's some going!"* — comment, 2026-08-07.
- *"Hand finished? Or handmade? Country of manufacture?"* — comment, 2026-04-01.
- *"If they really are hand forged then can I expect it to look different to the one in the ad?"* —
  comment, 2026-07-24.

**Legality and safety.**
- *"With all the knife crime do you think this appropriate?"* — comment, 2026-02-16.
- *"How do you verify the age of the person you're sending these knives to?"* — comment, 2026-06-03.
- *"Surely these items should be sold from licensed premises the same as shotguns are."* — comment,
  2026-06-10.
- *"I thought advertising knives online was banned?"* — comment, 2026-03-03.

**The offer's own logic.**
- *"If it's the ONLY knife I need then why do I need to buy two to get one free? \nSurely the one
  would be enough?"* — comment, 2024-11-22.
- *"Why would I need 3 if it's so good..."* — comment, 2026-03-02.
- *"One knife does the job of every other knife so we've made 4 in our collection.\nSomething
  doesn't seem right."* — comment, 2026 (classified brand-side by my filter and re-read as a
  customer's sarcasm).

**The AI complaint.**
- *"Ai slop. Stamped and mass produced."* — comment, 2026-09-05.
- *"Please ensure your ai bot can at least pronounce the product name"* — comment, 2026-08-27.
- *"I have the Loki knife and it is brilliant, but PLEASE don't use an AI voiceover, or at least use
  one that knows Bjorn is pronounced \"Byawn\" and not \"Bi-jorn\""* — comment, 2026-08-28.

### Trigger moments

- *"Saw so many ads on this line so decided to narrow it down to one for my Hub's Christmas gift.
  He is SO picky"* — Jill Equi, review, 2025-12-28 `[2026-09-07 pull]`.
- *"Instagram kept advertising me this and when family members were stuck on what to buy me for
  Christmas, I sent them this."* — Sarah Spence, review, 2024-01-11 `[2026-09-07 pull]`.
- *"Stephen Langford I'm going to treat myself to one of these. Might get the buy 2 get 2 free if you
  fancy going halves? Could get 2 each?"* — comment, 2026-07-19. Two people splitting the offer
  between them, in public.
- *"My son in law just ordered 4 for us all. Amazing knife seen one at a BBQ"* — comment,
  2026-06-13. Word of mouth from seeing one in use.

### Metaphors and similes

- *"cuts like butter"*, *"goes through meat like butter"*, *"sharp as a lazer"* — recurring review
  phrasings `[2026-09-07 pull]`.
- *"it's a heafty knife worthy of some serious brisket cutting"* — Joel Glidewell, review,
  2025-12-22 `[2026-09-07 pull]`.
- *"like a lost (but well preserved) Viking treasure being put to practical use in my kitchen"* —
  Michael, review, 2026-02-14 `[2026-09-07 pull]`.
- *"I suspect these may be mass produced Chinesium"* — comment, 2026-08-10. Hostile, and a coinage.

### Category jargon the customer uses

Whetstone, honing rod, full tang, balance, edge retention in plain words ("holds its edge"), Damascus,
Rockwell, high carbon, stainless, coating. Note that **Rockwell and carbon content are customer
words in the comments** while the brand rule bans them from brand copy. That is a real tension and
it is named in the objections section.

### Anti-language — what customers never say

- **"Laser."** **0 of 2,135 reviews.** `verified` by direct sweep on 2026-09-08. The brand's own
  hard rule for the Feather turns on a word no customer has ever typed.
- **"Japanese", attached to a BJORN product.** Zero, across both corpora. The word itself appears
  twice in 2,135 reviews and twice in 882 comments, always about somebody else's knives. `verified`.
- **"Heirloom", "hand-forged", "work of art".** 15 reviews of 2,135, 0.7%, use any of the brand's
  craft words. `verified`. Very low echo, which is good news for the phrase bank.
- **Deal-led identity language.** Nobody describes themselves as a bargain hunter. Price talk is a
  verdict after the fact in the reviews and an attack in the comments, never an identity.

### Outliers

- Caitlin Gorman's 2023-12-11 five-star sarcastic review that the knife is *"not made for humans of
  my type, it's made for men"* `[2026-09-07 pull]`. Invisible to any rating filter.
- Colleen Parsons, 2026-01-03: *"the feathered design is a paradise for microbiol life"*
  `[2026-09-07 pull]`. A hygiene worry about the Feather specifically, in formal diction.
- *"Forget the knife who cooked that meat 🤯"* — comment, 2026-07-19. The ad's food styling
  out-performing the product.

### Whole-review concept candidates

- **Kate Taylor, 2025-12-19** `[2026-09-07 pull]` — the retired mother whose Christmas knives were
  stolen off her doormat and who the brand replaced for free. A founder-response ad already written
  by a customer.
- **Vince, 2025-12-06** `[2026-09-07 pull]` — the man who cut himself opening the box and gave five
  stars.
- **The comment-section fight itself.** 39 people saying it is not hand forged, in public, under the
  brand's own ads, while 39 more vouch for the knife they own. That is a response-ad format the
  brand has the raw material for and has never used.

## Data limitations

**1. The review corpus lost 47.0% of its records between two consecutive days.** 4,028 on
2026-09-07, 2,135 on 2026-09-08. `verified`. Every count in `source-pulls/customer-reviews.md` and
`audits/2026-Q3/customer-review-audit.md` is against a denominator that no longer exists. Their
qualitative reads survive; their arithmetic does not. Both should be re-run. Until a human confirms
with the review platform, treat the cause as **inferred deduplication**, not as data loss.

**2. Post-purchase surveys are empty.** Zero responses, re-checked 2026-09-08. This is the highest
tier of buyer evidence and the brand has none of it. Every purchase-motivation claim in this brain
is inferred from text written after the fact by people who chose to speak.

**3. The reviews cannot be read as sentiment.** 99.0% four and five star. Absence of complaint here
is not evidence of absence.

**4. The review corpus is six months stale.** It stops 2026-03-11. The current 90-day ad window
carries no review coverage at all. Anything said about who is buying *now* rests on the comment
corpus alone.

**5. One review surface only.** No Amazon, no marketplace, no retailer, no third-party platform.
The `platform` field lists the brand's own collection channels, so the surface-comparison read this
prompt normally delivers cannot be run. This is a **partial** pass by the review-mining method's
own source-coverage test: of the seven surfaces a complete review picture wants, this brand has two,
and one of them is ad comments.

**6. 20.7% of the comment corpus is the brand talking.** 279 of 1,351. Separated by a text
classifier, not by a field, because `author_name` is null on every row. The classifier errs toward
over-calling brand, so 882 substantive customer comments is a floor.

**7. 14.1% of the comment corpus has no content at all.** 177 bare tags, 10 emoji-only and 3 empty
rows, 190 of 1,351. Counted as gift and share behavior, never as language.

**8. No demographics anywhere.** No age, gender, region, country, income or first-time-buyer field
on any of the 3,486 records. Every demographic read in this brain is a model inference from writing
style and named relationships.

**9. Product attribution is unreliable on both sides.** On reviews, one review can be stored against
several products. On comments, the product can only be read off the ad name, and
`running-notes/brand-rules.md` already records that the ad name's own product field is wrong often
enough to matter, because the account's biggest ads show four knives under one knife's name.

**10. No LTV, repeat-purchase or order-value visibility.** Repeat purchase can only be counted when
somebody says so in text. There is no field that identifies a returning buyer, and no way to join a
reviewer to a commenter.

**11. The two corpora barely overlap in time.** Reviews 2022-03 to 2026-03; comments 2024-06 to
2026-09. Only 21 months carry both. Any claim that a theme "moved" between the two is comparing
different periods as well as different surfaces, and should say so.

**12. Comment collection has gaps.** No comments at all for 2025-02 through 2025-08, or for
2026-01. The ad account was spending through both stretches, so these are collection gaps rather
than quiet months.

**13. Sarcasm and irony defeat every filter used here.** Both keyword sweeps and star ratings miss
them. The ones in this document were found by reading.

**14. Every theme count is a keyword or pattern match, not a meaning judgment.** A sweep says the
words are present. Where a sweep is contaminated, it is flagged in place. Do not promote a sweep
count to a claim about what customers meant.

## Open loops

**1. Why did the review corpus halve overnight?**
4,028 records on 2026-09-07, 2,135 on 2026-09-08, with 2025 and 2026 counts identical and 2022 down
78%. Brian Chapin went from 8 rows to 1.
*Pull — Gap.* Half a corpus disappeared between two pulls and nothing in this brain predicted it.
**Was the review corpus deduplicated, re-imported, or partially lost between 2026-09-07 and
2026-09-08?**
Every count in two large finished documents rests on the answer, and so does whether this brain
re-runs them or reconciles them. Only the brand and the review platform can settle it.
*Territory: Product.*

**2. The comment section is arguing about the brand's central claim and nobody has answered it in
creative.**
39 of 882 substantive comments challenge whether the knives are hand forged. Meanwhile five
top-spending ads carrying $38,475.26, 44.5% of top-ten spend, describe the Feather pattern as etched
by hand, and the brand's own rule says it is laser-applied.
*Pull — Tension.* The rule, the ads and the customers are telling three different stories about the
same blade.
**What is actually true about how these blades are made, and what happens to conversion if the
brand shows it?**
Several commenters ask for the same proof in the same words: *"So show us the smith actually making
one. No Ai this time."* A single piece of factory or forge footage would settle a 4.4% objection
cluster and test the claim at the same time.
*Territory: Messaging.*

**3. The buyer is asking for the exact language the brand has banned itself from using.**
19 of 882 comments ask a direct materials question. *"What is the Rockwell rating?"* appears
verbatim at least four times. The brand's copy law forbids alloy codes, HRC numbers and spec
language, and the brand's own comment team answers with *"1080 high carbon steel"* and *"58–60
HRC"* anyway.
*Pull — Curiosity.* The rule and the practice already disagree, in public, on the brand's own page.
**Does answering the spec question in creative help or hurt this brand?**
It decides whether the no-jargon rule is a voice preference or a conversion decision, and right now
nobody has tested it.
*Territory: Messaging.*

**4. Knife crime and UK legality is the loudest hostile theme the brand has, and this brain had
never recorded it.**
35 of 882 substantive comments, 4.0%, most of them in the last four months. Two reviews in four
years raise the same worry politely.
*Pull — Surprise.* Nothing in the vault predicted that the biggest argument under these ads would be
about whether the ads should exist.
**How much reach and delivery is this brand losing to the legality argument, and does answering it
on screen change anything?**
It touches ad approval, comment moderation, and possibly the two DISAPPROVED top spenders already
logged in `brand-lens.md`.
*Territory: Messaging.*

**5. The AI voiceover has become an objection with a start date.**
14 comments attacking the ads as AI-made, all from 2026-07 onward, including one from a happy
owner. Every ad in the account carries `AI VO` in its name.
*Pull — Pattern.* A brand-new objection appeared in July and has not stopped.
**Is the AI voiceover costing this account anything measurable, and would one human-voiced ad tell
us?**
It is one of the cheapest tests available and the account has never run a non-AI voice in its top
set.
*Territory: Creators and talent.*

**6. In the reviews the buyer writes and the recipient is described. In the comments the recipient
writes and tags the buyer.**
177 bare friend tags plus a run of comments like *"Amber Holdroyd my Xmas gift"* and *"Can I have one
of these for Christmas plse Iain 😁😘 xx"*, against 285 reviews naming a partner as recipient.
*Pull — Resonance.* The same transaction is visible from both ends on two different surfaces, and
the brand is only writing to one end of it.
**Does creative built for the person asking for the gift work as well as creative built for the
person buying it?**
Q4 is the window, the mechanic is free, and nothing in the account has ever tried it.
*Territory: Personas.*

## Method sign-offs

Proof-of-read for the expertise loaded before this analysis.

`expertise-routing.md` names `customer-review-mining-method.md` as the canonical read for any
customer-language or review-sourced VoC doc, and `persona-research-and-creative-strategy-process.md`
alongside it for persona-bearing reads. Both were loaded and the analysis runs in their vocabulary:
denominators attached to every count, the golden-nugget standard applied so generic praise stayed
out of the quote index, the repetition threshold used to mark thin clusters, volume held separate
from emotional intensity, era tagging carried by putting a date on every quote, source coverage
graded honestly as partial, and the persona-versus-behavioral-overlay distinction respected by
leaving persona calls to the persona docs rather than making them here.

**Brand context applied.** `brand-lens.md` for the two unsettled product conflicts, which this doc
flags and does not resolve, and for the standing constraint that the review corpus can never be read
as representative sentiment. `running-notes/brand-rules.md` for the ad naming convention and its two
recorded unreliabilities. `running-notes/missing-context.md` for the empty survey and the single
review surface. `CLAUDE.md` for the copy law that the comment-section spec questions collide with.
`source-pulls/customer-reviews.md` and `audits/2026-Q3/customer-review-audit.md` for the verbatim
quote stock and the prior denominators this pull now contradicts.
