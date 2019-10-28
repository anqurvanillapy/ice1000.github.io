---
layout: page
title: Documentation for VitalyR
description: Documentation for VitalyR
comments: true
permalink: /pages/vitalyr-normalizer.html
---

VitalyR is a untyped lambda calculus normalizer
built as an IntelliJ IDEA plugin.
It is common sense that lambda calculus does not normalize,
so we can easily tell that VitalyR does not terminate.
VitalyR normalizes your term in an IDE background process,
so when your term do not normalize (y-combinator, for instance),
you can see that the background process runs for a long time.
Usually you click the cancel button to cancel an infinite loop normalization.

## Syntax overview

```
-- Line comments are supported, no block comments

-- Global definition, starts with lambda keyword,
-- with a name and a body
lambda a = a

-- Lambda abstraction is similar to Haskell
lambda id = \a. a

-- Application syntax is same as Haskell
-- You can use parenthesis if you need to / want to
lambda idid = id id id id
```

Identifiers are parsed using this regex:

```regexp
[a-zA-Z_'\-/][a-zA-Z0-9_\-'\\/]*
```

## How to install

Open `Settings | Plugins | Marketplace` in your IntelliJ IDE,
search for _Dependently-Typed Lambda Calculus_ and install the plugin.
The plugin is compatible with all IntelliJ-based IDEs starting from the version 2019.1.4, which is quite old.

## How to use

Create a VitalyR file via right click on a file and
`New | New Type Theory File | VitalyR File`,
type in your file name, and you got a file!

To normalize a definition,
press <kbd>Alt</kbd>+<kbd>Enter</kbd> on that definition,
ensure your file has syntactically correct and well-scoped terms.

## Normalization

The normalizer will try to beta-reduce and your application terms
and un-eta your lambda terms.
When there's naming clashes, such as `\a. (\b. \a. b) a`
(which, according to lexical scoping, should evaluate to `\b. \a. b`,
but if you directly reduce it, it'll become `\a. \a. \a`),
the outermost abstraction will be renamed (by adding a `_` prefix).
