[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [string]$GameDir
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot 'common.ps1')
Assert-NfrGameRoot -GameDir $GameDir

$root = Get-NfrProjectRoot
$compiler = Join-Path $GameDir 'engine\tools\scc.exe'
$scriptRoot = Join-Path $GameDir 'r6\scripts'
$pluginRoot = Join-Path $GameDir 'red4ext\plugins'
$baseline = Join-Path $GameDir 'r6\cache\modded\final.redscripts'
$preflightRoot = Join-Path $root 'build\redscript-preflight'
$preflightCache = Join-Path $preflightRoot 'cache'
$compilePathsFile = Join-Path $preflightRoot 'plugin-script-paths.txt'
$outputLog = Join-Path $preflightRoot 'compiler-output.log'
$errorLog = Join-Path $preflightRoot 'compiler-error.log'

if (-not (Test-Path -LiteralPath $compiler -PathType Leaf)) {
  throw "REDscript compiler is missing: $compiler"
}
if (-not (Test-Path -LiteralPath $baseline -PathType Leaf)) {
  throw "The modded REDscript baseline is missing. Start the game once to create: $baseline"
}

New-Item -ItemType Directory -Path $preflightCache -Force | Out-Null

# The compiler treats final.redscripts as its immutable engine/RTTI baseline and writes the
# compiled mod result beside it. Keep both artifacts isolated from the cache used to launch.
Copy-Item -LiteralPath $baseline -Destination (Join-Path $preflightCache 'final.redscripts') -Force
foreach ($name in @('final.redscripts.bk', 'final.redscripts.modded', 'final.redscripts.ts')) {
  $stalePath = Join-Path $preflightCache $name
  if (Test-Path -LiteralPath $stalePath -PathType Leaf) {
    Remove-Item -LiteralPath $stalePath -Force
  }
}

# RED4ext supplies these paths to the startup compiler after native plugins register their script
# declarations. Reproduce the path set explicitly so Codeware and other dependency APIs resolve.
$pluginScripts = @()
if (Test-Path -LiteralPath $pluginRoot -PathType Container) {
  $pluginScripts = @(Get-ChildItem -LiteralPath $pluginRoot -Filter '*.reds' -Recurse -File |
    Sort-Object -Property FullName |
    ForEach-Object { $_.FullName })
}
[System.IO.File]::WriteAllLines($compilePathsFile, [string[]]$pluginScripts)

$arguments = @(
  '-compile', $scriptRoot,
  '-customCacheDir', $preflightCache,
  '-compilePathsFile', $compilePathsFile,
  '-Wnone',
  '-threads', '4',
  '-no-testonly',
  '-no-breakpoint',
  '-profile=off'
)

$startInfo = [System.Diagnostics.ProcessStartInfo]::new()
$startInfo.FileName = $compiler
$startInfo.WorkingDirectory = $GameDir
$startInfo.UseShellExecute = $false
$startInfo.CreateNoWindow = $true
$startInfo.RedirectStandardOutput = $true
$startInfo.RedirectStandardError = $true
foreach ($argument in $arguments) {
  [void]$startInfo.ArgumentList.Add($argument)
}
$process = [System.Diagnostics.Process]::new()
$process.StartInfo = $startInfo
if (-not $process.Start()) {
  throw 'Could not start the REDscript compiler.'
}
$standardOutput = $process.StandardOutput.ReadToEndAsync()
$standardError = $process.StandardError.ReadToEndAsync()
$process.WaitForExit()
[System.IO.File]::WriteAllText($outputLog, $standardOutput.GetAwaiter().GetResult())
[System.IO.File]::WriteAllText($errorLog, $standardError.GetAwaiter().GetResult())

$compilerOutput = if (Test-Path -LiteralPath $outputLog -PathType Leaf) {
  Get-Content -LiteralPath $outputLog -Raw
} else {
  ''
}
$compilerOutput += if (Test-Path -LiteralPath $errorLog -PathType Leaf) {
  Get-Content -LiteralPath $errorLog -Raw
} else {
  ''
}
$errors = @($compilerOutput -split "`r?`n" | Where-Object { $_ -match '^\[ERROR\b' })
if ($process.ExitCode -ne 0 -or $errors.Count -gt 0) {
  $nfrDiagnostics = @($compilerOutput -split "`r?`n" |
    Select-String -Pattern 'NeonFittingRoom|\[ERROR' -Context 0, 3 |
    ForEach-Object { $_.ToString() })
  if ($nfrDiagnostics.Count -gt 0) {
    Write-Host ($nfrDiagnostics -join [Environment]::NewLine)
  }
  throw "REDscript preflight failed. Full compiler output: $outputLog"
}

Write-Host "REDscript preflight passed with $($pluginScripts.Count) RED4ext plugin declaration file(s)."
