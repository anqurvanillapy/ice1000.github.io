---
layout: post
title: 没有 lambda abstraction 的无聊 Kotlin
category: Kotlin
tags: Kotlin
keywords: Kotlin
description: Kotlin is actually a purely functional programming language
---

很抱歉最近连续一段时间博客都没有更新，因为我忙着开发 IDE 和折腾申请的事去了（啊我好歹还是非常想上个好大学的），而且自从 Windows 虚拟机原地爆炸之后我就有点提不起劲（QQ 就没了，搜狗输入法也没了， Notepad++ 没了，现在只有 Emacs 可以用）。
不过呢好在我一直都有学习啦，所以博客呢总是可以持续更新的。

最近在大量阅读 IntelliJ IDEA 源码的同时呢也获得了一些人生经验，也终于走上了适应 "阅读大量源码" 这一危险活动的道路。<br/>
不过呢，这篇文章是分享一些我最近发现的一个有趣的 Kotlin 代码写法的，目的只是为了娱乐，不建议在公司里这么写。

同时，本文也会指出一些 Kotlin 的华点。

## 什么样的有趣写法呢

就是，我们可以完全舍弃除了类定义之外的大括号使用。<br/>

比如，我们原本有这么一段逻辑：

```kotlin
SyntaxTraverser
    .psiTraverser(parent.parent)
    .filter { it is CovSymbol && it.text == symbol.text }
    .map { (it as CovSymbol).reference }
    .filter { it != null }
    .toList()
    .toTypedArray()
```

我们如果把所有的大括号都去掉，那么代码应该会变成这样（由于没有默认的 Applicative ，似乎会被迫多定义一个函数呢）：

```kotlin
fun textEq(it: CovSymbol) = symbol.text == it.text
SyntaxTraverser
    .psiTraverser(parent.parent)
    .filterIsInstance<CovSymbol>()
    .filter(::textEq)
    .mapNotNull(CovSymbol::reference)
    .toList()
    .toTypedArray()
```

因此，我们可以尝试把这个 `textEq` 扩展到普适的情况，并不可避免地需要使用大括号：

```kotlin
infix fun <A, B, C> ((A) -> B).then(g: (B) -> C): (A) -> C = { g(this(it)) }
fun <A, B, C> app(f: A.() -> B, g: B.(B) -> C, a: A) = f then f(a)::g
```

但因为 Kotlin 的贫瘠，`f(a)::g`这样的代码在`g`是一个变量时是无比合理但无法通过编译的，所以我们还需要一个柯里化的帮助函数，并不可避免地需要使用大括号：

```kotlin
fun <A, B, C> curry(f: (A, B) -> C) = { a: A -> { b: B -> f(a, b) } }
```

我们还可以通过声明整个函数的返回类型而减少自己写的类型声明：

```kotlin
fun <A, B, C> curry(f: (A, B) -> C): (A) -> (B) -> C = { a -> { f(a, it) } }
```

然后`app`就可以写成这样了：

```kotlin
fun <A, B, C> app(f: A.() -> B, g: B.(B) -> C, a: A) = f then curry(g)(f(a))
```

然后我们就可以把原来的代码改成：

```kotlin
SyntaxTraverser
    .psiTraverser(parent.parent)
    .filterIsInstance<CovSymbol>()
    .filter(app(CovSymbol::getText, String::equals, symbol))
    .mapNotNull(CovSymbol::reference)
    .toList()
    .toTypedArray()
```

但是这么一看我们似乎又不需要这个`app`函数了，只需要借助柯里化就可以改进最早使用了`textEq`的版本：

```kotlin
SyntaxTraverser
    .psiTraverser(parent.parent)
    .filterIsInstance<CovSymbol>()
    .filter(CovSymbol::getText then curry(String::equals)(symbol.text))
    .mapNotNull(CovSymbol::getReference)
    .toList()
    .toTypedArray()
```

我们现在得到了两个帮助函数。
with the help of 这两个帮助函数（当然，我们可能还需要更多的更进一步柯里化的函数），我们可以开心地不用大括号编程了。

### 性能

考虑到这些函数全部都不涉及将匿名函数作为闭包的传递，我们可以很轻易地知道，他们全部可以 inline ：

```kotlin
inline fun <A, B, C> curry(f: A.(B) -> C): (A) -> (B) -> C = { a -> { a.f(it) } }
inline infix fun <A, B, C> ((A) -> B).then(g: (B) -> C): (A) -> C = { g(this(it)) }
inline fun <A, B, C> app(f: A.() -> B, g: B.(B) -> C, a: A) = f then curry(g)(f(a))
```

于是刚才的那种组合函数风格的代码就可以在编译后变得和一开始那种风格一样啦，一个闭包对象都不会产生哦。

## 另一个例子

比如，我们要获取命令行里的 JDK 的版本，按理说是可以通过这样的代码来读取的：

```kotlin
fun gitVersion() {
  Runtime.getRuntime().exec("javac -version")
      .also(Process::waitFor)
      .inputStream
      .let(::InputStreamReader)
      .let(::BufferedReader)
      .lines()
      .collect(Collectors.toList())
      .joinToString("\n")
      .let(::println)
}
```

这里其实用到了副作用，就是`also`。
这其实是不清真的，所以这并不是纯函数式编程，只是组合函数的编程。

当然了，对于`Process::waitFor`的调用最好还是加上时间限制的，此时我们就需要用到`flip`函数，和对于有三个参数的函数的柯里化帮助函数。

## 优势

那么这种洒不腊姬的写法能给我们的生活带来什么好处呢？

相信写过 Kotlin 的民那都已经体会到了，在对一个表达式`a`进行某种变换的时候，如果通过一个以`a`为参数的函数的话，需要在表达式`a`左右两边分别加上一些东西，即左边加上函数名和左括号、右边加上右括号，变成`f(a)`，需要进行很多光标移动。
而如果通过扩展函数（实际上就是普通函数的语法糖），只需要在表达式`a`的右边加上`.f()`，不需要进行光标移动，于是就能带来很不错的编码体验。

差不多就缩这么多吧。感觉这玩意不是很有价值，噗。不过这样的话，以后如果大家和 Haskeller 们讨论编程时，听到`point-free`这个词，就可以联系到这篇文章。<br/>
因为本文所说的这种编码风格就叫`point-free`哦。

第一次用 Emacs 写这么多中文，感觉好不习惯【x
