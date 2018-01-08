---
layout: page
title: Programming Languages I contributed to
description: ice1000 contributed languages
keywords: ice1000
menu: Languages
permalink: /languages/
---

[简体中文](../languages-cn/)

# Lice

My first programming language, created before learning compiler theories because I want to put some ideas into practise.  
Its syntax looks like Lisp, and I removed all syntax sugars to make the parser's time complexity proportional to the code length.
Encouraged by Marisa, I successfully implemented three evaluation models -- call by name (like but not C's macro),
call by value (the most common one) and call by need (lazy evaluation).  
It's written in Kotlin, execute through traversing AST (it's naive, I know). It also has a unfinished Haskell implementation.  
This language doesn't have reserved words, all the language construct (including control flows like `if` `while`, anonymous function creation like `lambda` `expr` `lazy`,
very basic stuffs like `def` `def?` `defexpr`) are implemented in the standard library.  
The way standard library is provided is bizarre: I write a Kotlin class and bind all their methods to Lice's symbol table.  
Lice's purpose is to be a scripting language depends on JVM languages, all the complicated programs should be written in JVM languages and invoked
in Lice by using Lice's API.

The worst point of Lice is it's name -- it means a kind of insect, but I didn't know this when I name it (I was at school, no internet access)

### Related Links

+ [IntelliJ IDEA-based IDE](https://plugins.jetbrains.com/plugin/10319-lice)
+ [Command line REPL](https://github.com/lice-lang/ldk)（支持彩色输出和代码补全）
+ [Android RPEL](https://github.com/lice-lang/lice-android)
+ [Language Reference](https://github.com/lice-lang/lice-reference)
+ [Interpreter Source](https://github.com/lice-lang/lice)
+ [Tiny Interpreter](https://github.com/lice-lang/lice-tiny)

The AST Editor, code formater appeared with the first version are all lost along with the change of my working environment.

# CovScript

This is a programming language created by my friend Michael Lee, written in C++.

这是我的朋友李登淳创造的一门编程语言，用 C++ 实现，具体介绍在官网还是比较详细的，我在这里就只写点我自己的看法吧。  
首先我不评价老李拿这门语言教别人编程的做法，这门语言本身是类 C 的（至少表达式和函数调用是 C 风格），
而函数、结构体、命名空间定义等是 Ruby 风格的 `end` 结尾，并有 `package` `import` `using` 的概念（也就是模块系统）。  
老李的 Parser 是手写的（可以说复杂度很高了，虽然 Parser 是很 trivial 的），让我对他的耐力很佩服（同为高二学生，
我在写 Lice 的时候就没有这份心思，只是做了个很灵活的 AST evaluator 而已）。  
这门语言支持调用 C++ 实现的函数，形式类似 JNI 。

最大的特色应该是它功能齐全的标准库，有数据库、 GUI 、网络编程、正则等库，感觉写程序很方便啊。

### 相关链接

+ [基于 IntelliJ IDEA 的 IDE](https://plugins.jetbrains.com/plugin/10326-covscript/) ，这是我送给老李的 2018 新年礼物
+ [解释器源码](https://github.com/covscript/covscript)
+ [官网](http://covscript.org)
