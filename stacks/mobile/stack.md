# Stack: Mobile (React Native + Expo + TypeScript)

Defaults for cross-platform mobile apps. Writing native instead (Swift/SwiftUI, Kotlin/Compose)? Keep the product rules below and replace the tooling sections marked **[edit]**. Overrides `core/` where they conflict.

## Tooling defaults **[edit]**
- Language: TypeScript with `strict: true`.
- Framework: Expo (managed workflow) with Expo Router for navigation.
- Lint/format: ESLint + Prettier.
- Tests: Jest + React Native Testing Library. End-to-end: Maestro (or Detox).
- Builds and releases: EAS Build / EAS Submit.

## Code
- Function components and hooks only. Typed props and typed navigation params.
- Screens stay thin: they compose components and call hooks. Logic lives in hooks and services.
- Use `FlatList`/`FlashList` for any list that can grow. Never map large arrays inside a `ScrollView`.
- Keep platform-specific code isolated (`.ios.tsx` / `.android.tsx` or `Platform.select`) and minimal.
- Handle safe areas, the keyboard, and different screen sizes on every screen.

## Structure
```
app/            # routes (Expo Router)
src/
  components/
  features/
  hooks/
  services/     # API client, storage, notifications
  types/
assets/
```

## Product rules
- Every screen that loads data has loading, error, empty, and offline states.
- Assume slow or no network. Cache sensibly and make retries explicit.
- Ask for permissions (camera, location, notifications) in context, right when needed, with a clear reason. Handle denial gracefully.
- Touch targets at least 44x44 pt (iOS) / 48x48 dp (Android).
- Accessibility: `accessibilityLabel`/`accessibilityRole` on interactive elements, support dynamic text sizes, sufficient contrast.
- Support both light and dark mode, or explicitly decide not to.

## Security and storage
- Tokens and credentials go in secure storage (`expo-secure-store` / Keychain / Keystore), never in plain AsyncStorage.
- No secrets in the app bundle. Anything shipped to the device can be extracted.
- Use HTTPS only. Validate server responses.
- Do not log personal data.

## Testing
- Component tests for behavior. Test critical flows (sign-in, core feature, purchase) end to end.
- Test on at least one iOS and one Android target before calling a feature done.
- Mock native modules at the boundary (camera, notifications, secure store).

## Releases
- Version (`version`) and build number (`buildNumber`/`versionCode`) bumped every release.
- Use environment-specific configs (dev, staging, production) through EAS profiles.
- Changelog entry and store release notes for every release.

## Definition of done (additions to `review-checklist.md`)
- [ ] Verified on iOS and Android
- [ ] Loading, error, empty, and offline states exist
- [ ] Works with large text and screen reader labels
- [ ] No new permissions requested without a reason
