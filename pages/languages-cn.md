---
layout: page
title: 我参与开发的编程语言
description: ice1000 contributed languages
keywords: ice1000
menu: Languages
permalink: /languages-cn/
---


# Lice

我的第一门编程语言，学习编译原理前为了保留想法而写的。  
语法继承自 Lisp ，在魔理沙的鼓励下做出了三种求值模型—— call by name （类似但不是 C 语言的宏）,
call by value （最普通的传值调用）, call by need （惰性求值）。
主体实现是 Kotlin ，有一个还未成型的 Haskell 实现。  
语言没有关键字，所有的语言构件（包括 `if` `while` 这种控制流， `lambda` `expr` `lazy` 这种匿名函数创建，
`def` `def?` `defexpr` 这种在其他语言里面肯定是关键字的东西）全部是通过标准库实现的。
标准库的提供方式很奇妙，是通过编写一些 Kotlin 类，然后将他们的方法绑定给 Lice 的符号表的。  
Lice 现在的存在目的是作为一个依附于 JVM 语言的脚本语言，所有的大型任务通过 JVM 语言编写并通过 Lice 的 API
传给 Lice 。

### 工具

+ [基于 IntelliJ IDEA 的 IDE](https://plugins.jetbrains.com/plugin/10319-lice)
+ [命令行 REPL](https://github.com/lice-lang/ldk)（支持彩色输出和代码补全）
+ [Android 上的 RPEL](https://github.com/lice-lang/lice-android)

