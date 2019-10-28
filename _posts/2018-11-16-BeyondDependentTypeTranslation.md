---
layout: post
title: The World Over Dependent Types
category: PLT
tags: PLT, Agda
keywords: PLT
katex: true
description: How to improve dependent type
---

This was originally an answer to a Q&A website question.
The question is,

> Disregarding Esolang, what can we add to a PL when there's already dependent types? Or, what extensions can be built
> on top of dependent type systems?

First of all, considering the three dimensions of the Lambda Cube,
most PLs are already equipped with $ \lambda 2 $ (term dependent on type) and they call it *polymorphism*.
Idris and Agda supports this too, so does Haskell with extensions.
Shame on you, OCaml.

Then, $ \lambda \omega $ and $ \lambda \Pi $ usually comes together. Consider $ \lambda \Pi $, disregarding simple PLs'
(like Kotlin, Java) Type Constructors, PLs with Type Level operations like C++, Scala can all do something dependently-typedly
(aka $ \lambda \Pi $), though limited (like no exhaustiveness check on sums, no termination check but limit the size of expansion).

Therefore those qualified Proof Assistants are all on the top of Lambda Cube, they have the other corners for free when
supporting dependent types. There's no much space for them to improve.
So, we can see from another perspective -- forget about the word 『type system』, but
focus on some side features (or, add-ons) of type systems, or improve the PL industrially.

+ Metaprogramming, which is featured in Typed Racket. Cliché PLs like Agda and Idris have Reflection as well. Coq even
  encourage you to ltac everywhere. Proof Assistants without macros lose the chance of engineering your proofs completely.
+ Make the unification during pattern matching more Hackable, like without-K in Agda (it was a simple check during
  case-split -- allowing only canonical terms in indices, causing instances of types like $ a + b \equiv c $ can matched
  as `refl` but not for $ a \equiv b + c $ and a weakened form of K rule is actually allowed, but now it's fixed by
  Jesper Cockx), with `postulate`d univalence axiom it can model HoTT. Idris haven't even considered this.
+ Termination checking Coinductive Data Types (aka guarded recursion). Agda provides nice [copattern](/lagda/MuGenHackingToTheGate.html)
  (link is mandarin) (normal patterns destruct data constructed with constructors, while copatterns pattern match on the
  process of destruction) and bad (personally speaking) Size-Types (I had a bad impression on it when playing with
  `Codata.Conat`). I don't know much about this in other PLs
+ Cubical models (interval operations)
+ Refinement Types, Like $F \star$'s `Lemma` which is a refined unit type. This requires an (external) SMT solver, though
+ Effect management, let the compiler to do such trivial jobs like capture monadic contexts
  + 『Jojo, after my yaers of experience with Monad Transformers I realized that, the power of do notation is limited ——
     not matter how great it inlines your lambdas, no matter how much helpers like `liftM`, `liftA` is provided, their
     heavy pressure on human brain is never reduced.』
  + 『What do you mean?』
  + 『I reject my State Monads, Jojo!』

In conclusion we can see that PLs like Agda, Idris are far above dependent types.

That's all, at least in my humble sight.


By the way, all these goodies are strongly coupled with the compile-time type checker, which means that it's impossible
in dynamic languages like JavaScript. After type-checking, things ("Views") like `refl` are just a singleton. Passing it
around is pointless at runtime.

[Origin](https://www.zhihu.com/question/296873212/answer/525067923).
