# Setting up CADCraft on a Windows PC

> **Last reviewed:** 2026-10-21 · **Last updated:** 2026-10-21 · **Change:** major (first version) · **Target:** CADCraft 0.10.0 on Windows 10/11, x64 and arm64

Three ways to get a running CADCraft on Windows, from quickest to most flexible. The first two
need no developer tools at all.

| Route | Time | Needs | Best for |
|---|---|---|---|
| [A. Install a release](#a-install-a-release-msi) | 2 minutes | nothing | using the app |
| [B. Portable zip](#b-portable-zip) | 2 minutes | nothing | a USB stick, a locked-down PC, trying it without installing |
| [C. Build from source](#c-build-from-source) | 15–40 minutes the first time | Git, Rust, MSVC build tools (the script installs them) | changing the code, running this fork's branches, agents |

Hardware: any 64-bit Windows 10 (1709 or later) or Windows 11 PC with a GPU driver that supports
DirectX 12 (every Intel, AMD and NVIDIA driver since about 2016). 8 GB of RAM is plenty for 2D
work; a build from source wants 16 GB and about 10 GB of free disk.

## A. Install a release (MSI)

1. Open the [latest release](https://github.com/storytold/cadcraft/releases/latest) of the
   upstream project and download the installer for your PC:
   - `cadcraft-<ver>-windows-x64.msi` for an Intel or AMD PC (almost everyone);
   - `cadcraft-<ver>-windows-arm64.msi` for a Snapdragon or other ARM PC;
   - `cadcraft-<ver>-windows-x86.msi` for an old 32-bit Windows.
   Optionally check the download against `SHA256SUMS.txt` from the same release:
   `Get-FileHash .\cadcraft-<ver>-windows-x64.msi` in PowerShell.
2. Double-click the `.msi`. The wizard installs into `C:\Program Files\CADCraft`, adds a Start
   menu entry, and offers a desktop shortcut (unticked by default). Installers and executables
   are code-signed, so SmartScreen does not object.
   Silent install with a desktop shortcut: `msiexec /i cadcraft-<ver>-windows-x64.msi /qn DESKTOPSHORTCUT=1`.
3. Start **CADCraft** from the Start menu. `.dxf` and `.dwg` files offer CADCraft under
   **Open with** (the installer does not take over the default app for them).

This fork (`Sparkey333/cadcraft_1`) publishes no installers of its own; the upstream installers
are the same code as this repository's `main` as of the release date. To run this fork's own
changes, use route C.

## B. Portable zip

Download `cadcraft-<ver>-windows-x64-portable.zip` (or `-arm64-`) from the same
[release page](https://github.com/storytold/cadcraft/releases/latest), unpack it anywhere and run
`cadcraft.exe`. The zip also holds `cadcraft-cli.exe`, the headless command-line tool. Nothing
is written outside the settings folder (`%APPDATA%\CADCraft`), and the executables link the C
runtime statically, so no Visual C++ redistributable is needed.

## C. Build from source

### With the setup script (recommended)

`packaging/windows/setup-dev.ps1` installs what is missing (Git, the Visual Studio 2022 Build
Tools with the C++ workload, Rust via rustup), clones or updates the repository, builds the
desktop app and the CLI in release mode, and starts CADCraft with the sample drawing. It uses
`winget`, which ships with Windows 10 (1709 or later) and Windows 11; installers that need
administrator rights ask for elevation on their own.

Open **PowerShell** (not as administrator) and run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Invoke-WebRequest https://raw.githubusercontent.com/Sparkey333/cadcraft_1/main/packaging/windows/setup-dev.ps1 -OutFile setup-dev.ps1
.\setup-dev.ps1
```

Options: `-Dir C:\cad\cadcraft` (where to clone; default `%USERPROFILE%\src\cadcraft`),
`-Branch <name>` (default `main`), `-RepoUrl https://github.com/storytold/cadcraft` (build
upstream instead of this fork), `-SkipInstall` (install nothing, only check), `-SkipRun` (build
only), `-NoSample` (start with an empty drawing). Run `Get-Help .\setup-dev.ps1 -Full` for the
whole list.

If a tool was just installed and the script stops with "is still not on PATH", open a new
PowerShell window and run the script again: installers change PATH for new windows only.

### By hand

1. **Git for Windows:** `winget install Git.Git`, or [git-scm.com](https://git-scm.com/download/win).
2. **MSVC build tools:** `winget install Microsoft.VisualStudio.2022.BuildTools --override "--wait --passive --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"`,
   or run the [Build Tools installer](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
   and tick **Desktop development with C++**. (A full Visual Studio 2022 or 2026 install with
   that workload works too.)
3. **Rust:** `winget install Rustlang.Rustup`, or [rustup.rs](https://rustup.rs). The desktop UI
   needs Rust 1.95 or later: `rustup update stable`.
4. **Clone and build** in a new PowerShell window:

   ```powershell
   git clone https://github.com/Sparkey333/cadcraft_1 $HOME\src\cadcraft
   cd $HOME\src\cadcraft
   cargo build --release -p cadcraft -p cadcraft-cli
   .\target\release\cadcraft.exe --sample
   ```

   The first build compiles about 500 crates and takes 5–20 minutes; later builds take seconds
   to a few minutes. `cargo run --release -p cadcraft -- --sample` builds and starts in one go.

5. **Optional, an MSI of your own build:** `pwsh packaging/windows/package.ps1 -Arch x64` (needs
   WiX v5: `dotnet tool install --global wix --version 5.0.2` and
   `wix extension add -g WixToolset.UI.wixext/5.0.2`). It is left unsigned unless signing
   secrets are set; see `packaging/windows/sign.ps1`.

## First five minutes

At the command line at the bottom of the window:

```text
line 0,0 @10,0 @0,5 c          a closed triangle
circle 5,2 1                    a circle
offset 0.25                     then pick the circle and a side
dimlinear 0,0 10,0 5,-2         a linear dimension
zoom e                          zoom to extents
```

Open the sample apartment plan with **File ▸ Open** and `examples\apartment.dxf` from the
repository (route C) or any DXF/DWG you have. **File ▸ Plot** writes a PDF.

Headless, from PowerShell (route B's zip or route C's `target\release`):

```powershell
.\cadcraft-cli.exe run --sample --cmd 'circle {"center":[0,0],"radius":5}' --save out.dxf --export out.png
.\cadcraft-cli.exe info out.dxf
.\cadcraft-cli.exe convert drawing.dwg drawing.svg
```

Scripts given with `--script` need real line breaks between commands. In PowerShell use a
here-string or `"LINE 0,0 10,10`nCIRCLE 5,5 3`n"` (a backtick-n), or put the lines in a file and
pass `--script-file setup.scr`.

## Agents and the control channel

Start the app with a control port and drive it with JSON lines, or let an MCP client (Claude
Desktop, Claude Code) draw in it:

```powershell
.\cadcraft.exe --sample --control 7979
.\cadcraft-cli.exe mcp --connect 127.0.0.1:7979      # MCP bridged to the running app
.\cadcraft-cli.exe mcp                                # MCP on a headless session
```

Claude Desktop configuration (`%APPDATA%\Claude\claude_desktop_config.json`):

```json
{ "mcpServers": { "cadcraft": { "command": "C:\\Program Files\\CADCraft\\cadcraft-cli.exe", "args": ["mcp", "--connect", "127.0.0.1:7979", "--lazy"] } } }
```

Details: [mcp.md](mcp.md), [control-protocol.md](control-protocol.md), [customization.md](customization.md).

## If something goes wrong

| Symptom | What to do |
|---|---|
| The app flashes in Task Manager and quits, or no window appears | Some AMD drivers crash when wgpu creates an OpenGL instance. Start it with `$env:WGPU_BACKEND = "vulkan"; .\cadcraft.exe` (or `dx12`), then `Remove-Item Env:WGPU_BACKEND`. See [Downloads ▸ Windows](../README.md#windows) in the README |
| `link.exe not found` or `error: linker 'link.exe' not found` during the build | The MSVC build tools are missing or were installed after Rust: install the C++ workload (step 2), open a new window, `rustup default stable-msvc` |
| `rustc 1.9x is too old` / `package requires rustc 1.95` | `rustup update stable` |
| A font or CJK text draws as boxes | CADCraft uses the fonts installed in `C:\Windows\Fonts`; install the font and restart. `CADCRAFT_FONTFALLBACK` picks fallbacks (README ▸ Fonts) |
| Where are the logs? | `%APPDATA%\CADCraft\logs\cadcraft.log` (the previous run is `cadcraft.1.log`). Attach it to a bug report |
| A screen magnifier loses the cursor | **View ▸ Accessibility ▸ Show System Cursor**, or `setx CADCRAFT_SYSTEM_CURSOR 1` |
| The build runs out of disk | `cargo clean` frees `target\` (about 4 GB for a release build) |

## Verified

This guide's build and headless commands were run on 2026-10-21 against this repository at the
commit that added it: `cargo build --release -p cadcraft-cli` (3 min on a 4-core Linux
container with Rust 1.97), then `run --sample`, `--save`, `--export`, `info`, `convert`
(DXF ▸ DWG ▸ SVG) and `perf 200000` all succeeded. The Windows-specific steps (winget ids,
the MSVC workload, the MSI) follow `packaging/windows/package.ps1` and the release workflow, which
build the published Windows installers.

## Revision history

| Date | Change | Summary |
|---|---|---|
| 2026-10-21 | major | First version: release, portable and build-from-source routes, the setup script, first commands, agents, troubleshooting |
