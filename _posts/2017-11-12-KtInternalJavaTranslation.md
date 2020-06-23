---
layout: post
title: Tricks in using Kotlin `internal`
category: Kotlin
keywords: Kotlin
description: Kotlin internal
---

A well-known problem of Kotlin's `internal` accessibility modifier is that it's actually compiled to
`public` on JVM level so it's possible to access a Kotlin module's `internal` definitions with non-Kotlin
projects if using the Kotlin module as an external jar, which violates the design purpose of the `internal`
modifier -- it's defined as *only accessible in the current module* while the concept of *module* is
Kotlin-specific.

### Disclaimer

Reflection can still violate anything. This article will not consider reflections.
(even `private` definitions are accessible via reflections!)

I'll introduce a very tricky solution here.
It's essentially taking advantage of Java's poorness of its syntax.

Consider this `internal` function in Kotlin:

```kotlin
internal fun zython() {
}
```

we can access it in another Java module.
Kotlin compiler will complain about an access violation if it's aware of this cross-module invocation,
while Java (or Scala, Ceylon, Eta, etc.) programmers can isolate the Kotlin compiler from this invalid
access.

## Method One

Use `@JvmName`.

This annotation specifies the name of the function generated in Java bytecode, which can be different from
the function name in Kotlin.
The function name in Kotlin code can still be used, but only in Kotlin.

We can specify a name that is not a valid Java (or Scala, Ceylon, Eta, etc.) identifier.

Like, prefixing the function name with a space.

```kotlin
@JvmName(" zython")
internal fun zython() {
}
```

or if you like Haskell you may do:

```kotlin
@JvmName("{-# LANGUAGE Zython #-}")
internal fun zython() {
}
```

In this way we're restricting the invocation of this function to Kotlin only, because you simply cannot
refer to this function in non-Kotlin languages (except using reflection, which is already claimed to be not
considered).

To invoke this function in another module, Kotlin is needed, while Kotlin compiler will reject this invocation because it's `internal`.

[Try it online!](https://tio.run/##y84vycnM@//fwass1y8xN1VDqVpXWcHH0c891NHdVSGqsiQjP09BWbdWSZMrM68ktSgvMUchrTRPoQoso6GpUM1Vy8UFEslNzATxbeFS//8DAA "Kotlin – Try It Online")

## Method Two

Since crappy names are **allowed**, why not have a try.

Kotlin supports surrounding an invalid identifier with a pair of `` ` `` to force it to be valid.
There are similar syntax in languages like C# or Rust, but those languages are using a single prefix
instead of a pair of prefix and suffix.
It's designed for using Java names which are keywords in Kotlin, like ``System.`in` ``.
Here we're abusing it.

Adding a space still works:

```kotlin
internal fun ` zython`() {
}
```

or Haskell-ish style:

```kotlin
internal fun `{-# LANGUAGE Zython #-}`() {
}
```

I am using the latter method in [a file in a personal project](https://github.com/icela/FriceEngine/blob/master/src/org/frice/Initializer.kt) -- not for `internal`, but for visual effect (it looks like a Haskell pragma!)
