[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot 'common.ps1')
$root = Get-NfrProjectRoot
$required = @(
  '.kiro\specs\neon-fitting-room\requirements.md',
  '.kiro\specs\neon-fitting-room\design.md',
  '.kiro\specs\neon-fitting-room\tasks.md',
  'src\NeonFittingRoom\core\NfrBuildMarker.reds',
  'src\NeonFittingRoom\core\NfrConfig.reds',
  'src\NeonFittingRoom\diagnostics\NfrLog.reds',
  'src\NeonFittingRoom\diagnostics\NfrLogBackend.reds',
  'assets\ink-source\nfr\ui\nfr_photomode_static_panel.inkwidget.json',
  'tools\templates\NfrBuildProfile.debug.reds',
  'tools\templates\NfrBuildProfile.release.reds',
  'tools\compile-redscript.ps1',
  'docs\smoke-test.md',
  'release\manifest-template.json',
  'release\nexus-listing.bbcode',
  'release\nexus-metadata.md',
  'LICENSE'
)

foreach ($path in $required) {
  if (-not (Test-Path -LiteralPath (Join-Path $root $path))) {
    throw "Required project artifact is missing: $path"
  }
}

$manifest = Get-NfrManifest
if ($manifest.version -notmatch '^\d+\.\d+\.\d+$') {
  throw "Release manifest version must use semantic versioning."
}

& (Join-Path $root 'tests\quality.ps1')
Write-Host "Neon Fitting Room structural verification passed."
