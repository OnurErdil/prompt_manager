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
