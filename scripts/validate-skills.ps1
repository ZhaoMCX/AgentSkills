$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillsRoot = Join-Path $repoRoot "skills"
$errors = New-Object System.Collections.Generic.List[string]
$skillNames = New-Object System.Collections.Generic.HashSet[string]

if (-not (Test-Path -LiteralPath $skillsRoot)) {
    throw "Missing skills directory: $skillsRoot"
}

$categoryDirs = @(Get-ChildItem -LiteralPath $skillsRoot -Directory)

if ($categoryDirs.Count -eq 0) {
    $errors.Add("No skill categories found under skills/.")
}

foreach ($category in $categoryDirs) {
    $categorySkillFile = Join-Path $category.FullName "SKILL.md"
    if (Test-Path -LiteralPath $categorySkillFile) {
        $errors.Add("Category must not be a skill directory: $($category.Name)")
    }

    $skillDirs = @(Get-ChildItem -LiteralPath $category.FullName -Directory)
    if ($skillDirs.Count -eq 0) {
        $errors.Add("Category has no skills: $($category.Name)")
    }

    foreach ($skill in $skillDirs) {
        $skillFile = Join-Path $skill.FullName "SKILL.md"

        if (-not (Test-Path -LiteralPath $skillFile)) {
            $errors.Add("Missing SKILL.md: $($category.Name)/$($skill.Name)")
            continue
        }

        if (-not $skillNames.Add($skill.Name)) {
            $errors.Add("Duplicate skill name: $($skill.Name)")
        }

        $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $skillFile

        if ($content -notmatch "(?s)^---\s.*?name:\s*$([regex]::Escape($skill.Name))\s") {
            $errors.Add("SKILL.md name does not match directory: $($category.Name)/$($skill.Name)")
        }

        if ($content -notmatch "(?s)^---\s.*?description:\s*.+") {
            $errors.Add("Missing description in SKILL.md: $($category.Name)/$($skill.Name)")
        }
    }
}

$metaFiles = Get-ChildItem -LiteralPath $skillsRoot -Recurse -Force -Filter *.meta
foreach ($meta in $metaFiles) {
    $errors.Add("Unexpected Unity .meta file: $($meta.FullName)")
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "All skills passed validation."
