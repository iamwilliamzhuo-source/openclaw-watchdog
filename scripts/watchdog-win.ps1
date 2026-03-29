# -------------------------------------------------------------------------------------
# OpenClaw Smart Watchdog (Windows Experimental)
# -------------------------------------------------------------------------------------
param (
    [string]$ProxyUrl = "http://127.0.0.1:7897",
    [string]$GatewayPort = "18789"
)

$ErrorActionPreference = "SilentlyContinue"
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$LogDir = Join-Path $env:USERPROFILE ".openclaw\logs"
$LogFile = Join-Path $LogDir "watchdog.log"
$HealthUrl = "http://127.0.0.1:$GatewayPort/health"

If (!(Test-Path $LogDir)) { New-Item -ItemType Directory -Force -Path $LogDir | Out-Null }

function Log($Message) {
    Add-Content -Path $LogFile -Value "[$Timestamp] $Message"
}

# Advanced Logic can be added here. Currently does process and HTTP probe check.
$GatewayRunning = Get-Process -Name "node" -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like "*openclaw gateway*" }

if (!$GatewayRunning) {
    Log "Process 'node' not found. Restarting OpenClaw Gateway..."
    Start-Process -NoNewWindow -FilePath "openclaw" -ArgumentList "gateway"
    exit
}

# Application Layer Health Check
try {
    $Response = Invoke-WebRequest -Uri $HealthUrl -UseBasicParsing -TimeoutSec 5
    if ($Response.StatusCode -ne 200) { throw "HTTP $($Response.StatusCode)" }
} catch {
    Log "Gateway health check failed ($($_.Exception.Message)). Hard restarting..."
    # Kill the existing process and start a new one
    $GatewayRunning | Stop-Process -Force
    Start-Process -NoNewWindow -FilePath "openclaw" -ArgumentList "gateway"
}
