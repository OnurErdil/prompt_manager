$ErrorActionPreference = "Stop"

Write-Host "Creating M0 docs package..." -ForegroundColor Cyan

$requiredFiles = @(
    "pubspec.yaml",
    "lib\main.dart",
    "docs",
    "docs\adr",
    "docs\checklists",
    "docs\ai_review_prompts"
)

foreach ($item in $requiredFiles) {
    if (-not (Test-Path $item)) {
        Write-Host "Missing required item: $item" -ForegroundColor Red
        Write-Host "Run setup_project_structure.ps1 first." -ForegroundColor Red
        exit 1
    }
}

function Write-DocFile {
    param (
        [string]$Path,
        [string]$Content
    )

    if (-not (Test-Path $Path)) {
        Set-Content -Path $Path -Value $Content -Encoding UTF8
        Write-Host "Created: $Path" -ForegroundColor Green
    }
    else {
        Write-Host "Exists:  $Path" -ForegroundColor DarkGray
    }
}

Write-DocFile "docs\00_project_overview.md" @"
# Prompt Manager / Prompt Yönetim Aracı — Project Overview

## Status

M0 — Project Setup and Technical Groundwork.

## Product Definition

Prompt Yönetim Aracı is a personal prompt lifecycle management tool for individual AI power users who want to turn valuable prompts into reusable personal work assets.

## Core Promise

Do not lose good prompts inside chats. Capture, structure, improve, reuse, and maintain them as part of a personal AI working system.

## V1 Focus

V1 focuses on the manual prompt lifecycle core:

- Capture prompts
- Convert prompts into structured prompt cards
- Add context, category, tags, status, and variables
- Search and filter the prompt library
- Reuse prompts through normal copy and variable fill-copy
- Update prompt cards over time

## Out of V1 Scope

- AI features
- Payment
- Marketplace
- Team/workspace
- Semantic search
- Usage analytics
- Version history
- Permanent delete
"@

Write-DocFile "docs\01_v1_scope.md" @"
# V1 Scope

## V1 Goal

Build a manual but strong prompt lifecycle core.

## Main Flow

Capture → Cardify → Variableize → Find → Use → Update

## P0 Features

- Quick Add
- Detailed Add
- Prompt Card
- Prompt Library
- Search
- Filter by category, tag, and status
- Normal Copy
- Variable Fill-Copy
- Edit Prompt
- Archive via status

## V1 Exclusions

- AI-supported improvement
- Semantic search
- Browser extension
- Import/export
- Collections
- Usage analytics
- Version history
- Permanent delete
"@

Write-DocFile "docs\02_architecture.md" @"
# Architecture

## Architecture Style

Feature-first + light clean architecture.

## Main Structure

- lib/app
- lib/core
- lib/features

## Features

- auth
- prompts
- settings

## Feature Layers

Each feature may contain:

- domain
- data
- presentation

## Data Flow

Screen → Provider/Notifier → Repository → Service → Firebase

## Boundary Rule

UI must not access Firebase Auth or Cloud Firestore directly.
"@

Write-DocFile "docs\03_data_model.md" @"
# Data Model

## Canonical Model

The canonical domain model is PromptCard.

## PromptCard Fields

- id
- ownerId
- title
- promptText
- description
- notes
- category
- tags
- status
- variables
- createdAt
- updatedAt
- schemaVersion

## Required User Field

Only promptText is required from the user.

## Status Technical Keys

- raw
- needs_edit
- ready
- archived

## Variable Standard

Variables use this format:

[VARIABLE_NAME]

## Variables Storage

Variables are parsed from promptText and stored as:

variables: string[]

## Schema Version

New records start with:

schemaVersion: 1
"@

Write-DocFile "docs\04_firebase_firestore_plan.md" @"
# Firebase and Firestore Plan

## V1 Backend

Firebase Auth + Cloud Firestore.

## Data Path

users/{userId}/prompts/{promptId}

## User Isolation Rule

Each user must only read and write their own prompt cards.

## M0 Role

Firebase project and FlutterFire setup will be prepared in M0.

## Later Milestones

- M1: Auth connection
- M2: Firebase-independent PromptCard domain model
- M3: Firestore data layer with Repository, Service, DTO, and Mapper
- M4: Read/create user isolation control
- M6: Update/archive rules
- M10: Final security review
"@

Write-DocFile "docs\05_milestone_plan.md" @"
# Milestone Plan

## V1 Milestones

