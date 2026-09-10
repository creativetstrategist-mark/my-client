---
brand: northern-knife
doc: attribution-reconciliation
generated_on: 2026-09-10
refresh_by: 2026-12-09
closes_loop: "PD-13 — Does the 2.0 ROAS floor mean Meta's number or Triple Whale's?"
built_from:
  - "Triple Whale get-shop-info, both stores, pulled live 2026-09-10"
  - "Triple Whale get-summary-kpis, northernknifeuk.myshopify.com and northernknife.myshopify.com, 2026-06-09 to 2026-09-07, pulled live 2026-09-10"
  - "running-notes/success-definition.md — the stated 2.0 floor"
  - "audits/2026-Q3/90-day-performance-audit.md — the Meta-side window figures this reconciles against"
data_limitations:
  - "The two stores report in DIFFERENT CURRENCIES — the US store in USD, the UK store in GBP. Nothing in this doc sums across them, and neither should anything else. Every figure below carries its currency."
  - "Gross profit here is Triple Whale's own configured contribution figure (sales less COGS, handling, payment fees, refunds and custom spends). It is the shop's configuration, not a margin the brand stated in words, so it is marked `verified from Triple Whale` rather than `stated`."
  - "UPDATED 2026-09-10: Parker's connected-account list was checked directly and returns exactly ONE account (1897335644135093, AURORA | A12264703 | NorthernKnife_UK_3, primary, enabled, USD), which confirms the US spend is unreachable from Parker rather than merely un-queried. The US Meta spend still has NOT been traced to a specific ad account id — nothing in Parker exposes it. That it exists, its size, and that it is a separate account are established; its id and name are not."
---

# Attribution reconciliation — what the 2.0 floor actually means

This closes **PD-13**, filed 2026-09-10 as the highest-value open question in the brain: every
ROAS figure in these documents is Meta's attributed number, the brand reads performance in Triple
Whale, and nobody had checked whether the two tie out. With lifetime headroom of 1.6% against the
stated floor, the answer decided whether this account was above water or below it.

**It came back the opposite way round from the hypothesis, and it moved three things that were
wrong.** Read the three findings before anything else.

---

## Finding 1 — Blended reads HIGHER than Meta, not lower

The loop predicted platform attribution would flatter the account and that Triple Whale would read
lower. It reads **higher**, on both stores, because Meta's number only sees Meta while the blended
number sees Google, email and organic revenue earned against a much smaller spend.

**Window: 2026-06-09 → 2026-09-07, the same 90 days as the performance audit. Pulled live 2026-09-10.**

| | **UK store** (GBP) | **US store** (USD) |
|---|---|---|
| Sales | £744,171.30 | $1,007,697.83 |
| Meta spend | £255,939.42 | $316,988.95 |
| **Meta-attributed ROAS** | **2.23** | **1.68** |
| Blended ROAS (all channels) | **2.39** | **2.83** |
| Triple Attribution ROAS | 2.95 | 1.96 |
| New-customer ROAS | 2.03 | 2.54 |
| Blended ad spend | £311,976.20 | $356,121.21 |
| Orders | 6,334 | 4,908 |
| MER | 41.92 | 35.34 |

`verified` — Triple Whale summary KPIs, both stores, pulled 2026-09-10.

**So "which ROAS" genuinely changes the answer**, and by a lot on the US store: 1.68 on Meta's own
number against 2.83 blended. Anyone applying a single 2.0 rule without saying which metric it
governs will reach opposite conclusions about the same store on the same day.

---

## Finding 2 — The margin is not missing any more, and my inference was wrong

`running-notes/missing-context.md` has carried "gross margin was never provided" as the single most
valuable number the brand could add, since 2026-09-07. **Triple Whale has it configured, and has had
it all along.** Nobody had looked.

| | UK store | US store |
|---|---|---|
| Contribution profit (Triple Whale `grossProfit`) | £444,106.57 | $579,189.27 |
| **Contribution margin** | **59.68%** | **57.48%** |
| **True breakeven ROAS on contribution** | **1.68** | **1.74** |

`verified from Triple Whale` — this is the shop's own configured figure: sales less COGS, handling
fees, payment gateway fees, refunds and custom spends.

**This corrects a number I inferred and propagated.** From the brand owner's *"below 2 ROAS is not
profitable"* I inferred a contribution margin near **50%**, and wrote that inference into
`success-definition.md`, `brand-rules.md`, `missing-context.md`, `CLAUDE.md` and `brand-profile.md`
with the caveat that at 48% the account would be underwater. **The real contribution margin is
57–60%, not 50%, so the true contribution breakeven is roughly 1.68–1.74, not 2.0.** The inference
was too pessimistic, and every document carrying it has been corrected.

**What that means for the stated 2.0 floor.** It is not a contribution-breakeven number. It is
higher than contribution breakeven on both stores, which makes it a **target that already carries
overhead and profit inside it** — a sensible operator's rule of thumb, not a break-even line. So:

- **Above 2.0** is comfortably profitable, not marginal.
- **Between ~1.7 and 2.0** still contributes something; it just does not clear the brand's bar.
- **Below ~1.7** is the line where a Meta dollar genuinely stops paying for itself.

Both readings should be quoted together, because the difference between "at breakeven" and
"clearing the owner's target with room" is the difference between two completely different plans.

