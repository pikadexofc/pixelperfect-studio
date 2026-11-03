#!/usr/bin/env bash
# PixelPerfect Studio - 1-Click Universal Installer for macOS / Linux
# Run via: curl -fsSL https://raw.githubusercontent.com/pikadexofc/pixelperfect-studio/main/install.sh | bash

set -e

echo -e "\033[1;36m\n🎨 PixelPerfect Studio - Universal Installer\033[0m"
echo "====================================================="

REPO="pikadexofc/pixelperfect-studio"
API_URL="https://api.github.com/repos/$REPO/releases/latest"

echo -e "\033[1;33m📡 Fetching latest release info from GitHub...\033[0m"
TAG=$(curl -s "$API_URL" | grep -o '"tag_name": *"[^"]*"' | head -n 1 | cut -d '"' -f 4 || echo "v1.1.0")
echo -e "\033[1;32m✓ Latest version: $TAG\033[0m"

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# 1. Antigravity Plugin Detection
GEMINI_DIR="$HOME/.gemini"
if [ -d "$GEMINI_DIR" ]; then
    echo -e "\033[1;36m\n[1/3] Setting up Antigravity Plugin...\033[0m"
    AG_DIR="$GEMINI_DIR/config/plugins/pixelperfect-studio"
    mkdir -p "$AG_DIR"
    AG_URL="https://github.com/$REPO/releases/download/$TAG/pixelperfect-studio-antigravity-1.1.0.zip"
    curl -sL "$AG_URL" -o "$TEMP_DIR/ag.zip"
    unzip -q -o "$TEMP_DIR/ag.zip" -d "$AG_DIR"
    echo -e "\033[1;32m  ✓ Installed in Antigravity: $AG_DIR\033[0m"
fi

# 2. Claude Desktop Detection (macOS)
if [ "$(uname)" = "Darwin" ]; then
    CLAUDE_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
    if [ -d "$(dirname "$CLAUDE_CONFIG")" ]; then
        echo -e "\033[1;36m\n[2/3] Configuring Claude Desktop MCP...\033[0m"
        python3 -c "
import json, os
path = os.path.expanduser('$CLAUDE_CONFIG')
data = {'mcpServers': {}}
if os.path.exists(path):
    try:
        with open(path) as f: data = json.load(f)
    except: pass
if 'mcpServers' not in data: data['mcpServers'] = {}
data['mcpServers']['pixelperfect'] = {
    'command': 'python3',
    'args': ['-m', 'pixelperfect_engine.pixelperfect_mcp']
}
with open(path, 'w') as f:
    json.dump(data, f, indent=2)
print('  ✓ Registered pixelperfect MCP in Claude Desktop')
" || true
    fi
fi

# 3. Python CLI
if command -v python3 &>/dev/null; then
    echo -e "\033[1;36m\n[3/3] Checking Python CLI engine...\033[0m"
    WHL_URL="https://github.com/$REPO/releases/download/$TAG/pixelperfect_engine-1.1.0-py3-none-any.whl"
    curl -sL "$WHL_URL" -o "$TEMP_DIR/engine.whl"
    python3 -m pip install "$TEMP_DIR/engine.whl" --quiet || pip3 install "$TEMP_DIR/engine.whl" --quiet || true
    echo -e "\033[1;32m  ✓ PixelPerfect Engine installed! Available command: 'pixelperfect'\033[0m"
fi

echo "====================================================="
echo -e "\033[1;32m🎉 Installation complete! You are ready to reconstruct.\033[0m\n"
