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
    if (
      $index -gt 0 -and
      $lines[$index] -match '^\s*/\*\*' -and
      $lines[$index - 1] -notmatch '^\s*$'
    ) {
      throw "$($file.FullName):$($index + 1) docstring must have one blank line before it."
    }

    if (
      $index -gt 1 -and
      $lines[$index] -match '^\s*/\*\*' -and
      $lines[$index - 1] -match '^\s*$' -and
      $lines[$index - 2] -match '^\s*$'
    ) {
      throw "$($file.FullName):$($index + 1) docstring has more than one blank line before it."
    }

    if ($lines[$index] -match '^\s*/\*\*\s+\*') {
      throw "$($file.FullName):$($index + 1) has a malformed docstring opening."
    }

    if ($lines[$index] -notmatch '^\s*(public|private|protected)\s+.*\b(class|func)\b') {
      continue
    }

    # The centralized provider catalog is intentionally longer than ordinary declaration docs.
    # Keep the bound finite while allowing its complete structured metadata block.
    $docStart = [Math]::Max(0, $index - 192)
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
