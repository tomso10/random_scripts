# Ensure script runs with admin rights
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    exit
}

# -------------------------
# Install Chocolatey if not installed
# -------------------------
if (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey not found. Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey already installed." -ForegroundColor Green
}

# -------------------------
# Install Applications
# -------------------------
$packages = @(
    "steam",
    "firefox",
    "discord",
    "medal",
    "wireshark",
    "spotify",
    "vscode",
    "vmwareworkstation",
    "vlc",
    "minecraft",
    "bitwarden"
)

Write-Host "`nInstalling applications via Chocolatey..." -ForegroundColor Cyan

foreach ($pkg in $packages) {
    Write-Host "Installing $pkg..." -ForegroundColor Yellow
    choco install $pkg -y --ignore-checksums
}

Write-Host "`nAll applications installed!" -ForegroundColor Green
