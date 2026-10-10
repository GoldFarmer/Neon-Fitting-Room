[CmdletBinding()]
param(
  [switch]$Check
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot 'common.ps1')
$root = Get-NfrProjectRoot
$sourceRoot = Join-Path $root 'src\NeonFittingRoom'

function Get-TaggedValue {
  param([string[]]$Lines, [string]$Tag)
  $matches = @($Lines | Where-Object { $_ -match "@${Tag}\s+(.+?)\s*(?:\*/)?$" })
  if ($matches.Count -ne 1) { return $null }
  [void]($matches[0] -match "@${Tag}\s+(.+?)\s*(?:\*/)?$")
  return $matches[1].Trim()
}

function Get-TaggedValues {
  param([string[]]$Lines, [string]$Tag)
  $values = @()
  foreach ($line in $Lines) {
    if ($line -match "@${Tag}\s+(.+?)\s*(?:\*/)?$") { $values += $matches[1].Trim() }
  }
  return $values
}

function Get-AnnotationMetadataList {
  param([string[]]$Lines, [string]$Tag, [string]$Location)
  $cleanLines = @()
  foreach ($line in $Lines) {
    $clean = $line -replace '^\s*/\*\*\s?', ''
    $clean = $clean -replace '^\s*\*\s?', ''
    $clean = $clean -replace '\s*\*/\s*$', ''
    $cleanLines += $clean
  }
  $text = $cleanLines -join "`n"
  $annotations = @([regex]::Matches($text, "(?ms)@$Tag\s+(\{.*?\})"))
  $values = @()
  foreach ($annotation in $annotations) {
    try { $values += ,($annotation.Groups[1].Value | ConvertFrom-Json) }
    catch { throw "Invalid @$Tag JSON at ${Location}: $($_.Exception.Message)" }
  }
  return $values
}

function Get-AnnotationMetadata {
  param([string[]]$Lines, [string]$Tag, [string]$Location)
  $values = @(Get-AnnotationMetadataList $Lines $Tag $Location)
  if ($values.Count -eq 0) { return $null }
  if ($values.Count -ne 1) { throw "Multiple @$Tag annotations appear at $Location." }
  return $values[0]
}

function Assert-MultilineAnnotation {
  param([string[]]$Lines, [string]$Tag, [string]$Location)
  foreach ($line in $Lines) {
    if ($line -match "@$Tag\s+\{") {
      if ($line -notmatch "^\s*\*\s*@$Tag\s+\{\s*$") {
        throw "@$Tag at $Location must begin on its own docstring line."
      }
      return
    }
  }
}

function Assert-AnnotationFields {
  param($Metadata, [string[]]$Required, [string[]]$Allowed, [string]$Tag, [string]$Location)
  foreach ($field in $Required) {
    if ($null -eq $Metadata.PSObject.Properties[$field]) {
      throw "@$Tag at $Location is missing '$field'."
    }
    $value = $Metadata.$field
    if ($value -isnot [array] -and [string]::IsNullOrWhiteSpace([string]$value)) {
      throw "@$Tag at $Location is missing '$field'."
    }
  }
  foreach ($property in $Metadata.PSObject.Properties) {
    if ($property.Name -notin $Allowed) {
      throw "@$Tag at $Location contains unsupported field '$($property.Name)'."
    }
  }
}

function Add-DependencyRecord {
  param(
    [System.Collections.Specialized.OrderedDictionary]$Values,
    [string]$Location,
    [System.Collections.Specialized.OrderedDictionary]$Records
  )
  if ($Values.Count -eq 0) { return }
  if (-not $Values.Contains('modules')) { $Values.modules = @() }
  $required = @('id', 'name', 'requirement', 'relationship', 'url', 'role', 'surfaces')
  foreach ($field in $required) {
    if (-not $Values.Contains($field) -or [string]::IsNullOrWhiteSpace($Values[$field])) {
      throw "Dependency metadata at $Location is missing '$field'."
    }
  }
  if ($Values.requirement -notin @('required', 'optional')) {
    throw "Dependency '$($Values.id)' has unsupported requirement '$($Values.requirement)'."
  }
  if ($Records.Contains($Values.id)) { throw "Duplicate dependency id '$($Values.id)'." }
  $Records[$Values.id] = [pscustomobject]$Values
}

