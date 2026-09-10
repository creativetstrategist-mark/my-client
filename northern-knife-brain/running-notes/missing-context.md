# Missing context — Northern Knife

What Parker does not know, why it matters, and how to close it. Every gap here is a real
limit on a read somewhere in this brain. Nothing here is a blocker.

## Dark data surfaces

| Surface | State | What it costs | How to close it |
|---|---|---|---|
| **Post-purchase surveys** | zero responses | The single best source for *why* someone bought and what they nearly bought instead. Without it, purchase motivation is inferred from reviews and ad comments, which are both post-hoc and skewed positive (4.93 average). `personas/post-purchase-surveys` is blocked. | Upload a CSV or connect a survey platform in Parker, then re-run that prompt. |
| **Northbeam** | not connected | Nothing on its own — the brand reads performance in Triple Whale. | No action needed unless the brand switches. |
| **Parker chat history** | none | No prior conversations to read the team's thinking out of. Everything in this brain came from data or the set-up intake. | Fills naturally as the team uses Parker. |
| **Placement position** | not exposed | Parker surfaces platform and device but not `platform_position`, and the connected Meta login does not reach ad account `act_1897335644135093`. Feed-versus-Reels-versus-Stories reads are unavailable; platform-level is the substitute. |
| **Reach / frequency** | not exposed | No frequency or CPMR read is possible, so creative fatigue is inferred from hook-rate and spend decay rather than measured by frequency. |
| **Competitor set** | 2 tracked | Coolina USA and Dalstrong only. The whitespace and creative-landscape reads are as narrow as the set they read. | Add the real rival set in the Parker app. |
| **Organic social (IG/FB/TT owned accounts)** | not tracked | `organic-channels-inventory` is a synthesis of the TikTok *inspiration* library, not of Northern Knife's own organic output. | Enable organic tracking for the brand's own handles. |

## Unanswered intake items

The set-up intake was deliberately short. These went unasked or unanswered and each one
sharpens a specific read:

- **Gross margin / contribution margin.** Without it every profitability statement in this
  brain is a revenue statement. Under a scale objective this is the most valuable single
  number the brand could add.
- **Max tolerable CPA, and the ROAS floor.** The objective is to scale; scaling means
  deliberately spending past the most efficient point. Nobody has said how far. Current
  reference: $79.57 CPA, 2.18 ROAS over 30 days.
- **LTV / payback window.** Decides whether a first-order loss is acceptable.
- **Secondary metrics the team weighs** beyond ROAS.
- **The spend-versus-efficiency rule** when two ads in one ad set diverge.
- **Brief template.** Not supplied, so `briefs/_brief-template.md` was not seeded from the
  brand's own format. The team keeps briefs in Notion (Video Brief Database) — the format
  there should be read in and saved so every brief this brain writes matches it.
- **The naming-convention confirmation.** Parker parsed the ad naming scheme off the ad
  names themselves (see `brand-rules.md`). The reading looks solid but is unconfirmed.
- **The gap question** — "what does a smart outsider always get wrong about this brand?" —
  was not put to the team. Worth asking; it is usually the highest-signal answer in an intake.

## Tools named but not connected

The team named **Slack, Gmail and Calendar** as places they work, and none was connected
before the build. Anything living in them (client conversations, launch dates, approvals)
is invisible to this brain's foundation and would have to be reconciled in later rather
than read in at build time.

Connected and read during the build: Notion, TrendTrack, Meta Ads, Triple Whale.

## Data-integrity issues found 2026-09-09 — issues 2 and 3 RESOLVED 2026-09-10, issue 1 still open

### 1. The review corpus has two different totals in circulation

| Figure | Where it is used | Provenance |
|---|---|---|
| **4,028** | `source-pulls/customer-reviews.md`, `audits/2026-Q3/customer-review-audit.md`, `BUILD-STATUS.md` | `verified` — an **unfiltered** `search_customer_reviews_sql` count run 2026-09-07 at session start, no keywords, no sentiment filter, no date range, `returnData: false`. It returned `totalReviews: 4028, totalMatching: 4028, matchPercentage: 100`, average 4.93. |
| **2,135** | `personas/voice-of-customer/voc-corpus-profile.md`, and carried forward into `source-pulls/ad-comments.md` | Reported by the corpus profile as its corpus size. The filter or subsetting that produces it is not stated. |

