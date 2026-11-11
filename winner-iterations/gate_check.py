"""Mechanical gates for a winner iteration (spec §3.4, §3.5, §4.3).

Usage:
    python3 -I winner-iterations/gate_check.py RUN.json [REFERENCE_FILE ...]

RUN.json holds the three scripts as lists of [row, copy] pairs, rows named
H1..Hn and B1..Bn, plus the Reskin's fix list:

    {"source":  [["H1", "..."], ["B1", "..."]],
     "rewrite": [["H1", "..."], ["B1", "..."]],
     "reskin":  [["H1", "..."], ["B1", "..."]],
     "fixes":   {"B12": ["notched into the blade", "built into the handle"]}}

REFERENCE_FILE: anything else the Rewrite must not copy from, for example the
winning briefs and approved-copy files in the brand pack.

Checks:
  - Rewrite length: each row within ±20% of the source row's word count, and
    the whole script within ±10% of the source.
  - Rewrite originality: no run of 6+ consecutive words shared with the source
    or a reference file. House language is exempt.
  - Reskin lock: after numerals and capitals are normalised, the only word
    differences from the source are in rows on the fix list.

Exit code 0 means every check passed.
"""
import difflib
import json
import re
import sys
from pathlib import Path

NUM = {"1": "one", "2": "two", "3": "three", "4": "four", "10": "ten", "30": "thirty"}
HOUSE = [  # spec §3.5 exemptions
    "buy two get two free", "four knives for the price of two", "link's below",
    "lifetime warranty", "thirty day money back trial", "free shipping",
]


def toks(text):
    t = text.lower().replace("—", " ").replace("-", " ")
    t = re.sub(r"[^a-z0-9' ]", " ", t)
    return [NUM.get(w, w) for w in t.split()]


def words(text):
    return len(text.replace("—", " ").split())


def shared_runs(a, b, n=6):
    ta, tb = toks(a), toks(b)
    grams = lambda ts: {tuple(ts[i:i + n]) for i in range(len(ts) - n + 1)}  # noqa: E731
    hits = (" ".join(h) for h in grams(ta) & grams(tb))
    return sorted(h for h in hits if not any(h in x or x in h for x in HOUSE))


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    run = json.loads(Path(sys.argv[1]).read_text())
    src, rew, res = (dict(run[k]) for k in ("source", "rewrite", "reskin"))
    fixes = run.get("fixes", {})
    bad = 0

    print("== Rewrite: length (±20% per row, ±10% total) ==")
    for k, s in run["source"]:
        a, b = words(s), words(rew.get(k, ""))
        lo, hi = round(a * 0.8), round(a * 1.2)
        ok = lo <= b <= hi
        bad += not ok
        print(f"{k:4} source {a:3}  new {b:3}  allowed {lo}-{hi}  {'OK' if ok else 'FAIL'}")
    body = [k for k, _ in run["source"] if k.startswith("B")]
    for h in (k for k, _ in run["source"] if k.startswith("H")):
        st = words(src[h]) + sum(words(src[k]) for k in body)
        nt = words(rew[h]) + sum(words(rew[k]) for k in body)
        pct = (nt - st) / st * 100
        ok = abs(pct) <= 10
        bad += not ok
        print(f"total with {h}: source {st}  new {nt}  ({pct:+.1f}%)  {'OK' if ok else 'FAIL'}")

    print("\n== Rewrite: originality (6+ shared words) ==")
    refs = {"source": " ".join(s for _, s in run["source"])}
    refs.update({Path(p).name: Path(p).read_text() for p in sys.argv[2:]})
    for k, line in run["rewrite"]:
        for name, ref in refs.items():
            for r in shared_runs(line, ref):
                bad += 1
                print(f"FAIL {k} vs {name}: '{r}'")

    print("\n== Reskin: lock (only fix-list rows may differ) ==")
    for k, s in run["source"]:
        a, b = toks(s), toks(res.get(k, ""))
        for op, i1, i2, j1, j2 in difflib.SequenceMatcher(a=a, b=b).get_opcodes():
            if op != "equal":
                listed = k in fixes
                bad += not listed
                print(f"{k}: '{' '.join(a[i1:i2])}' -> '{' '.join(b[j1:j2])}'"
                      f"  {'(fix list)' if listed else 'NOT ALLOWED'}")

    print("\nRESULT:", "PASS" if bad == 0 else f"{bad} problem(s)")
    sys.exit(0 if bad == 0 else 1)


if __name__ == "__main__":
    main()
