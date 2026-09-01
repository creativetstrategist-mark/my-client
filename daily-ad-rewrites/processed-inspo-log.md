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
