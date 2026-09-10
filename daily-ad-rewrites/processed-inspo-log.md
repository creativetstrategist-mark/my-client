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

> The single row above is backfilled from NK306 in the Notion database so the
> Coolina ad is not picked again. The routine has not yet had a scheduled run
> that wrote to this file.
