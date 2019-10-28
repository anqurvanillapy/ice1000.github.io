---
layout: post
title: Different styles of equality reasoning
category: PLT
tags: PLT, Agda
keywords: PLT
agda: true
description: Different styles of equality reasoning
---

```
{-# OPTIONS --cubical --safe #-}
module 2019-4-21-CuttMltt where
import Agda.Builtin.Equality as MLTT
import Cubical.Core.Everything as CUTT
import Agda.Builtin.Nat as MNat
import Cubical.Data.Nat as CNat
private variable A B : Set
```

In dependently-typed programming languages, we do equality proofs.

Type Theory folks formed two groups; one stands for "proofs are not important",
one stands for "proofs are important".
Someone claims that the identity proof between two objects is unique -- which
is related to the K rule.
The other people believe that the proof of identity is significant -- the same
theorem can
have different proofs, where the identity relation on these *proofs* are also
nontrivial and can be proved to be equivalent or not.

# Intuitionistic Logic

First, let's take a look at the world of unique identity proofs.

```
module Intuitionistic where
 open MLTT
 open MNat
```

In Intuitionistic Logic, we can prove new theorems via pattern matching on existing theorems,
because identity proofs are instances of the equality type:

```
 trans : {a b c : A} → a ≡ b → b ≡ c → a ≡ c
 trans refl refl = refl

 sym : {a b : A} → a ≡ b → b ≡ a
 sym refl = refl

 cong : {a b : A} → (f : A → B) → a ≡ b → f a ≡ f b
 cong _ refl = refl
```

or we can use `rewrite`, which is syntactic sugar of pattern matching
(and this definition is more Idris style):

```
 trans₁ : {a b c : A} → a ≡ b → b ≡ c → a ≡ c
 trans₁ p q rewrite p = q

 cong₁ : {a b : A} → (f : A → B) → a ≡ b → f a ≡ f b
 cong₁ _ p rewrite p = refl
```

These three functions, `trans`, `sym` and `cong` are our equality proof
combinators.

Larger and more concrete theorems, such as the plus commutative law:

```
 +-comm : ∀ a b → a + b ≡ b + a
```

can be proved by induction -- the base case is simply `a ≡ a + 0`,
where we can introduce a lemma for it:

```
 +-comm zero b = +-zero b
```

... and we prove the lemma by induction as well:

```
  where
  +-zero : ∀ a → a ≡ a + 0
  +-zero zero = refl
  +-zero (suc a) = cong suc (+-zero a)
```

Very small theorems can be proved by induction trivially using
a recursive call as the induction hypothesis and let the `cong`
function to finish the induction step.

Combining induction and our `trans` combinator we get the induction
step of the proof of the plus commutative law:

```
 +-comm (suc a) b = trans (cong suc (+-comm a b)) (+-suc b a)
  where
  +-suc : ∀ a b → suc (a + b) ≡ a + suc b
  +-suc zero _ = refl
  +-suc (suc a) b = cong suc (+-suc a b)
```

On the other hand, even large theorems such as the plus commutative law
can also be proved without the help of lemmas.

Here's an example, by exploiting the `rewrite` functionality:

```
 +-comm₁ : ∀ n m → n + m ≡ m + n
 +-comm₁ zero zero = refl
 +-comm₁ zero (suc m) rewrite sym (+-comm₁ zero m)  = refl
 +-comm₁ (suc n) zero rewrite +-comm₁ n zero = refl
 +-comm₁ (suc n) (suc m) rewrite +-comm₁ n (suc m)
  | sym (+-comm₁ (suc n) m) | +-comm₁ n m = refl
```

What does `rewrite` do?
Let's look at it in detail.

To prove this theorem, whose goal is `a + c ≡ b + d`,

```
 step-by-step : ∀ {a b c d} → a ≡ b → c ≡ d → a + c ≡ b + d
 step-by-step {b = b} {d = d} p q
```

we first rewrite with `p`, which turns the goal to `b + c ≡ b + d`,
then rewrite with `q`, which turns the goal to `b + d ≡ b + d`,

```
  rewrite p | q
```

which is a specialized version of `refl`:

```
  = refl {x = b + d}
```

It's like we're destructing our goal step by step and finally turn it into a specialized `refl`.

For more complicated proofs, we're not only destructing the goal -- we're also constructing
terms that can be used to destruct the goal.
`rewrite` is how we *use* the constructed terms to destruct terms.

Our proof is *bidirectional*.

# Cubical model

What if the identity proofs are not trivial?

```
module Cubical where
 open CUTT using (_≡_; I; ~_; hcomp; inS; hfill; i0; i1)
 open CNat
```

In the Cubical model, there's no pattern matching because you can never tell
how many proofs there can be (so no case analysis).
Instead, there are interval operations that can construct proofs via existing proofs
in a more detailed way.

Inverting an interval is `sym`:

```
 sym : {a b : A} → a ≡ b → b ≡ a
 sym p i = p (~ i)
```

Creating a new interval by combining an old path with an arbitrary function
is `cong`:

```
 cong : {a b : A} (f : A → B) → a ≡ b → f a ≡ f b
 cong f p i = f (p i)
```

`trans` is far more complicated -- you'll need cubical kan operation:

```
 trans : {a b c : A} → a ≡ b → b ≡ c → a ≡ c
 trans p q i = hfill (λ { j (i = i0) → p i; j (i = i1) → q j}) (inS (p i)) i
```

Although we lose the ability to `rewrite`, we still have our combinators -- `sym`, `cong` and `trans`,
which means that several existing proofs are still perfectly valid under the Cubical model.

On the other hand, according to the design of `Path` types, some proofs become perfectly
natural. For instance, the `step-by-step` theorem shown above can be proved by:

```
 step-by-step : ∀ {a b c d} → a ≡ b → c ≡ d → a + c ≡ b + d
 step-by-step p q i = p i + q i
```

There can also be equality on functions, which is not even possible in the
Intuitionistic type theory:

```
 funExt : {f g : A → B} → (∀ x → f x ≡ g x) → f ≡ g
 funExt p i a = p a i
```

# Obvious Conclusions

+ The Cubical model introduces tons of primitives while it's fairly more powerful
  than the Intuitionistic type theory
+ Cubical model is harder implementation-wise
+ Intuitionistic type theory is more friendly for letting the compiler to solve some
  unification problems
+ Both of these two models are not gonna save Agda
