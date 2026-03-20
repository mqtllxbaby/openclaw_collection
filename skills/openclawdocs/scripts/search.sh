#!/bin/bash
# Search OpenClaw documentation by keyword

set -e

DOCS_URL="https://docs.openclaw.ai/llms.txt"

if [ -z "$1" ]; then
    echo "Usage: $0 <keyword>"
    echo ""
    echo "Examples:"
    echo "  $0 telegram"
    echo "  $0 cron"
    echo "  $0 webhook"
    exit 1
fi

KEYWORD="$1"

echo "🔍 Searching OpenClaw docs for: '$KEYWORD'"
echo ""

# Fetch sitemap and search
DOCS=$(curl -s "$DOCS_URL" | grep "^- \[" | sed 's/.*(\(.*\))/\1/')

echo "📄 Matching documents:"
echo "======================"

MATCHES=0
for doc in $DOCS; do
    if echo "$doc" | grep -qi "$KEYWORD"; then
        echo "   - https://docs.openclaw.ai/$doc"
        MATCHES=$((MATCHES + 1))
    fi
done

if [ $MATCHES -eq 0 ]; then
    echo "   No exact path matches found."
    echo ""
    echo "💡 Try fetching and searching content:"
    echo "   curl -s https://docs.openclaw.ai/llms.txt | grep -i '$KEYWORD'"
else
    echo ""
    echo "✅ Found $MATCHES matching document(s)"
    echo ""
    echo "💡 Fetch a doc with:"
    echo "   ./scripts/fetch-doc.sh <path>"
fi
