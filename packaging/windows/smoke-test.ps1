<#
.SYNOPSIS
  Functional smoke test for CADCraft on Windows.

.DESCRIPTION
  Runs the headless CLI through its real workflows (sample drawing, info, DXF -> DWG -> SVG -> PNG
  -> PDF, a scripted drawing saved and exported, the JSON command form, a DWG round trip, the
  command catalogue, a short benchmark), then starts the desktop app with the JSON control channel,
  draws through it, checks the drawing changed, asks for a screenshot and a headless render, and
  quits. Every step prints PASS or FAIL; the exit code is the number of failed steps. Entity checks
  read `cadcraft-cli info` (model-space counts), never raw DXF text.

  Run it from the repository root after packaging\windows\setup-dev.ps1 has built the app, or point
  it at installed binaries with -Cli and -App. Works in Windows PowerShell 5.1 and PowerShell 7.

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

# Before PowerShell 7.3 (and in Legacy mode) embedded double quotes are not escaped when arguments
# reach a native program, so JSON arguments need their quotes escaped by hand.
$script:LegacyArgs = ($PSVersionTable.PSVersion -lt [version]'7.3') -or ((Get-Variable -Name PSNativeCommandArgumentPassing -ValueOnly -ErrorAction SilentlyContinue) -eq 'Legacy')
function NativeArg([string] $s) { if ($script:LegacyArgs) { return ($s -replace '"', '\"') } else { return $s } }

$script:Pass = 0
$script:Fail = 0
function Ok([string] $Name) { $script:Pass++; Write-Host "PASS  $Name" }
function Bad([string] $Name, [string] $Why) { $script:Fail++; Write-Host "FAIL  $Name  ($Why)" }
function Step([string] $Name, [string] $Exe, [string[]] $Arguments) {
  # runs the command, PASS on exit 0, log in target\smoke\NAME.log; returns the output text
  $log = Join-Path $Out "$Name.log"
  $text = (& $Exe @Arguments 2>&1 | Out-String)
  $code = $LASTEXITCODE
  Set-Content -Path $log -Value $text
  if ($code -eq 0) { Ok $Name } else { Bad $Name "exit $code, see $log" }
  return $text
}
function Check([string] $Name, [bool] $Condition, [string] $Why = "") {
  if ($Condition) { Ok $Name } else { Bad $Name $Why }
}
function JsonOf([string] $text) { try { return ($text | ConvertFrom-Json) } catch { return $null } }
function IsPng([string] $path) {
  if (-not (Test-Path $path)) { return $false }
  $b = [System.IO.File]::ReadAllBytes($path)
  if ($b.Length -lt 8) { return $false }
  $sig = @(0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A)
  for ($k = 0; $k -lt 8; $k++) { if ($b[$k] -ne $sig[$k]) { return $false } }
  return $true
}
function StartsWith([string] $path, [string] $prefix) {
  if (-not (Test-Path $path)) { return $false }
  $b = [System.IO.File]::ReadAllBytes($path)
  if ($b.Length -lt $prefix.Length) { return $false }
  return ([System.Text.Encoding]::ASCII.GetString($b, 0, $prefix.Length) -eq $prefix)
}

Write-Host "CADCraft smoke test - $((Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')) - out: $Out"

# 0. binaries
$needApp = -not $NoGui
if (-not (Test-Path $Cli) -or ($needApp -and -not (Test-Path $App))) {
  if (-not $NoBuild) {
    Write-Host "building release binaries (first time: several minutes)"
    Push-Location $Root
    try { cargo build --release -p cadcraft-cli -p cadcraft } finally { Pop-Location }
  }
  if (-not (Test-Path $Cli) -or ($needApp -and -not (Test-Path $App))) { Write-Host "binaries missing: $Cli / $App"; exit 1 }
}

# 1. CLI version and command catalogue (a JSON array with one object per command)
$v = Step 'cli-version' $Cli @('--version')
Check 'cli-version-string' ($v -match 'cadcraft') 'no "cadcraft" in --version output'
$cmds = Step 'cli-commands' $Cli @('commands')
$cmdCount = @(JsonOf $cmds).Count
Check 'cli-commands-count' ($cmdCount -ge 300) "got $cmdCount commands"

