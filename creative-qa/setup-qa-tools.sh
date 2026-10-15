#!/usr/bin/env bash
# Prepare a session for a creative QA run, then say whether a full QA is
# actually possible. Idempotent — safe to run at the start of every run; it
# installs only what is missing.
#
# Exit codes. The QA run should branch on these:
#   0  tools ready AND the Frame.io media host is reachable
#        -> run the full Zoro pass.
#   3  tools ready BUT the media host is blocked
#        -> only file naming and container metadata can be checked. Per
#           qa-process.md, post NOTHING on that alone unless Mark has asked
#           for a partial pass; report the block instead.
#   1  tooling could not be installed
#        -> report it and do not QA.

set -uo pipefail

MEDIA_HOST="${MEDIA_HOST:-at.adobe.com}"
fail=0

say()  { printf '%s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }
py_has() { python3 -c "import $1" >/dev/null 2>&1; }

say "== creative QA setup =="

# ffmpeg/ffprobe ship with the image; we check rather than install them.
for bin in ffmpeg ffprobe; do
  if have "$bin"; then
    say "ok       $bin"
  else
    say "MISSING  $bin  (needed for frames, audio and specs)"
    fail=1
  fi
done

if have tesseract; then
  say "ok       tesseract  $(tesseract --version 2>&1 | head -1)"
else
  say "...      installing tesseract-ocr"
  apt-get update -qq >/dev/null 2>&1
  if apt-get install -y -qq tesseract-ocr >/dev/null 2>&1 && have tesseract; then
    say "ok       tesseract  $(tesseract --version 2>&1 | head -1)"
  else
    say "FAILED   tesseract-ocr did not install."
    say "         It needs 'apt-get update' first (the image ships without the"
    say "         package lists, so a bare install reports 'Unable to locate"
    say "         package') and network access to the Ubuntu archives."
    fail=1
  fi
fi

for mod in numpy PIL; do
  if py_has "$mod"; then say "ok       python $mod"; else
    say "MISSING  python $mod  (needed by the QA scripts)"; fail=1
  fi
done

if py_has faster_whisper; then
  say "ok       python faster_whisper"
else
  say "...      installing faster-whisper (pulls av + ctranslate2, ~75 MB)"
  if pip install -q faster-whisper --break-system-packages >/dev/null 2>&1 && py_has faster_whisper; then
    say "ok       python faster_whisper"
  else
    say "FAILED   faster-whisper did not install."
    fail=1
  fi
fi

if [ "$fail" -ne 0 ]; then
  say ""
  say "RESULT: TOOLING INCOMPLETE — report this and do not QA."
  exit 1
fi

# The check that actually decides whether this run can QA anything.
say ""
say "== preflight: Frame.io media host =="
code=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 20 "https://${MEDIA_HOST}/" 2>/dev/null || true)
if [ -z "$code" ] || [ "$code" = "000" ]; then
  say "BLOCKED  ${MEDIA_HOST} is not reachable from this container."
  say ""
  say "Frame.io serves every download, proxy, thumbnail and scrub-sheet URL from"
  say "this host, so no cut can be QA'd — captions, VO, safe zones and audio all"
  say "need the bytes. This is the environment's network policy, not a code"
  say "problem, and the policy binds when the container is provisioned, so"
  say "allowing the host only takes effect in a NEW session."
  say ""
  say "RESULT: TOOLS READY, MEDIA BLOCKED — naming and metadata only."
  exit 3
fi
say "ok       ${MEDIA_HOST} reachable (HTTP ${code})"
say ""
say "RESULT: READY — full QA is possible."
exit 0
