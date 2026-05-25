# Firebase Rules Review Prompt

You are reviewing Firestore security rules for a Flutter + Firebase app.

Project: Prompt Manager / Prompt YÃ¶netim AracÄ±

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
