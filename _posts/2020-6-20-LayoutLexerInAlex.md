---
layout: post
title: Lexer for two-dimensional syntax (in Alex)
category: Parser
keywords: Parser Haskell
---

I apologize for the moronic title (about two-dimensional).
The two-dimensional syntax you may (well, probably) expect belongs to esolang only.
How can I write about esolangs? That's ridiculous.

The two-dimensional syntax I want to talk about is similar to
indentation-based syntax, like in Python.
The problem on implementation is that whitespaces and EOLs (end-of-lines) now have
their semantics. You can't just ignore them during lexical analysis, like in Java.

There are many known limitations in Python's layout syntax such as its lambdas can
[only be one-linear](https://stackoverflow.com/q/1233448/7083401). However,
Taine Zhao told me that it's her one-minute task to support multiline lambdas in
Python, so it's not because the Python team's lack of knowledge on parsing techniques.
There are some other reasons where she can't remember.

Imagine the following Python code:

```python
if a:
    if b:
        print('road roller da!!!')
else:
    print('ora ora ora!!!')
```

And this one:

```python
if a:
    if b:
        print('road roller da!!!')
    else:
        print('ora ora ora!!!')
```

If we write our lexer that trims all whitespaces, these two pieces of code will
be equivalent. However, it's clear that they are different semantically.
If we transliterate it into Java:

```java
// First snippet
if (a)
  if (b)
    print("road roller da!!!");
else
  print("ora ora ora!!!");

// Second one
if (a)
  if (b)
    print("road roller da!!!");
  else
    print("ora ora ora!!!");
```

Well, they are parsed the same way and will be compiled to identical bytecode.
This is considered an advantage of layout-based syntax.
As I said Python's layout syntax is limited, is there a better one?
Can we mix layout and non-layouts (like using curly-braces) together?
Can we support multiline lambdas (one step further,
can we arbitrarily do line breaks in expressions)?

Well, Haskell is doing pretty well here:

```haskell
starPlatinum = \case
  A a -> case -- line break
       a of
    e -> f
      a b -- line break, parsed as "f a b"
    _ -> \x ->
      x -- multiline lambda
  c -> d
```

Here are four pieces of semantically equivalent code:

```haskell
-- One
rua = do
  a <- b
  c <- d
  e <- p <|> do
    f
    g <- h
    pure i
  j

-- Two
rua = do { a <- b ; c <- d ; e <- p <|> do { f ; g <- h ; pure i }; j }

-- Three
rua = do
  a <- b
  c <- d
  e <- p <|> do { f ; g <- h ; pure i }
  j

-- Four
rua = do { a <- b ; c <- d ; e <- p <|> (do
    f
    g <- h
    pure i);
  j } -- this line has reduced indentation
  -- comparing to the line before,
  -- so the inner "do" block is considered closed
```

You [can't](https://stackoverflow.com/a/6167353/7083401) do this in Python.

Well, let's stop dissing Python and think about the essence of layout syntax.
Layouts are in fact equivalent to a combination of curly braces and semicolons
(or whatever symbol you'd like to surround a block of code and
separate a list of statements).
However, layouts are based on whitespaces, which is less noisy comparing to
braces and semicolons.

So, we can naturally derive the algorithm to tackle layouts in a parser.
In fact, you're supposed to deal with layouts in a *lexer*.

We want our layouts to be:

0. Optional, unlike Python
0. Based on arbitrary number of whitespaces (works as long as the code is aligned),
   unlike Python (enforced 4-spaces)

I'm not gonna talk about one linear `let`-`in` structure here,
because that requires the lexer to gain additional information from the parser.

## Implementation

I'm gonna introduce an implementation in [Alex], the lexer generator for Haskell.

 [Alex]: https://www.haskell.org/alex

Our lexer needs an additional state stored, which is a stack, and whose elements are
"are we in a layout, and if so how many leading whitespaces does the current layout have". We name it `layoutStack`.
We have another state stack, which is the normal lexer state, namely `alexStartCodes`.

```haskell
{-# LANGUAGE LambdaCase #-}

import Data.Maybe (listToMaybe)
import Control.Monad (join)

data AlexUserState = AlexUserState
  { layoutStack    :: [Maybe Int]
  , alexStartCodes :: [Int]
  }
```

We need to decide which tokens will start a new layout.
For Python, it's colon. For Haskell, there's `do`, `where`, `let`, `of`, etc.

```haskell
isStartingNewLayout :: TokenType -> Bool
isStartingNewLayout WhereToken     = True
isStartingNewLayout PostulateToken = True
isStartingNewLayout InstanceToken  = True
isStartingNewLayout _              = False
```

We need to manipulate the lexer state stack in the `Alex` monad.

```haskell
pushLexState :: Int -> Alex ()
pushLexState nsc = do
  sc <- alexGetStartCode
  s@AlexUserState { alexStartCodes = scs } <- alexGetUserState
  alexSetUserState s { alexStartCodes = sc : scs }
  alexSetStartCode nsc

popLexState :: Alex Int
popLexState = do
  csc <- alexGetStartCode
  s@AlexUserState { alexStartCodes = scs } <- alexGetUserState
  case scs of
    []        -> alexError "State code expected but no state code available"
    sc : scs' -> do
      alexSetUserState s { alexStartCodes = scs' }
      alexSetStartCode sc
      pure csc
```

As well as the layout state stack.

```haskell
popLayout :: Alex (Maybe Int)
popLayout = do
  s@AlexUserState { layoutStack = lcs } <- alexGetUserState
  case lcs of
    []        -> alexError "Layout expected but no layout available"
    lc : lcs' -> do
      alexSetUserState s { layoutStack = lcs' }
      pure lc

getLayout :: Alex (Maybe Int)
getLayout = do
  AlexUserState { layoutStack = lcs } <- alexGetUserState
  pure . join $ listToMaybe lcs
```

When we scanned a layout-starting token, we add a layout state.
If the next token is `{`, we drop the newly added layout state immediately.
Also, we need to omit all empty lines.

```perl
$white_no_nl = $white # \n

tokens :-

$white_no_nl  ;

<layout> {
  \n          ;
  \{          { explicitBraceLeft }
  ()          { newLayoutContext }
}
```

Dropping the layout state (`PsiToken` is the token type defined by me,
which stores token type and position information.
The token type for `{` is `BraceLToken`):

```haskell
explicitBraceLeft :: AlexAction PsiToken
explicitBraceLeft ((AlexPn pos line col), _, _, _) size = do
  popLexState
  pushLayout Nothing
  toMonadPsi pos line col size BraceLToken
```

Here's the definition of `PsiToken` and `toMonadPsi` by the way (unimportant):

```haskell
data PsiToken = PsiToken
  { tokenType :: TokenType
  , location  :: Loc
  } deriving (Eq, Show)

toMonadPsi :: AlexPosn -> Int -> TokenType -> Alex PsiToken
toMonadPsi pn size token = do
  loc <- currentLoc pn size
  pure PsiToken
    { tokenType = token
    , location  = loc
    }
```

When lexing, we may enter a new layout, or continue a layout, or close a layout.
Here's the rules for some arbitrarily selected tokens:

```perl
<0> {
  \n          { beginCode bol }
  import      { simple ImportToken }
  where       { simple WhereToken }
  postulate   { simple PostulateToken }
  instance    { simple InstanceToken }
  infixl      { simple InfixLToken }
}
```

In `beginCode` we push a new lexer state (`bol` is short for begin-of-lines),
while in `simple` we deal with most "simple" tokens
(that are not string, not comments, not characters, etc.).
Note that the lexer rules for the `layout` state is already given.

```haskell
beginCode :: Int -> AlexAction PsiToken
beginCode n _ _ = pushLexState n >> alexMonadScan

simple :: TokenType -> AlexAction PsiToken
simple token ((AlexPn pos line col), _, _, _) size = do
  -- run `pushLexState` when it's `where`, `instance` or `postulate`
  if isStartingNewLayout token then pushLexState layout else pure ()
  toMonadPsi pos line col size token
```

When we scanned each new line, we check if the layout is changed.

+ If unchanged, we will generate a virtual semicolon (stands for the separator
  for block statements).
+ If the current line has more leading whitespaces,
  we see it as a part of some expressions in the previous line
  (like a line-break inside of an expression. Python doesn't support this).
+ If it has less, we generate a `}` token which ends a layout.

```perl
<bol> {
  \n          ;
  ()          { doBol }
}
```

Here's how.

```haskell
doBol :: AlexAction PsiToken
doBol ((AlexPn pos line col), _, _, _) size =
  getLayout >>= \case
    Just n -> case col `compare` n of
      LT -> popLayout   *> addToken BraceRToken
      EQ -> popLexState *> addToken SemicolonToken
      GT -> popLexState *> alexMonadScan
    Nothing -> popLexState *> alexMonadScan
  where addToken = toMonadPsi pos line col size
```

How was that? Isn't it trivial?
Hey, Python.

The source code were taken and modified from [OwO]'s Haskell implementation.

 [OwO]: https://github.com/owo-lang/OwO-Haskell-Deprecated

## Current status

Nowadays we use [BNFC], which is a BNF-based parser generator.
It generates Alex+Happy input along with an AST definition
(convenient, but no position information), which then generates to Haskell.
It natively supports layouts, you simply tell BNFC which token will start a layout,
and that's it.

I have created a generalized layout lexer wrapper in my [intellij-dtlc] project --
an intellij plugin supporting lots of PL research languages.
A number of which are created with BNFC, and they enjoy the layout feature.
The wrapper helps me parsing those BNFC-based languages.

 [BNFC]: https://hackage.haskell.org/package/BNFC
 [intellij-dtlc]: https://github.com/owo-lang/intellij-dtlc/blob/master/src/org/ice1000/tt/psi/layout.kt
