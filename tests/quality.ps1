[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$sourceRoot = Join-Path $root 'src\NeonFittingRoom'
$sourceFiles = @(Get-ChildItem -LiteralPath $sourceRoot -Filter '*.reds' -Recurse -File)

foreach ($file in $sourceFiles) {
  $lineNumber = 0
  foreach ($line in Get-Content -LiteralPath $file.FullName) {
    $lineNumber++
    if ($line.Length -gt 120) {
      throw "$($file.FullName):$lineNumber exceeds 120 characters."
    }
  }

  $lines = @(Get-Content -LiteralPath $file.FullName)
  $sourceText = $lines -join "`n"
  if ($sourceText -match '<<<<<<<|=======|>>>>>>>|TODO|FIXME|Phase\s+\d') {
    throw "$($file.FullName) contains a merge marker or planning marker."
  }

  for ($index = 0; $index -lt $lines.Count; $index++) {
    if ($lines[$index] -notmatch '^\s*(public|private|protected)\s+.*\b(class|func)\b') {
      continue
    }

    $docStart = [Math]::Max(0, $index - 16)
    $docBlock = $lines[$docStart..($index - 1)] -join "`n"
    if ($docBlock -notmatch '/\*\*') {
      throw "$($file.FullName):$($index + 1) is missing an immediate declaration docstring."
    }
    if ($lines[$index] -match '\bfunc\b') {
      foreach ($tag in '@param', '@return', '@errors') {
        if ($docBlock -notmatch [regex]::Escape($tag)) {
          throw "$($file.FullName):$($index + 1) is missing $tag in its function contract."
        }
      }
    }
  }
}

Write-Host "Quality checks passed for $($sourceFiles.Count) REDscript source file(s)."
