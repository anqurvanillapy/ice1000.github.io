---
layout: post
title: Membership proofs and De Bruijn indices
category: PLT
tags: PLT, Agda
keywords: PLT
agda: true
description: Membership proofs and De Bruijn indices
---

```
{-# OPTIONS --cubical #-}
module 2020-1-19-DeBruijnIndex where

open import Cubical.Data.Bool
open import Cubical.Data.List
open import Cubical.Data.Maybe
open import Cubical.Data.Prod
open import Cubical.Data.Sigma hiding (_≡_)
open import Cubical.Foundations.Function
open import Cubical.Relation.Nullary

open import Agda.Builtin.Equality
open import Agda.Builtin.Nat
open import Agda.Builtin.String

variable A : Set
```

This post requires basic knowledge on dependent type programming,
in the sense that Idris people would prefer.
Though I imported cubical libraries, I didn't mean to use the cubical features they provide.
I just need a working list definition and basic operations on an equality type.

# The "contains" relation

In a dependent type setting, we can define propositions as types.
Like, the "contains" relation is a type:

```agda
infix 4 _∈_
data _∈_ {A : Set} (a : A) : List A -> Set where
  here  : (as : List A) -> a ∈ a ∷ as
  there : ∀ {as c} -> (a ∈ as) -> a ∈ c ∷ as
```

We can observe some trivial "contains" facts:

```agda
_ : 1 ∈ 1 ∷ 3 ∷ []
_ = here (3 ∷ [])

_ : 1 ∈ 2 ∷ 1 ∷ []
_ = there (here [])

_ : 1 ∈ 2 ∷ 1 ∷ 3 ∷ []
_ = there (here (3 ∷ []))
```

We can see that `here` is the proof that a list contains its head,
and `there` is the proof that if a list contains something, appending anything
to the list head will still make the appended list contain the thing.
We can generalize `there` to list concatenation:

```agda
theres : ∀ {as bs : List A} {a} -> a ∈ bs -> a ∈ (as ++ bs)
theres {as = []} p = p
theres {as = _ ∷ _} p = there (theres p)

theres′ : ∀ {as bs : List A} {a} -> a ∈ as -> a ∈ (as ++ bs)
theres′ (here as) = here (as ++ _)
theres′ (there p) = there (theres′ p)
```

# Syntax with binding

