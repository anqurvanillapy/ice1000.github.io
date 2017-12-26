---
layout: post
title: IntelliJ IDEA 复杂的重构操作
category: IntelliJ
tags: Java, IntelliJ IDEA
keywords: Java,IDEA, PhpStorm,WebStorm,PyCharm,Rider,RubyMine,CLion,Android Studio,JUnit
description: IDEA refactoring 2
---

上次我说了一些 "复杂的重构技巧" ，讲的是一些使用 IntelliJ 的简单功能实现复杂的重构需求的技巧。
看到大家的反响之后我就感觉那个可能不大亲民，因为很多人连 inline 这功能都不知道（那岂不是把 IntelliJ 用成了记事本），
于是我决定再写一篇讲讲 IntelliJ 已经提供好了的一些复杂的重构功能。

这就不再是需要自己进行奇奇怪怪的操作的教程了，就会亲民得多。

## 从方法中提取方法

这是用来快速复用一段代码的功能，名叫 "Extract Method" 。  
比如，我现在有这么一段业务代码（顺带一提，这是在 Java 调用动态语言 API 时能使用的最健壮的处理数值类型的方法）：

```java
liceEnv.defineFunction("run-later", ((metaData, nodes) -> {
  Number time = (Number) nodes.get(0).eval();
  Consumer<Node> nodeConsumer = Node::eval;
  if (time != null) runLater(time.longValue(), () -> {
    for (int i = 1; i < nodes.size(); i++) {
      // 截图之前写的时候脑抽了，这个是后来改的
      nodeConsumer.accept(nodes.get(i));
    }
  });
  return new ValueNode(null, metaData);
}));
...
```

为了效率考虑，你决定不使用 `subList(1, nodes.size()).forEach` 而是使用 `for` 循环。

然后你突然发现，这个 "遍历一个集合除了第一个元素之外的元素" 操作在你的代码里面已经被调用了很多次了。  
于是你决定贯彻 "非极端性 DRY 原则" ，把这坨代码复用起来。

我们仔细观察一下。  
这坨代码中，直觉上，我们希望可以通过形如

```java
nodes.forEachExceptFirst(someOperation::accept)
```

的代码来一行处理这个操作的（不懂方法引用的请退群），但是这个 `forEachExceptFirst` 是不存在的。

所以我们想自己造一个。  
这时候我们就应该使用 IntelliJ IDEA 提供的 `Extract method` 功能了。

首先选中那一堆代码，然后按下 <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>m</kbd>，看到这么一个窗口。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/19/0.png)

然后我们在 "Name" 那一栏输入 `forEachExceptFirst` ，也就是我们想提取的函数的函数名；然后回车。

我们可以看到，代码变成了这样：

```java
liceEnv.defineFunction("run-later", ((metaData, nodes) -> {
  Number time = (Number) nodes.get(0).eval();
  Consumer<Node> nodeConsumer = Node::eval;
  if (time != null) runLater(time.longValue(), () -> {
    forEachExceptFirst(nodes, nodeConsumer);
  });
  return new ValueNode(null, metaData);
}));
...
```

我们可以看看它生成的这个 `forEachExceptFirst` 方法：

```java
private void forEachExceptFirst(
    List<? extends Node> nodes,
    Consumer<Node> nodeConsumer) {
  for (int i = 1; i < nodes.size(); i++) {
     nodeConsumer.accept(nodes.get(i));
  }
}
```

然后你就可以在其他地方使用这个方法了。

我们可以给它加上 [JetBrains annotations](../../../01/06/JBAnnotations/):

```java
private void forEachExceptFirst(
    @NotNull List<@NotNull ? extends @NotNull Node> nodes,
    @NotNull Consumer<@NotNull Node> nodeConsumer) {
  for (int i = 1; i < nodes.size(); i++) {
     nodeConsumer.accept(nodes.get(i));
  }
}
```

当然加这么多意义不大，对 `Node` 类型的 `@NotNull` 注解是可以去掉的。

撤回这个操作的话，请使用[上一篇博客](../../21/IDEARefactoring/)所大量使用的 `inline` 功能。

## 从类中提取接口

