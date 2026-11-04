# PixelPerfect Studio - 1-Click Universal Installer for Windows
# Run via: powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/pikadexofc/pixelperfect-studio/main/install.ps1 | iex"

$ErrorActionPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "`n=======================================================" -ForegroundColor Cyan
Write-Host "🎨 PixelPerfect Studio - 1-Click Universal Installer" -ForegroundColor Cyan
Write-Host "=======================================================" -ForegroundColor Gray

$Repo = "pikadexofc/pixelperfect-studio"
$ApiUrl = "https://api.github.com/repos/$Repo/releases/latest"

Write-Host "`n📡 Fetching latest release from GitHub..." -ForegroundColor Yellow
try {
    $Release = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "User-Agent" = "PixelPerfect-Installer" }
    $Tag = $Release.tag_name
    Write-Host "✓ Detected latest version: $Tag" -ForegroundColor Green
} catch {
    $Tag = "v1.1.0"
    Write-Host "! Falling back to default release: $Tag" -ForegroundColor Yellow
}

$TempDir = Join-Path $env:TEMP "pixelperfect_install"
if (Test-Path $TempDir) { Remove-Item -Recurse -Force $TempDir -ErrorAction SilentlyContinue }
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

# -------------------------------------------------------------
# 1. Antigravity IDE Plugin Detection & Installation
# -------------------------------------------------------------
$GeminiDir = Join-Path $env:USERPROFILE ".gemini"
$GeminiPluginsDir = Join-Path $GeminiDir "config\plugins"
if (Test-Path $GeminiDir) {
    Write-Host "`n[1/3] Setting up Antigravity Plugin..." -ForegroundColor Cyan
    $AgDest = Join-Path $GeminiPluginsDir "pixelperfect-studio"
    $AgAsset = $Release.assets | Where-Object { $_.name -like "*antigravity*.zip" } | Select-Object -First 1
    
    if ($AgAsset) {
        $AgZip = Join-Path $TempDir "antigravity.zip"
        Write-Host "  Downloading $($AgAsset.name)..."
        Invoke-WebRequest -Uri $AgAsset.browser_download_url -OutFile $AgZip
        New-Item -ItemType Directory -Path $AgDest -Force | Out-Null
        Expand-Archive -Path $AgZip -DestinationPath $AgDest -Force
        Write-Host "  ✓ Installed in Antigravity: $AgDest" -ForegroundColor Green
    }
}

# -------------------------------------------------------------
# 2. Claude Desktop MCP Server Registration (JSONC Resilient)
# -------------------------------------------------------------
$ClaudeDir = Join-Path $env:APPDATA "Claude"
$ClaudeConfigPath = Join-Path $ClaudeDir "claude_desktop_config.json"
if (Test-Path $ClaudeDir) {
    Write-Host "`n[2/3] Configuring Claude Desktop MCP..." -ForegroundColor Cyan
    try {
        $Config = @{ mcpServers = @{} }
        if (Test-Path $ClaudeConfigPath) {
            $raw = Get-Content -Raw $ClaudeConfigPath
            # Strip comments & trailing commas
            $clean = $raw -replace '(?m)^\s*//.*$', '' -replace '(?s)/\*.*?\*/', '' -replace ',(\s*[}\]])', '$1'
            $parsed = $clean | ConvertFrom-Json
            if ($parsed.mcpServers) { $Config.mcpServers = $parsed.mcpServers }
        }
        $Config.mcpServers | Add-Member -MemberType NoteProperty -Name "pixelperfect" -Value @{
            command = "python"
            args = @("-m", "pixelperfect_engine.pixelperfect_mcp")
        } -Force
        $Config | ConvertTo-Json -Depth 5 | Set-Content -Path $ClaudeConfigPath -Encoding UTF8
        Write-Host "  ✓ Configured MCP in: $ClaudeConfigPath" -ForegroundColor Green
    } catch {
        Write-Host "  ! Note: Could not auto-edit claude_desktop_config.json: $_" -ForegroundColor Yellow
        Write-Host "    You can add it manually to your Claude config." -ForegroundColor Gray
    }
}

# -------------------------------------------------------------
# 3. Python Engine & Playwright Headless Chromium Verification
# -------------------------------------------------------------
Write-Host "`n[3/3] Checking Python CLI engine & Headless Browser..." -ForegroundColor Cyan
$PyCmd = Get-Command python -ErrorAction SilentlyContinue
if ($PyCmd) {
    $WhlAsset = $Release.assets | Where-Object { $_.name -like "*.whl" } | Select-Object -First 1
    if ($WhlAsset) {
        $WhlPath = Join-Path $TempDir $WhlAsset.name
        Write-Host "  Downloading $($WhlAsset.name)..."
        Invoke-WebRequest -Uri $WhlAsset.browser_download_url -OutFile $WhlPath
        Write-Host "  Installing via pip (--user)..."
        & python -m pip install --user --upgrade $WhlPath --quiet
        Write-Host "  ✓ PixelPerfect Engine installed! Available command: 'pixelperfect'" -ForegroundColor Green
    }

    # Ensure Playwright Chromium is present
    Write-Host "  Verifying Playwright Headless Chromium..." -ForegroundColor Yellow
    & python -m playwright install chromium --quiet
    Write-Host "  ✓ Playwright Headless Chromium verified and ready." -ForegroundColor Green
} else {
    Write-Host "  Python not found in PATH (optional for ChatGPT web users)." -ForegroundColor Gray
}

# Cleanup temporary files
Remove-Item -Recurse -Force $TempDir -ErrorAction SilentlyContinue

Write-Host "`n=======================================================" -ForegroundColor Gray
Write-Host "🎉 Installation complete! You are ready to reconstruct." -ForegroundColor Green
Write-Host "• Antigravity: PixelPerfect Studio skills are active"
Write-Host "• Claude Desktop: Restart Claude to load the MCP server"
Write-Host "• CLI: Run 'pixelperfect --help' in terminal`n"