---

## Finding 3 — Both stores are net profitable, and the "barely breakeven" framing was wrong

| | UK store | US store |
|---|---|---|
| **Net profit, 90 days** | **£132,145.06** | **$225,537.59** |
| Net margin | 17.76% | 22.38% |

`verified from Triple Whale`, same pull.

The brain has been saying, since the floor landed this morning, that this account had "very nearly
exactly broken even" across its life. **That framing was built on Meta's UK-only attributed number
and a margin I guessed too low.** On the business's own books, across this 90-day window, the two
stores cleared **£132,145.06** and **$225,537.59** at 17.8% and 22.4% net margin. That is a healthy
business, not one scraping breakeven.

**The tension with the objective softens but does not disappear.** "Scale acquisition" against a 2.0
target still means the room to trade efficiency for volume is real but bounded — and on the US
store's Meta spend specifically, there is none, which is Finding 4.

---

## Finding 4 — The US store's Meta spend is below its own breakeven, and this brain has never audited it

**US Meta spend: $316,988.95 in 90 days, at 1.68 ROAS, against a contribution breakeven of 1.74.**
That is **below the line** — not below the brand's 2.0 target, below the point where the spend pays
for its own goods. `verified` on the figures.

The US store is still net profitable (22.38%) because the rest of the mix carries it: Google at 4.26
ROAS on $35,125.48, Klaviyo driving 23.1% of sales, and a large organic base. **Meta is being
subsidised by the other channels on that store.**

**And this brain has never looked at it.** Every audit here reads the UK Meta account. The proof is
in the numbers: the performance audit's 90-day window spend of **$337,402.58** against the UK store's
**£255,939.42** implies an FX rate of **1.3183** — a clean GBP→USD match. So the brain's Meta figures
are the UK account, denominated in USD by Meta and in GBP by Triple Whale.

That leaves the US store's **$316,988.95** of 90-day Meta spend — roughly the same size as the
account this brain spent a week auditing — **outside everything in this vault.** `missing-context.md`
records that the Meta connector reached only `act_8557554027677317` and `act_1771028750359089`, both
DISABLED with zero spend, and that neither was the account the audits read. There is at least one
more live, spending Meta account that Parker has never seen.

> **This is the single largest gap in the brain and it is bigger than anything on the loop agenda.**
> Roughly half the paid business is unaudited, and the half that is unaudited is the half performing
> worse. Every "this account has never run that" claim in the diversity audit, every format and
> fatigue read, every persona-delivery finding — all of it describes the UK account only, and none
> of the documents say so, because nobody knew.
>
> **CONFIRMED 2026-09-10, after this doc was first written.** Parker's own connected-account list
> was checked directly. It returns **exactly one account**:
>
> ```
> 1897335644135093 · AURORA | A12264703 | NorthernKnife_UK_3
> is_primary: true · is_enabled: true · currency: USD
> ```
>
> There is no second account to scope to, so the US spend is genuinely unreachable from Parker
> rather than merely un-queried. `verified`.
>
> **And the check strengthened the finding rather than weakening it.** The one connected account's
> whole 90-day spend of $337,402.58 maps to the UK store's £255,939.42 at FX 1.3183. The *entire*
> account reconciles to the UK store alone — so the US store's $316,988.95 cannot be a slice of
> this same account being split across stores by attribution. It is a separate ad account,
> connected to Triple Whale but not to Parker. `inferred`, and the inference is now tight.
>
> **Still not verified:** the US account's id and name. Nothing in Parker exposes them, by design.
>
> **A trap for whoever connects it:** the already-connected account is named `NorthernKnife_UK_3`,
> reports in **USD**, and points at `northernknife.co.uk`. **Do not identify the US account by
> currency** — the one that is already connected is the USD one.

---

## What this does to the loop agenda

- **PD-13 — CLOSED.** The floor is a target, not a breakeven, and blended reads higher than Meta.
  Answered in full above.
- **PD-11 — reopened in a smaller form.** The 2.0 answer stands as the brand's bar, but it is now
  known to sit above contribution breakeven. What is still unstated is the *overhead* inside it.
- **The margin gap in `missing-context.md` — CLOSED**, from Triple Whale rather than from the brand.
- **NEW — the unaudited US Meta account.** Filed as the top item. It outranks every loop currently
  in Tier 1, because it changes the denominator under all of them.
- **PL-1 / the SARAH read — needs re-running per store.** The 1.64 return that made the chooser look
  unfundable was a UK-account figure read against a 2.0 breakeven that turns out to be 1.68. She may
  clear contribution after all. Nobody should act on "SARAH does not pay for herself" until that is
  re-checked against the right breakeven and the right store.

## Method sign-off

**What I did:** called `get-shop-info` on both connected Northern Knife stores, confirmed they report
in different currencies, then pulled `get-summary-kpis` separately for each across the performance
audit's exact window. Nothing was blended across currencies at any point.

**What I did not do:** trace the US Meta spend to an ad account id, pull lifetime rather than
90-day figures, or re-run any per-persona or per-ad number against the corrected breakeven. Those
are named above as follow-ups rather than done quietly.

**What would change this read:** an FX rate materially different from 1.3183 would weaken the
identification of the audited account as the UK one. A different configured cost model in Triple
Whale would move the contribution margins. Neither would change Finding 4.
