# PixelPerfect Studio - 1-Click Universal Installer for Windows
# Run via: irm https://raw.githubusercontent.com/pikadexofc/pixelperfect-studio/main/install.ps1 | iex

$ErrorActionPreference = "Stop"

Write-Host "`n🎨 PixelPerfect Studio - 1-Click Universal Installer" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Gray

$Repo = "pikadexofc/pixelperfect-studio"
$ApiUrl = "https://api.github.com/repos/$Repo/releases/latest"

Write-Host "📡 Fetching latest release from GitHub..." -ForegroundColor Yellow
try {
    $Release = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "User-Agent" = "PixelPerfect-Installer" }
    $Tag = $Release.tag_name
    Write-Host "✓ Detected latest version: $Tag" -ForegroundColor Green
} catch {
    $Tag = "v1.1.0"
    Write-Host "! Falling back to default release: $Tag" -ForegroundColor Yellow
}

$TempDir = Join-Path $env:TEMP "pixelperfect_install"
if (Test-Path $TempDir) { Remove-Item -Recurse -Force $TempDir }
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

# 1. Antigravity IDE Plugin Detection
$GeminiPluginsDir = Join-Path $env:USERPROFILE ".gemini\config\plugins"
if (Test-Path (Join-Path $env:USERPROFILE ".gemini")) {
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

# 2. Claude Desktop MCP Server Detection
$ClaudeConfigPath = Join-Path $env:APPDATA "Claude\claude_desktop_config.json"
if (Test-Path (Join-Path $env:APPDATA "Claude")) {
    Write-Host "`n[2/3] Configuring Claude Desktop MCP..." -ForegroundColor Cyan
    try {
        $Config = @{ mcpServers = @{} }
        if (Test-Path $ClaudeConfigPath) {
            $Content = Get-Content -Raw $ClaudeConfigPath | ConvertFrom-Json
            if ($Content.mcpServers) { $Config.mcpServers = $Content.mcpServers }
        }
        $Config.mcpServers | Add-Member -MemberType NoteProperty -Name "pixelperfect" -Value @{
            command = "python"
            args = @("-m", "pixelperfect_engine.pixelperfect_mcp")
        } -Force
        $Config | ConvertTo-Json -Depth 5 | Set-Content -Path $ClaudeConfigPath -Encoding UTF8
        Write-Host "  ✓ Configured MCP in: $ClaudeConfigPath" -ForegroundColor Green
    } catch {
        Write-Host "  ! Could not auto-edit claude_desktop_config.json: $_" -ForegroundColor Yellow
    }
}

# 3. Python Wheel Installation
Write-Host "`n[3/3] Checking Python CLI engine..." -ForegroundColor Cyan
$PyCmd = Get-Command python -ErrorAction SilentlyContinue
if ($PyCmd) {
    $WhlAsset = $Release.assets | Where-Object { $_.name -like "*.whl" } | Select-Object -First 1
    if ($WhlAsset) {
        $WhlPath = Join-Path $TempDir $WhlAsset.name
        Write-Host "  Downloading $($WhlAsset.name)..."
        Invoke-WebRequest -Uri $WhlAsset.browser_download_url -OutFile $WhlPath
        Write-Host "  Installing via pip..."
        & python -m pip install $WhlPath --quiet
        Write-Host "  ✓ PixelPerfect Engine installed! Available commands: 'pixelperfect'" -ForegroundColor Green
    }
} else {
    Write-Host "  Python not found in PATH (optional for ChatGPT/IDE users)." -ForegroundColor Gray
}

# Cleanup
Remove-Item -Recurse -Force $TempDir -ErrorAction SilentlyContinue

Write-Host "`n=====================================================" -ForegroundColor Gray
Write-Host "🎉 Installation complete! You are ready to reconstruct." -ForegroundColor Green
Write-Host "• Antigravity: PixelPerfect Studio skills are active"
Write-Host "• Claude Desktop: Restart Claude to load the MCP server"
Write-Host "• CLI: Run 'pixelperfect --help' in terminal`n"
