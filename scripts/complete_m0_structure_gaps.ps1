$ErrorActionPreference = "Stop"

Write-Host "Completing M0 structure and documentation gaps..." -ForegroundColor Cyan

function Ensure-Directory {
    param ([string]$Path)

    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
        Write-Host "Created directory: $Path" -ForegroundColor Green
    }
    else {
        Write-Host "Exists directory:  $Path" -ForegroundColor DarkGray
    }

    $gitkeepPath = Join-Path $Path ".gitkeep"
    if (-not (Test-Path $gitkeepPath)) {
        New-Item -ItemType File -Path $gitkeepPath | Out-Null
    }
}

function Write-FileIfMissing {
    param (
        [string]$Path,
        [string]$Content
    )

    if (-not (Test-Path $Path)) {
        Set-Content -Path $Path -Value $Content -Encoding UTF8
        Write-Host "Created file: $Path" -ForegroundColor Green
    }
    else {
        Write-Host "Exists file:  $Path" -ForegroundColor DarkGray
    }
}

function Rename-IfExistsAndTargetMissing {
    param (
        [string]$OldPath,
        [string]$NewPath
    )

    if ((Test-Path $OldPath) -and (-not (Test-Path $NewPath))) {
        Rename-Item -Path $OldPath -NewName (Split-Path $NewPath -Leaf)
        Write-Host "Renamed: $OldPath -> $NewPath" -ForegroundColor Yellow
    }
}

$features = @("auth", "prompts", "settings")

foreach ($feature in $features) {
    Ensure-Directory "lib\features\$feature\domain\entities"
    Ensure-Directory "lib\features\$feature\domain\repositories"
    Ensure-Directory "lib\features\$feature\domain\usecases"

    Ensure-Directory "lib\features\$feature\data\dto"
    Ensure-Directory "lib\features\$feature\data\mappers"
    Ensure-Directory "lib\features\$feature\data\repositories"
    Ensure-Directory "lib\features\$feature\data\services"

    Ensure-Directory "lib\features\$feature\presentation\screens"
    Ensure-Directory "lib\features\$feature\presentation\providers"
    Ensure-Directory "lib\features\$feature\presentation\widgets"
}

Ensure-Directory "docs\adr"
Ensure-Directory "docs\checklists"
Ensure-Directory "docs\ai_review_prompts"

Rename-IfExistsAndTargetMissing "docs\adr\adr_001_cloud_first_firebase.md" "docs\adr\ADR-001-cloud-first-v1.md"
Rename-IfExistsAndTargetMissing "docs\adr\adr_002_feature_first_light_clean_architecture.md" "docs\adr\ADR-004-feature-first-light-clean-architecture.md"
Rename-IfExistsAndTargetMissing "docs\adr\adr_003_promptcard_canonical_model.md" "docs\adr\ADR-003-canonical-promptcard-model.md"
Rename-IfExistsAndTargetMissing "docs\adr\adr_004_v1_manual_ai_later.md" "docs\adr\ADR-006-v1-manual-core-ai-later.md"

Write-FileIfMissing "docs\adr\ADR-002-firebase-auth-firestore-v1.md" @"
# ADR-002 — Firebase Auth + Cloud Firestore for V1

## Status

Accepted.

## Context

V1 needs user accounts and cloud-based prompt storage.

## Decision

Use Firebase Auth and Cloud Firestore as the V1 backend direction.

## Consequences

- Authentication will be handled through Firebase Auth.
- Prompt data will be stored under user-scoped Firestore paths.
- Firestore physical database creation is postponed until billing/budget safety is decided or before M3.
"@

Write-FileIfMissing "docs\adr\ADR-005-ui-does-not-access-firebase-directly.md" @"
# ADR-005 — UI Does Not Access Firebase Directly

## Status

Accepted.

## Context

The app must preserve clean architecture boundaries.

## Decision

UI screens must not directly call Firebase Auth or Cloud Firestore.

## Expected Flow

Screen -> Provider/Notifier -> Repository -> Service -> Firebase

## Consequences

- UI remains testable.
- Firebase can be replaced or abstracted later.
- Business rules do not leak into widgets.
"@

Write-FileIfMissing "docs\adr\ADR-007-firestore-user-scoped-path.md" @"
# ADR-007 — Firestore User-Scoped Prompt Path

## Status

Accepted.

## Decision

Use the following Firestore path for prompt cards:

users/{userId}/prompts/{promptId}

## Consequences

- Each user's prompt cards are isolated.
- Firestore security rules can be written around user ownership.
- Cross-user read/write must be blocked.
"@

Write-FileIfMissing "docs\adr\ADR-008-variable-standard-and-storage.md" @"
# ADR-008 — Variable Standard and Storage

## Status

Accepted.

## Decision

Prompt variables use the following format:

[VARIABLE_NAME]

Variables are parsed from promptText and stored as:

variables: string[]

## V1 Boundary

Variable metadata such as hint, type, default value, and required flag are outside V1.
"@

Write-FileIfMissing "docs\adr\ADR-009-no-permanent-delete-v1.md" @"
# ADR-009 — No Permanent Delete in V1

## Status

