# Processed inspo log — dedup ledger for the daily ad-rewriting routine

Every TrendTrack ad the daily routine has already turned into briefs. The
real dedup mechanism is the TrendTrack folder itself — once an ad is used it
gets moved from the personal **"Inspo &lt;-"** folder to the personal
**"Swiped -&gt;"** folder (`move_favorite_item`, `scope: "personal"`), so it
physically leaves the pool the routine picks from. This table is the
human-readable audit trail on top of that, not the primary dedup check —
always pick new ads from "Inspo <-" as it stands live, not from memory of
this table.

Folder IDs (personal scope): **Inspo <-** = `3df81f20-b754-425e-a487-5cad19d4dbab`
· **Swiped ->** = `3ef55bf5-3e9d-47d7-9332-8cf868637b48`.

| Date | Ad ID / Advertiser | Concept (batch) | Products adapted for | Notion Creative IDs |
|---|---|---|---|---|
| 2026-09-01 | `facebook_1046120557939181` — Hatori Knives ("We over-ordered. Badly.") | The Warehouse Confession | Feather, Santoku, LOKI Blackout | NK382, NK383, NK384 |
| 2026-09-01 | `facebook_2215362502620024` — Hollow Alpaca Socks ("Compression socks aren't supposed to hurt.") | Nobody Tells You This About Bad Knives | Feather, Santoku, LOKI Blackout | NK385, NK386, NK387 |
| 2026-09-01 | `facebook_1545064266641647` — HexClad ("Stop buying cheap cookware...") | Stop Buying Knives You'll Replace | Feather, Santoku, LOKI Blackout | NK388, NK389, NK390 |
| 2026-09-01 | `facebook_925489177241093` — The Beard Struggle ("Struggling with a beard...") | The Knife Drawer Intervention | Feather, Santoku, LOKI Blackout | NK391, NK392, NK393 |
| 2026-09-01 | `facebook_27167990652833654` — Deejo ("Le couteau qu'on ne range pas.") | A Blade You Don't Hide Away | Feather, Santoku, LOKI Blackout | NK394, NK395, NK396 |
| 2026-09-02 | `facebook_2197612081019569` — Loop ("Loud noises making you feel on edge?") | The Reviews Are In | Feather, Santoku, LOKI Blackout | NK400 (Hasnain), NK401 (Onyeka), NK402 (Naveed) |
| 2026-09-02 | `facebook_1601099514983412` — The Ridge ("5 in 1 Power Bank - get 10,000mAh in the palm of your hand.") | One Blade, Every Job | Feather, Santoku, LOKI Blackout | NK403 (Umar), NK404 (Hammad), NK405 (Renniel) |
| 2026-09-02 | `facebook_27591131313889575` — Hume Health ("Your weight alone is a blunt tool.") | You're Judging Knives Wrong | Feather, Santoku, LOKI Blackout | NK406 (Anas), NK407 (Hasnain), NK408 (Naveed) |
| 2026-09-02 | `facebook_3042867619439863` — Dalstrong ("The benefits of a whetstone without the learning curve.") | Without The Trade-Off | Feather, Santoku, LOKI Blackout | NK409 (Onyeka), NK410 (Renniel), NK411 (Anas) |
| 2026-09-02 | `facebook_2485487308591716` — Kimbo Rolling Sharpener ("Sick of Blunt Knives?") | Stop Fighting Your Own Knife | Feather, Santoku, LOKI Blackout | NK412 (Hammad), NK413 (Umar), NK414 (Onyeka) |

## Run notes

**2026-09-02** — First run under the editor-assignment rules, so the Creative IDs
column now carries the assigned editor per page. Concept 3 ("You're Judging
Knives Wrong") came out long on all three products (211–245 spoken words,
~85–98s), so it drew only from the long-script set — Anas, Hasnain, Naveed.
It was also AI-heavy on all three, which normally prefers Anas or Renniel, but
Renniel is not cleared for scripts over 80 seconds: duration won, per the
precedence in `notion-schema-verified.md`, and Renniel took the short AI-heavy
cuts in concepts 2 and 4 instead.

Also note: NK397–NK399 ("You Get What You Pay For", 2026-09-02) are in the
database but were **not** created by this routine — Strategist `Claude`,
Content `UGC`, Avatar `MIKE` on all three products, a filled Date, and an
`<embed>` rather than a `<video>` in AD INSPO. They were built from the same
The Ridge ad this run used for concept 2, on a different angle. Re-query the
max Creative ID every run rather than continuing from this log.
