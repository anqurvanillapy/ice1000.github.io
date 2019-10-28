# Literate Agda 博客

这是使用 Literate Agda 写的一个博客系列。
由于这种博客的排版和文章组织方式区别非常大，因此单独放在一起。

```agda
{-# OPTIONS --no-unicode  #-}
{-# OPTIONS --without-K   #-}
{-# OPTIONS --no-main     #-}
{-# OPTIONS --cubical     #-}
{-# OPTIONS --rewriting   #-}
{-# OPTIONS --copattern   #-}
{-# OPTIONS --sized-types #-}
{-# OPTIONS --prop        #-}

module index where
```

通过添加很多其实在这个目录页面没有什么用的 Pragma 来呼吁大家关爱 Haskell 程序员。

## 文章目录

```agda
import Typeclassopedia using ()
  -- date: 2018/11/1
  -- Record 实现 Typeclass

import DependentFunctionsVersusDynamicTyping using ()
  -- date: 2018/11/7
  -- 形式验证、依赖类型与动态类型

import MuGenHackingToTheGate using ()
  -- date: 2018/11/11
  -- 无穷大的自然数

import CopatternIsMoreThanCoinduction using ()
  -- date: 2018/11/12
  -- 更多 copattern 的应用

import PathToHigherInductiveTypes using ()
  -- date: 2019/1/21
  -- 路漫漫其区间兮, 吾将归纳而求索
```

## 杂项

```agda
import CubicalAgdaLiterate using ()
  -- date: 2019/1/17
  -- A blog copied from:
  -- https://homotopytypetheory.org/2018/12/06/cubical-agda/
  -- Slightly modified to make Agda happy
```

<!--
```agda
import Cubical.Data.List using ()
import Agda.Builtin.String using ()
```
-->
