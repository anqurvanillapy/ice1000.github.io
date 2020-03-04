---
layout: post
title: Structural typing and first-class case expressions
category: PLT
tags: Haskell ML MLPolyR
keywords: Haskell ML MLPolyR Row-polymorphism
description: Structural typing and first-class case expressions
---

This blog is an excerpt from a little paper I'm working on atm,
showing a little case where structural typing is superior than nominal typing.

# Background knowledge

Consider (Haskell-ish pseudo-code):

```haskell
Guy  = { age : Int }
Girl = { age : Int }

sticky :: Guy
sticky = { age = 19 }

fingers :: Girl
fingers = sticky
```

This code:

+ Type-checks under structural type systems
  because `Guy` and `Girl` essentially expand to
  the same structure -- `{ age :: Int }`.
+ Does not type-check under nominal type systems (Agda, Haskell, Idris, etc.)
  because `Guy` and `Girl` are different definitions

# Main content

Consider this AST:

```haskell
data Exp
  = BLit Bool
  | If Exp Exp Exp
  | Not Exp
  | Or Exp Exp
  | And Exp Exp -- Boolean

  | ILit Int
  | Add Exp Exp
  | Neg Exp
  | Sub Exp Exp -- Integer
```

Assume the constructed `Exp` are always well-typed
(there are many ways to make a promise on type-level,
like GADT. It's omitted here for simplicity),
we can have an interpreter on it:

```haskell
eval (BLit n)   = BLit n
eval (If c a b) = let (BLit c)         = eval c in eval $ if c then a else b
eval (Not a)    = let (BLit a)         = eval a in BLit $ not a
eval (Or a b)   = let (BLit a, BLit b) = (eval a, eval b) in BLit $ a || b
eval (And a b)  = let (BLit a, BLit b) = (eval a, eval b) in BLit $ a && b

eval (ILit n)   = ILit n
eval (Neg a)    = let (ILit a)         = eval a in ILit (- a)
eval (Add a b)  = let (ILit a, ILit b) = (eval a, eval b) in ILit $ a + b
eval (Sub a b)  = let (ILit a, ILit b) = (eval a, eval b) in ILit $ a - b
```

For code modularization we may want to split them into two functions,
one for `Bool`-relevant cases and one for `Int`-relevant functions
(this is actually a very practical need):

```haskell
evalB (BLit n)   = BLit n
evalB (If c a b) = let (BLit c)         = eval c in eval $ if c then a else b
evalB (Not a)    = let (BLit a)         = eval a in BLit $ not a
evalB (Or a b)   = let (BLit a, BLit b) = (eval a, eval b) in BLit $ a || b
evalB (And a b)  = let (BLit a, BLit b) = (eval a, eval b) in BLit $ a && b
-- warning: `evalB` is not exhaustive!

evalI (ILit n)   = ILit n
evalI (Neg a)    = let (ILit a)         = eval a in ILit (- a)
evalI (Add a b)  = let (ILit a, ILit b) = (eval a, eval b) in ILit $ a + b
evalI (Sub a b)  = let (ILit a, ILit b) = (eval a, eval b) in ILit $ a - b
-- warning: `evalI` is not exhaustive!

eval = evalB OR evalI
-- error: there is not such OR operation in Haskell :(
```

The `eval` above is not possible in nominal-typed languages such as Haskell, unless we define a
number of other data types representing possible subsets of `Exp` (in our case it should be
(`BLit | If | Or | And | Not`) and (`ILit | Neg | Add | Neg | Sub`))
and a bunch of auxiliary functions that convert instances of
each data type back and forth.

Plus, without the "subset" data types we'll get exhaustiveness warnings under
nominal type system.

### Something you may come up with

FWIW, you can write this (under Haskell's nominal type system):

```haskell
evalB ... (original code)
evalB other      = evalI other

evalI ... (original code)
evalI other      = evalB other
```

However, this is possible **only because we have two functions**.
If we've modularize `eval` into three parts, you won't be able to do this.

## Structural typing

However, in structurally-typed languages, we will not need those
subset-data types, exhaustiveness warnings and conversion functions,
and our `evalB`/`evalI` will have types:

```haskell
evalB :: BLit | If | Or | And | Not -> Exp
evalI :: ILit | Neg | Add | Neg | Sub -> ILit
```

but eventually a re-dispatch is still required:

```haskell
eval (BLit n)   = evalB (BLit n)
eval (If c a b) = evalB (If c a b)
eval (Not a)    = evalB (Not a)
eval (Or a b)   = evalB (Or a b)
eval (And a b)  = evalB (And a b)

eval (ILit n)   = evalI (ILit n)
eval (Neg a)    = evalI (Neg a)
eval (Add a b)  = evalI (Add a b)
eval (Sub a b)  = evalI (Sub a b)
```

This is too much boilerplate (the code above does not contain any nontrivial information,
but the `eval` function can only be written in this way, if we only change Haskell
from nominal-typed to structurally-typed,
and don't introduce any new language features).

## New feature

But of course we can use some additional language feature to support this!

Imagine a _strip off_ operation that "eliminates one variant away from a data type",
denoted as:

<pre>
<code><strong>case</strong> BLit n: evalB (BLit n)
<strong>or</strong> other clauses
</code></pre>

, we can achieve boilerplate-free modularization. In case
there is no cases to eliminate,
we introduce a **`whatever`** keyword as the eliminator for the empty
variant type.

Rewriting the original code using the _strip off_ operation will be:

```haskell
eval = case BLit n: BLit n
  or case If c a b: let (BLit c) = eval c in if c then eval a else eval b
  or case Not a: let (BLit a)           = eval a in BLit $ not a
  or case Or a b: let (BLit a, BLit b)  = (eval a, eval b) in BLit (a || b)
  or case And a b: let (BLit a, BLit b) = (eval a, eval b) in BLit (a && b)
  or case ILit n: ILit n
  or case Neg a: let (ILit a)           = eval a in ILit (- a)
  or case Add a b: let (ILit a, ILit b) = (eval a, eval b) in ILit (a + b)
  or case Sub a b: let (ILit a, ILit b) = (eval a, eval b) in ILit (a - b)
  or whatever
```

Modularize it (it's nothing but parametrization):

```haskell
evalB f = case BLit n: BLit n
  or case Not a: let (BLit a)           = eval a in BLit $ not a
  or case Or a b: let (BLit a, BLit b)  = (eval a, eval b) in BLit (a || b)
  or case And a b: let (BLit a, BLit b) = (eval a, eval b) in BLit (a && b)
  or f
evalI f = case ILit n: ILit n
  or case Neg a: let (ILit a)           = eval a in ILit (- a)
  or case Add a b: let (ILit a, ILit b) = (eval a, eval b) in ILit (a + b)
  or case Sub a b: let (ILit a, ILit b) = (eval a, eval b) in ILit (a - b)
  or f
```

And there should be a function connecting `evalB` and `evalI` together:

<pre>
<code>eval = evalB (evalI <strong>whatever</strong>)
</code></pre>

This feature is available in the MLPolyR language and the Rose language.

@LdBeth (together with me) had made some effort to make MLPolyR compile with MLton
and have created a [GitHub repo](https://github.com/owo-lang/MLPolyR)
so it's now accessible from everywhere.

In the MLPolyR language, the _strip off_ operation is called "first-class cases".