$dependencies = [ordered]@{}
$hooks = @()
$injectionContracts = @()
$injections = @()
$externalModules = @()
$moduleGuards = @()
$dependencyUses = @()
foreach ($file in Get-ChildItem -LiteralPath $sourceRoot -Recurse -File -Filter '*.reds') {
  $lines = @(Get-Content -LiteralPath $file.FullName)
  $relative = $file.FullName.Substring($root.Length + 1).Replace('\', '/')
  $sourceText = $lines -join "`n"
  if ($sourceText -match '(?m)\*/\n\s*\n(?=\s*(?:@if\(|@(wrapMethod|replaceMethod|addMethod|addField)\(|public\s|private\s|protected\s))') {
    throw "A docstring is separated from its declaration by a blank line in $relative."
  }
  $lastDoc = @()
  $lastDocEnd = -1
  $inDoc = $false
  $doc = @()

  for ($index = 0; $index -lt $lines.Count; $index += 1) {
    $line = $lines[$index]
    if ($line -match '^\s*import\s+([A-Za-z0-9_]+)[\.{]') {
      $externalModules += [pscustomobject]@{ Module = $matches[1]; Location = "${relative}:$($index + 1)" }
    }
    if ($line -match 'ModuleExists\("([^"]+)"\)') {
      $externalModules += [pscustomobject]@{ Module = $matches[1]; Location = "${relative}:$($index + 1)" }
      $guardModule = $matches[1]
      if ($lastDocEnd -ne $index - 1) {
        throw "ModuleExists('$guardModule') at ${relative}:$($index + 1) has no immediately adjacent docstring."
      }
      $guardDependencies = @(Get-AnnotationMetadataList $lastDoc 'dependencies' "${relative}:$($index + 1)")
      if ($guardDependencies.Count -eq 0) {
        throw "ModuleExists('$guardModule') at ${relative}:$($index + 1) has no @dependencies annotation."
      }
      $moduleGuards += [pscustomobject]@{
        Module = $guardModule
        DependencyIds = @($guardDependencies | ForEach-Object { [string]$_.id })
        Location = "${relative}:$($index + 1)"
      }
    }
    if (-not $inDoc -and $line -match '^\s*/\*\*') {
      $inDoc = $true
      $doc = @($line)
    } elseif ($inDoc) {
      $doc += $line
    }
    if ($inDoc -and $line -match '\*/\s*$') {
      $inDoc = $false
      $lastDoc = $doc
      $lastDocEnd = $index
      $location = "${relative}:$($index + 1)"
      $providerMetadataList = @(Get-AnnotationMetadataList $doc 'dependencyProvider' $location)
      if ($providerMetadataList.Count -gt 0) {
        Assert-MultilineAnnotation $doc 'dependencyProvider' $location
        foreach ($providerMetadata in $providerMetadataList) {
          Assert-AnnotationFields $providerMetadata `
            @('id', 'name', 'requirement', 'relationship', 'url', 'modules', 'surfaces', 'role') `
            @('id', 'name', 'requirement', 'relationship', 'url', 'modules', 'surfaces', 'role') `
            'dependencyProvider' $location
          $providerModules = @()
          if ($null -ne $providerMetadata.PSObject.Properties['modules']) {
            $providerModules = @($providerMetadata.modules)
          }
          $providerValues = [ordered]@{
            id = [string]$providerMetadata.id
            name = [string]$providerMetadata.name
            requirement = [string]$providerMetadata.requirement
            relationship = [string]$providerMetadata.relationship
            url = [string]$providerMetadata.url
            role = [string]$providerMetadata.role
            surfaces = @($providerMetadata.surfaces)
            modules = $providerModules
          }
          Add-DependencyRecord $providerValues $location $dependencies
        }
      }
      $dependencyMetadataList = @(Get-AnnotationMetadataList $doc 'dependencies' $location)
      foreach ($dependencyMetadata in $dependencyMetadataList) {
        Assert-MultilineAnnotation $doc 'dependencies' $location
        Assert-AnnotationFields $dependencyMetadata @('id', 'adopted', 'min') @('id', 'adopted', 'min') `
          'dependencies' $location
        $dependencyUses += [pscustomobject]@{
          Id = [string]$dependencyMetadata.id
          Adopted = [string]$dependencyMetadata.adopted
          Minimum = [string]$dependencyMetadata.min
          Location = "${relative}:$($index + 1)"
        }
      }
      continue
    }

    if ($line -notmatch '^\s*@(wrapMethod|replaceMethod|addMethod|addField)\(([^)]+)\)') { continue }
    $kind = $matches[1]
    $targetClass = $matches[2]
    if ($kind -in @('addMethod', 'addField')) {
      if ($lastDocEnd -lt 0) { throw "$kind at ${relative}:$($index + 1) has no docstring." }
      for ($between = $lastDocEnd + 1; $between -lt $index; $between += 1) {
        if ($lines[$between] -notmatch '^\s*@if\(.+\)\s*$') {
          throw "$kind at ${relative}:$($index + 1) is not immediately associated with its docstring."
        }
      }
      $dependencyMetadataList = @(Get-AnnotationMetadataList $lastDoc 'dependencies' "${relative}:$($index + 1)")
      if ($dependencyMetadataList.Count -eq 0) {
        throw "$kind target '$targetClass' at ${relative}:$($index + 1) has no @dependencies annotation."
      }
      $dependencyMetadata = @($dependencyMetadataList | Where-Object id -eq 'cp2077')[0]
      if ($null -eq $dependencyMetadata) { $dependencyMetadata = $dependencyMetadataList[0] }
      Assert-MultilineAnnotation $lastDoc 'dependencies' "${relative}:$($index + 1)"
      Assert-AnnotationFields $dependencyMetadata @('id', 'adopted', 'min') @('id', 'adopted', 'min') `
        'dependencies' "${relative}:$($index + 1)"
      $injections += [pscustomobject]@{
        Kind = $kind; Target = $targetClass; Location = "${relative}:$($index + 1)"; File = $relative
      }
      $injectionContracts += [pscustomobject]@{
        File = $relative; Target = $targetClass; Provider = [string]$dependencyMetadata.id
        AdoptedVersion = [string]$dependencyMetadata.adopted; MinimumVersion = [string]$dependencyMetadata.min
        Location = "${relative}:$($index + 1)"
      }
      continue
    }
    if ($lastDocEnd -lt 0) { throw "Hook at ${relative}:$($index + 1) has no docstring." }
    for ($between = $lastDocEnd + 1; $between -lt $index; $between += 1) {
      if ($lines[$between] -notmatch '^\s*@if\(.+\)\s*$') {
        throw "Hook at ${relative}:$($index + 1) is not immediately associated with its docstring."
      }
    }
    $method = $null
    for ($scan = $index + 1; $scan -lt [Math]::Min($lines.Count, $index + 12); $scan += 1) {
      if ($lines[$scan] -match '\bfunc\s+([A-Za-z0-9_]+)') { $method = $matches[1]; break }
    }
    if (-not $method) { throw "Could not resolve hook method at ${relative}:$($index + 1)." }
    $actualTarget = "$targetClass.$method"
    $dependencyMetadataList = @(Get-AnnotationMetadataList $lastDoc 'dependencies' "${relative}:$($index + 1)")
    if ($dependencyMetadataList.Count -eq 0) {
      throw "Hook $actualTarget at ${relative}:$($index + 1) has no @dependencies annotation."
    }
    $dependencyMetadata = @($dependencyMetadataList | Where-Object id -eq 'cp2077')[0]
    if ($null -eq $dependencyMetadata) { $dependencyMetadata = $dependencyMetadataList[0] }
    Assert-MultilineAnnotation $lastDoc 'dependencies' "${relative}:$($index + 1)"
    Assert-AnnotationFields $dependencyMetadata @('id', 'adopted', 'min') @('id', 'adopted', 'min') `
      'dependencies' "${relative}:$($index + 1)"
    $target = $actualTarget
    $provider = [string]$dependencyMetadata.id
    $adoptedVersion = [string]$dependencyMetadata.adopted
    $minimumVersion = [string]$dependencyMetadata.min
    foreach ($entry in ([ordered]@{
      id = $provider
      adopted = $adoptedVersion
      min = $minimumVersion
    }).GetEnumerator()) {
      if ([string]::IsNullOrWhiteSpace([string]$entry.Value)) {
        throw "Hook $actualTarget at ${relative}:$($index + 1) has incomplete @dependencies metadata: '$($entry.Key)'."
      }
    }
    $hooks += [pscustomobject]@{
      Kind = $kind
      Target = $target
      Provider = $provider
      AdoptedVersion = $adoptedVersion
      MinimumVersion = $minimumVersion
      Location = "${relative}:$($index + 1)"
    }
  }
}

if ($dependencies.Count -eq 0) { throw 'No @dependencyProvider records were found.' }
foreach ($dependency in $dependencies.Values) {
  $uses = @($dependencyUses | Where-Object Id -eq $dependency.id)
  if ($uses.Count -eq 0) { throw "Provider '$($dependency.id)' has no @dependencies usage annotation." }
  $adoptedVersion = @($uses.Adopted | Sort-Object { try { [version]$_ } catch { [version]'0.0' } })[-1]
  $knownMinimums = @($uses.Minimum | Where-Object { $_ -ne 'TBD' })
  if (@($uses.Minimum | Where-Object { $_ -eq 'TBD' }).Count -gt 0) {
    $minimumVersion = 'TBD'
  } else {
    $minimumVersion = @($knownMinimums | Sort-Object { try { [version]$_ } catch { [version]'0.0' } })[-1]
  }
  $dependency | Add-Member -NotePropertyName adopted -NotePropertyValue $adoptedVersion
  $dependency | Add-Member -NotePropertyName minimum -NotePropertyValue $minimumVersion
}
foreach ($use in $dependencyUses) {
  if (-not $dependencies.Contains($use.Id)) {
    throw "@dependencies at $($use.Location) references undeclared provider '$($use.Id)'."
  }
}
foreach ($hook in $hooks) {
  if (-not $dependencies.Contains($hook.Provider)) {
    throw "Hook '$($hook.Target)' names undeclared provider '$($hook.Provider)'."
  }
  $hook.Provider = $dependencies[$hook.Provider].name
}
foreach ($contract in $injectionContracts) {
  if (-not $dependencies.Contains($contract.Provider)) {
    throw "Injection contract '$($contract.Target)' names undeclared provider '$($contract.Provider)'."
  }
  $contract.Provider = $dependencies[$contract.Provider].name
}
foreach ($moduleUse in $externalModules) {
  if (-not @($dependencies.Values | Where-Object { $_.modules -contains $moduleUse.Module })) {
    throw "External module '$($moduleUse.Module)' at $($moduleUse.Location) has no declaring dependency contract."
  }
}
foreach ($guard in $moduleGuards) {
  $provider = @($dependencies.Values | Where-Object { $_.modules -contains $guard.Module })
  if ($provider.Count -ne 1) {
    throw "ModuleExists('$($guard.Module)') at $($guard.Location) does not map to exactly one provider."
  }
  if ($guard.DependencyIds -notcontains $provider[0].id) {
    throw "ModuleExists('$($guard.Module)') at $($guard.Location) lacks @dependencies metadata for '$($provider[0].id)'."
  }
}

function Get-VersionText {
  param($Dependency)
  if ($Dependency.minimum -eq 'TBD') {
    return "minimum TBD; adopted at $($Dependency.adopted)"
  }
  return "minimum $($Dependency.minimum); adopted at $($Dependency.adopted)"
}

function Set-GeneratedFile {
  param([string]$Path, [string]$Content)
  $normalized = ($Content.TrimEnd() + "`r`n")
  if ($Check) {
    if (-not (Test-Path -LiteralPath $Path)) { throw "Generated file is missing: $Path" }
    $existing = (Get-Content -LiteralPath $Path -Raw).Replace("`r`n", "`n").TrimEnd()
    if ($existing -ne $normalized.Replace("`r`n", "`n").TrimEnd()) {
      throw "Generated dependency artifact is stale: $Path"
    }
    return
  }
  [IO.File]::WriteAllText($Path, $normalized)
}

function Set-GeneratedSection {
  param([string]$Path, [string]$Start, [string]$End, [string]$Content)
  $raw = Get-Content -LiteralPath $Path -Raw
  $pattern = '(?s)' + [regex]::Escape($Start) + '.*?' + [regex]::Escape($End)
  $replacement = $Start + "`r`n" + $Content.TrimEnd() + "`r`n" + $End
  if ($raw -notmatch $pattern) { throw "Generated dependency markers are missing from $Path" }
  $expected = [regex]::Replace($raw, $pattern, [System.Text.RegularExpressions.MatchEvaluator]{ param($m) $replacement })
  if ($Check) {
    if ($raw.Replace("`r`n", "`n") -ne $expected.Replace("`r`n", "`n")) {
      throw "Generated dependency section is stale: $Path"
    }
    return
  }
  [IO.File]::WriteAllText($Path, $expected)
}

$dependencyRows = @()
foreach ($dependency in $dependencies.Values) {
  $dependencyRows += "| [$($dependency.name)]($($dependency.url)) | $($dependency.requirement) | $($dependency.relationship) | $($dependency.adopted) | $($dependency.minimum) | $($dependency.role) |"
}
$hookRows = @()
foreach ($hook in $hooks | Sort-Object Target, Location) {
  $hookRows += "| ``$($hook.Target)`` | $($hook.Kind) | $($hook.Provider) | $($hook.AdoptedVersion) | $($hook.MinimumVersion) | ``$($hook.Location)`` |"
}
$injectionRows = @()
foreach ($contract in $injectionContracts | Sort-Object File, Target -Unique) {
  $count = @($injections | Where-Object { $_.File -eq $contract.File -and $_.Target -eq $contract.Target }).Count
  $kinds = @(($injections | Where-Object { $_.File -eq $contract.File -and $_.Target -eq $contract.Target }).Kind | Sort-Object -Unique)
  $injectionRows += "| ``$($contract.Target)`` | $($kinds -join ', ') | $count | $($contract.Provider) | $($contract.AdoptedVersion) | $($contract.MinimumVersion) | ``$($contract.Location)`` |"
}
$surfaceRows = @()
foreach ($dependency in $dependencies.Values) {
  foreach ($surface in $dependency.surfaces) {
    $surfaceRows += "| $($dependency.name) | ``$surface`` | $($dependency.adopted) | $($dependency.minimum) |"
  }
}
$matrix = @"
# Neon Fitting Room — Generated Dependency Matrix

This file is generated by ``tools/generate-dependencies.ps1`` from implementation docstrings.
Do not edit dependency versions here. ``TBD`` means the first compatible provider version has not
been established deterministically; it does not mean that every older version is supported.

## Runtime providers

| Provider | Requirement | Relationship | Version when adopted | Minimum version | Role |
| --- | --- | --- | --- | --- | --- |
$($dependencyRows -join "`r`n")

## REDscript method hooks

| Target | Integration | Provider | Version when adopted | Minimum version | Source |
| --- | --- | --- | --- | --- | --- |
$($hookRows -join "`r`n")

## REDscript class injections

| Target class | Integration | Count | Provider | Version when adopted | Minimum version | Contract source |
| --- | --- | ---: | --- | --- | --- | --- |
$($injectionRows -join "`r`n")

## Consumed dependency surfaces

| Provider | API, type, data, or integration surface | Version when adopted | Minimum version |
| --- | --- | --- | --- |
$($surfaceRows -join "`r`n")

## Validation policy

- The source docstrings are authoritative; this matrix is derived output.
- A known minimum is an evidence-backed compatibility floor. A development version is not silently
  treated as a minimum.
- Required transitive providers are listed because users must install them even when NFR does not
  call their APIs directly.
- Recommended companion mods are documented separately and are not runtime dependencies.
"@
Set-GeneratedFile (Join-Path $root 'docs\dependency-matrix.md') $matrix

$requiredMarkdown = @()
$optionalMarkdown = @()
foreach ($dependency in $dependencies.Values) {
  $line = "- [$($dependency.name)]($($dependency.url)) — $($dependency.role) ($((Get-VersionText $dependency)))."
  if ($dependency.requirement -eq 'required') { $requiredMarkdown += $line } else { $optionalMarkdown += $line }
}
$readmeSection = @"
<!-- Generated by tools/generate-dependencies.ps1 from REDscript docstrings. -->

Required:

$($requiredMarkdown -join "`r`n")

Optional integrations:

$($optionalMarkdown -join "`r`n")
"@
Set-GeneratedSection (Join-Path $root 'README.md') '<!-- NFR-GENERATED-DEPENDENCIES:START -->' '<!-- NFR-GENERATED-DEPENDENCIES:END -->' $readmeSection

$requiredBbcode = @('[b]Required[/b]', '[list]')
$optionalBbcode = @('[b]Optional integrations[/b]', '[list]')
foreach ($dependency in $dependencies.Values) {
  $version = Get-VersionText $dependency
  $line = "[*][url=$($dependency.url)]$($dependency.name)[/url] — $($dependency.role) ($version)."
  if ($dependency.requirement -eq 'required') { $requiredBbcode += $line } else { $optionalBbcode += $line }
}
$requiredBbcode += '[/list]'
$optionalBbcode += '[/list]'
$nexusSection = @"
<!-- Generated by tools/generate-dependencies.ps1 from REDscript docstrings. -->
$($requiredBbcode -join "`r`n")

$($optionalBbcode -join "`r`n")
"@
Set-GeneratedSection (Join-Path $root 'release\nexus-listing.bbcode') '<!-- NFR-GENERATED-DEPENDENCIES:START -->' '<!-- NFR-GENERATED-DEPENDENCIES:END -->' $nexusSection

$manifestPath = Join-Path $root 'release\manifest-template.json'
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$manifestDependencies = [ordered]@{}
foreach ($dependency in $dependencies.Values) {
  $manifestDependencies[$dependency.id] = [ordered]@{
    name = $dependency.name
    requirement = $dependency.requirement
    relationship = $dependency.relationship
    adoptedVersion = $dependency.adopted
    minimumVersion = $dependency.minimum
    url = $dependency.url
  }
}
$manifest.dependencies = $manifestDependencies
$manifestText = $manifest | ConvertTo-Json -Depth 8
Set-GeneratedFile $manifestPath $manifestText

Write-Host "Validated $($dependencies.Count) dependency record(s), $($hooks.Count) interception contract(s), and $($injections.Count) class injection(s)."
if (-not $Check) { Write-Host 'Generated dependency documentation and release metadata.' }
