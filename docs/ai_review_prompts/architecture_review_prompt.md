# Architecture Review Prompt

You are reviewing the architecture of a Flutter app.

Project: Prompt Manager / Prompt YÃ¶netim AracÄ±

Expected architecture:

- feature-first + light clean architecture
- lib/app
- lib/core
- lib/features
- features: auth, prompts, settings
- feature layers: domain, data, presentation
- data flow: Screen â†’ Provider/Notifier â†’ Repository â†’ Service â†’ Firebase

Review for:

- architecture boundary violations
- overengineering
- missing separation of concerns
- Firebase leakage into UI
- readiness for future migration
