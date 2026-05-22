param(
    [Parameter(Mandatory = $true)]
    [string]$Topic,

    [string]$OutputRoot = "dist\topics",

    [string]$Message
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$topicsFile = Join-Path $repoRoot "topics.json"

if (-not (Test-Path -LiteralPath $topicsFile)) {
    throw "Missing topics manifest: $topicsFile"
}

$topics = Get-Content -Raw -LiteralPath $topicsFile | ConvertFrom-Json
$topicConfig = $topics.PSObject.Properties[$Topic]

if ($null -eq $topicConfig) {
    $available = ($topics.PSObject.Properties.Name | Sort-Object) -join ", "
    throw "Unknown topic '$Topic'. Available topics: $available"
}

$repository = $topicConfig.Value.repository
$commitMessage = if ($Message) { $Message } else { "Sync $Topic from AgentSkills" }

$outputRootPath = if ([System.IO.Path]::IsPathRooted($OutputRoot)) {
    $OutputRoot
} else {
    Join-Path $repoRoot $OutputRoot
}

$target = Join-Path $outputRootPath $Topic

& (Join-Path $PSScriptRoot "export-topic.ps1") -Topic $Topic -OutputRoot $OutputRootPath

git -C $target init | Out-Host
git -C $target branch -M main | Out-Host
git -C $target remote add origin "https://github.com/$repository.git" | Out-Host

git -C $target fetch origin main | Out-Host
if ($LASTEXITCODE -ne 0) {
    $description = $topicConfig.Value.description
    gh repo view $repository *> $null
    if ($LASTEXITCODE -ne 0) {
        gh repo create $repository --public --description $description | Out-Host
        git -C $target fetch origin main | Out-Host
    }
}

if ($LASTEXITCODE -eq 0) {
    git -C $target reset --soft origin/main | Out-Host
}

git -C $target add . | Out-Host

$status = git -C $target status --short
if (-not $status) {
    Write-Host "No changes to publish for $Topic."
    exit 0
}

git -C $target commit -m $commitMessage | Out-Host
git -C $target push -u origin main | Out-Host

Write-Host "Published $Topic -> https://github.com/$repository"
