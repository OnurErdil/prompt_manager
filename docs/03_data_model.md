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
