# ADR 003 â€” Canonical PromptCard Model

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
