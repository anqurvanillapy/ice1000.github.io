---
layout: post
title: Functional programming language -- Arend
category: Arend
tags: Arend
keywords: Small intro to Arend
---

This article introduces Arend as a functional programming language,
assuming basic understanding of Haskell concepts.
Note: if you're an expert in dependent type theories (or HoTT), you should read
the official [tutorial] or [reference].

Well, the motivation of writing this article is weird.
I haven't been writing anything for a while because I spent all my spare time on
project Arend. Thus I thought I should write something about it.
A lot of my friends were asking me "What are you working on recently?",
"A new programming language? Tell me about it!",
"What is homotopy type theory?" because they do not
know much about dependent type theories which are assumed by official materials.
So, here's a intro to Arend as a functional programming language.

# Basic information

 [instructions]: https://github.com/JetBrains/Arend/blob/master/ARCHITECTURE.md
 [reference]: https://arend-lang.github.io/documentation/language-reference
 [tutorial]: https://arend-lang.github.io/documentation/tutorial
 [HoTT-I]: https://arxiv.org/abs/2004.14195

0. It's a purely functional programming language.
0. It doesn't compile (yet) -- there's only an interpreter and a typechecker.
   Reason: some builtin functions do not have a runtime implementation
   (they only reduce for certain cases. I'm not gonna talk about these functions
   in this little intro).
0. Its compiler is written in Java. You can easily compile it from source with JDK
   of version > 11 (and good internet connection) -- simply follow the
   [instructions].
0. Its type system is [HoTT-I].
   + In case you happened to know Cubical type
     theories, HoTT-I is just Cubical subtracting `Glue`, `glue`, `unglue` or
     `V`, `Vin`, `Vproj`. Also, it doesn't have `hcomp` and connections.
   + If you don't know any Cubical type theories, well -- you can see it as a
     dependent type system with some additional mysterious powers.
0. It's developed and maintained by a small team at JetBrains Research,
   so there's decent IDE support -- say, an IntelliJ IDEA plugin with most
   traditional JetBrains-quality IDE functionality.
   Considered the key advantage of Arend.
0. All of Arend keywords start with a backslash.
   By designing the syntax this way, keywords will never conflict variable names.
0. Arend design has something in common with Haskell
   (naming convention, operators) and Agda (telescope syntax, module system).
0. No panic, no infinite loop (neither coinduction), no axioms, no unsafe, no IO.
   No string/char literals and operations. Well, it could be added later,
   but it's not on our list yet.
0. Arend supports Java FFI, namely "language extension" or "tactics".

# Basic syntax

## Functions

To define a function in Arend, use the `\func` keyword with `=>` connecting the
function body:

```arend
-- This is a comment
\func test => 114514
```

Parameters can be defined with parenthesis-surrounded "names-colon-type" bindings
(note: `Nat` is the type for natural numbers, and `\open Nat` means import the
functions defined in the module called `Nat` into the current scope. By default,
the `+` operator for `Nat` is not in scope):

```arend
\open Nat
\func add (a : Nat) (b : Nat) => a + b
```

Note that `a: Nat` will give you syntax error because `a:` is a valid Arend name.

