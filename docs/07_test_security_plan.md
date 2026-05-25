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
