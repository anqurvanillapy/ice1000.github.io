---
layout: post
title: Interpreter without an AST
category: Haskell
tags: Haskell
keywords: Haskell, Parser, Interpreter
description: Writing an interpreter without defining an AST
---

Last year I've created a binary arithmetic expression evaluator with parenthesis support,
written in Haskell with parser combinators.
This evaluator is nothing special except not using an AST definition.

This is quite interesting because we usually parse the expressions into an AST and
then evaluate them.
The basic idea is just evaluating the expression **during** parsing.

I'm changing the original code a little bit so it looks even fancier,
with this [Parser in a tweet](https://twitter.com/Anka213/status/1123746090761768962).

First the parser definition:

```haskell
import Control.Monad.State
import Control.Applicative
import Data.List
import Data.Functor

type Parser = StateT String Maybe

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = mfilter p $ StateT uncons

char c = satisfy (== c)
oneOf = satisfy . flip elem
```

And we have digit/letter/whitespace parsers accordingly:

```haskell
alpha = ['a'..'z'] ++ ['A'..'Z']
digit = ['0' .. '9']

alphaC = oneOf alpha
digitC = oneOf digit

alphaParser = whitespace *> some alphaC
digitParser = whitespace *> read <$> some digitC
whitespace = many $ oneOf " \t\r\n\f"
```

Parsing a chain is just like what we're doing before:

```haskell
chainl1 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainl1 p op = p >>= rest
  where rest a = (do
          f <- op
          b <- p
          rest $ f a b) <|> return a
```

Now a parser combinator library is almost complete.
What's next? Our expression evaluator!

```haskell
addP = whitespace *> char '+' $> (+)
subP = whitespace *> char '-' $> (-)
mulP = whitespace *> char '*' $> (*)
divP = whitespace *> char '/' $> div
add' = chainl1 sub' addP
sub' = chainl1 mul' subP
mul' = chainl1 div' mulP
div' = chainl1 unit' divP
unit' = digitParser <|> paren
exprParser = add' <|> sub' <|> mul' <|> div' <|> unit'
paren = char '(' *> exprParser <* char ')'
pc = (fst <$>) . runStateT exprParser
```

Test:

```
*Main> pc "(3+4)*5"
Just 35
*Main> pc "3+4*5"
Just 23
*Main> pc "(3+4_*5"
Nothing
```

Why can we do this?

Before, we're passing a parser of an AST node to `chain1`, like this:

```haskell
data Exp = Lit Int | Add Exp Exp deriving Show
-- When parsed a `+`, return an `Add` function
addP' = whitespace *> char '+' $> Add
-- When parsed some digits, `read` them and return a `Lit`
digitP' = whitespace *> (Lit . read <$> some digitC)

parseExpression = chainl1 digitP' addP'
```

Test:

```
*Main> fst <$> runStateT parseExpression "3+4"
Just (Add (Lit 3) (Lit 4))
```

Sounds familiar right?
What I've changed is the binary function returned by `addP'`.
It was a constructor, gather the two sides of the operator and return an `Exp`.
Now it's a function, consumes the two sides of the operator and returns
the result.

That's it.

I feel like readers of this blog does not learn anything special.
Apologize for the time you've wasted, seriously.