If two continuous parameters have the same type, you may merge their bindings
(it's a syntactic sugar):

```arend
\func add' (a b : Nat) => a + b
```

Functions are always curried:

```arend
\func add2 (a : Nat) => a +
\func add3 (a : Nat) => + a
\func add4 (a : Nat) => add a
\func add5 (a : Nat) => add' a
\func add6 => add
```

All of the above functions are doing the same thing
(though some of them reverse the order of two of its parameters).

You may also explicitly annotate the return type of a function:

```arend
\func add7 (a b : Nat) : Nat => a + b
```

Arend mostly follows Haskell's naming convention for functions.

## Data types and pattern matching

You can define data types using the `\data` keyword:

```arend
\data Bool
  | true
  | false
```

The above code snippet defines a datatype namely `Bool`, with two constructors
`true` and `false` (separated with vertical bars), both with no arguments.
Arend contradicts Haskell's naming convention on constructors -- it's uncapitalized.

You may add datatype and constructor parameters just like function parameters:

```arend
\data Maybe (A : \Type)
  | nothing
  | just (a : A)
```

Well, you can omit the bound name if it's unused:

```arend
\data Maybe' (A : \Type)
  | nothing'
  | just' A
```

In comparison to Haskell:

```haskell
data Maybe' a = Nothing' | Just' a
```

The only additional boilerplate is that you need to specify the type of the
_type parameter_ explicitly -- and it's because Arend's type system is too
complicated for some type inference mechanism you were familiar with before.

To write a pattern matching function, there are many ways -- by using clauses,
or case expression. Both of which are similar to the one in Haskell.

```arend
-- Note that there are two patterns
\func and (a b : Bool) : Bool
  | true,  b => b
  | false, _ => false
```

```arend
\func or (a b : Bool) : Bool => \case a \with
  | true  => true
  | false => b
```

Syntactic sugar for LambdaCase in Haskell: `\case __ \with`.

There is also a syntactic sugar for pattern matching w.r.t. only one parameter:

```arend
\func or' (a b : Bool) : Bool \elim a
  | true  => true
  | false => b
```

Note that pattern matching needs to be **total**, say, you cannot omit any clauses.
Also, recursive functions must be defined by clauses
(there is one more restriction namely structural induction, which I do not want to
talk about in this little intro).

Also, type aliases are simply functions:

```arend
\func MyFancyBool : \Type => Bool

\func and' (a b : MyFancyBool) : MyFancyBool
  | true,  b => b
  | false, _ => false
```

# Functions and tuples

A lambda in Arend looks like `\lam (a : Nat) => a + 1`,
its type looks like `\Pi (a : Nat) -> Nat`.
Since the type of `a` can be inferred and is not used in the return type here,
you can simplify them as `\lam a => a + 1` and `Nat -> Nat`.

A tuple in Arend looks like `(1, 2, 3)`, its type looks like `\Sigma Nat Nat Nat`.
Since the three elements of which are of the same type, we can combine their binding
into `\Sigma (a b c : Nat)`.

# Other features

Arend also supports (I'm trying my best to use terminology from Haskell):

0. Typeclasses and instances (brute-force instance resolution) with
   `\extends` subclassing
0. Records and projections
0. Higher kinded types
0. Something absent from GHC Haskell including:
   0. Type lambdas (available in UHC Haskell)
0. Haskell extensions including:
   0. RankNTypes
   0. TypeFamilies
   0. GADTs
   0. Functional dependencies

Arend has a REPL, but it's in a dev branch (developed primarily by me!).
Basic functionality in GHCi are stolen, like `:t`, `:?`, `:load Bla.ard`, etc.
There's also completion for keywords and global functions.
Here's a complete list of REPL commands until 16, May 2020:

```
>:?
There are 13 commands available.
:quit      Quit the REPL
:type      Show the synthesized type of a given expression
:normalize Modify the normalization level of printed expressions
:libraries List registered libraries in the REPL
:?         Show this message (`:? [command name]` to describe a command)
:modules   List all loaded modules
:unload    Unload an Arend module loaded before
:load      Load an Arend module from working directory
:reload    Reload the module loaded last time
:prompt    Change the repl prompt (current prompt: '>')
:lib       Load a library of given directory or arend.yaml file
:pwd       Show current working directory
:cd        Modify current working directory
Note: to use an Arend symbol beginning with `:`, start the line with a whitespace.
```

It has also got a fancy, beautiful but stupid, pointless ASCII-art banner:

```
>java -jar cli-1.3.0-full.jar -i
    ___                       __
   /   |  _______  ____  ____/ /
  / /| | / __/ _ \/ __ \/ __  /  Arend REPL 1.3.0
 / ___ |/ / /  __/ / / / /_/ /   https://arend-lang.github.io
/_/  |_/_/  \___/_/ /_/\__,_/    :? for help
```
