[CmdletBinding()]
param(
  [ValidateSet('Debug', 'Release')]
  [string]$BuildFlavor = 'Release'
)

. (Join-Path $PSScriptRoot 'common.ps1')
$root = Get-NfrProjectRoot
$manifest = Get-NfrManifest
$files = @(Get-NfrSourceFiles -BuildFlavor $BuildFlavor)
$flavor = $BuildFlavor.ToLowerInvariant()
$build = Join-Path $root 'build'
$stage = Join-Path $build "stage\$flavor"
$release = Join-Path $build $flavor
$packageName = "$($manifest.name)-$($manifest.version)-$flavor.zip"
$packagePath = Join-Path $release $packageName
$sourceRoot = Join-Path $root 'src\NeonFittingRoom'
$scriptsStage = Join-Path $stage 'r6\scripts\NeonFittingRoom'
$profile = Join-Path $root "tools\templates\NfrBuildProfile.$flavor.reds"
$backend = Join-Path $root "tools\templates\NfrLogBackend.$flavor.reds"
$inkArchive = Join-Path $root 'build\ink\NeonFittingRoom.archive'
$archiveStage = Join-Path $stage 'archive\pc\mod'

& (Join-Path $PSScriptRoot 'build-ink.ps1')

if (Test-Path -LiteralPath $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
if (-not (Test-Path -LiteralPath $inkArchive -PathType Leaf)) { throw 'NFR Ink build did not produce an archive.' }
New-Item -ItemType Directory -Path $scriptsStage -Force | Out-Null
New-Item -ItemType Directory -Path $archiveStage -Force | Out-Null
foreach ($file in $files) {
  $relative = $file.FullName.Substring($sourceRoot.Length).TrimStart('\')
  $target = Join-Path $scriptsStage $relative
  New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force | Out-Null
  Copy-Item -LiteralPath $file.FullName -Destination $target -Force
}
Copy-Item -LiteralPath $profile -Destination (Join-Path $scriptsStage 'NfrBuildProfile.reds') -Force
Copy-Item -LiteralPath $backend -Destination (Join-Path $scriptsStage 'diagnostics\NfrLogBackend.reds') -Force
Copy-Item -LiteralPath (Join-Path $root 'README.md') -Destination (Join-Path $scriptsStage 'README.md') -Force
Copy-Item -LiteralPath (Join-Path $root 'LICENSE') -Destination (Join-Path $scriptsStage 'LICENSE') -Force
Copy-Item -LiteralPath $inkArchive -Destination (Join-Path $archiveStage 'NeonFittingRoom.archive') -Force

New-Item -ItemType Directory -Path $release -Force | Out-Null
if (Test-Path -LiteralPath $packagePath) { Remove-Item -LiteralPath $packagePath -Force }
Compress-Archive -Path (Join-Path $stage 'r6'), (Join-Path $stage 'archive') -DestinationPath $packagePath -Force
$checksum = (Get-FileHash -LiteralPath $packagePath -Algorithm SHA256).Hash.ToLowerInvariant()
Set-Content -LiteralPath "$packagePath.sha256" -Value "$checksum  $packageName" -NoNewline

$verifyPath = Join-Path $stage '_verify'
Expand-Archive -LiteralPath $packagePath -DestinationPath $verifyPath -Force
if (-not (Test-Path -LiteralPath (Join-Path $verifyPath 'r6\scripts\NeonFittingRoom\core\NfrBuildMarker.reds'))) {
  throw 'Package validation failed: expected NFR build marker is missing.'
}
if (-not (Test-Path -LiteralPath (Join-Path $verifyPath 'r6\scripts\NeonFittingRoom\NfrBuildProfile.reds'))) {
  throw 'Package validation failed: expected generated NFR build profile is missing.'
}
if (-not (Test-Path -LiteralPath (Join-Path $verifyPath 'r6\scripts\NeonFittingRoom\diagnostics\NfrLogBackend.reds'))) {
  throw 'Package validation failed: expected generated NFR logging backend is missing.'
}
if (-not (Test-Path -LiteralPath (Join-Path $verifyPath 'archive\pc\mod\NeonFittingRoom.archive'))) {
  throw 'Package validation failed: expected compiled NFR Ink archive is missing.'
}
if (-not (Test-Path -LiteralPath (Join-Path $verifyPath 'r6\scripts\NeonFittingRoom\README.md')) -or
  -not (Test-Path -LiteralPath (Join-Path $verifyPath 'r6\scripts\NeonFittingRoom\LICENSE'))) {
  throw 'Package validation failed: expected NFR documentation is missing.'
}
if ($flavor -eq 'release') {
  $nativeCalls = Get-ChildItem -LiteralPath (Join-Path $verifyPath 'r6\scripts\NeonFittingRoom') -Filter '*.reds' -Recurse |
    Select-String -Pattern '(?<![A-Za-z])(FTLog|FTLogWarning|FTLogError)\s*\('
  if ($nativeCalls) { throw 'Package validation failed: release scripts must not call debug logging APIs.' }
}
Remove-Item -LiteralPath $verifyPath -Recurse -Force
Write-Host "Created $packagePath"
Write-Host "SHA-256: $checksum"
