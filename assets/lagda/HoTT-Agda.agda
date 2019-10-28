{-# OPTIONS --without-K  #-}
{-# OPTIONS --cubical    #-}

module HoTT-Agda where

open import Agda.Primitive public using (lzero)
  renaming (Level to ULevel; lsuc to lsucc; _⊔_ to lmax)

open import Cubical.Data.Bool public
open import Cubical.Data.Unit renaming (tt to unit) public
open import Cubical.Data.Nat renaming (suc to S; zero to O; ℕ to Nat) public
open import Cubical.Core.Everything public
open import Agda.Builtin.Equality renaming (refl to idp; _≡_ to _==_) public
open import Cubical.Data.Prod public
open import Cubical.Data.Sum public
open import Agda.Builtin.List renaming ([] to nil; _∷_ to _::_) public

of-type : ∀ {i} (A : Type i) (u : A) → A
of-type A u = u

infix 40 of-type
syntax of-type A u =  u :> A

_++_ : {A : Set} -> List A -> List A -> List A
nil       ++ ys = ys
(x :: xs) ++ ys = x :: (xs ++ ys)

infix 40 _<_ _≤_

data _<_ : Nat → Nat → Type₀ where
  ltS : {m : Nat} → m < (S m)
  ltSR : {m n : Nat} → m < n → m < (S n)

_≤_ : Nat → Nat → Type₀
m ≤ n = (m == n) ⊎ (m < n)

<-trans : {m n k : Nat} → m < n → n < k → m < k
<-trans lt₁ ltS = ltSR lt₁
<-trans lt₁ (ltSR lt₂) = ltSR (<-trans lt₁ lt₂)

≤-trans : {m n k : Nat} → m ≤ n → n ≤ k → m ≤ k
≤-trans (inl idp) lte₂ = lte₂
≤-trans lte₁@(inr _) (inl idp) = lte₁
≤-trans (inr lt₁) (inr lt₂) = inr (<-trans lt₁ lt₂)

<-cancel-S : {m n : Nat} → S m < S n → m < n
<-cancel-S ltS = ltS
<-cancel-S (ltSR lt) = <-trans ltS lt

O<S : ∀ m → O < S m
O<S O = ltS
O<S (S m) = ltSR (O<S m)

<-ap-S : {m n : Nat} → m < n → S m < S n
<-ap-S ltS = ltS
<-ap-S (ltSR lt) = ltSR (<-ap-S lt)

infixr 80 _∘_

_∘_ : ∀ {i j k} {A : Type i} {B : A → Type j} {C : (a : A) → (B a → Type k)}
    → (g : {a : A} → (x : B a) → C a x)
    → (f : (a : A) → B a) → (a : A) → C a (f a)
g ∘ f = λ x → g (f x)

-- Application
infixr 0 _$_
_$_ : ∀ {i j} {A : Type i} {B : A → Type j} → (∀ x → B x) → (∀ x → B x)
f $ x = f x

ap : ∀ {i j} {A : Type i} {B : Type j} (f : A → B) {x y : A}
   → (x == y → f x == f y)
ap f idp = idp