**Nothing is silently reconciled here.** The 4,028 figure is a verified unfiltered total for the
brand. 2,135 is plausibly a legitimate *subset* — reviews carrying usable text, or an embedded /
semantically-indexed subset, or a date-bounded read — but which of those it is has not been
established, and a subset presented as the corpus total would understate every percentage taken
against it.

**Consequence, stated plainly:** `ad-comments.md` used the 2,135 figures throughout, so its
review-side corroboration percentages are expressed against an unexplained denominator. Its
comment-side counts (882 substantive / 1,351 total) are unaffected.

**To settle it:** run an unfiltered `search_customer_reviews_sql` count, then re-run whatever
filter the corpus profile used, and state the relationship between the two in both docs. Until
then, cite 4,028 for the corpus and label any 2,135-based percentage as resting on a subset.

### 2. The ad-comments tool went unavailable mid-build — RESOLVED 2026-09-10

`mcp__Parker__search_facebook_ad_comments_sql` **worked on 2026-09-07** — it was used in the
session-start operability check and returned live comment rows through 2026-09-06. On 2026-09-09
it returns *"MCP server Parker is connected but does not offer this tool here."*

This is a **regression during the build, not a standing gap.** The Meta connector is not a
fallback: it reaches `act_8557554027677317` and `act_1771028750359089`, both DISABLED with zero
spend, and neither is `act_1897335644135093`, the UK account every audit here reads.

**What it cost:** `source-pulls/ad-comments.md` could make no fresh pull. Every count and quote in
it is carried from the corpus profile's 2026-09-08 read of all 1,351 rows — solid, but
single-sourced, and the doc says so rather than implying corroboration.

**What is still missing, and it is the read that pull exists to produce:** the **ad-level join.**
`ad_names` sits on 100% of the 1,351 rows and the naming convention encodes the persona each ad
was written for, so comments can be read *by ad and by persona*. That has never been run by
anyone. It is the top item for the next refresh, the moment the tool returns.

Three cheap sweeps also never ran and would each close a real gap:
- **"laser"** on the comment side — the Feather rule conflict has only been tested on reviews.
- **"opener" / "bottle"** — the LOKI conflict has no comment-side read at all.
- **grill language** — MIKE is 36.7% of 90-day spend and this surface has no read on him.

**RESOLVED 2026-09-10.** The tool is back. A three-row verification pull returned live comments
through **2026-09-09T19:55:53+00:00** — fresher than any customer surface in this brain — with
`ad_names` populated on every row, including the full naming string
(`NK313_VID_Return Box - Trial (NK168)_3D_Generalist_LOKI Blackout_AI VO_MIKE - BBQ KING_B2G2_...`).
So **the ad-level join and all three sweeps are runnable now.** They have still never been run;
this entry stays open as the work item, not as a blocker. It is the top item for the next refresh.

**One new caveat from that pull, carry it:** the response's `total` field returned **0** while
three rows came back, so the RPC's total_count is unreliable. Any comment count must be derived by
paging the rows, never read off `total`. A count taken from that field would read as zero.

**A second thing that pull showed:** one comment carried **two** ad ids against a single ad name,
so the ad-to-comment relationship is many-to-many. The join has to account for a comment appearing
under more than one ad, or per-ad counts will double-count.

### 3. Parker MCP disconnected 2026-09-09 — RESOLVED 2026-09-10

As of the whitespace run, `Parker MCP` is not connected in this session at all — not just the
comments tool. The Meta connector remains no substitute: `act_8557554027677317` and
`act_1771028750359089` only, both DISABLED with zero spend, neither being
`act_1897335644135093`.

**Consequence:** every figure in `quarterly-whitespace-analysis.md` for spend, format, emotion and
persona is *carried* from the 2026-09-07 and 2026-09-08 pulls, and no creative media was inspected
live. That is stated in its frontmatter. Any prompt still pending that needs a live ad or review
pull cannot run honestly until Parker returns.

**RESOLVED 2026-09-10.** Parker reconnected and every brand-scoped tool is available again. The
figures already carried in `quarterly-whitespace-analysis.md` were **not** re-pulled or re-verified
against the restored connection, so they remain carried, exactly as its frontmatter says. What
changed is only that the prompts still pending are runnable again.

**Triple Whale is connected and was used**, which is how the whitespace analysis reached order-level
data none of the earlier documents could see. Worth remembering: it is a live route to revenue,
order and repeat-purchase truth that the Parker-shaped prompts do not reach for by default.
