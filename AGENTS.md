# AGENTS.md — Prompt Manager / Prompt Yönetim Aracı

## Project Overview

This repository contains the Flutter project for Prompt Manager / Prompt Yönetim Aracı.

The product is a personal prompt lifecycle management tool for individual AI power users. Its purpose is not just to store prompts, but to help users capture, structure, classify, reuse, and maintain prompts as personal working assets.

## Current Development Status

The project has completed:

* M0 — Project Setup and Technical Groundwork
* M1 — App Shell / Routing / Auth
* M1.10 — İlk Tema, UI Temel Standartları ve V1 Görsel Kalite Planı

Next milestone:

* M2 — PromptCard Domain Model

M2 focus:

* Build the PromptCard domain model independently from Firebase.
* Keep the domain model free from Firestore `Timestamp`, document snapshots, DTOs, and Firebase-specific types.
* Define domain-level status, variable parsing, validation, and repository interface boundaries as needed.

M2 does not include:

* Firestore data layer
* prompt creation flow
* Firestore repository/service connection
* Firestore DTO or mapper implementation
* prompt add UI
* AI, payment, semantic search, usage analytics, or V1 scope expansions

## Technical Identity

* Flutter project name: prompt_manager
* Local path: C:\dev\prompt_manager
* Android package: com.onurerdil.promptmanager
* Main visible Turkish app name: Prompt Yönetim Aracı
* Future English visible name: to be decided later

## Architecture Rules

The project uses feature-first + light clean architecture.

Main structure:

* lib/app
* lib/core
* lib/features

Main features:

* auth
* prompts
* settings

Each feature may use:

* domain
* data
* presentation

Preferred data flow:

Screen -> Provider/Notifier -> Repository -> Service -> Firebase

## Strict Boundaries

Do not let UI access Firebase Auth or Cloud Firestore directly.

Do not place Firebase logic inside screens or widgets.

Do not introduce product feature code outside the current milestone.

Do not add AI, payment, marketplace, team/workspace, semantic search, usage analytics, version history, or permanent delete unless explicitly requested.

V1 uses archive behavior instead of permanent delete.

## Firebase Notes

Firebase base configuration exists.

Current Firebase state:

* firebase_core is added
* firebase_auth is added and used through the M1 auth data flow
* firebase_options.dart exists
* google-services.json exists
* firebase.json exists
* Firebase Auth is configured for the M1 auth flow
* Cloud Firestore is the intended database
* Cloud Firestore physical database creation is postponed due to billing requirement
* Realtime Database is not used and must remain locked if present

Do not add cloud_firestore before the M3 Data Layer / Firestore milestone unless explicitly instructed.

Firebase client config files in this repo are not backend secrets. Security must be enforced through Firebase Auth settings, Firebase Security Rules, future App Check/API restriction evaluation, and Firestore rules.

## Documentation Rules

Important documentation folders:

* docs/
* docs/canon/
* docs/adr/
* docs/checklists/
* docs/ai_review_prompts/
* scripts/

Canon documents contain locked decisions. Do not rewrite or change product decisions in Canon unless explicitly instructed.

ADR documents record architectural decisions. Do not change accepted decisions without explaining why.

Development notes are kept in:

docs/09_development_notes.md

Use development notes for milestone notes, temporary decisions, AI review results, errors, and open questions.

## Working Rules for Codex

Before modifying files:

1. Inspect the relevant files.
2. Explain the planned change.
3. Modify only the files requested.
4. Do not change product decisions.
5. Do not add new features unless explicitly requested.
6. Show the diff or summary after changes.
7. Do not commit or push unless explicitly requested.

For review tasks:

* Do not modify files.
* Return a structured report only.

For documentation tasks:

* Preserve existing structure unless asked to reorganize.
* Keep Turkish project terminology consistent.
* Do not remove important historical notes.
* Do not rewrite Canon from scratch unless explicitly instructed.

For code tasks:

* Keep changes small and milestone-scoped.
* Run or recommend:

    * flutter analyze
    * flutter test
    * flutter build apk --debug
* Avoid overengineering.

## Milestone Boundaries

M0:
Project setup only. No product feature code.

M1:
App shell, routing, Firebase Auth preparation, AuthGate, Login/Register, logout, first UI theme standard. Completed.

M2:
PromptCard domain model. Firebase-independent domain only; no Firestore data layer or prompt creation flow.

M3:
Data layer, Firestore service/repository/DTO/mapper, Firestore rules draft.

M4:
First core flow.

M5:
Prompt detail and normal copy.

M6:
Prompt editing, status, archive.

M7:
Detailed add.

M8:
Search and filtering.

M9:
Variable fill-copy.

M10:
Security, testing, V1 closure.

## Default Output Style

When reviewing:

* Overall status
* Blocking issues
* Non-blocking issues
* Recommended actions
* Whether the next milestone can safely start

When editing:

* Files changed
* What changed
* Why it changed
* Any risks
* Commands to run next
