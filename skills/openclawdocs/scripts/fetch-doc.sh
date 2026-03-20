#!/bin/bash
# Fetch specific OpenClaw documentation

set -e

DOCS_BASE="https://docs.openclaw.ai"
CACHE_DIR="/tmp/openclawdocs-cache"
mkdir -p "$CACHE_DIR"

if [ -z "$1" ]; then
    echo "Usage: $0 <doc-path>"
    echo ""
    echo "Examples:"
    echo "  $0 channels/telegram"
    echo "  $0 automation/cron-jobs"
    echo "  $0 concepts/memory"
    echo ""
    echo "Or run without args to list recent docs"
    exit 1
fi

DOC_PATH="$1"
CACHE_FILE="$CACHE_DIR/$(echo $DOC_PATH | tr '/' '_').md"
CACHE_TTL=3600  # 1 hour

# Check cache
if [ -f "$CACHE_FILE" ]; then
    AGE=$(($(date +%s) - $(stat -c%Y "$CACHE_FILE" 2>/dev/null || stat -f%m "$CACHE_FILE" 2>/dev/null || echo 0)))
    if [ $AGE -lt $CACHE_TTL ]; then
        echo "📄 Using cached: $DOC_PATH (${AGE}s old)"
        cat "$CACHE_FILE"
        exit 0
    fi
fi

echo "📡 Fetching: $DOC_PATH"
echo ""

# Try different extensions
for ext in "" ".md" "/index.md"; do
    URL="${DOCS_BASE}/${DOC_PATH}${ext}"
    HTTP_CODE=$(curl -s -o "$CACHE_FILE" -w "%{http_code}" "$URL")
    
    if [ "$HTTP_CODE" = "200" ] && [ -s "$CACHE_FILE" ]; then
        echo "✅ Fetched: $URL"
        echo ""
        cat "$CACHE_FILE"
        exit 0
    fi
done

echo "❌ Could not fetch doc: $DOC_PATH"
echo ""
echo "Try:"
echo "  - Checking the path directly: https://docs.openclaw.ai/${DOC_PATH}"
echo "  - Browse sitemap: ./scripts/sitemap.sh"
echo "  - Search: ./scripts/search.sh <keyword>"

exit 1
