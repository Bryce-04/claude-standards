# Stack: iOS (Swift + SwiftUI)

Defaults for native Apple apps. Edit the sections marked **[edit]**. Overrides `core/` where they conflict.

## Tooling defaults **[edit]**
- Swift 5.10+ (Swift 6 strict concurrency for new code), SwiftUI, minimum iOS version pinned in the project.
- Dependencies: Swift Package Manager. Commit `Package.resolved`.
- Lint/format: SwiftLint and swift-format (or SwiftFormat).
- Tests: Swift Testing / XCTest; XCUITest for critical flows only.
- Build and release: Xcode Cloud, GitHub Actions, or fastlane.

## Code
- SwiftUI views are small and declarative. Logic lives in observable view models (`@Observable`), not in view bodies.
- Unidirectional flow: view -> view model -> service -> data. Views never call the network or database directly.
- Use `async/await` and actors. No completion-handler pyramids, no `DispatchQueue` for new code.
- Model state with enums and associated values so invalid states cannot be represented.
- No force unwraps (`!`) or `try!` outside tests and previews. Handle optionals and errors explicitly.
- Prefer value types (`struct`, `enum`). Use `class` only for identity or shared mutable state.
- Dependencies are injected through initializers or the environment so they can be replaced in tests.
- Every view has a `#Preview`.

## Product rules
- Support Dynamic Type, Dark Mode, and VoiceOver. Every interactive element has an accessibility label.
- Use system components and the Human Interface Guidelines before custom UI.
- Handle loading, error, empty, and offline states on every screen.
- Request permissions in context, with a clear reason string. Handle denial.

## Security and privacy
- Secrets and tokens go in the Keychain, never `UserDefaults` or source.
- App Transport Security stays on. No arbitrary-loads exceptions without an ADR.
- Declare every data type collected in the privacy manifest. Never log personal data.

## Structure
```
App/            # entry point, app-level setup
Features/       # one folder per feature: View, ViewModel, tests
Services/       # networking, persistence, auth
Models/
Resources/
Tests/
```

## Definition of done (additions to `review-checklist.md`)
- [ ] Builds with no warnings
- [ ] Works in Dark Mode and at large Dynamic Type sizes
- [ ] VoiceOver labels present; previews compile
- [ ] No force unwraps in production code
