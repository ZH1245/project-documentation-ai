# Rule: TypeScript & TS/JSDoc

> Applies to TypeScript (and JSDoc-typed JavaScript) repos. Delete if not applicable.

## Rule

- **Explicit types on public APIs.** Exported functions, components, and module boundaries have
  explicit parameter and return types. Let inference handle locals.
- **No `any`.** Use `unknown` + narrowing, or a proper union. `any` disables the type checker.
- **Prefer discriminated unions** over an optional bag-of-props.
- **JSDoc on exported functions** where the name isn't fully self-explanatory: one line on purpose,
  `@param` / `@returns` only when they add information beyond the type.
- **Avoid type assertions (`as Foo`)** unless interop forces it; document why in one line.

## Why

Explicit boundary types make a module's contract readable without opening its body, and catch
breakage at the call site. `any` and stray assertions silently defeat that, so bugs surface at
runtime instead of compile time.

## Good

```ts
/** Resolves the active workspace for a user, or null if they have none. */
export function getActiveWorkspace(userId: string): Workspace | null {
  const memberships = findMemberships(userId); // inferred locally
  return memberships.find((m) => m.isActive)?.workspace ?? null;
}
```

## Bad

```ts
export function getActiveWorkspace(userId): any {   // no types, returns any
  const memberships = findMemberships(userId) as any[];  // assertion hides the real type
  // caller now gets `any` and loses all checking downstream
}
```

## Applying it

- Turn on `strict` in `tsconfig.json`; treat `any` in review as a defect.
- JSDoc restates *why/units/edge cases*, not the type — the type already says the type.
