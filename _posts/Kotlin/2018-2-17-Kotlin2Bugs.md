---
layout: post
title: 聊两个 Kotlin 编译器的 bug
category: Kotlin
tags: Kotlin
keywords: Kotlin
description: Kotlin bugs
---

最近在使用 Kotlin 开发一个 [IDE 插件](https://github.com/ice1000/julia-intellij)，遇到了一些 Kotlin 编译器的 bug ，就在博客里分享一下。

## Java 交互问题

首先， Kotlin 编译器在遇到接口自带实现的情况时，会生成一个 `DefaultImpls` ，大概长这样:

```java
@Metadata(
  mv = {1, 1, 9},
  bv = {1, 0, 2},
  k = 3
)
public static final class DefaultImpls {
  @NotNull
  public static FShapeQuad getDefaultActiveArea(final FriceGame $this) {
     return (FShapeQuad)(new FShapeQuad() { // ...
     });
  }

  @NotNull
  public static FShapeQuad getBox(FriceGame $this) {
    FShapeQuad var10000 = $this.getActiveArea();
    if (var10000 == null) {
      var10000 = $this.getDefaultActiveArea();
    }

    return var10000;
  }
// ...
```

然后生成的子类中还是会有这些抽象方法的实现，
只是实现都会调用这个 `DefaultImpls` 里的方法（也就是说，
它对 Java8 的 default 一无所知
![rubbish-kotlin](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/rubbish-kotlin.png)）。

因此，如果有一个 Java 的子类实现这个接口，
那么这些在 Kotlin 里有默认实现的方法其实都还是抽象的，
只是你可以直接在里面写 `return DefaultImpls.xxx()` 而已。

我遇到这个问题的 case ，是有这样的代码的继承关系：

```kotlin
interface IJuliaSymbol : PsiElement { fun rua() = 233 }
abstract class JuliaSymbolMixin : JuliaSymbol
```

```java
interface JuliaSymbol extends IJuliaSymbol { }
class JuliaSymbolImpl extends JuliaSymbolMixin { }
```

我以为 `rua` 的实现会在 `JuliaSymbolMixin` 中被自动插入，
于是 `JuliaSymbolImpl` 就可以使用了。

结果我太年轻，编译器直接抛异常。

此乃 [KT-22882](https://youtrack.jetbrains.com/issue/KT-22882)。

错误信息：

```
Error:Kotlin: [Internal Error] java.lang.AssertionError: Could not generate LightClass for org.ice1000.julia.lang.psi.impl declared in <null>
System: Linux 4.13.0-32-generic Java Runtime: 1.8.0_151-8u151-b12-0ubuntu0.16.04.2-b12
```

## 元数据和实际代码不符的问题

一开始我遇到这个问题是懵逼的，因为我只是调用了一个 `inline reified` 的方法而已，我犯了什么错呢。

```kotlin
get() = parentOfType<JuliaStatements>() ?: parent
```

实际上是这样的， Kotlin 在查找方法之类的东西的定义的时候，
是进入类文件的元数据进行查找的，
因此如果元数据和方法本身不匹配的话就可以崩掉编译器。

而这里就是一个道理，生成的类被混淆了，而元数据保持不变，
于是编译器找到的合法定义变得不存在了，就抛异常。

这也是一开始 Alex 没有成功复现这个 bug 的原因，因为在他的电脑里，
gradle 是通过下载 IntelliJ Community 的最新版来解决的依赖问题，
而这个就没有被混淆，所以编译正常通过。

此乃 [KT-22916](https://youtrack.jetbrains.com/issue/KT-22916)。

错误信息：

```
e: org.jetbrains.kotlin.codegen.CompilationException: Back-end (JVM) Internal error: Couldn't inline method call 'parentOfType' into
public open val startPoint: com.intellij.psi.PsiElement defined in org.ice1000.julia.lang.psi.impl.JuliaDeclaration
open val startPoint: PsiElement get() = parentOfType<JuliaStatements>() ?: parent
Cause: Not generated
Cause: Couldn't obtain compiled function body for public inline fun <reified T : com.intellij.psi.PsiElement> com.intellij.psi.PsiElement.parentOfType(): T? defined in com.intellij.psi.util[DeserializedSimpleFunctionDescriptor@676ab4f3]
File being compiled and position: (29,42) in /home/ice1000/git-repos/julia-intellij/src/org/ice1000/julia/lang/psi/impl/julia-psi-mixin.kt
The root cause was thrown at: InlineCodegen.kt:529
```

希望这些 bug 都早日得到修复。

最后再唾弃一次：
![rubbish-kotlin](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/rubbish-kotlin.png)

第二次用 Emacs 写这么多中文，感觉好不习惯【x
