---
layout: post
title: Type inference under dependent type (meta variables)
category: PLT
tags: Haskell Agda Dependent-Type
keywords: Haskell Agda Dependent-Type
description: The simplest way of solving meta variables
---

In non-dependent type programming languages where types are distinct from values,
we can omit type information sometimes to let the compiler (type-checker) to infer
the omitted types, like what you're doing in Haskell (or even in weaker type systems,
such as Kotlin's, or C#'s).

In case the language is dependently-typed,
the situation is slightly different.
Since their way of writing parametrically-polymorphic functions
is to have an extra argument:

```haskell
identity :: (a : Type) -> a -> a
identity _ a = a
```

Thus the application of such function will require an explicit type application:

```haskell
twoThreeThree :: Int
twoThreeThree = identity Int 233
```

which is stupid.

## Meta variables

One solution, is to introduce a new language concept called "meta variables".
It's like a "hole" in the program (previously you may heard about it
when people were talking about type-directed development).

A "meta variable" is an expression whose **value** is **inferred** contextually.
Since type inference is generally synthesizing a type from context,
in a type system where there's no distinction between types and values,
synthesizing a type is just like synthesizing a value.
So in the end we'll have a more powerful inference facility,
which can infer both types and values.

The type-checker is responsible for figuring out a value that can make the whole
program well-typed after replacing the meta variable with this it.
The _value_ here is called the **solution** to the meta variable,
and the process of figuring out this value is called _solve meta_.

Normally, a meta variable is written as an underscore.
We rewrite the above code using meta variable:

```haskell
twoThreeThree :: Int
twoThreeThree = identity _ 233
```

But how does a type-checker _solve_ this meta variable?

<br/><br/><br/><br/>
<br/><br/><br/><br/>
<br/><br/><br/><br/>

Let's look into the implementation detail of the dependent type-checker.

## Solve meta

A common implementation of a dependent-type checker is bidirectional:
it checks an expression against a type by applying some certain rules,
and fallback to type inference and compare the inferred the type with
the expected type.

This process can be expressed using this pseudo-code:

```haskell
-- | Infer the type of an expression, may fail
infer :: Expr -> Monad Expr

-- | expression, expected type
check :: Expr -> Expr -> Monad ()
check (Lam bla) (PiType rua) = do blabla
check (CaseSplit bla) (PiType rua) = do blabla
check (Pair bla) (SigmaType rua) = do blabla

-- here's the important fallback part!
check expr ty = do
  inferred <- infer expr
  inferred `compareTerm` ty
```

As we can see there's a fallback case,
where it happens when checking against an complex expression such as an application:

```haskell
-- here's the important fallback part!
check expr ty = do
  inferred <- infer expr
  inferred `compareTerm` ty
```

We need a function that compares if two terms are equivalent!
Which means that we can solve metas here, it's gonna be something like:

```haskell
compareTerm :: Expr -> Expr -> Monad ()
```

And thus we can have some meta-solving clauses like this:

```haskell
compareTerm Meta Meta = throwError CannotSolveMeta
compareTerm Meta a = solveMeta a
compareTerm a Meta = solveMeta a
```

But how should we implement `solveMeta`?
Since this looks like we'll need to modify the `Meta` terms
(we hope our AST to be immutable).

A simple solution will be letting the `compareTerm` function
return the two terms if they're equaled, like this:

```haskell
compareTerm Meta a = pure (a, a)
compareTerm a Meta = pure (a, a)
```

And then `compareTerm` becomes an AST mapper.

This, is possible, but not nice enough.

A simple case that the code above can't to solve will be,
I have a `Meta` whose current solution will be invalidated in later type-checking.

For instance, I can have a meta that is required to be equal to `Int` **and** `Bool`
at the same time, which means it's an unsolvable meta.
If we use the above "`compareTerm` as AST mapper" strategy,
the error message will be something like "`Int` is not equal to `Bool`",
which is very misleading (because we first solve the meta to `Int`,
then require this "solved" `Int` to be equal to `Bool`.
The user did not write this `Int` himself!).

Further more, I can have one meta value used in many places,
like `(\ a -> expr) _` where `a` occurred multiple times in `expr`.

I can't mutate the other occurrences of the inlined `a`!
This is bad.

## Meta references

Now we have the design of "meta references".
Meta variables become global references to something in your context,
and when you solve a meta, you mutate the context;
when you're trying to compare two terms while one
of them is an already solved meta,
you'll need to compare the referred solution in the context with the other term.

Pseudo code:

```haskell
compareTerm (Meta id) a = solveMeta id a
compareTerm a (Meta id) = solveMeta id a

solveMeta :: MetaId -> Expr -> Monad ()
solveMeta id a = do
  ctx <- get
  case lookupSolution ctx id of
    Just solution -> solution `compareTerm` a
    Nothing -> do
      put $ updateSolution ctx a
      pure ()
```

Now you've got a meta solver!

## Further reading

+ [Elaboration Zoo: holes](https://github.com/AndrasKovacs/elaboration-zoo/tree/master/03-holes)
+ [Ulf Norell and Catarina Coquand. Type checking in the presence of metavariables](http://www.cse.chalmers.se/~ulfn/papers/meta-variables.pdf)
+ Agda thesis
