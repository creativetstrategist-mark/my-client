# Notion integration map

Read and written on 2026-10-08. IDs are stable; schemas are not — re-fetch a
collection before writing to it.

## What this repo writes into

| Target | ID |
|---|---|
| `🎬 Creator Script Library` (data source) | `collection://5b803420-2b09-4b3e-beea-4e3e3cf839b9` |
| ↳ database page | `https://app.notion.com/p/a6876299e5734ed4aa1fe03b77524497` |

One new row per script. Properties: process doc Section D. Body: Section C.

## What this repo reads from, and never writes

| Source | ID |
|---|---|
| `UGC Creator Library` (hub page) | `3984ac62-7aac-8146-a6f8-c8b492d38085` |
| `Knives — B-Roll Library` | `collection://ca66767d-35ce-4318-9c3d-84398122de68` |
| `Sharpener — B-Roll Library` | `collection://c3795d74-319b-44ee-8a91-e172681a228f` |

The b-roll libraries are owned by the Gen 2 system. Select shots from them;
never add, renumber or re-point rows from here.

## Archive, for structure reference only

| Source | ID |
|---|---|
| `UGC Creator Brief` (Gen 1 hub) | `2ef4ac62-7aac-800f-bbcc-d4ea9803b1b5` |
| ↳ `May - July Campaign` | `34a4ac62-7aac-8042-9ccf-fe3be1d7af25` |
| ↳ `Ever Green UGC` (data source) | `collection://2ef4ac62-7aac-80f8-9619-000b47c2a838` |
| ↳ `Batch 1 \| Father's Day First Wave` | `collection://3494ac62-7aac-815d-9986-000b782af0f0` |

Gen 1 pages are superseded. Read them for structure history
(`observed-notion-structure.md`), not for current copy rules — the May 2026
Feather brief asserts the pattern is hand-finished, which the current rule
forbids outright.

## Querying the b-roll library

SQL over the collection returns **live rows only**, which is what you want —
an archived shot is not a shot. Checking an ID you read elsewhere:

```
SELECT "Shot ID", "Shot", "Category", "Campaign", "Block", "Priority", "Cast"
FROM "collection://ca66767d-35ce-4318-9c3d-84398122de68"
WHERE "Shot ID" IN ('KNF-XM12','KNF-PS05')
```

An ID that returns no row is archived or never existed. A `notion-fetch` of an
archived page still succeeds and returns its properties — it is only flagged
`deleted` in the response header, which is easy to miss.

Live state when last read: **102 rows**, 9 of them `KNF-XM*`, 43 at P1, 85
`Andy Approved`, 29 assigned to `Include in:` Trybe packs.

## Not reachable from this session

`briefs/ugc-broll-library/` — the Gen 2 markdown source of truth, which the
library page names and whose `README.md` holds the general filming rules sent
to every creator.

It is in neither repo this account exposes (`my-client` is the ad-rewriting
repo; `my-business` is a website), and Parker returns no brands, so it is not
a Parker Brain. It is most likely a local working directory on the machine
running the other Claude Code session.

**Consequence:** this repo reaches the Gen 2 system **through Notion only**.
The filming rules in Section F of the process doc were reconstructed from the
`Filming notes` on live script pages, not from that README — so they may be
incomplete. If that directory is ever attached as a repo, reconcile the
process doc against its README and this file against its layout.
