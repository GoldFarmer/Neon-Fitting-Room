[CmdletBinding()]
param()

$root = Split-Path -Parent $PSScriptRoot
$checklist = Join-Path $root 'docs\smoke-test.md'
Write-Host "Use the versioned in-game checklist: $checklist"
