---
layout: post
title: 如何让孩子爱上Kotlin：DSL（中）
category: Kotlin
tags: Essay
keywords: Kotlin
description: Kotlin DSL 2 inline
---

## Kotlin传教文

本文向您介绍Kotlin语言的一些奇特之处，方便您对Kotlin这门语言建立一个简单的概念。

我就开门见山地接着上次的讲了。

## 何为inline

相信写过C系列语言的同学应该都十分熟悉inline这个修饰符了吧——而且好像不止C系列有inline。没事这里我继续说说Kotlin的inline。本文篇幅非常短，因为inline是个很简单的东西。

inline修饰符其实就是告诉编译器，把这个方法的调用行为优化掉。怎么优化呢？就是直接省掉调用行为，直接把方法的内容写到调用的地方。但是Kotlin中的inline有所不同是，inline只能修饰含有单个block参数的方法。别的方法也可以用inline修饰，语法上不会报错，但是如果你使用的IDE是IntelliJ IDEA，它会告诉你“nothing to inline”，并高亮提示。

然后这就是inline了。。你可以使用inline做这样的事情：

```kotlin
// inline方法调用
lock(l) { foo() }

// 普通的写法
l.lock()
try {
  foo()
}
finally {
  l.unlock()
}
```

是不是挺好的。。。

为什么这种事情要inline来做呢？因为函数调用传递参数是需要消耗时间的。。。而且需要一层函数调用栈。。但是inline就把这些都省去了呢。。。

有个破孩子看了上面那段话，不明白啥意思，我补个例子：

```kotlin
// 首先假设fuck ()是一段代码。不考虑fuck的开销。
// 编译前
inline fun a() = fuck ()
a()
a()
// 产生了两次函数调用
//  编译后
fuck ()
fuck ()
// 没有函数调用了
```

当然以上代码并不是正确的，因为Kotlin的inline不是随随便便就能inline的。

原本lambda开销就大，你需要专门搞个匿名内部类，再传递它的实例，其实你只是想丢个lambda。

Java 程序员:

> 我能怎么办，我也很绝望啊

内联了，这个lambda对象/类就不会产生了。

另外一个作用就是。。。

```kotlin
inline fun assWeCan(block: () -> Unit) {
	// codes
}

fun boyNextDoor(block: () -> Unit) {
	// codes
}

fun foo() {
	boyNextDoor {
		// 这种写法是不能通过编译的，因为有两个函数。你必须使用 return@assWeCan 或者 return@foo 这种写法指定要return的Context。
		return
	}
	assWeCan {
		// 这种写法可以通过编译，因为你inline了之后这个Lambda就没有了，Context只有一个。
		return
	}
}
```

以上代码在"http://try.kotlinlang.org"上编译通过。

所以啊，inline博大精深。

## noinline和crossinline

那么，noinline和crossinline又是什么鬼呢。。。

其实inline这种东西啊，在一些比较奇怪的时候，会有各种各样的问题啦。。比如各种东西的作用域啊。。Context不一样啦。。。。所以Kotlin又弄了俩inline方法的Lambda参数的修饰符。

注意，inline是方法的修饰符，crossinline和noinline是参数的修饰符，而且仅限参数！

其实理解起来很简单。请先仔细阅读上文中的代码。

### crossinline

考虑如下代码，这段代码是编译不过的。编译器会提示你加个crossinline。

```kotlin
inline fun test(f: () -> Unit) {
	thread(f)
}
```

这玩意强制编译器把你的inline按照上述代码中方法boyNextDoor的样子处理（强制inline）。如果不能那样处理的话就给个error，不通过编译。很简单吧。

比如以下代码就不能通过编译：

```kotlin
inline fun test(crossinline f: () -> Unit) {
	thread(block = f)
	// 你也可以这样写，下面这种写法也不能通过编译
	// thread(f)
}
```

因为你进行了很不和谐的参数传递操作（其实只要是控制流都会出事），而如果把代码inline进去的话是不行的。。自己想想如果把这个方法直接写到原方法中的样子吧。你只能这样写：

```kotlin
inline fun test(crossinline f: () -> Unit) {
	thread({ f() })
}
```

### noinline

这玩意不让编译器把你的inline按照上述代码中方法boyNextDoor的样子处理。如果那样处理不能有任何效率/空间上的优化的话就给个warning，通过编译。很简单吧。

```kotlin
inline fun test(noinline f: () -> Unit) {
    thread { f() }
}
```

以上代码你会收到一个可爱的warning。

因为这inline本来是个可以优化调用的操作，你非要写成这样就失去了inline的意义了（虽然不加noinline根本不过编译），所以警告一下啦。

Kotlin就是要求你写的清晰。为了节约你的时间和精力，她帮你推断类型。为了节约你的debug和code Review时间，她强制让你声明一些别的语言里面不强制的东西（比如任何数值类型必须显示cast，显示声明infix，显示声明tailrec，crossinline，noinline等等等等）。

像某些语言的隐式转换啊，就是专门让别人在不开debugger的情况下看不懂你的代码的。。（逃

于是。。。

### 本垃圾说完了

嘛，就这样啦。欢迎围观寒冰Frice全家桶：

+ [Frice-JVM](https://github.com/icela/FriceEngine)
+ [Frice-CLR](https://github.com/icela/FriceEngine-CSharp)
+ [Frice-Designer](https://github.com/icela/FriceDesigner)
+ [Frice-Demo](https://github.com/icela/FriceDemo)
+ [Frice-DSL](https://github.com/icela/FriceEngine-DSL)


，求star求follow！QwQ
