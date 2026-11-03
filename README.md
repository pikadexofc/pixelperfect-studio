<div align="center">

# PixelPerfect Studio

### Turn images into editable, layered HTML designs.

**Supports Antigravity · Claude Code / MCP · ChatGPT · CLI**

[![Fund the production](https://img.shields.io/badge/FUND%20THE%20PRODUCTION-Support%20PixelPerfect%20Studio-8B5CF6?style=for-the-badge)](https://mdzobaedislamshanto.supportkori.shop/)
[![Release](https://img.shields.io/github/v/release/pikadexofc/pixelperfect-studio?style=for-the-badge&color=22C55E)](https://github.com/pikadexofc/pixelperfect-studio/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

[Quick Install](#-1-click-quick-install) · [Platform Guides](INSTALLATION.md) · [Releases](https://github.com/pikadexofc/pixelperfect-studio/releases) · [Report Issue](https://github.com/pikadexofc/pixelperfect-studio/issues)

</div>

---

## ⚡ 1-Click Quick Install (Zero Friction)

Install and configure PixelPerfect Studio automatically across your detected tools (Antigravity, Claude Desktop, CLI):

#### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/pikadexofc/pixelperfect-studio/main/install.ps1 | iex
```

#### macOS / Linux (Terminal)
```bash
curl -fsSL https://raw.githubusercontent.com/pikadexofc/pixelperfect-studio/main/install.sh | bash
```

---

## What is PixelPerfect Studio?

PixelPerfect Studio reconstructs visual references (posters, app icons, badges, UI mockups, banners) into high-fidelity, fixed-size, editable HTML designs.

- **Fixed-Size Artboard Invariant:** Never drifts into a responsive website. Canvas size matches the original reference exactly.
- **Layer Addressability:** Every meaningful shape, icon, and text node carries a semantic `data-layer-id` attribute.
- **Embedded Inspector HUD:** Every deliverable includes a zero-dependency floating HUD with an opacity slider and layer toggles for instant visual comparison.
- **100% Offline Standalone:** Zero remote CDNs or broken external links.

---

## 🚀 Choose Your Platform

### 1. Antigravity IDE & Antigravity 2.0
Already included in the installer, or manually download `pixelperfect-studio-antigravity-1.1.0.zip` from [Releases](https://github.com/pikadexofc/pixelperfect-studio/releases) and extract to:
- Windows: `%USERPROFILE%\.gemini\config\plugins\pixelperfect-studio`
- macOS/Linux: `~/.gemini/config/plugins/pixelperfect-studio`

### 2. Claude Code & Claude Desktop (MCP)
Add PixelPerfect Studio to your `claude_desktop_config.json`:
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

### 3. OpenAI ChatGPT / Custom GPT
Download `pixelperfect-studio-chatgpt-1.1.0.zip` from [Releases](https://github.com/pikadexofc/pixelperfect-studio/releases) or paste the master prompt below in any conversation.

### 4. Standalone Terminal CLI
```bash
# Run computer vision forensics
pixelperfect analyze reference.png

# Run automated Playwright visual QA
pixelperfect verify reference.png design.html

# Inject interactive HUD into your HTML
pixelperfect inject-hud design.html -r reference.png
```

---

## 📋 Copy-and-Paste Master Prompt

Upload your reference image and paste this single prompt:

```text
Turn this image into editable layered HTML at its original size.

Separate every meaningful visual component into its own independently addressable layer tagged with data-layer-id. Recover exact typography or extract visible letterforms. Preserve the original composition and dimensions.

Inject the interactive Inspector HUD and deliver only the final verified standalone HTML file.
```

---

## What You Receive

The customer-facing deliverable is **one final standalone HTML file**.

- Double-click to open in any web browser.
- Use the floating **Inspector HUD** in the corner to slide between your new HTML design and the original image reference.
- Toggle individual layers on and off to verify structural alignment.

---

## Distribution & Support

- Issues and Bug Reports: [GitHub Issues](https://github.com/pikadexofc/pixelperfect-studio/issues)
- Downloads & Changelogs: [GitHub Releases](https://github.com/pikadexofc/pixelperfect-studio/releases)
- Support Ongoing Development: [**Fund the Production**](https://mdzobaedislamshanto.supportkori.shop/)

---

<div align="center">

**PixelPerfect Studio**  
A PixelPie Media project by [Md. Zobaed Islam Shanto](https://github.com/pikadexofc)

[Fund the production](https://mdzobaedislamshanto.supportkori.shop/)

</div>