- M0 — Project Setup and Technical Groundwork
- M1 — App Shell / Routing / Auth
- M2 — PromptCard Domain Model
- M3 — Data Layer / Firestore
- M4 — First Core Flow
- M5 — Prompt Detail / Normal Copy
- M6 — Prompt Editing / Status / Archive
- M7 — Detailed Add
- M8 — Search / Filtering
- M9 — Variable Fill-Copy
- M10 — Security / Test / V1 Closure

## Milestone Review Areas

Each milestone should check:

- Working flow
- Correct data behavior
- Architecture boundary
- Error states
- Security
- V1 scope leakage
"@

Write-DocFile "docs\06_acceptance_criteria.md" @"
# Acceptance Criteria

## V1 Completion Criteria

V1 is complete when the following flow works end to end:

Capture → Cardify → Variableize → Find → Use → Update

## Core Acceptance Points

- User can create a prompt card
- User can add prompt text quickly
- User can enrich prompt details
- User can search and filter prompt cards
- User can copy prompt normally
- User can fill variables and copy final prompt
- User can edit prompt cards
- User can archive prompts by status
- User data is isolated by user account
"@

Write-DocFile "docs\07_test_security_plan.md" @"
# Test and Security Plan

## Test Approach

Testing and security are distributed across milestones.

## Basic Checks

- flutter analyze
- flutter test
- manual run check
- auth state checks
- Firestore access checks
- error state checks

## Firestore Security Focus

- Users can only access their own data
- No cross-user read
- No cross-user write
- Archive is status-based
- Permanent delete is not part of V1

## Scope Protection

V1 must not include:

- AI
- Payment
- Marketplace
- Team/workspace
- Semantic search
- Usage analytics
- Version history
"@

Write-DocFile "docs\08_parking_lot_v1_5_v2.md" @"
# Parking Lot — V1.5 / V2 / V3

## V1.5 Candidates

- Browser extension
- Import/export
- Collections/groups
- Usage count
- Onboarding
- Prompt template library
- Prompt Health Check

## V2 Direction

- AI-supported prompt processing
- Prompt improvement
- Automatic classification
- Semantic search
- Strong template system
- AI-supported import/export

## V3 Direction

- Personal AI working memory
- Project-based prompt systems
- Workflows
- Integrations
- Advanced analytics
- Agent-supported maintenance
"@

Write-DocFile "docs\09_development_notes.md" @"
# Development Notes

## Current Phase

M0 — Project Setup and Technical Groundwork.

## Technical Identity

- Flutter project name: prompt_manager
- Local path: C:\dev\prompt_manager
- Git repo name: prompt_manager
- Package org: com.onurerdil
- Android package target: com.onurerdil.promptmanager
- Turkish visible app name: Prompt Yönetim Aracı
- Future English visible name: to be decided later

## Current Rule

Do not develop product features in M0.

## M0 Focus

- Flutter project setup
- Git setup
- Folder structure
- Docs package
- ADR records
- Checklists
- AI review prompts
- Firebase preparation
- First build/run verification
"@

Write-DocFile "docs\adr\adr_001_cloud_first_firebase.md" @"
# ADR 001 — Cloud-first Firebase Approach

## Status

Accepted.

## Context

V1 needs user accounts and cloud-based prompt storage.

## Decision

Use Firebase Auth + Cloud Firestore as the V1 backend candidate.

## Consequences

- Fast Flutter integration
- User-based data isolation
- Cloud-first data availability
- Canonical domain model must remain Firebase-independent
"@

Write-DocFile "docs\adr\adr_002_feature_first_light_clean_architecture.md" @"
# ADR 002 — Feature-first + Light Clean Architecture

## Status

Accepted.

## Context

The app needs structure without overengineering.

## Decision

Use feature-first structure with light clean architecture.

## Structure

- app
- core
- features/auth
- features/prompts
- features/settings

Each feature may contain domain, data, and presentation layers.

## Consequences

- Clear modular structure
- Easier growth
- UI does not depend directly on Firebase
"@

Write-DocFile "docs\adr\adr_003_promptcard_canonical_model.md" @"
# ADR 003 — Canonical PromptCard Model

## Status

Accepted.

## Context

Prompt cards must remain portable and not locked to Firestore.

## Decision

Define PromptCard as the canonical domain model.

## Consequences

- Firestore is an implementation detail
- Future migration is easier
- Export/import can rely on stable schema
"@

Write-DocFile "docs\adr\adr_004_v1_manual_ai_later.md" @"
# ADR 004 — V1 Manual Core, AI Later

## Status

Accepted.

## Context

