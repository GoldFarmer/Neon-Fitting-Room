[CmdletBinding(SupportsShouldProcess)]
param(
  [Parameter(Mandatory = $true)]
  [string]$GameDir,
  [ValidateSet('Debug', 'Release')]
  [string]$BuildFlavor = 'Debug',
  [switch]$SkipInkBuild,
  [switch]$SkipRedscriptCompile
)

. (Join-Path $PSScriptRoot 'common.ps1')
Assert-NfrGameRoot -GameDir $GameDir
$root = Get-NfrProjectRoot
$files = @(Get-NfrSourceFiles -BuildFlavor $BuildFlavor)
$destination = Join-Path $GameDir 'r6\scripts\NeonFittingRoom'
$inkArchive = Join-Path $root 'build\ink\NeonFittingRoom.archive'
$inkDestination = Join-Path $GameDir 'archive\pc\mod\NeonFittingRoom.archive'
$declarations = Join-Path $GameDir 'r6\scripts\Logs.reds'
$profile = Join-Path $root "tools\templates\NfrBuildProfile.$($BuildFlavor.ToLowerInvariant()).reds"
$backend = Join-Path $root "tools\templates\NfrLogBackend.$($BuildFlavor.ToLowerInvariant()).reds"
$declarationTemplate = Join-Path $root 'tools\templates\Logs.reds'

if (-not $SkipInkBuild) {
  & (Join-Path $PSScriptRoot 'build-ink.ps1')
}

if ($PSCmdlet.ShouldProcess($destination, 'Install unbundled Neon Fitting Room REDscript sources')) {
  # A partial copy leaves deleted or experimental .reds files compiled by REDscript. Replace only
  # NFR's own destination so the installed source tree exactly matches this build.
  if (Test-Path -LiteralPath $destination -PathType Container) {
    Remove-Item -LiteralPath $destination -Recurse -Force
  }
  New-Item -ItemType Directory -Path $destination -Force | Out-Null
  $sourceRoot = Join-Path $root 'src\NeonFittingRoom'
  foreach ($file in $files) {
    $relative = $file.FullName.Substring($sourceRoot.Length).TrimStart('\')
    $target = Join-Path $destination $relative
    New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force | Out-Null
    Copy-Item -LiteralPath $file.FullName -Destination $target -Force
  }
  Copy-Item -LiteralPath $profile -Destination (Join-Path $destination 'NfrBuildProfile.reds') -Force
  Copy-Item -LiteralPath $backend -Destination (Join-Path $destination 'diagnostics\NfrLogBackend.reds') -Force
  $generatedCount = 2
  Write-Host "Installed $($files.Count + $generatedCount) $BuildFlavor NFR script file(s) beneath $destination."
}

if ($BuildFlavor -eq 'Debug' -and -not (Test-Path -LiteralPath $declarations -PathType Leaf)) {
  if ($PSCmdlet.ShouldProcess($declarations, 'Create shared debug logging declarations')) {
    Copy-Item -LiteralPath $declarationTemplate -Destination $declarations
    Write-Host "Created shared debug logging declarations at $declarations."
  }
}

if ($BuildFlavor -eq 'Release' -and (Test-Path -LiteralPath $declarations -PathType Leaf)) {
  $existing = Get-Content -LiteralPath $declarations -Raw
  $template = Get-Content -LiteralPath $declarationTemplate -Raw
  if ($existing -eq $template -and $PSCmdlet.ShouldProcess($declarations, 'Remove NFR-created logging declarations')) {
    Remove-Item -LiteralPath $declarations -Force
    Write-Host "Removed NFR-created debug logging declarations at $declarations."
  }
}

if ($SkipRedscriptCompile) {
  Write-Host 'Skipped REDscript compiler preflight.'
} else {
  & (Join-Path $PSScriptRoot 'compile-redscript.ps1') -GameDir $GameDir
}

if ($SkipInkBuild) {
  Write-Host 'Skipped compiled Ink archive rebuild and installation.'
  return
}

if (-not (Test-Path -LiteralPath $inkArchive -PathType Leaf)) { throw 'NFR Ink build did not produce an archive.' }

if (Test-Path -LiteralPath $inkDestination -PathType Leaf) {
  $sourceHash = (Get-FileHash -LiteralPath $inkArchive -Algorithm SHA256).Hash
  $destinationHash = (Get-FileHash -LiteralPath $inkDestination -Algorithm SHA256).Hash
  if ($sourceHash -eq $destinationHash) {
    Write-Host "Compiled NFR Ink archive is already installed and unchanged."
    return
  }
}

if ($PSCmdlet.ShouldProcess($inkDestination, 'Install NFR compiled Ink archive')) {
  New-Item -ItemType Directory -Path (Split-Path -Parent $inkDestination) -Force | Out-Null
  Copy-Item -LiteralPath $inkArchive -Destination $inkDestination -Force
  Write-Host "Installed compiled NFR Ink archive at $inkDestination."
}
