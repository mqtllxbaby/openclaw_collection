#!/bin/bash
# Track OpenClaw documentation changes

set -e

TRACK_DIR="/tmp/openclawdocs-tracking"
DOCS_URL="https://docs.openclaw.ai/llms.txt"
mkdir -p "$TRACK_DIR"

case "${1:-help}" in
    snapshot)
        echo "📸 Creating documentation snapshot..."
        TIMESTAMP=$(date +%Y%m%d_%H%M%S)
        SNAPSHOT_FILE="$TRACK_DIR/snapshot_${TIMESTAMP}.txt"
        curl -s "$DOCS_URL" > "$SNAPSHOT_FILE"
        echo "✅ Snapshot saved: $SNAPSHOT_FILE"
        echo "   Docs tracked: $(wc -l < "$SNAPSHOT_FILE")"
        ;;
    
    list)
        echo "📋 Available snapshots:"
        ls -lt "$TRACK_DIR"/snapshot_*.txt 2>/dev/null | head -10 || echo "   No snapshots found"
        ;;
    
    since)
        if [ -z "$2" ]; then
            echo "Usage: $0 since <date>"
            echo "Example: $0 since 2026-01-01"
            exit 1
        fi
        echo "🔍 Changes since: $2"
        echo ""
        # Find snapshot closest to date
        SNAPSHOT=$(ls "$TRACK_DIR"/snapshot_*.txt 2>/dev/null | head -1)
        if [ -z "$SNAPSHOT" ]; then
            echo "❌ No snapshots found. Run 'snapshot' first."
            exit 1
        fi
        echo "Comparing against: $SNAPSHOT"
        curl -s "$DOCS_URL" | diff -u "$SNAPSHOT" - | grep "^+" | grep -v "^+++" | head -20
        ;;
    
    compare)
        echo "🔄 Comparing current docs with latest snapshot..."
        SNAPSHOT=$(ls "$TRACK_DIR"/snapshot_*.txt 2>/dev/null | head -1)
        if [ -z "$SNAPSHOT" ]; then
            echo "❌ No snapshots found. Run 'snapshot' first."
            exit 1
        fi
        curl -s "$DOCS_URL" | diff "$SNAPSHOT" - | head -30
        ;;
    
    *)
        echo "📚 OpenClaw Documentation Change Tracker"
        echo ""
        echo "Usage: $0 <command> [args]"
        echo ""
        echo "Commands:"
        echo "  snapshot          Save current documentation state"
        echo "  list              List available snapshots"
        echo "  since <date>      Show changes since date"
        echo "  compare           Compare current vs last snapshot"
        echo ""
        echo "Examples:"
        echo "  $0 snapshot"
        echo "  $0 since 2026-01-01"
        echo "  $0 compare"
        ;;
esac