AI features can increase complexity and cost.

## Decision

Keep V1 manual. Move AI-supported features to V2 and later.

## Consequences

- V1 is simpler and cheaper
- Core product value is tested first
- AI Gateway and cost model remain future architecture concerns
"@

Write-DocFile "docs\checklists\m0_project_setup_checklist.md" @"
# M0 Project Setup Checklist

## Flutter Setup

- [ ] Flutter project created
- [ ] Project path is C:\dev\prompt_manager
- [ ] flutter pub get passed
- [ ] flutter analyze passed
- [ ] flutter test passed
- [ ] flutter run passed

## Git Setup

- [ ] Git initialized
- [ ] Branch is main
- [ ] Initial Flutter project commit created
- [ ] Project structure commit created

## Structure Setup

- [ ] scripts/setup_project_structure.ps1 created
- [ ] lib/app created
- [ ] lib/core created
- [ ] lib/features created
- [ ] auth feature folders created
- [ ] prompts feature folders created
- [ ] settings feature folders created

## Docs Setup

- [ ] docs package created
- [ ] ADR files created
- [ ] checklist files created
- [ ] AI review prompt files created

## Firebase Preparation

- [ ] Firebase project created
- [ ] Firebase Auth prepared
- [ ] Cloud Firestore prepared
- [ ] FlutterFire configured
- [ ] firebase_options.dart generated

## M0 Scope Check

- [ ] No product feature code added
- [ ] No PromptCard model added yet
- [ ] No login UI added yet
- [ ] No Firestore repository added yet
"@

Write-DocFile "docs\checklists\milestone_acceptance_checklist.md" @"
# Milestone Acceptance Checklist

For each milestone, check:

- [ ] Main user flow works
- [ ] Data behavior is correct
- [ ] Architecture boundary is preserved
- [ ] UI does not directly access Firebase
- [ ] Error states are considered
- [ ] Security impact is considered
- [ ] V1 scope leakage is avoided
- [ ] flutter analyze passes
- [ ] flutter test passes
"@

Write-DocFile "docs\checklists\v1_scope_guard_checklist.md" @"
# V1 Scope Guard Checklist

Before accepting a new feature, check:

- [ ] Does it support capture, cardify, variableize, find, use, or update?
- [ ] Is it necessary for V1?
- [ ] Can it be postponed to V1.5, V2, or V3?
- [ ] Does it introduce AI, payment, marketplace, team/workspace, semantic search, usage analytics, version history, or permanent delete?
- [ ] Does it increase M0-M10 complexity unnecessarily?
"@

Write-DocFile "docs\ai_review_prompts\m0_project_setup_review_prompt.md" @"
# M0 Project Setup Review Prompt

You are reviewing a Flutter + Firebase project setup.

Project: Prompt Manager / Prompt Yönetim Aracı

Review the M0 setup for:

- Flutter project structure
- Git cleanliness
- docs package
- ADR files
- checklist files
- AI review prompt files
- absence of product feature code
- readiness for Firebase setup
- consistency with feature-first + light clean architecture

Important constraints:

- No product feature should be developed in M0.
- UI must not directly access Firebase in later milestones.
- V1 is manual and AI-free.
"@

Write-DocFile "docs\ai_review_prompts\architecture_review_prompt.md" @"
# Architecture Review Prompt

You are reviewing the architecture of a Flutter app.

Project: Prompt Manager / Prompt Yönetim Aracı

Expected architecture:

- feature-first + light clean architecture
- lib/app
- lib/core
- lib/features
- features: auth, prompts, settings
- feature layers: domain, data, presentation
- data flow: Screen → Provider/Notifier → Repository → Service → Firebase

Review for:

- architecture boundary violations
- overengineering
- missing separation of concerns
- Firebase leakage into UI
- readiness for future migration
"@

Write-DocFile "docs\ai_review_prompts\firebase_rules_review_prompt.md" @"
# Firebase Rules Review Prompt

You are reviewing Firestore security rules for a Flutter + Firebase app.

Project: Prompt Manager / Prompt Yönetim Aracı

Expected Firestore path:

users/{userId}/prompts/{promptId}

Main security principle:

Each authenticated user can only read and write their own prompt cards.

Review for:

- cross-user read risk
- cross-user write risk
- unsafe broad rules
- archive/status update behavior
- V1 no permanent delete expectation
- ownerId consistency
"@

Write-Host ""
Write-Host "M0 docs package created successfully." -ForegroundColor Green
Write-Host "No product feature code was created." -ForegroundColor Yellow