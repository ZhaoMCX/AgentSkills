param(
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

foreach ($topic in ($topics.PSObject.Properties.Name | Sort-Object)) {
    Write-Host "Publishing $topic..."
    $args = @{
        Topic = $topic
        OutputRoot = $OutputRoot
    }

    if ($Message) {
        $args.Message = $Message
    }

    & (Join-Path $PSScriptRoot "publish-topic.ps1") @args
}
