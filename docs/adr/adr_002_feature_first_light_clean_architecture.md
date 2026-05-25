# ADR 002 â€” Feature-first + Light Clean Architecture

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
