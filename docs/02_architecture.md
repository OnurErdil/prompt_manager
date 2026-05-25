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

Screen â†’ Provider/Notifier â†’ Repository â†’ Service â†’ Firebase

## Boundary Rule

UI must not access Firebase Auth or Cloud Firestore directly.
