---
layout: post
title: REPLs with Typed Holes
category: Arend
keywords: Repl Goals Arend Agda Idris F#
---

I have made a comparison among several programming languages with REPL and
typed holes (well, maybe not natively) support, including Arend, GHC Haskell,
PureScript, F#, Agda, Idris, Idris2, and the experimental language for the
CHM paper, cubicaltt.
I have the [original gist](https://gist.github.com/ice1000/c20426a218c7b08374e71985734a7b39).

Note that Agda REPL is abandoned, cubicaltt is experimental, Arend REPL is
not even merged into the master branch, and Idris2 is still under active
development.

I made this because I was working on a REPL for Arend, in both [cli] and [IDE],
and I need others' work in the industry as references.
I hope this can be helpful to you as well.

 [cli]: https://github.com/jetbrains/arend/pull/210
 [IDE]: https://github.com/jetbrains/intellij-arend/pull/188

Here's a simple table as a summary (converted from Excel via <https://thisdavej.com/copy-table-in-excel-and-paste-as-a-markdown-table>):

| Language    | Arend    | GHC Haskell | PureScript     | F#        | Agda        | Idris      | Idris2       | cubicaltt  |
|-------------|----------|-------------|----------------|-----------|-------------|------------|--------------|------------|
| Type system | HoTT-I   | System F    | System F       | System F  | Cubical TT  | MLTT       | MLTT+QTT     | Cubical TT |
| Typed holes | Builtin  | Builtin     | Builtin        | Hacky     | Builtin     | Builtin    | Builtin      | Builtin    |
| Expressions | Hidden   | Hidden      | Hidden         | Printed   | Evaluated   | Elaborated | Elaborated   | Printed    |
| Builtin `+` | type Nat | class Num   | class Semiring | type int  | type Nat    | class Num  | class Num    | N/A        |
| Startup     | Fast     | Fast        | Very slow      | Fast      | Fast        | Slow       | Fast         | Fast       |
| Status      | Head     | Stable      | Stable         | Stable    | Abandoned   | Stable     | Experimental | Toy        |
| Based on    | Nothing  | Nothing     | Project        | Nothing   | File        | Nothing    | Nothing      | File       |
| Banner      | √        | ×           | ×              | ×         | √           | √          | √            | ×          |
| Candidates  | ×        | ×           | √              | ×         | ×           | ×          | ×            | ×          |
| Syntax      | `{?A}`   | `_A`        | `?A`           | N/A       | `?`, `{!!}` | `?A`       | `?A`         | `?`        |
| Named hole  | Optional | Optional    | Enforced       | ×         | ×           | Enforced   | Optional     | ×          |
| Completion  | √        | √           | √              | √         | ×           | √          | ×            | ×          |
| Help        | `:?`     | `:?`        | `:?`           | `#help;;` | `:?`        | `:?`       | `:?`         | `:h`       |
| Quit        | `:q`     | `:q`        | `:q`           | `#quit;;` | `:q`        | `:q`       | `:q`         | `:q`       |

Below is my experiment.

## Arend

```
λ> java -jar cli-1.3.0-full.jar -i
    ___                        __
   /   |  _______  ____  ____/ /
  / /| | / __/ _ \/ __ \/ __  /  Arend REPL 1.3.0
 / ___ |/ / /  __/ / / / /_/ /   https://arend-lang.github.io
/_/  |_/_/  \___/_/ /_/\__,_/    :? for help

>\open Nat
>1 + {?}
[GOAL] Repl:1:5: Goal
  Expected type: Nat
  In: {?}
>:q
```

## GHC Haskell

```
λ> ghci
GHCi, version 8.8.3: https://www.haskell.org/ghc/  :? for help
Prelude> 1 + _

<interactive>:1:5: error:
    • Found hole: _ :: a
      Where: ‘a’ is a rigid type variable bound by
               the inferred type of it :: Num a => a
               at <interactive>:1:1-5
    • In the second argument of ‘(+)’, namely ‘_’
      In the expression: 1 + _
      In an equation for ‘it’: it = 1 + _
    • Relevant bindings include it :: a (bound at <interactive>:1:1)
      Constraints include Num a (from <interactive>:1:1-5)
Prelude> :q
Leaving GHCi.
```

## PureScript Spago

(Modified to remove the "\[info]" stuffs and "Compiling" logs)

```
λ> spago repl
PSCi, version 0.13.6
Type :? for help

import Prelude

> 1 + ?A
Error found:
in module $PSCI
at :1:5 - 1:7 (line 1, column 5 - line 1, column 7)

  Hole 'A' has the inferred type

    Int

  You could substitute the hole with one of these values:

    $PSCI.it             :: Int
    Data.Bounded.bottom  :: forall a. Bounded a => a
    Data.Bounded.top     :: forall a. Bounded a => a
    Data.Semiring.one    :: forall a. Semiring a => a
    Data.Semiring.zero   :: forall a. Semiring a => a


in value declaration it

See https://github.com/purescript/documentation/blob/master/errors/HoleInferredType.md for more information,
or to contribute content related to this error.


> :q
See ya!
()
```

## F#

```
λ> fsi

Microsoft (R) F# Interactive version 10.8.0.0 for F# 4.7
Copyright (c) Microsoft Corporation. All Rights Reserved.

For help type #help;;

> let __<'a> = failwith "typed hole";;
val __<'a> : obj

> 1 + __;;

  1 + __;;
  ----^^

stdin(2,5): error FS0001: The type 'obj' does not match the type 'int'

> #quit;;
```

## Agda

```
λ> cat A.agda
{-# OPTIONS --allow-unsolved-metas #-}
open import Agda.Builtin.Nat
λ> agda -I A.agda
                 _
   ____         | |
  / __ \        | |
 | |__| |___  __| | ___
 |  __  / _ \/ _  |/ __\     Agda Interactive
 | |  |/ /_\ \/_| / /_| \
 |_|  |\___  /____\_____/    Type :? for help.
        __/ /
        \__/

The interactive mode is no longer under active development. Use at your own risk.
Main> 1 + ?
suc ?0
Main> :metas
?0 : Nat
Main> :q
```

## Idris

```
λ> idris
     ____    __     _
    /  _/___/ /____(_)____
    / // __  / ___/ / ___/     Version 1.3.2-git:0417c53fb
  _/ // /_/ / /  / (__  )      https://www.idris-lang.org/
 /___/\__,_/_/  /_/____/       Type :? for help

Idris is free software with ABSOLUTELY NO WARRANTY.
For details type :warranty.
Idris> 1 + ?A
prim__addBigInt 1 ?A : Integer
Holes: A
Idris> :q
Bye bye
```

## Idris 2

```
λ> idris2
     ____    __     _         ___
    /  _/___/ /____(_)____   |__ \
    / // __  / ___/ / ___/   __/ /     Version 0.1.0-18b644965
  _/ // /_/ / /  / (__  )   / __/      https://www.idris-lang.org
 /___/\__,_/_/  /_/____/   /____/      Type :? for help

Welcome to Idris 2.  Enjoy yourself!
Main> 1 + ?A
prim__add_Integer 1 ?A
Main> :q
Bye for now!
```

## cubicaltt

(Modified to remove the "Parsed successfully" and "Checking" logs)

```
λ> cubical nat.ctt
cubical, version: 1.0  (:h for help)

Loading "nat.ctt"
Warning: the following definitions were shadowed [retIsContr]
File loaded.
> add (suc zero) ?

Hole at (1,16) in :

--------------------------------------------------------------------------------
nat

EVAL: add (suc zero) ?
> :q
```
