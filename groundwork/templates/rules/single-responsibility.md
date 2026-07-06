# Rule: Single responsibility & small composed functions

## Rule

- **One concern per file.** If a file does two unrelated things, split it.
- **One reason to change per function.** A function should do one thing at one level of abstraction.
- **Compose small named functions inside larger ones.** Build behaviour from small, well-named
  helpers called by a higher-level function — not one long function. This makes each step easy to
  read, test, debug, and extend later.

## Why

Small, single-purpose units localize bugs (you know which function to look in), make diffs small,
and let you change one behaviour without disturbing the rest. A 150-line function hides its seams;
five 30-line functions show them.

## Good

```ts
async function checkout(cart: Cart): Promise<Receipt> {
  const priced = priceCart(cart);
  const payment = await charge(priced.total);
  const order = await createOrder(priced, payment);
  return buildReceipt(order);
}
```

Each step is a named function with its own responsibility. `checkout` reads like a summary.

## Bad

```ts
async function checkout(cart: Cart): Promise<Receipt> {
  // 150 lines: pricing math, tax rules, payment gateway calls, DB writes,
  // email sending, and receipt formatting all inlined here...
}
```

One function, many responsibilities. To change tax logic you must read all of it, and a bug could
be anywhere.

## Applying it

- Extract a helper the moment a block inside a function needs its own comment to explain *what* it
  does — the name should replace the comment.
- Keep helpers at a single level of abstraction; don't mix high-level orchestration with low-level
  string fiddling in the same function.
- Don't over-extract: a helper used once and trivially short can stay inline. Extract for clarity,
  not for a rule.
