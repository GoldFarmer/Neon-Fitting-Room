[CmdletBinding()]
param(
  [string]$WkDaemonPath = $env:WKMCP_DAEMON
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot 'common.ps1')
$root = Get-NfrProjectRoot
$source = Join-Path $root 'assets\ink-source\nfr\ui\nfr_photomode_static_panel.inkwidget.json'
$resourceRoot = Join-Path $root 'build\ink\resources'
$compiledWidget = Join-Path $resourceRoot 'nfr\ui\nfr_photomode_static_panel.inkwidget'
$packedArchive = Join-Path $root 'build\ink\resources.archive'
$archive = Join-Path $root 'build\ink\NeonFittingRoom.archive'

function Invoke-NfrWkDaemon {
  param([string[]]$Arguments)

  $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
  $startInfo.FileName = 'dotnet'
  $startInfo.Arguments = "`"$WkDaemonPath`""
  $startInfo.UseShellExecute = $false
  $startInfo.RedirectStandardInput = $true
  $startInfo.RedirectStandardOutput = $true
  $startInfo.RedirectStandardError = $true
  $process = [System.Diagnostics.Process]::new()
  $process.StartInfo = $startInfo
  try {
    if (-not $process.Start()) { throw 'Could not start the WolvenKit daemon.' }
    $readyLine = $process.StandardOutput.ReadLine()
    if ([string]::IsNullOrWhiteSpace($readyLine)) {
      $daemonError = $process.StandardError.ReadToEnd()
      throw "WolvenKit daemon exited before reporting ready. $daemonError"
    }
    $ready = $readyLine | ConvertFrom-Json
    if (-not $ready.ready) { throw 'WolvenKit daemon did not report ready.' }
    $request = @{ id = 1; argv = $Arguments } | ConvertTo-Json -Compress
    $process.StandardInput.WriteLine($request)
    $process.StandardInput.Flush()
    while (-not $process.HasExited) {
      $line = $process.StandardOutput.ReadLine()
      if ([string]::IsNullOrWhiteSpace($line)) { continue }
      $response = $line | ConvertFrom-Json
      $exitProperty = $response.PSObject.Properties['exit']
      if ($response.id -eq 1 -and $null -ne $exitProperty) {
        if ($exitProperty.Value -ne 0) { throw "WolvenKit daemon failed: $($response.output)" }
        return $response
      }
    }
    throw 'WolvenKit daemon exited before completing the request.'
  } finally {
    if (-not $process.HasExited) { $process.Kill() }
    $process.Dispose()
  }
}

if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
  throw "NFR Ink source is missing: $source"
}

if ([string]::IsNullOrWhiteSpace($WkDaemonPath)) {
  $WkDaemonPath = 'C:\Tools\wkmcp\daemon\WkDaemon.dll'
}
if (-not (Test-Path -LiteralPath $WkDaemonPath -PathType Leaf)) {
  throw "WkMCP daemon was not found: $WkDaemonPath"
}

New-Item -ItemType Directory -Path $resourceRoot -Force | Out-Null
if (Test-Path -LiteralPath $compiledWidget -PathType Leaf) { Remove-Item -LiteralPath $compiledWidget -Force }
$conversionRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('nfr-ink-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $conversionRoot -Force | Out-Null
try {
  Invoke-NfrWkDaemon @('convert', 'deserialize', $source, '--outpath', $conversionRoot) | Out-Null
  $converted = Get-ChildItem -LiteralPath $conversionRoot -Recurse -File |
    Where-Object { $_.Extension -ne '.json' } |
    Select-Object -First 1
  if ($null -eq $converted) { throw 'WolvenKit did not produce an NFR Ink widget.' }
  New-Item -ItemType Directory -Path (Split-Path -Parent $compiledWidget) -Force | Out-Null
  Copy-Item -LiteralPath $converted.FullName -Destination $compiledWidget -Force
} finally {
  if (Test-Path -LiteralPath $conversionRoot) { Remove-Item -LiteralPath $conversionRoot -Recurse -Force }
}

Invoke-NfrWkDaemon @('pack', $resourceRoot, '--outpath', (Split-Path -Parent $archive)) | Out-Null
if (-not (Test-Path -LiteralPath $packedArchive -PathType Leaf)) {
  throw 'WolvenKit failed to pack NFR Ink resources.'
}

Copy-Item -LiteralPath $packedArchive -Destination $archive -Force
Write-Host "Built compiled NFR Ink archive at $archive"
