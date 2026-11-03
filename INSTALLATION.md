# PixelPerfect Studio - Installation Guide

Quickly install and configure PixelPerfect Studio for your preferred environment.

---

## ⚡ Method A: 1-Click Quick Install (Recommended)

The automated installer detects your installed software and configures PixelPerfect Studio in seconds.

### Windows (PowerShell)
Open PowerShell and run:
```powershell
irm https://raw.githubusercontent.com/pikadexofc/pixelperfect-studio/main/install.ps1 | iex
```

### macOS / Linux (Terminal)
Open Terminal and run:
```bash
curl -fsSL https://raw.githubusercontent.com/pikadexofc/pixelperfect-studio/main/install.sh | bash
```

The script will automatically:
1. Detect and install the plugin for **Antigravity IDE** if `~/.gemini` exists.
2. Register the MCP server in **Claude Desktop** if installed.
3. Install the **Python CLI engine** if Python is available.

---

## 📦 Method B: Manual Platform Setup

If you prefer to configure manually or are targeting a specific platform:

### 1. Antigravity IDE & Antigravity 2.0
1. Download **`pixelperfect-studio-antigravity-1.1.0.zip`** from [GitHub Releases](https://github.com/pikadexofc/pixelperfect-studio/releases).
2. Unzip into your plugins folder:
   - **Windows:** `%USERPROFILE%\.gemini\config\plugins\pixelperfect-studio\`
   - **macOS / Linux:** `~/.gemini/config/plugins/pixelperfect-studio/`
3. Restart Antigravity or reload plugins.

### 2. Claude Desktop / Claude Code / Cursor / Windsurf (MCP)
1. Download **`pixelperfect-studio-mcp-1.1.0.zip`** from [GitHub Releases](https://github.com/pikadexofc/pixelperfect-studio/releases).
2. Unpack into your tools directory.
3. Add the server entry to your client configuration:
   - **Claude Desktop (`claude_desktop_config.json`):**
     ```json
     {
       "mcpServers": {
         "pixelperfect": {
           "command": "python",
           "args": ["-m", "pixelperfect_engine.pixelperfect_mcp"]
         }
       }
     }
     ```
4. Restart Claude Desktop.

### 3. OpenAI ChatGPT / Custom GPT
1. Open ChatGPT and create or edit a Custom GPT.
2. Under **Instructions**, copy and paste the [Master Prompt](README.md#-copy-and-paste-master-prompt).
3. If using Custom Actions, upload `plugin.json` from **`pixelperfect-studio-chatgpt-1.1.0.zip`**.

### 4. Standalone Python CLI
1. Download **`pixelperfect_engine-1.1.0-py3-none-any.whl`** from [Releases](https://github.com/pikadexofc/pixelperfect-studio/releases).
2. Install via pip:
   ```bash
   pip install pixelperfect_engine-1.1.0-py3-none-any.whl
   ```
3. Test installation:
   ```bash
   pixelperfect --help
   ```

---

## Need Help?
- [Report an issue](https://github.com/pikadexofc/pixelperfect-studio/issues)
- [Support production](https://mdzobaedislamshanto.supportkori.shop/)