# 2. sample drawing, info, conversion chain (the floor plan sample has 16 entities)
$fp = Join-Path $Out 'floorplan.dxf'
Step 'sample-floorplan' $Cli @('sample', 'floorplan', $fp) | Out-Null
$info = JsonOf (Step 'info-dxf' $Cli @('info', $fp))
Check 'info-entities' ($null -ne $info -and $info.entityCount -eq 16) "entityCount=$($info.entityCount)"
$dwg = Join-Path $Out 'floorplan.dwg'
Step 'convert-dwg' $Cli @('convert', $fp, $dwg) | Out-Null
$infoDwg = JsonOf (Step 'info-dwg' $Cli @('info', $dwg))
Check 'info-dwg-entities' ($null -ne $infoDwg -and $infoDwg.entityCount -eq 16) "entityCount=$($infoDwg.entityCount)"
$svg = Join-Path $Out 'floorplan.svg'
Step 'convert-svg' $Cli @('convert', $dwg, $svg) | Out-Null
$svgText = if (Test-Path $svg) { Get-Content $svg -Raw } else { '' }
Check 'svg-has-root' ($svgText -match '<svg') 'no <svg root'
Check 'svg-has-geometry' (([regex]::Matches($svgText, '<(polyline|path|line|circle)')).Count -ge 10) 'fewer than 10 drawn elements'
$png = Join-Path $Out 'floorplan.png'
Step 'convert-png' $Cli @('convert', $fp, $png) | Out-Null
Check 'png-signature' (IsPng $png) "$png is not a PNG"
$pdf = Join-Path $Out 'floorplan.pdf'
Step 'convert-pdf' $Cli @('convert', $fp, $pdf) | Out-Null
Check 'pdf-header' (StartsWith $pdf '%PDF-') "$pdf does not start with %PDF-"

# 3. scripted drawing: a command-line script exactly as a user would type it
$scr = Join-Path $Out 'draw.scr'
Set-Content -Path $scr -Value "LINE 0,0 100,0`n`nCIRCLE 50,50 25`nDIMLINEAR 0,0 100,0 50,-20`n" -NoNewline
$drawDxf = Join-Path $Out 'draw.dxf'
$drawPng = Join-Path $Out 'draw.png'
Step 'run-script' $Cli @('run', '--metric', '--script-file', $scr, '--save', $drawDxf, '--export', $drawPng) | Out-Null
$infoDraw = JsonOf (Step 'info-draw' $Cli @('info', $drawDxf))
Check 'draw-entities' ($null -ne $infoDraw -and $infoDraw.entityCount -eq 3) "entityCount=$($infoDraw.entityCount)"
Check 'draw-line' ($null -ne $infoDraw -and $infoDraw.counts.Line -eq 1) "Line=$($infoDraw.counts.Line)"
Check 'draw-circle' ($null -ne $infoDraw -and $infoDraw.counts.Circle -eq 1) "Circle=$($infoDraw.counts.Circle)"
Check 'draw-dimension' ($null -ne $infoDraw -and $infoDraw.counts.Dimension -eq 1) "Dimension=$($infoDraw.counts.Dimension)"
Check 'draw-png-signature' (IsPng $drawPng) "$drawPng is not a PNG"
$jsonDxf = Join-Path $Out 'json.dxf'
Step 'run-json' $Cli @('run', '--metric', '--cmd', (NativeArg 'line {"points":[[0,0],[10,10]]}'), '--cmd', (NativeArg 'circle {"center":[5,5],"radius":2}'), '--save', $jsonDxf) | Out-Null
$infoJson = JsonOf (Step 'info-json' $Cli @('info', $jsonDxf))
Check 'json-line' ($null -ne $infoJson -and $infoJson.counts.Line -eq 1) "Line=$($infoJson.counts.Line)"
Check 'json-circle' ($null -ne $infoJson -and $infoJson.counts.Circle -eq 1) "Circle=$($infoJson.counts.Circle)"

# 4. round trip of the scripted drawing through DWG keeps all three entities
$drawDwg = Join-Path $Out 'draw.dwg'
$drawBack = Join-Path $Out 'draw-back.dxf'
Step 'draw-to-dwg' $Cli @('convert', $drawDxf, $drawDwg) | Out-Null
Step 'draw-dwg-back' $Cli @('convert', $drawDwg, $drawBack) | Out-Null
$infoBack = JsonOf (Step 'info-draw-back' $Cli @('info', $drawBack))
Check 'roundtrip-line' ($null -ne $infoBack -and $infoBack.counts.Line -eq 1) "Line=$($infoBack.counts.Line)"
Check 'roundtrip-circle' ($null -ne $infoBack -and $infoBack.counts.Circle -eq 1) "Circle=$($infoBack.counts.Circle)"
Check 'roundtrip-dimension' ($null -ne $infoBack -and $infoBack.counts.Dimension -eq 1) "Dimension=$($infoBack.counts.Dimension)"

# 5. short benchmark
Step 'perf-20k' $Cli @('perf', '20000') | Out-Null

