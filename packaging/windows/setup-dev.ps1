<#
.SYNOPSIS
  Set up a Windows PC to build and run CADCraft from source, then start it.

.DESCRIPTION
  Installs whatever is missing (Git, the Visual Studio 2022 Build Tools with the C++ workload,
  Rust via rustup), clones or updates the repository, builds the desktop app and the command-line
  tool in release mode, and starts CADCraft with the sample drawing.

  Everything is installed with winget (part of Windows 10 1709+ and Windows 11). Installers that
  need administrator rights ask for elevation themselves; the script itself does not need an
  elevated window.

  Run it from PowerShell:

    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    .\setup-dev.ps1

  Before the repository is cloned, download the script first:

    Invoke-WebRequest https://raw.githubusercontent.com/Sparkey333/cadcraft_1/main/packaging/windows/setup-dev.ps1 -OutFile setup-dev.ps1
    .\setup-dev.ps1

  The release build takes 5 to 20 minutes the first time, depending on the machine; later builds
  reuse the compiled dependencies and take seconds to a few minutes.

.PARAMETER RepoUrl
  Git URL to clone. Default: https://github.com/Sparkey333/cadcraft_1

.PARAMETER Branch
  Branch to check out. Default: main

.PARAMETER Dir
  Where the repository goes. Default: %USERPROFILE%\src\cadcraft. If it already holds a clone,
  it is updated (git pull) instead of cloned again.

.PARAMETER SkipInstall
  Do not install anything; only check that Git, Rust and the MSVC tools are present.

.PARAMETER SkipRun
  Build, but do not start the app afterwards.

.PARAMETER NoSample
  Start the app with an empty drawing instead of the sample drawing.

.EXAMPLE
  .\setup-dev.ps1
  Installs what is missing, clones into %USERPROFILE%\src\cadcraft, builds and starts CADCraft.

.EXAMPLE
  .\setup-dev.ps1 -Dir C:\cad\cadcraft -Branch main -SkipRun
  Clones or updates C:\cad\cadcraft and builds it without starting the app.

.EXAMPLE
  .\setup-dev.ps1 -RepoUrl https://github.com/storytold/cadcraft
  Uses the upstream repository instead of the fork.
#>
param(
  [string] $RepoUrl = 'https://github.com/Sparkey333/cadcraft_1',
  [string] $Branch = 'main',
  [string] $Dir = (Join-Path $HOME 'src\cadcraft'),
  [switch] $SkipInstall,
  [switch] $SkipRun,
  [switch] $NoSample
)
$ErrorActionPreference = 'Stop'
$MinimumRust = [version]'1.95.0'

function Invoke-Native([string] $What, [scriptblock] $Block) {
  Write-Output "==> $What"
  & $Block
  if ($LASTEXITCODE -ne 0) { throw "$What failed with exit code $LASTEXITCODE" }
}

function Test-CommandPresent([string] $Name) {
  return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

# Installers add themselves to the registry PATH; pick that up without opening a new window.
function Import-SystemPath {
  $machine = [Environment]::GetEnvironmentVariable('Path', 'Machine')
  $user = [Environment]::GetEnvironmentVariable('Path', 'User')
  $cargoBin = Join-Path $HOME '.cargo\bin'
  $env:Path = ($machine, $user, $cargoBin, $env:Path | Where-Object { $_ }) -join ';'
}

function Test-WingetPresent {
  if (Test-CommandPresent 'winget') { return $true }
  Write-Warning 'winget was not found. Install "App Installer" from the Microsoft Store (or update Windows), or install Git, the Visual Studio 2022 Build Tools (C++ workload) and rustup by hand, then run this script again with -SkipInstall.'
  return $false
}

function Install-WithWinget([string] $Id, [string] $Override) {
  $wingetArgs = @('install', '--id', $Id, '--exact', '--silent', '--accept-package-agreements', '--accept-source-agreements', '--disable-interactivity')
  if ($Override) { $wingetArgs += @('--override', $Override) }
  Write-Output "==> winget install $Id"
  & winget @wingetArgs
  # 0 = installed; -1978335189 (0x8A15002B) = already installed, nothing to do.
  if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne -1978335189) {
    throw "winget install $Id failed with exit code $LASTEXITCODE"
  }
  Import-SystemPath
}

# The MSVC linker and Windows SDK that the Rust MSVC toolchain links with.
function Test-VcToolsPresent {
  if (Test-CommandPresent 'cl.exe') { return $true }
  $vswhere = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio\Installer\vswhere.exe'
  if (-not (Test-Path $vswhere)) { return $false }
  $found = & $vswhere -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath 2>$null
  return [bool]$found
}

