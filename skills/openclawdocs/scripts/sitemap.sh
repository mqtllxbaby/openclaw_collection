#!/bin/bash
# Sitemap generator - shows all OpenClaw docs by category
# Fetches live from docs.openclaw.ai/llms.txt

set -e

DOCS_URL="https://docs.openclaw.ai/llms.txt"
CACHE_FILE="/tmp/openclawdocs-sitemap.txt"
CACHE_TTL=3600  # 1 hour

# Check cache
if [ -f "$CACHE_FILE" ]; then
    AGE=$(($(date +%s) - $(stat -f%m "$CACHE_FILE" 2>/dev/null || stat -c%Y "$CACHE_FILE" 2>/dev/null || echo 0)))
    if [ $AGE -lt $CACHE_TTL ]; then
        echo "📁 Using cached sitemap (${AGE}s old)"
        cat "$CACHE_FILE"
        exit 0
    fi
fi

echo "📡 Fetching OpenClaw documentation sitemap..."

# Fetch llms.txt and extract categories
curl -s "$DOCS_URL" | grep "^- \[" | sed 's/.*(\(.*\))/\1/' | sort > "$CACHE_FILE"

# Group by category
echo ""
echo "📚 OpenClaw Documentation Categories:"
echo "======================================"

for category in start gateway channels concepts tools automation cli platforms nodes web install reference plugins skills; do
    COUNT=$(grep -c "/${category}/" "$CACHE_FILE" 2>/dev/null || echo 0)
    if [ $COUNT -gt 0 ]; then
        echo ""
        echo "📁 /${category}/ (${COUNT} docs)"
        grep "/${category}/" "$CACHE_FILE" | sed 's|^|   - |' | head -10
        if [ $COUNT -gt 10 ]; then
            echo "   ... and $((COUNT - 10)) more"
        fi
    fi
done

echo ""
echo "💡 Full list: https://docs.openclaw.ai/llms.txt"
echo "💡 Cache: $CACHE_FILE (TTL: ${CACHE_TTL}s)"