# 6. desktop app over the control channel
if (-not $NoGui) {
  $shot = Join-Path $Out 'shot.png'
  $render = Join-Path $Out 'render.png'
  $guiLog = Join-Path $Out 'gui.log'
  $inUse = $false
  try { $t = New-Object System.Net.Sockets.TcpClient; $t.Connect('127.0.0.1', $Port); $t.Close(); $inUse = $true } catch { $inUse = $false }
  if ($inUse) {
    Bad 'gui-control-port' "port $Port already in use; pass -Port"
  } else {
    $proc = Start-Process -FilePath $App -ArgumentList @('--sample', '--control', "$Port") -PassThru -RedirectStandardOutput $guiLog -RedirectStandardError (Join-Path $Out 'gui.err.log')
    $client = $null
    for ($i = 0; $i -lt 60 -and -not $client; $i++) {
      if ($proc.HasExited) { break }
      Start-Sleep -Seconds 1
      try { $c = New-Object System.Net.Sockets.TcpClient; $c.Connect('127.0.0.1', $Port); $client = $c } catch { $client = $null }
    }
    if ($client) {
      Ok "gui-control-port (after ${i}s)"
      $stream = $client.GetStream()
      $stream.ReadTimeout = 65000   # above the server's own 60 s reply deadline
      $writer = New-Object System.IO.StreamWriter($stream); $writer.AutoFlush = $true
      $reader = New-Object System.IO.StreamReader($stream)
      $script:replies = @()
      function Send([int] $id, [string] $line) {
        # sends one request and returns the reply carrying the same id (skips stray late replies)
        $writer.Write($line + "`n")
        for ($tries = 0; $tries -lt 5; $tries++) {
          try { $r = $reader.ReadLine() } catch { $script:replies += "timeout waiting for id $id"; return '' }
          if ($null -eq $r) { return '' }
          $script:replies += $r
          $j = JsonOf $r
          if ($null -ne $j -and $j.id -eq $id) { return $r }
        }
        return ''
      }
      $shotJson = ($shot -replace '\\', '\\')
      $renderJson = ($render -replace '\\', '\\')
      $r0 = Send 10 '{"id":10,"method":"drawing.inspect","params":{"entities":false}}'
      $r1 = Send 1 '{"id":1,"method":"ping","params":{}}'
      Check 'gui-ping' ($r1 -match '"result":"pong"') "reply: $r1"
      $r2 = Send 2 '{"id":2,"method":"cmdline.input","params":{"text":"circle 0,0 5"}}'
      $j2 = JsonOf $r2
      Check 'gui-cmdline-circle' ($null -ne $j2 -and $j2.ok -and -not $j2.result.error -and -not $j2.result.running) "reply: $r2"
      $r3 = Send 3 '{"id":3,"method":"engine.execute","params":{"command":"line","params":{"points":[[0,0],[10,0],[10,10]]}}}'
      Check 'gui-execute-line' ($r3 -match '"ok":true') "reply: $r3"
      $r4 = Send 4 '{"id":4,"method":"cmdline.input","params":{"text":"zoom e"}}'
      $j4 = JsonOf $r4
      Check 'gui-cmdline-zoom' ($null -ne $j4 -and $j4.ok -and -not $j4.result.error -and -not $j4.result.running) "reply: $r4"
      $r5 = Send 5 '{"id":5,"method":"drawing.inspect","params":{"entities":false}}'
      $n0 = (JsonOf $r0).result.entityCount
      $n5 = (JsonOf $r5).result.entityCount
      Check 'gui-entities-added' (($null -ne $n0) -and ($null -ne $n5) -and (($n5 - $n0) -eq 3)) "entityCount $n0 -> $n5, expected +3"
      Start-Sleep -Seconds 2
      $r6 = Send 6 ('{"id":6,"method":"ui.screenshot","params":{"path":"' + $shotJson + '"}}')
      $r7 = Send 7 ('{"id":7,"method":"ui.render","params":{"path":"' + $renderJson + '","width":800,"height":500}}')
      Check 'gui-render-png' (($r7 -match '"ok":true') -and (IsPng $render)) "reply: $r7"
      if (IsPng $shot) { Ok "gui-screenshot ($((Get-Item $shot).Length) bytes)" }
      else { Write-Host "WARN  gui-screenshot (no presented frame; the headless render stands in): $r6" }
      $r8 = Send 8 '{"id":8,"method":"app.quit","params":{}}'
      Check 'gui-quit-reply' ($r8 -match '"ok":true') "reply: $r8"
      Set-Content -Path (Join-Path $Out 'control.log') -Value ($script:replies -join "`n")
      $client.Close()
      if ($proc.WaitForExit(15000)) { Check 'gui-exit' ($proc.ExitCode -eq 0) "exit code $($proc.ExitCode)" }
      else { Bad 'gui-exit' 'app still running 15 s after app.quit'; Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue }
      $guiText = if (Test-Path $guiLog) { Get-Content $guiLog -Raw } else { '' }
      Check 'gui-no-panic' ($guiText -notmatch 'panicked') 'panic in gui.log'
    } else {
      Bad 'gui-control-port' "app not answering after ${i}s, see $guiLog"
      if (-not $proc.HasExited) { Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue }
    }
  }
}

Write-Host '----'
Write-Host "passed $script:Pass, failed $script:Fail - logs in $Out"
if ($script:Fail -gt 125) { exit 125 }
exit $script:Fail