One straightforward application of this "contains" property is "syntax with binding",
say, a syntax tree definition with binding (lambda abstraction and application)
(we're talking about simple syntax with binding here -- no HOAS/PHOAS).
We use names (say, strings) to represent references.
First, let's assume that `String` has decidable equality:

```agda
decEqStr : (a b : String) -> Dec (a ≡ b)
decEqStr a b with primStringEquality a b
... | true = yes p where postulate p : _
... | false = no p where postulate p : _
```

The language will be typed, and will have a primitive type `nat` and the function type:

```agda
infixr 7 _=>_
data Ty : Set where
  nat  : Ty
  _=>_ : Ty -> Ty -> Ty
variable a b c d : Ty
```

And equality on `Type` is decidable:

```agda
argEq : a => b ≡ c => d -> (a ≡ c) × (b ≡ d)
argEq refl = refl , refl

decEqTy : (a b : Ty) -> Dec (a ≡ b)
decEqTy nat nat = yes refl
decEqTy nat (_ => _) = no (λ ())
decEqTy (a => b) nat = no (λ ())
decEqTy (a => b) (c => d) with decEqTy a c
... | no nrefl = no (nrefl ∘ proj₁ ∘ argEq)
... | yes refl with decEqTy b d
... | yes refl = yes refl
... | no nrefl = no (nrefl ∘ proj₂ ∘ argEq)
```

Let's define `Name` as `String`, and `Ctx` (short for "Context") as a list of typed bindings
(so it's simply-typed, not dependently-typed):

```agda
Name = String
Ctx = List (Name × Ty)
```

And here's the syntax tree definition.
Terms are required to be well-typed and well-scoped,
so it should contain the context the term is typed:

```agda
data Term (Γ : Ctx) : Ty -> Set where
```

`lit` creates `nat` literals and `suc` finds the successor of `nat`s,
both should be well-typed under any context:

```agda
  lit : (n : Nat) -> Term Γ nat
  suc : Term Γ (nat => nat)
```

Application only happens when the function's type is respected:

```agda
  app : Term Γ (a => b) -> Term Γ a -> Term Γ b
```

Then let's look into bindings.
A variable reference should contain the name and a proof that the name is in-scope:

```agda
  var : (x : Name) (i : (x , a) ∈ Γ) -> Term Γ a
```

An abstraction extends the context of the body term:

```agda
  lam : (x : Name) (a : Ty) -> Term ((x , a) ∷ Γ) b
      -> Term Γ (a => b)
```

We don't even need to implement context lookup -- the information of the binding is already
stored in the proof term of "contains", say, in the arguments of the constructors of `∈`.

# Fact: `∈` proofs are de Bruijn indices

But what **actually** is a proof of `∈`?
The proof of `∈` is structurally isomorphic to a natural number
(`here` corresponds to `zero`, `there` corresponds to `suc`), if we omit the arguments of its constructors.
The natural number isomorphic to the proof of `∈` itself is essentially the **index** of the element
(in our case it's the binding in the context) in the list.
So what we stored in the variable references are their bindings' corresponding indices in the context!

In fact, the `lookupVar` function that tries to find a name in the context is
essentially finding the index of the name:

```agda
lookupVar : (Γ : Ctx) (x : Name) -> Dec (Σ Ty λ a → (x , a) ∈ Γ)
lookupVar [] x = no λ ()
lookupVar ((y , t) ∷ Γ) x with decEqStr x y
... | yes refl = yes (t , here Γ) -- return `zero`
... | no nrefl with lookupVar Γ x
... | no nex = no λ
  { (s , here .Γ) -> nrefl refl
  ; (s , there p) -> nex (s , p)
  }
... | yes ex = yes (ex .fst , there (ex .snd))
          -- ^ return `suc <induction result>`
```

An interesting fact is that it is enough to store only the index of the binding in
variable reference terms.
The indices we're using here is also known as **De Bruijn Indices**.

Note: we'll need to really lookup the context to obtain the type of a binding if the constructor arguments
of `∈`'s proof are omitted, though.

# Remark: terms from different contexts

In our setting, terms are bounded with the context they are formed under.
This means that when we want to, say, do some term substitution,
(so two terms go together into one)
we need to ensure the terms are from the same context.

Example: apply a term `e` onto a lambda term `f` requires `e` and `f` to be formed
under the same context (this fact can be told from the parameters of `Term.app`).
Imagine `f` is of form `λ x. a` where `a` is a term, we can tell from the parameters
of `Term.lam` that `a` is formed under a context extended from the context where `f`
and `e` are formed. Therefore we cannot simply substitute `x := e` into `a`,
because `a` and `e` are from different contexts.
This implies that we need to append `x` into the context of `e`
before substitution, say, plus one to all the indices inside `e`
(we refer to this operation as "shifting" or "weakening").

In fact, we can extend the context with any arbitrary contexts:

```agda
extendCtx : ∀ {Γ Θ a} -> Term Γ a -> Term (Γ ++ Θ) a
extendCtx (lit n) = lit n
extendCtx suc = suc
extendCtx (app f e) = app (extendCtx f) (extendCtx e)
extendCtx (var x i) = var x (theres′ i)
extendCtx (lam x a p) = lam x a (extendCtx p)
```

Note that this `extendCtx` doesn't touch the name of the variables.
The variable references still refer to correct binding even there's name shadowing.

There's a common mistake for those who try to implement syntax with binding
via de Bruijn indices, say, forgetting to shift the indices of the substituted term.
Now with dependent types, we gain a thorough understanding of why should we shift
the indices before substitution.
The same thing also happens for "taking a binding from the context"
when dealing with let bindings or typed bindings under dependent types --
the bindings themselves are from a different (though weaker, because they're from a
outer scope with fewer variables) context, so we need to shift them before
using them under the inner contexts.

I have jumped into the hole of "forgetting to shift de Bruijn indices" when
developing [Voile] and [Narc]. That's also the motivation for writing this post.
I hope this will help dependent type implementors.

 [Voile]: https://lib.rs/voile
 [Narc]:  https://lib.rs/nar

