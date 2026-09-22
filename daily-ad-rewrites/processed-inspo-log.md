# Processed inspo log

Dedup ledger for the daily ad-rewriting routine. **Every TrendTrack ad used by
the routine gets logged here.** Check this file before picking new inspo so the
routine doesn't reuse the same source twice in a row.

## How to use it

1. Before picking: read the table below. Any ad id or URL that appears here is
   already spent — skip it.
2. After creating the day's briefs: append one row per ad used, then commit and
   push the update.
3. One row per **ad**, not per brief. The `Briefs created` column lists the
   Notion Creative IDs generated from that one source (normally three — one per
   focus product).

## Format

| Date used | Ad ID / URL | Advertiser | Briefs created | Notes |
|---|---|---|---|---|

Column notes:
- **Date used** — `YYYY-MM-DD`, the routine run date.
- **Ad ID / URL** — the TrendTrack share link or ad id. Prefer the full share
  URL; it is the thing that can be checked against unambiguously.
- **Advertiser** — the brand the inspo came from.
- **Briefs created** — comma-separated `NK###` ids, in Feather / Santoku /
  Blackout order.
- **Notes** — the mechanic taken, or why fewer than three briefs came out of it.

## Log

| Date used | Ad ID / URL | Advertiser | Briefs created | Notes |
|---|---|---|---|---|
| 2026-08-22 | https://app.trendtrack.io/share/ads/coolina-usa-2xqDP1 | Coolina | NK306 | Backfilled from the live brief, not from a routine run. Deadpan split-screen call-and-response mechanic. LOKI Blackout only. |
| 2026-09-10 | https://app.heyparker.ai/share/ideas/tOtgfZXPt0mH | Parker (NorthernKnife own long-form VSL) | NK458, NK460, NK459 | Not a TrendTrack source — logged anyway so the mechanic isn't re-adapted. Returned-knife story cut to under 60s. Feather and Santoku on JOHN, Blackout on MIKE. |
| 2026-09-10 | https://app.trendtrack.io/share/ads/northernknife-uk-lVoSCO | NorthernKnife UK (our own ad) | NK461, NK462, NK463 | Forward-looking "What if" anaphora, inverted to a backward-looking version. Feather on JOHN, Blackout on MIKE, Santoku on JOHN. No lineup in any of the three — single-product by the strategist's call. Source contains an "etched" claim on the Feather pattern — a hard-rule violation, not carried over. |
| 2026-09-14 | https://app.trendtrack.io/share/ads/the-ridge-CFRKoe | The Ridge | NK490, NK491, NK492 | Everyday-carry UGC. Mechanic taken: consolidation claim first, product named at beat 4, multi-buy justified by **placement rather than savings**. No lineup — single product per the strategist's call. Each cut re-angled rather than transplanted: Feather = "it replaced three" (JOHN); Santoku = "I own knives that cost more and reach for this" (JOHN), count deliberately **four**, since a "replaced three" wink references the santoku name's Japanese-origin meaning; Blackout = "I bought the cheap one expecting a gimmick" (MIKE), and its beat-8 gift pivot is rebuilt as a **peer beat** because MIKE recoils from gift framing. |
| 2026-09-15 | https://app.trendtrack.io/en/share/ad/v81BDjx__yxPgfXwWFL4ZePCnpsW9kBmM0ZzJiXtU8g | Holo (alpaca compression socks) | NK496, NK495, NK497 | Feather only, by the strategist's call. **Offer-led mechanism** — price objection named, offer stated as news, offer justified by quality tier rather than arithmetic, **negative-benefit stack**, category-superiority close. Run on VANCE, not JOHN: the mechanism is a price objection and JOHN does not have one. **Opens on the offer, which is a declared §C.3 deviation** — documented on the page, re-landed at ~70% with four beats after, and explicitly not a precedent. Source's spec register (mmHg, graduated compression) is exactly §C.1-banned language and was not carried over. Extended to ~110s at the strategist's request. Santoku took NK495 (recycled — it held a duplicate Feather cut of this same ad) and Blackout took NK497. **Blackout inverts the price objection**: at $79.90 the doubt is "too cheap to be real", not "too expensive", which makes the quality stack rebut a suspicion instead of justify a cost. Santoku has no verified price or scarcity figure, so its scarcity beat is rebuilt as a craft limit (hand-carved handles, no two alike) and its price shows on the PDP rather than in VO. |
| 2026-09-22 | https://app.trendtrack.io/en/share/ad/CXBIX_J9MrM2Jtmxv9o2xBNFE5jOD3rDG4KdHZYHO3I | Dr. Squatch | NK505 | Feather only so far. **Mechanic taken: the feature stack is spent on the FREE item, not the paid one** — which converts the bonus from filler into the reason to buy. Our equivalent is the two free knives, and it answers a latent B2G2 objection ("the free ones must be seconds") that nothing else in the catalogue addresses. Run on VANCE. **Three things deliberately not carried over:** the 39% (our offer is B2G2, never a percentage, never stacked); the "limited edition / once they're sold out it's done" deadline (B2G2 is the standing storewide offer — scarcity moved onto the product, where 500-a-run and ~3 months are real); and the "she might stick around" line, which is a cheap joke at a woman's expense and is nowhere in our voice. |
| 2026-09-15 | https://app.trendtrack.io/en/share/ad/v81BDjx__yxPgfXwWFL4ZePCnpsW9kBmM0ZzJiXtU8g | Holo (alpaca compression socks) | NK495 | Price-objection entry, offer framed as rare **for the quality tier** rather than as a discount, category dismissal close. Feather only, JOHN, and deliberately long (~100s). **Two things not carried over:** the source opens on the offer in sentence two — a discount-first hook, on JOHN's recoil list — so the offer moved to ~64% per §C.3; and the source's spec stack ("15 to 20 mmHg, graduated compression") is exactly the register §C.1 bans, rebuilt as plain material plus consequence. |

> The NK306 row is backfilled from the Notion database so the Coolina ad is not
> picked again. The routine has not yet had a scheduled run that wrote to this
> file.

> **Known gap, left deliberately.** NK464-466, NK473-475, NK476-478 and
> NK479-481 were written in-session from sources that are not logged here: a
> competitor scam-accusation script, two customer reviews, and an ad comment.
> The strategist ruled 2026-09-14 that these do not need backfilling. They were
> not TrendTrack favourites, so the daily routine's search will not surface them
> anyway. Do not re-raise this.
