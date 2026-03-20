#!/bin/bash
# Check user's OpenClaw version vs latest
# Supports: --json for machine-readable output (auto-detection)

set -e

OPENCLAW_CONFIG="$HOME/.openclaw/openclaw.json"
OUTPUT_FORMAT="human"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --json)
            OUTPUT_FORMAT="json"
            shift
            ;;
        --auto)
            OUTPUT_FORMAT="version-only"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Get local version
get_local_version() {
    if command -v openclaw &> /dev/null; then
        local first_line
        first_line=$(openclaw --version 2>/dev/null | head -1)
        printf '%s\n' "$first_line" | sed -nE 's/^OpenClaw[[:space:]]+([0-9][^[:space:]]*).*$/\1/p' | head -1
    elif [ -f "$OPENCLAW_CONFIG" ]; then
        grep -o '"lastTouchedVersion": *"[^"]*"' "$OPENCLAW_CONFIG" | cut -d'"' -f4
    else
        echo "unknown"
    fi
}

LOCAL_VERSION=$(get_local_version)

# Output based on format
case $OUTPUT_FORMAT in
    json)
        LATEST_VERSION=$(npm view openclaw version 2>/dev/null || echo "unknown")
        cat <<EOF
{
  "local_version": "$LOCAL_VERSION",
  "latest_version": "$LATEST_VERSION",
  "is_latest": $([ "$LOCAL_VERSION" = "$LATEST_VERSION" ] && echo "true" || echo "false"),
  "version_family": "$([ -n "$LOCAL_VERSION" ] && echo "${LOCAL_VERSION:0:4}.x" || echo "unknown")"
}
EOF
        ;;
    version-only)
        echo "$LOCAL_VERSION"
        ;;
    human)
        echo "🔍 Checking OpenClaw version..."
        echo ""
        
        if [ "$LOCAL_VERSION" != "unknown" ]; then
            echo "✅ Local version: $LOCAL_VERSION"
        else
            echo "❌ Could not determine local version"
        fi
        
        # Get latest version from npm
        echo ""
        echo "📦 Checking npm for latest..."
        LATEST_VERSION=$(npm view openclaw version 2>/dev/null || echo "unknown")
        
        if [ "$LATEST_VERSION" != "unknown" ]; then
            echo "✅ Latest version: $LATEST_VERSION"
        else
            echo "⚠️  Could not fetch latest version from npm"
        fi
        
        # Compare versions
        echo ""
        if [ "$LOCAL_VERSION" != "unknown" ] && [ "$LATEST_VERSION" != "unknown" ]; then
            if [ "$LOCAL_VERSION" = "$LATEST_VERSION" ]; then
                echo "✅ You're on the latest version!"
            else
                echo "⚠️  Update available!"
                echo "   Current: $LOCAL_VERSION"
                echo "   Latest:  $LATEST_VERSION"
                echo ""
                echo "💡 Update with a supported workflow"
                echo "   Preferred: openclaw update"
                echo "   Global install fallback: npm install -g openclaw@latest && openclaw gateway restart"
            fi
        fi
        
        # Version-specific notes
        echo ""
        echo "📋 Version Notes:"
        if [[ "$LOCAL_VERSION" == 2026.3* ]]; then
            echo "   ✅ You're on 2026.3.x"
            echo "   - Most current docs are likely applicable"
            echo "   - Verify exact behavior when plugin, cron, or channel details matter"
        elif [[ "$LOCAL_VERSION" == 2026* ]]; then
            echo "   ✅ You're on 2026.x"
            echo "   - Most current docs may apply, but minor-release differences can matter"
        elif [[ "$LOCAL_VERSION" == 2025* ]]; then
            echo "   ⚠️  You're on 2025.x (legacy)"
            echo "   - Some docs may differ (for example older config guidance)"
            echo "   - Prefer version-specific verification before suggesting changes"
        else
            echo "   ❓ Unknown version: $LOCAL_VERSION"
            echo "   - Verify commands and config fields before relying on them"
        fi
        
        echo ""
        echo "📚 Docs: https://docs.openclaw.ai"
        echo "🔧 Changelog: https://github.com/openclaw/openclaw/blob/main/CHANGELOG.md"
        ;;
esac
