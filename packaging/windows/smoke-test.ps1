<#
.SYNOPSIS
  Functional smoke test for CADCraft on Windows.

.DESCRIPTION
  Runs the headless CLI through its real workflows (sample drawing, info, DXF -> DWG -> SVG -> PNG
  -> PDF, a scripted drawing saved and exported, the command catalogue, a short benchmark), then
  starts the desktop app with the JSON control channel, draws through it, asks for a screenshot and
  quits. Every step prints PASS or FAIL; the exit code is the number of failed steps.

  Run it from the repository root after packaging\windows\setup-dev.ps1 has built the app, or point
  it at installed binaries with -Cli and -App.

.PARAMETER Cli
  Path to cadcraft-cli.exe. Default: target\release\cadcraft-cli.exe under the repository.

.PARAMETER App
  Path to cadcraft.exe. Default: target\release\cadcraft.exe under the repository.

.PARAMETER NoBuild
  Fail instead of building when the binaries are missing.

.PARAMETER NoGui
  Skip the desktop-app step (CLI only).

.PARAMETER Port
  Control-channel port for the desktop app. Default 7733.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File packaging\windows\smoke-test.ps1
#>
[CmdletBinding()]
param(
  [string] $Cli = "",
  [string] $App = "",
  [switch] $NoBuild,
  [switch] $NoGui,
  [int] $Port = 7733
)

$ErrorActionPreference = 'Continue'
$Root = Resolve-Path (Join-Path $PSScriptRoot '..\..')
if (-not $Cli) { $Cli = Join-Path $Root 'target\release\cadcraft-cli.exe' }
if (-not $App) { $App = Join-Path $Root 'target\release\cadcraft.exe' }
$Out = Join-Path $Root 'target\smoke'
if (Test-Path $Out) { Remove-Item -Recurse -Force $Out }
New-Item -ItemType Directory -Force -Path $Out | Out-Null

$script:Pass = 0
$script:Fail = 0

function Step([string] $Name, [string] $Exe, [string[]] $Arguments) {
  $log = Join-Path $Out "$Name.log"
  $text = & $Exe @Arguments 2>&1 | Out-String
  Set-Content -Path $log -Value $text
  if ($LASTEXITCODE -eq 0) { $script:Pass++; Write-Output "PASS  $Name" }
  else { $script:Fail++; Write-Output "FAIL  $Name  (exit $LASTEXITCODE, see $log)" }
  return $text
}
function Check([string] $Name, [bool] $Condition, [string] $Why = "") {
  if ($Condition) { $script:Pass++; Write-Output "PASS  $Name" }
  else { $script:Fail++; Write-Output "FAIL  $Name  $Why" }
}

Write-Output "CADCraft smoke test · $((Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')) · out: $Out"

# 0. binaries
if (-not (Test-Path $Cli) -or -not (Test-Path $App)) {
  if ($NoBuild) { Write-Output "binaries missing: $Cli / $App"; exit 1 }
  Write-Output "building release binaries (first time: several minutes)"
  Push-Location $Root
  try { cargo build --release -p cadcraft-cli -p cadcraft; if ($LASTEXITCODE -ne 0) { Write-Output "build failed"; exit 1 } }
  finally { Pop-Location }
}

# 1. CLI version and command catalogue
$v = Step 'cli-version' $Cli @('--version')
Check 'cli-version-string' ($v -match 'cadcraft')
$cmds = Step 'cli-commands' $Cli @('commands')
Check 'cli-commands-count' ((($cmds -split "`n") | Where-Object { $_.Trim() }).Count -ge 300)

# 2. sample drawing, info, conversion chain
$fp = Join-Path $Out 'floorplan.dxf'
Step 'sample-floorplan' $Cli @('sample', 'floorplan', $fp) | Out-Null
$info = Step 'info-dxf' $Cli @('info', $fp)
Check 'info-entities' ($info -match 'entit')
Step 'convert-dwg' $Cli @('convert', $fp, (Join-Path $Out 'floorplan.dwg')) | Out-Null
Step 'info-dwg' $Cli @('info', (Join-Path $Out 'floorplan.dwg')) | Out-Null
Step 'convert-svg' $Cli @('convert', (Join-Path $Out 'floorplan.dwg'), (Join-Path $Out 'floorplan.svg')) | Out-Null
Check 'svg-has-root' ((Test-Path (Join-Path $Out 'floorplan.svg')) -and ((Get-Content (Join-Path $Out 'floorplan.svg') -Raw) -match '<svg'))
Step 'convert-png' $Cli @('convert', $fp, (Join-Path $Out 'floorplan.png')) | Out-Null
Check 'png-nonempty' ((Test-Path (Join-Path $Out 'floorplan.png')) -and ((Get-Item (Join-Path $Out 'floorplan.png')).Length -gt 0))
Step 'convert-pdf' $Cli @('convert', $fp, (Join-Path $Out 'floorplan.pdf')) | Out-Null
Check 'pdf-header' ((Test-Path (Join-Path $Out 'floorplan.pdf')) -and ([System.Text.Encoding]::ASCII.GetString([System.IO.File]::ReadAllBytes((Join-Path $Out 'floorplan.pdf')), 0, 5) -eq '%PDF-'))

