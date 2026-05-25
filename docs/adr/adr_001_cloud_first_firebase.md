# ADR 001 â€” Cloud-first Firebase Approach

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
