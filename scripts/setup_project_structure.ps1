$ErrorActionPreference = "Stop"

Write-Host "Prompt Manager project structure setup started..." -ForegroundColor Cyan

$requiredFiles = @(
    "pubspec.yaml",
    "lib\main.dart"
)

foreach ($file in $requiredFiles) {
    if (-not (Test-Path $file)) {
        Write-Host "This script must be run from the Flutter project root." -ForegroundColor Red
        Write-Host "Missing required file: $file" -ForegroundColor Red
        exit 1
    }
}

$directories = @(
    "lib\app",
    "lib\core",

    "lib\features",
    "lib\features\auth",
    "lib\features\auth\domain",
    "lib\features\auth\data",
    "lib\features\auth\presentation",

    "lib\features\prompts",
    "lib\features\prompts\domain",
    "lib\features\prompts\data",
    "lib\features\prompts\presentation",

    "lib\features\settings",
    "lib\features\settings\domain",
    "lib\features\settings\data",
    "lib\features\settings\presentation",

    "docs",
    "docs\adr",
    "docs\checklists",
    "docs\ai_review_prompts",

    "scripts"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
        Write-Host "Created: $dir" -ForegroundColor Green
    }
    else {
        Write-Host "Exists:  $dir" -ForegroundColor DarkGray
    }

    $gitkeepPath = Join-Path $dir ".gitkeep"

    if (-not (Test-Path $gitkeepPath)) {
        New-Item -ItemType File -Path $gitkeepPath | Out-Null
    }
}

Write-Host ""
Write-Host "Project structure setup completed successfully." -ForegroundColor Green
Write-Host "No product feature code was created." -ForegroundColor Yellow