function Get-RustVersion {
  if (-not (Test-CommandPresent 'rustc')) { return $null }
  $text = (& rustc --version 2>$null) | Select-Object -First 1
  if ($text -match '(\d+)\.(\d+)\.(\d+)') { return [version]"$($Matches[1]).$($Matches[2]).$($Matches[3])" }
  return $null
}

Write-Output 'CADCraft: Windows development setup'
Write-Output "  repository: $RepoUrl ($Branch)"
Write-Output "  directory:  $Dir"
Import-SystemPath

# 1. Tools ------------------------------------------------------------------------------------
if ($SkipInstall) {
  Write-Output '==> -SkipInstall: checking tools only'
}
else {
  $haveWinget = Test-WingetPresent
  if (-not (Test-CommandPresent 'git')) {
    if ($haveWinget) { Install-WithWinget 'Git.Git' } else { throw 'Git is missing' }
  }
  if (-not (Test-VcToolsPresent)) {
    if ($haveWinget) {
      # The C++ workload (MSVC compiler, linker and the Windows SDK), in a passive wizard so the
      # progress is visible; nothing else from Visual Studio is installed.
      Install-WithWinget 'Microsoft.VisualStudio.2022.BuildTools' '--wait --passive --norestart --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended'
    }
    else { throw 'The Visual Studio Build Tools (C++ workload) are missing' }
  }
  if (-not (Test-CommandPresent 'cargo')) {
    if ($haveWinget) { Install-WithWinget 'Rustlang.Rustup' } else { throw 'Rust (rustup) is missing' }
  }
}

foreach ($tool in 'git', 'cargo', 'rustc') {
  if (-not (Test-CommandPresent $tool)) {
    throw "$tool is still not on PATH. Open a new PowerShell window (installers change PATH for new windows) and run the script again."
  }
}
if (-not (Test-VcToolsPresent)) {
  throw 'The MSVC build tools were not found. Install the Visual Studio 2022 Build Tools with the "Desktop development with C++" workload, then run the script again.'
}

# The desktop UI needs Rust 1.95 or later (crates/ui-egui); the rest of the workspace 1.90.
$rust = Get-RustVersion
if (-not $rust -or $rust -lt $MinimumRust) {
  Invoke-Native 'rustup update stable' { rustup update stable }
  Invoke-Native 'rustup default stable' { rustup default stable }
  $rust = Get-RustVersion
}
if (-not $rust -or $rust -lt $MinimumRust) { throw "Rust $MinimumRust or later is required; found $rust" }
Write-Output "==> Rust $rust, $(& cargo --version)"

# 2. Source -----------------------------------------------------------------------------------
if (Test-Path (Join-Path $Dir '.git')) {
  Write-Output "==> updating $Dir"
  Invoke-Native 'git fetch' { git -C $Dir fetch origin $Branch }
  Invoke-Native 'git checkout' { git -C $Dir checkout $Branch }
  Invoke-Native 'git pull' { git -C $Dir pull --ff-only origin $Branch }
}
else {
  $parent = Split-Path -Parent $Dir
  if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
  Invoke-Native 'git clone' { git clone --branch $Branch $RepoUrl $Dir }
}

# 3. Build ------------------------------------------------------------------------------------
Invoke-Native 'cargo build --release (cadcraft, cadcraft-cli)' {
  cargo build --release --manifest-path (Join-Path $Dir 'Cargo.toml') -p cadcraft -p cadcraft-cli
}

$exe = Join-Path $Dir 'target\release\cadcraft.exe'
$cli = Join-Path $Dir 'target\release\cadcraft-cli.exe'
Write-Output ''
Write-Output "Built: $exe"
Write-Output "       $cli"
Write-Output 'Try at the command line inside the app:  line 0,0 @10,0 @0,5 c   |   circle 5,2 1   |   zoom e'
Write-Output "Headless check:  & '$cli' run --sample --cmd 'circle {""center"":[0,0],""radius"":5}' --export out.png"
Write-Output 'If the window never appears (some AMD drivers):  $env:WGPU_BACKEND = "vulkan"  then start it again.'

# 4. Run --------------------------------------------------------------------------------------
if (-not $SkipRun) {
  $appArgs = @()
  if (-not $NoSample) { $appArgs += '--sample' }
  Write-Output "==> starting CADCraft $($appArgs -join ' ')"
  Start-Process -FilePath $exe -ArgumentList $appArgs -WorkingDirectory $Dir
}
