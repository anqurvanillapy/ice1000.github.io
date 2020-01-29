---
layout: post
title: Effects as operator overloading
category: Haskell
tags: Haskell, Effects
keywords: Haskell, Effects
description: Overload semicolons
---

This post will be based on C++-like psuedo code
(because this post is written for a certain person who currently speaks mainly C++),
assuming the concepts of "operator overloading", "exception handling"
and optionally coroutines.

## Once upon a time

There was a piece of code that uses exceptions.

```cpp
#include <iostream>
#include <climits>

/// Convert `long` to `int`.
int shrink(long i) {
  int j;
  if (i <= INT_MAX && i >= INT_MIN) {
    using namespace std;
    j = (int) i;
  }
  else throw i;
  return j;
}

int main() {
  using namespace std;
  long i;
  cin >> i;
  try {
    cout << shrink(i) << endl;
  } catch (long i) {
    cerr << "Failed to convert: " << i << endl;
  }
  return 0;
}
```

This program may run in these two procedures:

```text
cin -> try block -> end

cin -> try block -> catch block -> end
```

So, the function `shrink` may finish at two points: the `return` statement
and the `throw` statement.
In the `main` function, we invoke `shrink` in a try-block,
print its return value if it returns a value or print an error message if it
throws an exception.

Let try to implement exceptions.
Assuming we can overload semicolons as a binary operator,
we defined semicolons like the following psuedo code:

```cpp
template <typename R, typename E>
R operator;(codeblock before, codeblock after) {
  before.run();
  if (hasException()) goToCatchBlock();
  else return after.run();
}
```

Then, when an exception happens during executing the `before` codeblock,
the semicolon doesn't execute the `after` code block.
Instead, it goes to the closest catch-block.

We may desugar the little example to invocations of `operator;`
(don't look into detail -- just to demonstrate how the statements get
passed as `codeblocks` into `operator;`):

```cpp
/// Convert `long` to `int`.
int shrink(long i) {
  return operator;(
    {int j},
    {
      operator;(
        {
          if (i <= INT_MAX && i >= INT_MIN) {
            operator;(
              {j = (int) i},
              {return (int) i}
            )
          }
          else throw i
        },
        {return j}
      )
    }
  )
}
```

Specifically, in this piece of code:

```cpp
operator;( // mark
  {
    if (i <= INT_MAX && i >= INT_MIN) {
      operator;(
        {j = (int) i},
        {return (int) i}
      )
    }
    else throw i
  },
  {return j}
)
```

Looking at the `// mark` commented `operator;` invocation:
it runs the `if (i ...` codeblock.
If `throw i` is reached, it won't execute the `return j` codeblock
but jumps out directly -- with an exception thrown.
If `throw i` is not reached, the `return j` codeblock will be executed
and it's a regular return.

This is good because if we call a function who throws an exception,
the statement of the function call will still be treated as exception-throwing,
so the exception can be speaded out to outer functions.

We can actually achieve this in C++ by writing each line of code as a lambda expression,
so we can call the lambda to execute a code block (in the semicolon operator).
We let the lambdas return a `result` which is either a returned result or a thrown result.
It'll look like this:

```cpp
result bind(
    // `before` can be invoked directly:
    // result before() { blabla }
    std::function<result()> before,
    // `after` requires the returned result from `before`:
    // result after(returned) { blabla }
    std::function<result(returned)> after
) {
  result r = before();
  // Is it a thrown result?
  // if so, we return the thrown thing without executing the second codeblock
  if (r.isThrown()) return r;
  // It's not a thrown result, so it's a returned result,
  // we cast it to a returned result and give it to `after`
  else return after(r.asReturned());
}
```

Up to now, we got some ideas about a possible implementation of exceptions,
say, by packing each statement in an exception-throwing functions as a lambda expression,
and we obtain a binary function called `bind` to progress the execution.
We can implement a compiler with exceptions support by this strategy.

### General idea

What we've did just now is that we use a function (namely `bind`)
to control the execution of statements.
The `bind` function passes the result of each statements right along their execution,
so latter statements can depend on the result of prior ones.

We may've seen similar things before.
In early year JavaScript, we write things like this (callback-hell):

```js
loadScript('1.js')
  .andThen(function(script1) {
    loadScript('2.js')
      .andThen(function(script2) {
        loadScript('3.js')
          .andThen(function(script3) {
            // use the loaded scripts
          });
      });
  });
```

We can see that `andThen` is just another name of `bind`.
Though there's a more fancy syntax for writing code like that, say, `async/await`:

```js
let script1 = await loadScriptAsync('1.js');
let script2 = await loadScriptAsync('2.js');
let script3 = await loadScriptAsync('3.js');
```

Here's some commonly seen similar structures:

+ The simplest `bind` just execute statements one by one, we call it `IO`.
+ If the `bind` function stops the execution when an exception is thrown,
  we call it `Error`.
+ If the `bind` function provides access to some states by passing it around as
  a part of `returned`, we call it `Reader`.
+ If the `bind` function obtain a thread pool and execute the functions as a chain
  in the thread, we call it `Coroutines` or `Future` or `Promise`.

More abstractly, `bind` provides a **context** for the statements' execution.

I'd like to name all of these structures as "Effect".
In Haskell, Effects are mistakenly called "Monads" and are used for simulating
imperative programming (mutable variables, exceptions, etc.).
You can actually overload the semicolon in Haskell.
The example used in this post is like the following in Haskell:

```haskell
import Control.Monad.Except
import Data.Int

shrink :: Int64 -> Except Int64 Int32
shrink i = do
  let intMax = fromIntegral (maxBound :: Int32)
      intMin = fromIntegral (minBound :: Int32)
  if i >= intMin && i <= intMax
  then return (fromIntegral i)
  else throwError i

main :: IO Int
main = do
  input <- getLine
  let long = read input
  either print
    (\i -> putStrLn ("Failed to convert" ++ show i))
    (runExcept (shrink long))
  return 0
```

It looks very similar to the C++ example.
We can see that overloading semicolons can give the language a very advanced level
of abstraction.

Here's how I define "more advanced" for level of abstraction:

Given language features `A` and `B`, if we can simulate the feature `B` as
a library using feature `A`, I'd prefer adding `A` to the language and remove `B`.

I hope this inspires you somehow.

<!-- ## The variant type

We can see the `shrink` function as returning two possible values -- a valid return
value, which is of type `int`, or an exception thrown, which is of type `long`.
The `return` statement returns the valid `int` value (hereafter as "returns"),
the `throw` statement returns the `long` exception (hereafter as "throws").
In `main`, we test if `shrink` returns or throws -- if it returns,
print the value returned; otherwise it throws, we print an error message with
the thrown value.

Let's try to re-interpret the above program without using exceptions.
We assume a type `result`, and we can create an instance of `result` via
the following two functions:

```cpp
result ok(int i);
result error(long i);
```

Then, if we have a variable of type `result`,
there will be two possiblities: it can be a valid returned `int` or
an exception `long`.
We assume an operation (namely `match`) for this,
using a syntax similar to try-catch or if-else:

```cpp
/// Obtain a variable of type `result`
result t = ...;
/// The assumed operation
match (t) {
  /// If `t` is created via `ok`, go to this block
  /// and assign the returned `int` value to `i`:
  ok(int i) {
    cout << shrink(i) << endl;
  }
  /// If `t` is created via `error`, go to this block
  /// and assign the thrown `long` value to `i`:
  error(long i) {
    cerr << "Failed to convert: " << i << endl;
  }
}
```

Explanation to the syntax is included in the comments. -->
