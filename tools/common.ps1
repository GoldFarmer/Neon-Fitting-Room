Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-NfrProjectRoot {
  return Split-Path -Parent $PSScriptRoot
}

function Get-NfrManifest {
  $manifestPath = Join-Path (Get-NfrProjectRoot) 'release\manifest-template.json'
  return Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
}

function Assert-NfrGameRoot {
  param([Parameter(Mandatory = $true)][string]$GameDir)

  $gameExecutable = Join-Path $GameDir 'bin\x64\Cyberpunk2077.exe'
  $scriptDirectory = Join-Path $GameDir 'r6\scripts'
  if (-not (Test-Path -LiteralPath $gameExecutable -PathType Leaf) -or
      -not (Test-Path -LiteralPath $scriptDirectory -PathType Container)) {
    throw "GameDir must be a Cyberpunk 2077 game root: $GameDir"
  }
}

function Get-NfrSourceFiles {
  param(
    [ValidateSet('Debug', 'Release')]
    [string]$BuildFlavor = 'Debug'
  )

  $sourceRoot = Join-Path (Get-NfrProjectRoot) 'src\NeonFittingRoom'
  if (-not (Test-Path -LiteralPath $sourceRoot -PathType Container)) {
    throw "NFR source directory is missing: $sourceRoot"
  }

  $files = @(Get-ChildItem -LiteralPath $sourceRoot -Filter '*.reds' -Recurse -File)
  if ($files.Count -eq 0) {
    throw "NFR source directory contains no REDscript files: $sourceRoot"
  }

  return $files
}
