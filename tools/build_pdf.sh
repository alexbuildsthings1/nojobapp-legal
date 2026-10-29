#!/bin/sh
# Prints privacy_policy.html to privacy_policy.pdf with headless Google Chrome,
# using the page's print styles (style.css and web.css's @media print block).
# The PDF is the copy bundled in the iOS app as assets/legal/privacy_policy.pdf.
#
#   tools/build_pdf.sh            # writes privacy_policy.pdf in the repo root
#   tools/build_pdf.sh out.pdf    # writes it somewhere else
set -eu

root=$(cd "$(dirname "$0")/.." && pwd)
out=${1:-"$root/privacy_policy.pdf"}
chrome=${CHROME:-"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"}

"$chrome" --headless --disable-gpu --no-pdf-header-footer \
  --run-all-compositor-stages-before-draw --virtual-time-budget=5000 \
  --print-to-pdf="$out" "file://$root/privacy_policy.html" 2>/dev/null
echo "Wrote $out"