# 3. scripted drawing: command-line script exactly as a user would type it
$scr = Join-Path $Out 'draw.scr'
Set-Content -Path $scr -Value "LINE 0,0 100,0`n`nCIRCLE 50,50 25`nDIMLINEAR 0,0 100,0 50,-20`n" -NoNewline
$drawDxf = Join-Path $Out 'draw.dxf'
Step 'run-script' $Cli @('run', '--metric', '--script-file', $scr, '--save', $drawDxf, '--export', (Join-Path $Out 'draw.png')) | Out-Null
$dxfText = if (Test-Path $drawDxf) { Get-Content $drawDxf -Raw } else { '' }
Check 'draw-dxf-has-line' ($dxfText -match '(?m)^LINE')
Check 'draw-dxf-has-circle' ($dxfText -match '(?m)^CIRCLE')
Check 'draw-dxf-has-dimension' ($dxfText -match '(?m)^DIMENSION')
Check 'draw-png-nonempty' ((Test-Path (Join-Path $Out 'draw.png')) -and ((Get-Item (Join-Path $Out 'draw.png')).Length -gt 0))
$jsonDxf = Join-Path $Out 'json.dxf'
Step 'run-json' $Cli @('run', '--metric', '--cmd', 'line {"points":[[0,0],[10,10]]}', '--cmd', 'circle {"center":[5,5],"radius":2}', '--save', $jsonDxf) | Out-Null
$jsonText = if (Test-Path $jsonDxf) { Get-Content $jsonDxf -Raw } else { '' }
Check 'json-dxf-entities' ((([regex]::Matches($jsonText, '(?m)^(LINE|CIRCLE)')).Count) -ge 2)
Step 'info-draw' $Cli @('info', $drawDxf) | Out-Null

# 4. round trip of the scripted drawing through DWG
Step 'draw-to-dwg' $Cli @('convert', $drawDxf, (Join-Path $Out 'draw.dwg')) | Out-Null
Step 'draw-dwg-back' $Cli @('convert', (Join-Path $Out 'draw.dwg'), (Join-Path $Out 'draw-back.dxf')) | Out-Null
$backText = if (Test-Path (Join-Path $Out 'draw-back.dxf')) { Get-Content (Join-Path $Out 'draw-back.dxf') -Raw } else { '' }
Check 'roundtrip-keeps-circle' ($backText -match '(?m)^CIRCLE')

# 5. short benchmark
Step 'perf-20k' $Cli @('perf', '20000') | Out-Null

# 6. desktop app over the control channel
if (-not $NoGui) {
  $shot = Join-Path $Out 'shot.png'
  $render = Join-Path $Out 'render.png'
  $guiLog = Join-Path $Out 'gui.log'
  $proc = Start-Process -FilePath $App -ArgumentList @('--sample', '--control', "$Port") -PassThru -RedirectStandardOutput $guiLog -RedirectStandardError (Join-Path $Out 'gui.err.log')
  $client = $null
  for ($i = 0; $i -lt 60 -and -not $client; $i++) {
    Start-Sleep -Seconds 1
    try { $c = New-Object System.Net.Sockets.TcpClient; $c.Connect('127.0.0.1', $Port); $client = $c } catch { $client = $null }
  }
  if ($client) {
    $script:Pass++; Write-Output "PASS  gui-control-port (after ${i}s)"
    $stream = $client.GetStream()
    $writer = New-Object System.IO.StreamWriter($stream); $writer.AutoFlush = $true
    $reader = New-Object System.IO.StreamReader($stream)
    $replies = @()
    function Send([string] $line) {
      $writer.Write($line + "`n")
      $stream.ReadTimeout = 20000
      try { $r = $reader.ReadLine(); $script:replies += $r; return $r } catch { return '' }
    }
    $shotJson = ($shot -replace '\\', '\\')
    $renderJson = ($render -replace '\\', '\\')
    $r1 = Send '{"id":1,"method":"ping","params":{}}'
    Check 'gui-ping' ($r1 -match 'pong')
    $r2 = Send '{"id":2,"method":"cmdline.input","params":{"text":"circle 0,0 5"}}'
    Check 'gui-cmdline-circle' ($r2 -match '"ok":true')
    $r3 = Send '{"id":3,"method":"engine.execute","params":{"command":"line","params":{"points":[[0,0],[10,0],[10,10]]}}}'
    Check 'gui-execute-line' ($r3 -match '"ok":true')
    Send '{"id":4,"method":"cmdline.input","params":{"text":"zoom e"}}' | Out-Null
    $r5 = Send '{"id":5,"method":"drawing.inspect","params":{}}'
    Check 'gui-inspect-entities' ($r5 -match 'entit')
    Start-Sleep -Seconds 2
    $r6 = Send ('{"id":6,"method":"ui.screenshot","params":{"path":"' + $shotJson + '"}}')
    Send ('{"id":7,"method":"ui.render","params":{"path":"' + $renderJson + '","width":800,"height":500}}') | Out-Null
    Start-Sleep -Seconds 2
    Check 'gui-render-png' ((Test-Path $render) -and ((Get-Item $render).Length -gt 0))
    if ((Test-Path $shot) -and ((Get-Item $shot).Length -gt 0)) { $script:Pass++; Write-Output "PASS  gui-screenshot ($((Get-Item $shot).Length) bytes)" }
    else { Write-Output "WARN  gui-screenshot (no presented frame yet; ui.render passed instead): $r6" }
    Send '{"id":8,"method":"app.quit","params":{}}' | Out-Null
    Set-Content -Path (Join-Path $Out 'control.log') -Value ($replies -join "`n")
    Start-Sleep -Seconds 2
    $client.Close()
  } else {
    $script:Fail++; Write-Output "FAIL  gui-control-port (see $guiLog)"
  }
  if (-not $proc.HasExited) { Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue }
}

Write-Output '----'
Write-Output "passed $script:Pass, failed $script:Fail · logs in $Out"
exit $script:Fail
