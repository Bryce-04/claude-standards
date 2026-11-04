# Stack: Web Frontend (TypeScript + React)

Defaults for browser apps. Swap React for your framework (Vue, Svelte, Next.js) by editing the sections marked **[edit]**. Overrides `core/` where they conflict.

## Tooling defaults **[edit]**
- Language: TypeScript with `strict: true`. No `any` without a comment explaining why.
- Bundler: Vite (or the framework's default).
- Lint/format: ESLint + Prettier.
- Unit/component tests: Vitest + Testing Library.
- End-to-end: Playwright for critical flows only.

## Code
- Function components and hooks only. One component per file, named exports, filename matches the component (`UserCard.tsx`).
- Keep components small. Extract logic into hooks (`useUserSearch`) and pure utility functions.
- Props are typed with an explicit interface. Avoid prop drilling past 2 levels; use context or a store.
- State: start local, lift when needed, reach for a global store only when several distant components share it.
- Server data goes through a data-fetching layer (TanStack Query, SWR, or framework loaders), not ad hoc `useEffect` fetches.
- Every async UI handles three states: loading, error, empty.
- No business logic inside JSX. Compute values above the `return`.

## Structure
```
src/
  components/   # shared, reusable UI
  features/     # feature folders: components, hooks, api, tests together
  hooks/
  lib/          # pure utilities, API client
  pages/ or routes/
  types/
```

## Accessibility (non-negotiable)
- Semantic HTML first (`button`, `nav`, `main`, `label`), not clickable `div`s.
- Every input has a label. Every image has meaningful `alt` (or `alt=""` if decorative).
- Everything usable by keyboard with visible focus.
- Color contrast meets WCAG AA. Do not convey meaning by color alone.

## Styling **[edit]**
- One approach per project (CSS Modules, Tailwind, or styled solution). Do not mix.
- Design tokens (colors, spacing, type scale) defined once and reused.
- Mobile-first, responsive layouts. Test at narrow and wide widths.

## Testing
- Test what the user sees and does (`getByRole`, `userEvent`), not component internals.
- Do not snapshot-test large trees.
- Mock the network with MSW or equivalent, not by mocking your own modules.

## Performance and security
- Code-split routes. Lazy-load heavy components.
- Optimize images and set explicit dimensions.
- Never use `dangerouslySetInnerHTML` with untrusted content.
- Secrets never go in client code. Anything in the bundle is public.
- Env vars exposed to the client use the framework's public prefix (`VITE_`) and contain nothing sensitive.

## Definition of done (additions to `review-checklist.md`)
- [ ] Works at mobile and desktop widths
- [ ] Keyboard navigable, labels present
- [ ] Loading, error, and empty states exist
- [ ] No console errors or warnings