比如，我们有这么一个 Java 类（最近突然觉得，对类型的注解应该比可见性修饰符更靠近类型（比如在一个方法中，
我就可以用这种方法来区分对返回类型的注解（比如 `@NotNull`）和对方法本身的注解（比如 `@Override`）），
所以就有了这么个把注解写在可见性修饰符后面的奇怪的写法，希望读者不要介意这一点）。

```java
public class Marisa {
  // blablabla

  public Marisa(@NotNull Touhou game) {
    // blablabla
  }

  public @NotNull ImageObject player() {
    return player;
  }

  public @NotNull List<@NotNull ImageObject> bullets() {
    return makeLeftRightBullets(player, mainBullet);
  }

  public void dealWithBullet(@NotNull ImageObject bullet) {
    // blablabla
  }
}
```

代码中省去了一些对文章不重要的细节。

然后我们可以在类名上右键，然后找到这个东西：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/19/1.png)

这样我们会看到一个窗口，里面的东西还挺复杂的：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/19/2.png)

首先我们在 "Interface name" 那里填我们想抽取的接口的名字，比如刚刚的那个类 `Marisa` ，就很适合
`GensokyoManagement` （毕竟魔理沙是幻想乡两位城管之一嘛，又因为城管的翻译是 `Urban management`）
这个名字的接口。

然后我们希望把这三个方法都抽取到接口里面去，于是就勾选下面的三个方法。请根据实际需求勾选需要抽取的方法。  
最后回车。

这时候 IntelliJ IDEA 会询问你，是否 "尽可能在这个类被使用的地方，把这个类的类型改成接口的类型"。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/19/3.png)

这是一种很好的作法，比如我们会倾向于把

```java
LinkedList<Marisa> gensokyoManagements = new LinkedList<Marisa>();
```

写成
 
```java
List<GensokyoManagement> gensokyoManagements = new LinkedList<Marisa>();
```

，对不对吖。  
这里这个提示就是问你要不要这么换一波的。这个就看需求了，另外建议取消勾选下面的 "Preview usages to be changed"。

最后我们就提取出来了这么个玩意（这里只有三个方法所以生成的代码很少，看起来不是很高大上，
如果你实现了一种操作比较多的数据结构（比如线段树啊，各种图啊树啊）再这么来一波，就能生成一大坨）：

```java
public interface GensokyoManagement {
  @NotNull ImageObject player();

  @NotNull List<@NotNull ImageObject> bullets();

  void dealWithBullet(@NotNull ImageObject bullet);
}
```

然后我们就可以再写其他类，比如：

```java
public class Reimu implements GensokyoManagement {
}
```

然后让 IntelliJ IDEA 自动生成之前那些方法，然后我们就可以愉快地写实现啦。

## 接口与实现间的互相发送代码

我们还有很多可以做的事情，比如我们现在给 `Marisa` 类加了新方法作为新功能，然后我们想给 `Reimu` 也加上，
并把这个方法作为 `GensokyoManagement` 的一个抽象方法之一（接口的方法是默认抽象的，别因为省了 `abstract`
修饰符就以为不是了）：

```java
public @NotNull List<@NotNull ImageObject> spellCard() {
  return masterSpark();
}
```

我们可以这样，在新方法上右键，然后这么选：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/19/4.png)

这样我们会看到一个窗口，里面的东西不怎么复杂：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/19/5.png)

只需要勾选我们要送给接口（或者父类）的方法，然后回车就好了。  
IntelliJ IDEA 会给你加上 `@Override` 修饰符，和生成新的抽象方法。

然后我们就可以跳到 `Reimu` 类，让 IntelliJ IDEA 生成一个空实现，然后接着写啦。

## 推荐阅读的相关文章

+ [IntelliJ 复杂的重构技巧](../../21/IDEARefactoring/)
+ [IntelliJ 中工程的基本概念](../../../../2016/11/19/IDEAAdvance3/)
+ [IntelliJ 中测试框架的使用](../../../../2016/12/11/IDEAAdvance4/)
+ [IntelliJ 中的文学编程](../../../04/01/IDEALanguageInjection/)

## 本文完

希望大家年底过的开心。

下一篇可能是 StupiJ IDEA 的一些华点。
