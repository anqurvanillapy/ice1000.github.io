---
layout: post
title: Fragmented Thoughts on Reducible Expressions
category: PLT
tags: Compilers, Interpreters
keywords: Dependent Type, Partial Evaluation
description: A general structure of program analyzer
katex: true
---

This article is my first article after migrating to
English-only blogging. It Introduces a general structure of a sort of program analyzers,
including type-checkers, partial evaluators, etc.

This article assumes knowledge of simply-typed lambda calculus.

## Syntax

I have been working with dependent types for a period of time and have developed a
simple [dialect of Mini-TT](https://github.com/owo-lang/minitt-rs) for practice.

There are two ASTs involved in the whole process -- a surface syntax tree, representing
unchecked expressions or reducible expressions (hereafter as *redex*, *redexes*) and a
value tree, representing non-redexes.

What is *reduce*? It can be explained as "simplify", or "evaluate".

Values can be canonical values or neutral values.
Canonical values are terms that cannot be reduced because it
consists only constructor calls, record constructors, lambda abstractions, etc. which are all non-reducible
language structures by definition.
Neutral values are terms that cannot be reduced because
the presence of a variable abstraction, for example consider a lambda expression
$\lambda x. x$, the second $x$ is a (and is the smallest) neutral value.
Trying to apply an argument to a neutral value or record projections on a neutral
value or anything else similar will produces a new neutral value.

Now such concepts are introduced:

+ Values
  + Canonical values
  + Neutral values
+ Reducible expressions

Here are some terms based on the values / redexes introduced above:

+ $ f 1 $ is:
  + A neutral value because of the presence of $f$, a free variable
+ $ \lambda f. f 1 $ is:
  + A canonical value -- a lambda expression, whose body is a neutral value
+ $ (\lambda x. x) 1 $ is (important, read carefully):
  + A redex, which reduces to a canonical value $1$ because
    + Applying a value $1$ on a lambda will introduce a name binding that $x = 1$
    + Under the context that $x = 1$, the neutral value $x$ reduces to a canonical value $1$
+ $ (\lambda x. f x) 1 $ is (also important):
  + A redex, which reduces to a neutral value $f 1$ because why not
  + And $f 1$ is a neutral value due to the presence of $f$, a free variable
  + If a context that $f = \lambda x. x$ is provided, the whole expression can be reduced to $1$
+ $ \lambda x. (\lambda y. x) 1 $ is:
  + I don't know.. It's hard to classify this expression
  + This can be a canonical value, because it's a lambda expression
  + A sub-expression, $ (\lambda y. x) 1 $ can be reduced to $x$, though
  + Hereafter as *semi-redex*

## Evaluation

One property of this lambda calculus model is that neutral values can be reduced
to canonical values contextually, expanding the context may cause the current
to-be-reduced expression to reduce.

What's more?

Obviously we have already got an implementation of the reduction function in mind and it's all
about manipulating expressions with the change of contexts.

How do we change contexts?

+ Pattern matching, causes the being matched variable to be replaced with the pattern
+ Function application, where `let` bindings are just a syntax sugar of it
+ Anything else?
  + `rewrite` in Proof Assistants sounds like a context-changing primitive
    + But that can be a syntax sugar of pattern matching
  + But can we have context-changing primitives at all?
    + Yes, `ltac` / *reflection* / *elaboration reflection* -- whatever you want to call that

New concepts:

+ Context
+ Reduction

This is the fundamental model of a "general model", because a large number of compiler-related
programs can be modeled by this "redex - context - reduce - canonical - context - reduce - .."
procedure.

## Applications

### Partial Evaluation

An easy-to-understand compiler optimization is constant folding, where the compiler evaluates
most redexes before compilation so these computations are completed in advance, saving runtime
costs.

The AST can be a big redex, which is going to be reduced as much as possible before getting compiled.
Side effects (memory allocations, printings, file IOs, FFIs) can be treated as neutral values
and avoid being evaluated at all.

With pre-reductions the control flow and the data flow are simplified, so it benefits static
analysis programs to reduce the program before analyzing it.
With the presence of external programs, static analysis can "analyze the know program like canonical values, ignore the unknown part like neutral values", like C analyzers
do not deal with inline assembly and Java analyzers do not deal with (unknown) `native`
functions.

### Dependent Type Checker

(this sub-section assumes dependent type background)

In the world of dependent types, where there is not only the current expression that depends on
the context and can be reduced, but also the current expression's **expected type**.

While checking an expression against a certain type (which is also an expression), these two
little kids can both be redexes.
The compiler will be responsible for reducing both of them at the same time so the type-checking process can be customized by doing some context changing to persuade the compiler that a given
expression is of the expected type, like pattern matching, rewriting or applying some tactics.

For instance, a non-redex type signature of some commutative laws will be

```haskell
addCommutative :: (a b :: Nat) -> a + b = b + a
mulCommutative :: (a b :: Nat) -> a * b = b * a
```

where its structure can be extracted as another function (and the compiler is responsible to reduce it during type-checking),
making the source code friendly for reading and refactoring:

```haskell
commutative :: ((<>) :: a -> a -> a) -> Type
commutative (<>) = (a b :: Nat) -> a <> b = b <> a

addCommutative :: commutative (+)
mulCommutative :: commutative (*)
```

## Problems

This model seems working so far, but there are problems not yet explored.

### I Am Who I Am

If the compiler is so naive that it follows exactly what is described in the first section to
apply some partial evaluation or dependent type checking, what problems can it encounter?

```haskell
loop :: a
loop = loop

test :: loop
test = 233
```

When checking `test`, the type signature `loop` is checked first, which is a redex or a neutral value and because of recursion, it can access itself in the context, which means `loop` is a redex.

Reducing `loop` produces `loop`, which is also a redex.

Wait... There isn't an end to this?

Yes, infinite loops will cause the type-checker and the partial evaluator infinite loop.
People usually forbidden them in dependent type checkers and treat them as side-effects in partial
evaluators.

Checking termination is known to be undecidable, but we can accept only a subset of terminating
programs. The subset is usually structural-inductive programs.

### Wait a Minute

Large redexes are gonna take a long time to reduce.
Caching the reduction result can be hard, but it's possible and worthwhile.

(JIT) compiling the redexes is also possible, like we have a VM in Coq to run tactics.

## Summary

So far I have described the intersection of partial evaluation (which can be used in constant
folding, static analysis, etc.) and dependent type checking.

It’s possible to cross-apply the discoveries and solutions from these two fields to get
the best of both worlds, win-win situation, maybe?

良い世、来いよ!