Accepted.

## Decision

V1 will not implement permanent delete.

Prompt cards will be archived by setting:

status: archived

## Consequences

- Data loss risk is reduced.
- Archive behavior stays simple.
- Permanent delete can be reconsidered after V1.
"@

Write-FileIfMissing "docs\adr\ADR-010-single-app-multilingual-ready.md" @"
# ADR-010 — Single App, Multilingual-Ready

## Status

Accepted.

## Decision

The product will start with Turkish visible UI but keep a single app and multilingual-ready structure.

## Consequences

- Technical project name is prompt_manager.
- Turkish visible name is Prompt Yönetim Aracı.
- English visible name will be decided later.
- System values must remain language-independent.
"@

Write-FileIfMissing "docs\checklists\m1_app_shell_routing_auth_checklist.md" "# M1 — App Shell / Routing / Auth Checklist`n`n- [ ] App shell planned`n- [ ] Routing planned`n- [ ] AuthGate planned`n- [ ] Firebase Auth package decision made`n- [ ] No prompt feature code added prematurely"
Write-FileIfMissing "docs\checklists\m2_promptcard_domain_model_checklist.md" "# M2 — PromptCard Domain Model Checklist`n`n- [ ] PromptCard entity created`n- [ ] Domain model is Firebase-independent`n- [ ] Status keys defined`n- [ ] Variable parsing planned`n- [ ] Rules-readiness check completed"
Write-FileIfMissing "docs\checklists\m3_data_layer_firestore_checklist.md" "# M3 — Data Layer / Firestore Checklist`n`n- [ ] Firestore database status reviewed`n- [ ] Billing/budget decision reviewed`n- [ ] DTO planned`n- [ ] Mapper planned`n- [ ] Repository planned`n- [ ] Service planned`n- [ ] Firestore rules draft prepared"
Write-FileIfMissing "docs\checklists\m4_first_core_flow_checklist.md" "# M4 — First Core Flow Checklist`n`n- [ ] Quick Add works`n- [ ] Prompt saved under current user`n- [ ] Library shows saved prompt`n- [ ] User isolation checked`n- [ ] No V1 scope leakage"
Write-FileIfMissing "docs\checklists\security_checklist.md" "# Security Checklist`n`n- [ ] No secrets committed`n- [ ] API keys handled safely`n- [ ] Firestore user isolation planned`n- [ ] Realtime Database is not used`n- [ ] Realtime Database rules are locked if accidentally created"
Write-FileIfMissing "docs\checklists\architecture_boundary_checklist.md" "# Architecture Boundary Checklist`n`n- [ ] UI does not access Firebase directly`n- [ ] Domain layer is technology-independent`n- [ ] Data layer owns Firebase implementation details`n- [ ] Repository boundary is respected"
Write-FileIfMissing "docs\checklists\scope_leak_checklist.md" "# Scope Leak Checklist`n`n- [ ] No AI feature added`n- [ ] No payment feature added`n- [ ] No marketplace feature added`n- [ ] No team/workspace feature added`n- [ ] No semantic search added`n- [ ] No usage analytics added`n- [ ] No version history added`n- [ ] No permanent delete added"
Write-FileIfMissing "docs\checklists\device_platform_test_checklist.md" "# Device / Platform Test Checklist`n`n- [ ] Android debug build works`n- [ ] Web run works if selected`n- [ ] iOS not targeted in V1 setup`n- [ ] Windows Firebase production usage not targeted"

Write-FileIfMissing "docs\ai_review_prompts\data_model_review_prompt.md" "# Data Model Review Prompt`n`nReview the PromptCard domain model for portability, V1 scope fit, Firestore independence, status handling, variables string[] design, and schemaVersion readiness."
Write-FileIfMissing "docs\ai_review_prompts\security_review_prompt.md" "# Security Review Prompt`n`nReview this Flutter + Firebase project for user data isolation, secret leakage, unsafe Firebase rules, accidental Realtime Database exposure, and V1 scope safety."
Write-FileIfMissing "docs\ai_review_prompts\milestone_review_prompt.md" "# Milestone Review Prompt`n`nReview the completed milestone for working flow, correct data behavior, architecture boundary, error states, security risks, and V1 scope leakage."
Write-FileIfMissing "docs\ai_review_prompts\scope_guard_review_prompt.md" "# Scope Guard Review Prompt`n`nReview whether any added work violates the V1 scope. V1 must not include AI, payment, marketplace, team/workspace, semantic search, usage analytics, version history, or permanent delete."
Write-FileIfMissing "docs\ai_review_prompts\ai_review_prompt_usage_map.md" "# AI Review Prompt Usage Map`n`n- M0: m0_project_setup_review_prompt.md`n- M1: architecture_review_prompt.md`n- M2: data_model_review_prompt.md`n- M3: firebase_rules_review_prompt.md and security_review_prompt.md`n- Each milestone end: milestone_review_prompt.md`n- Scope concerns: scope_guard_review_prompt.md"

Write-Host ""
Write-Host "M0 structure and documentation gaps completed." -ForegroundColor Green
Write-Host "No product feature code was created." -ForegroundColor Yellow