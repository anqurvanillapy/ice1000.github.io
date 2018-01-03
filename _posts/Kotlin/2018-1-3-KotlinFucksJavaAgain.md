---
layout: post
title: Kotlin 那些不仅仅是语法糖的好处
category: Kotlin
tags: Kotlin
keywords: Kotlin
description: Kotlin fucks Java again
issue_id: 9
---

夜雀的 [Kotlin 的华点](https://lgzh1215.github.io/2017/10/18/huadian/)一文可能会引起我们一个沉重的思考——"这语言到底能不能用？"。但这个人对 Kotlin 的了解到了如此的程度，说明他起码也是 Kotlin 的一个粉丝，而且对 Kotlin 是爱的深沉啊！

本文我决定告诉大家一些 Kotlin 能做的但是 Java 无论如何也做不到的事情（刚好对上夜雀的那个[一件 Java 能做但是 Kotlin 不能做的事情](https://lgzh1215.github.io/2017/10/18/huadian/#一件Java能做但是Kotlin不能做的事情)）吧。

## Motivation

因为很多人总是在网上发表一些言论，说什么

> Kotlin 不就是一堆语法糖吗， Java 有 IDEA 写起来还不是一样快，怕什么。

好像对于初学者（尤其是那种学过的语言很少，而且对 Java 的了解也很少）来说看起来确实是这样。

### Disclaimer

本文说的都是以 JVM 为后端的 Kotlin ，不是 KotlinJS ，也不是 Konan 。  
要不然就没有可比性了。

## 低能区

现在是低能区，是一些人都看得懂的。

### reified

这个知道的人应该很多，就是借助 `inline` 功能把泛型参数拿进来，并在运行时使用（而不是像 Java 那样只有编译期知道）。  
这个拿进来的类，可以获取它的 `Class<out T>` ，可以进行 `instanceof` 的判断。

但是这个方法有个缺点，就是只能把方法的泛型搞成真泛型，没法把类的泛型也搞成真泛型。  
我们只能借助我以前在博客写过的一个关于用 `companion object` 的 `invoke` 操作符重载的操作，来模拟这样的效果（障眼法）：

```kotlin
class Abcd<T>(val clazz: Class<T>) {
  fun printGenericParameter() = clazz.canonicalName
  companion object {
    inline operator fun <reified T> invoke() = Abcd(T::class.java)

    @JvmStatic fun Array<String>.main() {
      val abcd = Abcd<LiceInjectionElement>()
      abcd.printGenericParameter().let(::println)
    }
  }
}
```

注意主函数里面，我假装调用了 `Abcd` 的构造函数，然后传入了一个泛型参数，然后再调用了一个方法，它把这个泛型参数的全限定名输出出来了：

```java
org.lice.lang.psi.impl.LiceInjectionElement
```

其他部分看不看得懂就是你的事了。

### 命名

我在[这篇文章](../../../../2017/11/12/InternalFucksJava/)里提到过一个使用很骚的命名方法的操作。

比如这段代码，就是 Java 写不了的（它编译生成的代码是 Java 无法写出来的）：

```kotlin
infix fun Int.`+`(int: Int) = this * int
fun Array<String>.main() {
  println(1 `+` 10) // 输出 10
  println(1 + 10) // 输出 11
}
```

根据同样的原理，我在 [Lice](https://github.com/lice-lang/lice) 的[标准库](https://github.com/lice-lang/lice-tiny/blob/master/src/org/lice/core/FunctionWithMetaHolders.kt)里大量使用了这种方法，然后直接通过对这些东西的实例进行

```kotlin
instance.javaClass.declaredMethods.forEach { method ->
  defineLiceFunction(method.name) { /* 省略 */ }
}
```

来生成标准库（因为我要求函数名是 `+`， `-`这种， Lisp 嘛），比起之前将每个标准库函数使用 Lambda 表示的作法，大大减少了编译生成的文件大小（`165kb -> 100kb`）。

### Label return

众所周知， Java 里面的 `break` 和 `continue` 是可以带标签的：

```java
public static void main(String... args) {
  out:while (true) {
    in:while (true) {
      System.out.println("do you like what you see");
      continue out;
    }
  }
}
```

而 Kotlin 也可以：

```kotlin
fun Array<String>.main() {
  out@while (true) {
    iin@while (true) {
      println("do you like what you see")
      continue@out
    }
  }
}
```

但是， Java 的 lambda 是没有标签的。比如，这么一段 Kotlin （出自之前的[forEach 也能 break continue](../../../../2017/04/23/KotlinForEachBreakContinue/)）， Java 中就没法写等价的：

```kotlin
run breaking@ {
  (0..20).forEach continuing@ {
    if (10 <= it) return@breaking
    println(it)
  }
}
```

这个东西 Scala 也只能模拟（Glavo 写过一个文章讲这个），不像 Kotlin 自己就有。

## 高能区

~~前方⑥出没，请无关人员撤离，交给城管处理。~~

### 无法写出来的类型

这个是我在群里的讨论里得知的东西。

相信很多 Java 程序员都知道这个操作：

```java
public static void main(String... args) {
  ArrayList<String> list = new ArrayList<String>() { {
    add("2333");
    add("666");
  } };
}
```

我们也可以在这个时候定义一些方法和成员变量：

```java
public static void main(String... args) {
  ArrayList<String> list = new ArrayList<String>() {
    { addSomeVars(); }

    String toBeAdded = "2333";
    void addSomeVars() {
      add(toBeAdded);
      add("666");
    }
  };
}
```

但是，这些定义出来的成员，也只能在匿名内部类里面被使用罢了，它本身是没法在外面被调用的——不过我们也都知道，你这个变量的类型是 `ArrayList<String>` ，which 没有那些成员。  
也就是说，你实际上是把一个类型为 `ArrayList<String>` 的子类型（就是匿名内部类的类型，这个东西是无法在代码里面表示的）的变量赋值到了一个 `ArrayList<String>` 的变量上。

我们可以根据 IDE 的表现看出：

![IDE](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/20/0.png)

所以用不了你定义的成员变量，也没什么大不了的。

但！是！在 Kotlin 里面，由于你可以让它自己推导类型，而编译器知道匿名内部类的类型（类型注解会被错误地推导，因此不能手动加）。  
因此我们可以使用它：

![IDE](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/20/1.png)

反编译成 Java 看看：

![IDE](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/20/2.png)

这个类型竟然是 `undefinedType` ——也难怪 Java 没法用了。

生成的字节码片段是这样的：

```
  public final static main([Ljava/lang/String;)V
  @Lkotlin/jvm/JvmStatic;()
    @Lorg/jetbrains/annotations/NotNull;() // invisible, parameter 0
   L0
    ALOAD 0
    LDC "args"
    INVOKESTATIC kotlin/jvm/internal/Intrinsics.checkParameterIsNotNull (Ljava/lang/Object;Ljava/lang/String;)V
   L1
    LINENUMBER 8 L1
    NEW org/lice/lang/psi/A$main$list$1
    DUP
    INVOKESPECIAL org/lice/lang/psi/A$main$list$1.<init> ()V
    ASTORE 1
   L2
    LINENUMBER 21 L2
    GETSTATIC java/lang/System.out : Ljava/io/PrintStream;
    ALOAD 1
    INVOKEVIRTUAL org/lice/lang/psi/A$main$list$1.getToBeAdded$production_sources_for_module_lice_ij ()Ljava/lang/String;
    INVOKEVIRTUAL java/io/PrintStream.println (Ljava/lang/String;)V
   L3
    LINENUMBER 22 L3
    GETSTATIC java/lang/System.out : Ljava/io/PrintStream;
    ALOAD 1
    INVOKEVIRTUAL org/lice/lang/psi/A$main$list$1.addSomeVars$production_sources_for_module_lice_ij ()V
    GETSTATIC kotlin/Unit.INSTANCE : Lkotlin/Unit;
    INVOKEVIRTUAL java/io/PrintStream.println (Ljava/lang/Object;)V
   L4
    LINENUMBER 23 L4
    RETURN
   L5
    LOCALVARIABLE list Lorg/lice/lang/psi/A$main$list$1; L2 L5 1
    LOCALVARIABLE args [Ljava/lang/String; L0 L5 0
    MAXSTACK = 2
    MAXLOCALS = 2
```

### 匿名类多继承时指定 super

这个东西 Java 根本就写不出类似的代码：

```kotlin
fun main(args: Array<String>) {
  val list = object : ArrayList<String>(), Cloneable {
    override fun clone(): Any {
      return super<ArrayList>.clone()
    }
  }
  System.out.println(list)
}
```

Java 的匿名内部类是不能多继承的（这里的继承也包括实现接口）。

这个奇技淫巧在 Kotlin 里面被实现的很完美，比如你的确是不能知道这个类型的名字的这一事实，在代码提示中也有体现：

![IDE](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/20/3.png)

右边本来应该写类型，它显示了 `<no name provided>`。

## 结束

我说完了。

类似[这种乱七八糟的东西](https://stackoverflow.com/a/47919670/7083401)， Java 也是无能为力的。
