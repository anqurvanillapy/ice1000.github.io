---
layout: post
title: Language extensions of Arend
category: Arend
tags: Arend
keywords: Small intro to Arend FFI
---

[Last article](5-16-ArendLittleIntro.html) I talked about basic
functionality of Arend.
This time let's take a look at its Java FFI, aka language extension.
I'm writing this because I didn't yet see any similar intros -- in the official
[documentation], it describes language extension as:

 [documentation]: https://arend-lang.github.io/about/arend-features#language-extensions

> A language extension is a Java class which is invoked during type-checking.
> This can be used to implement custom operations on the abstract syntax tree which
> are not supported by the language. They can also be used to implement various
> decision procedures for proof automation. To do this, you’ll need Arend API
> (you can also download its sources).

Well, neither examples nor demos.
In the [tracking issue](https://github.com/JetBrains/Arend/issues/119) of Arend
language extension, there is no description on the feature anywhere.
Though the standard library has implemented a number of language extensions,
which can serve as a great demo.
I want to do this because there tends to be cloud-programmers(*) who want to know
about Arend but were too busy to do so.

 (*) cloud-programmers: programmers who only read documentation of something but
     never really used it (or only played with hello-world level programs with it).
     They will make false claims based on their assumptions of certain technologies
     and mess up the communities because fake information spreads the fastest.
     Don't try to Google it (**), it's transliterated from a Chinese meme.

 (**) Interestingly, I googled it and the result says Clojure is a math language.
      Made my day.

We'll create an Arend project with Java FFI.

Disclaimer.
The content of this article might (though not likely) be obsolete in the
future because it uses unreleased APIs,
but I'll try my best to keep the code examples up-to-date when things changed.

# What is a language extension?

Well, the above text quoted from the documentation explains it well.

# Example project

## Prerequisite

Now, you need to obtain the following stuffs:

0. Any JDK of version >= 11 and any proper Java development environment
0. Arend compiler fat jar, dev version (or maybe a release version when 1.4 is out)
   (I'm using 840e4c0fdd4889b2201736a3258e5e48fb98e67b)
0. Arend API and optionally its sources

To obtain the latter two, you can:

 [instructions]: https://github.com/JetBrains/Arend/blob/master/ARCHITECTURE.md#common-gradle-tasks

+ Download them from [GitHub Actions](https://github.com/JetBrains/Arend/actions)
+ Build from source -- you may follow [instructions]

Now, you'll have the following jars:

+ Arend compiler
  + `cli-1.3.0-full.jar`
+ Arend API
  + `api-1.3.0.jar`
  + `api-1.3.0-sources.jar` (optional)

We're gonna first create a simple function similar to the
following Arend pseudo code:

```arend
\module Tesla.Meta {
  \func test => <some function body>
}
```

The function body cannot be implemented in Arend code,
and it will "take any number of arguments, but just return `114514`".

## Create a proper Java project

Now, let's create a Java project with your favorite Java IDE
(or via cli, if you'd like to), with the Arend API jar(s).
I'm using IntelliJ IDEA for this -- and I have the following project structure
(after a clean build):

```yaml
IntroLangExt
- .idea
- lib
  - api-1.3.0.jar
  - api-1.3.0-sources.jar
- out
  - production/IntroLangExt
    - org/ice1000/arend/ext
      - MyExt.class
- src
  - org/ice1000/arend/ext
    - MyExt.java
```

And, I have `MyExt.java` like this, as an initial extension:

```java
package org.ice1000.arend.ext;

import org.arend.ext.*;
import org.arend.ext.module.*;
import org.arend.ext.concrete.*;
import org.arend.ext.dependency.*;
import org.arend.ext.reference.*;

public class MyExt extends DefaultArendExtension {
  @Override
  public void declareDefinitions(DefinitionContributor contributor) {
    // TODO create some definition
  }
}
```

A class implementing `ArendExtension` (or extending `DefaultArendExtension`)
will be the entry point of a language extension.
You can implement a lot of stuffs (and there will be more in the future),
but we're only gonna create Arend functions in Java this time.
Btw, apart from that, you can also create goal solvers at the moment.

In order to declare language extension with dependencies on an Arend module,
Use the annotation `org.arend.ext.dependency.Dependency` and
`org.arend.ext.dependency.ArendDependencyLoader#load`
(can be use in `org.arend.ext.ArendExtension#load`).

Now, we can invoke `contributor::declare` in the body of `MyExt` to create
our own Arend definitions in Java.

## Create an Arend function

An Arend function is usually a class that implements
`org.arend.ext.typechecking.MetaDefinition`
(there's an alternative base definition `BaseMetaDefinition`).
Let's create it, namely `TestDef.java`:

```java
package org.ice1000.arend.ext;

import org.arend.ext.ArendPrelude;
import org.arend.ext.concrete.*;
import org.arend.ext.concrete.expr.*;
import org.arend.ext.typechecking.*;

public class TestDef extends BaseMetaDefinition {
  @Override
  public TypedExpression invokeMeta(ExpressionTypechecker typechecker, ContextData contextData) {
    // TODO
    return null;
  }
}
```

The `contextData` parameter gives you the arguments passed to our
Java FFI definition,
while the `typechecker` allows you to obtain well-typed core expressions
(say, `TypedExpression`) from concrete expressions
(that you can easily create by yourself).

Attention.
**Never implement any interfaces in `org.arend.ext.concrete` or `org.arend.ext.core`. Always use Arend API do obtain expressions!**

In order to use the `Nat` type from the `Prelude` module,
we need to obtain an instance of `ArendPrelude`.
In order to create concrete expressions, we need an instance of `ConcreteFactory`.
They can be obtained in `ArendExtension`, so we add the following to `MyExt`:

```java
private ArendPrelude prelude;
private ConcreteFactory factory;

@Override
public void setConcreteFactory(ConcreteFactory factory) {
  this.factory = factory;
}

@Override
public void setPrelude(ArendPrelude prelude) {
  this.prelude = prelude;
}
```

These setters will be invoked by the Arend compiler.
Then, we create a constructor of with the required fields in our `TestDef`:

```java
private final MyExt ext;

public TestDef(MyExt ext) {
  this.ext = ext;
}
```

## Implement the Arend function

Then, we implement `invokeMeta`:

```java
@Override
public TypedExpression invokeMeta(ExpressionTypechecker typechecker, ContextData contextData) {
  var nat = ext.factory.ref(ext.prelude.getNat().getRef());
  var checkedNat = Objects.requireNonNull(typechecker.typecheck(nat, null));
  var num = ext.factory.number(114514);
  return typechecker.typecheck(num, checkedNat.getExpression());
}
```

In the four lines of the function body, we:

0. Line 0
  0. Get a reference to the `Nat` type (`ArendRef`) by `prelude.getNat().getRef()`
  0. Use `factory.ref` to create a `ConcreteExpression` from an `ArendRef`
0. Line 1
  0. Use `typechecker.typecheck(nat, null)` to check `nat` against no type
  0. Assert that the typechecking returns a non-null instance of `TypedExpression`
0. Line 2
  0. Create a numeric literal `114514` (`ConcreteExpression`)
     by `factory.number(114514)`
0. Line 3
  0. Use `checkedNat.getExpression()` to get the type-checked reference to `Nat`
     (you can also do `checkedNat.getType()` to get its type)
  0. Use `typechecker.typecheck` to check the numeric literal against the type `Nat`
  0. Return the type-checked result

We ignored all the arguments passed to it, but just return a natural number
`114514` typed as `Nat` (we're typing it as `Nat` because numeric literals are
polymorphic, they can be `Int` as well).

Remark.
You can do arbitrary things in `invokeMeta`, such as IO
(file, network, process, etc), storing side-effective local states, etc.
But it's recommended in general to be referential-transparent.

Remark.
Since you can do IO, you can easily integrate third-party tools into Arend.

## Integration into extension

With `TestDef` we can now implement `MyExt`.
Recall that we're gonna provide a function `test` in module `Tesla.Meta`,
so we register the definition in this way:

```java
@Override
public void declareDefinitions(DefinitionContributor contributor) {
  var modulePath = ModulePath.fromString("Tesla.Meta");
  contributor.declare(
      modulePath,
      LongName.fromString("test"),
      "A testing function",
      Precedence.DEFAULT,
      new TestDef(this)
  );
}
```

In the above code, we:

0. Use `ModulePath.fromString("Tesla.Meta")` to create a module path `Tesla.Meta`
0. Invoke `contributor::declare` to declare a definition that
   0. is in module `Tesla.Meta`
   0. is of name `test` -- by passing the name to `LongName::fromString`
   0. is described as `A testing function`
   0. is a symbol of the default precedence (like ordinary functions)
   0. is implemented as `new TestDef(this)`

Then, we build the Java project to obtain the class files.

## Create Arend module

Now, let's invoke it in Arend!

We're gonna create our Arend module under the root of the Java project,
and copy `cli-1.3.0-full.jar` there (I'm copying it for convenience
because I constantly change the cli jar I use. You may also put it somewhere else
and use `java -jar [path to cli-1.3.0-full.jar] [path to arend.yaml]` to check
the module):

```yaml
IntroLangExt
- ArendMod
  - src
    - Test.ard
  - arend.yaml
  - cli-1.3.0-full.jar
- out
- src
- ... other files and subdirectories omitted
```

In `arend.yaml`, we describe our module:

```yaml
langVersion: 1.3
sourcesDir: src
binariesDir: .bin
extensionsDir: ../out/production/IntroLangExt
extensionMainClass: org.ice1000.arend.ext.MyExt
```

Then, we put the following Arend code into `Test.ard` to test our
`test` function in `Tesla.Meta`:

```arend
\import Tesla.Meta

\func boy : Nat => test
\func next : Nat => test 1
\func door : Nat => test boy
```

## Typecheck the extension

To really check it, we open the terminal in the `ArendMod` directory,
and type the following command:

```
$ java -jar cli-1.3.0-full.jar

[INFO] Loading library prelude
[INFO] Loaded library prelude (215ms)
[INFO] Loading library ArendMod
[INFO] Loaded library ArendMod (130ms)

--- Typechecking ArendMod ---
[ ] Test
--- Done (47ms) ---
```

Well, seems it worked.

# Real-world example

We can use language extension to create some algebra solvers,
program synthesizer, etc.

More examples can be found in the standard library -- find it on GitHub.
One extension in the stdlib I'd like to talk about is `$` -- it's the same thing
as the one in Haskell, but it's not implemented as a function as in Agda or Idris.

Here's the definition in Agda:

```agda
_$_ : ∀ {A : Set a} {B : A → Set b} →
      ((x : A) → B x) → ((x : A) → B x)
f $ x = f x
```

Look at its type signature. It's very complicated in comparison to Haskell's,
but serves no more functionality than an alternative to parenthesis.
Also, there's one implicit parameter which can be solved only with
higher-order unification.
So, it's an overkill in dependent type systems.

In Idris (maybe they're aware of the overkill-ness of the problem),
it became part of the syntax to avoid letting the compiler to solve a complicated
implicit argument like in Agda (code taken from `src/Idris/Parser/Ops.hs`):

```haskell
-- | Creates table for fixity declarations to build expression parser
-- using pre-build and user-defined operator/fixity declarations
table :: [FixDecl] -> [[P.Operator IdrisParser PTerm]]
table fixes
   = [[prefix "-" negateExpr]] ++
      toTable (reverse fixes) ++
     [[noFixityBacktickOperator],
      [binary "$" P.InfixR $ \fc _ x y -> flatten $ PApp fc x [pexp y]],
      [binary "=" P.InfixL $ \fc _ x y -> PApp fc (PRef fc [fc] eqTy) [pexp x, pexp y]],
      [noFixityOperator]]
```

However, making it part of the syntax disables users from changing its name.
Also, it's impossible to eliminate it (since we can hide `Prelude` functions
in Haskell, and we can avoid importing `Function._$_` in Agda).

In Arend, `$` is a language extension (in the stdlib) that simply creates
an application expression with two of its arguments, provided as an infix operator,
neither polluting the syntax nor burdening the unifier.

If you're curious about the actual [implementation](https://github.com/JetBrains/arend-lib/blob/master/meta/src/main/java/org/arend/lib/meta/ApplyMeta.java), here's a copy:

```java
package org.arend.lib.meta;

import org.arend.ext.concrete.expr.ConcreteArgument;
import org.arend.ext.concrete.expr.ConcreteExpression;
import org.arend.ext.typechecking.BaseMetaDefinition;
import org.arend.ext.typechecking.ContextData;
import org.arend.ext.typechecking.ExpressionTypechecker;
import org.arend.ext.typechecking.TypedExpression;
import org.arend.lib.StdExtension;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.List;

public class ApplyMeta extends BaseMetaDefinition {
  private final StdExtension ext;

  public ApplyMeta(StdExtension ext) {
    this.ext = ext;
  }

  @Nullable
  @Override
  public boolean[] argumentExplicitness() {
    return new boolean[] { true };
  }

  @Override
  public @Nullable ConcreteExpression getConcreteRepresentation(@NotNull List<? extends ConcreteArgument> arguments) {
    return ext.factory.app(arguments.get(0).getExpression(), arguments.subList(1, arguments.size()));
  }

  @Override
  public @Nullable TypedExpression invokeMeta(@NotNull ExpressionTypechecker typechecker, @NotNull ContextData contextData) {
    List<? extends ConcreteArgument> args = contextData.getArguments();
    return typechecker.typecheck(ext.factory.withData(contextData.getReferenceExpression().getData()).app(args.get(0).getExpression(), args.subList(1, args.size())), contextData.getExpectedType());
  }
}
```
