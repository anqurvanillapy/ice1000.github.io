---
layout: post
title: 一些看了让人很爽的动态图
category: IntelliJ
tags: Misc
keywords: cool pics
description: interesting
---

最近沉迷 IDE 开发，给我的语言 Lice 和老李的语言 CovScript 各自开发了 IntelliJ IDEA 插件，做了一些自己觉得很爽的功能，给引擎加了一些测试。
然后我发现了一个 Linux 下的非常叼的录 gif 的软件，于是就拿来晒一下。

## Lice

选中一段代码并执行，然后查看最后一个表达式的值（如果有命令行输出，那么也会一起展示）：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/lice-0.gif)

选中一段代码，执行，并将结果化为代码的形式替换回去：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/lice-1.gif)

选中一段代码并执行在面对比较复杂的数据时也没有问题：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/lice-4.gif)

冗余的代码，提示删除：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/lice-5.gif)

面对返回函数和匿名函数的代码，也可以正确告知执行结果：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/lice-6.gif)

## CovScript

选中一段代码并执行，然后查看命令行输出（这个功能实现起来好麻烦的！）：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/cov-0.gif)

可以进行一些语法上的转换：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/cov-1.gif)

## FriceEngine

我给引擎的测试代码也录了些屏，感觉观赏性非常好。

一个瞎写的测试代码：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/frice/tests/frice-0.gif)

加速旋转：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/frice/tests/frice-1.gif)

匀速追尾运动：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/frice/tests/frice-2.gif)

变速追尾运动（可以自己观察下和前者的区别）：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/frice/tests/frice-3.gif)

无法闪避的自机狙：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/frice/tests/frice-4.gif)


## Misc

还有就是我之前说过的类似的一个操作，把`class A(var b: B)`的全部 usage 替换为对 `B` 的直接使用。
当然最后还缺少一个 `fun Sema(s: SymbolList) = s` 并 inline 之的操作（想想为什么），没在 gif 中体现。

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/refactor-0.gif)

从一段代码中提取函数：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/refactor-1.gif)

为什么说 IDEA 的调试器能拯救人类呢？因为：

![](https://coding.net/u/ice1000/p/Gifs/git/raw/master/idea/debug-0.gif)










