param(
  [string]$Python = "py",
  [switch]$NoZip
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$scriptPath = Join-Path $repoRoot "pepcalc"

$pyArgs = @()
if ($Python -eq "py") {
  $pyArgs = @("-3")
}

& $Python @pyArgs -m pip install --upgrade pip
& $Python @pyArgs -m pip install --upgrade pyinstaller

& $Python @pyArgs -m PyInstaller --clean --onefile --name pepcalc $scriptPath

$distExe = Join-Path $repoRoot "dist\\pepcalc.exe"
if (-not (Test-Path $distExe)) {
  throw "Build failed: $distExe not found."
}

if ($NoZip) {
  Write-Host "Built $distExe"
  exit 0
}

$zipPath = Join-Path $repoRoot "pepcalc-windows.zip"
if (Test-Path $zipPath) {
  Remove-Item $zipPath
}

Compress-Archive -Path $distExe -DestinationPath $zipPath
Write-Host "Wrote $zipPath"
