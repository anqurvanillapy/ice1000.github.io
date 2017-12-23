---
layout: post
title: IntelliJ IDEA 复杂的重构技巧
category: IntelliJ
tags: Java, IntelliJ IDEA
keywords: Java,IDEA, PhpStorm,WebStorm,PyCharm,Rider,RubyMine,CLion,Android Studio,JUnit
description: IDEA refactoring
---

重构是 IDE 给人类生活带来便利的一个重要方面。但是 IDE 永远不是我们肚子里的蛔虫，有时我们会有复杂到 IDE 不可能直接提供的重构需求。  
下面我来告诉大家怎么利用有限的 IDE 重构功能， ~~创造无限的价值~~ 处理复杂的情况。

## 复习一下快捷键

先复习一下快捷键吧，我们这次就看两个就好。

### inline

这个叫 `inline` 的东西快捷键是 <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>n</kbd>。  
这个东西的作用是把当前光标上的东西，在代码级别内联掉。

按下这个快捷键后，会看到一个弹窗（这个是 `inline` 一个 Kotlin 方法的弹窗，对于 Java 还多几个选项。
不过这都不是重点啦）:

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/18/0.png)

我们都默认选第一个，就是在 `inline` 之后删除被 `inline` 的东西，第二个是 `inline` 后保留。  
如果你是在调用处而不是定义处这么搞，第三个选项就可以选，是只 `inline` 这一处。

我们一般不管，使用第一个。

### rename

这个我就不多介绍了，应该是最常用的快捷键之一了: <kbd>Shift</kbd>+<kbd>F6</kbd> 。

## 删除一个被多次引用的空函数

### 场景

我们知道， IntelliJ 会把 "没有被用到的函数" 标灰（这个 "没有被用到" 的定义其实蛮复杂的，比如你实现了一个接口，
那么这个接口的方法即使没被调用也不会被标灰。这里我就不纠结这个细节了），并且会给出 "Safe delete" 的提示。  
这往往不是我们想要的，因为我们看到这个东西的时候， 多半都是刚写完一个函数还没来得及调用的时候。

而我们有时在重构的时候，一个函数里面的东西被全部移出去后，这个函数体就是空的了，而它仍然在多处被调用。  
我们这时想删除这个函数，以及它的所有调用处。

```kotlin
fun SymbolList.addGetSetFunction() {
}
```

比如这个，我在重构 [Lice](https://github.com/lice-lang/lice) 的时候，就产生了很多上面这种东西。  
这个函数被调用了，所以 IntelliJ IDEA 不会给出 "Safe delete" 的选项。

虽然语言是 Kotlin ，但是这就是一个朴素的函数声明，我觉得不需要进行进一步的说明。

```kotlin
private fun initialize() {
  addDefines()
  addGetSetFunction()
  addControlFlowFunctions()
```

它像这样被不停调用着。

当然，你可以按下 <kbd>Ctrl</kbd> 然后点击这个函数，再一处一处地删除。

### 解决方法

不过我们为什么不试试直接 `inline` 掉它呢？

```kotlin
private fun initialize() {
  addDefines()
  addControlFlowFunctions()
```

它的函数体本身就是空的，所以说 `inline` 掉后，每个调用处就啥都没了。

## 修改大量出现的相同结构

### 场景

比如，我们有这样的，自己用的库代码（为了让更多人看懂，我在这里使用了 Java）：

```java
// code 0
class Val {
  private Object o;
  public Object getO() { return o; }
}
interface Node { Val eval(); }
```

然后我们可以通过 `someNode.eval().getO()` 来获取一个 `Object` ，对吧。  
然后想象一下我们有这样的业务代码：

```java
// code 1
Object a = xxx.getNode().eval().getO();
xxx.use(yyy.eval().getO());
Val bla = blablabla.eval();
switch (bla.getO().toString()) {
  case "2333":
    break;
}
...
```

这是我们现在的代码。

### 问题

然后我们经过一番小重构，把刚刚的库代码重构成了这样：

```java
// code 0
interface Node { Object eval(); }
```

直接把 `Val` 去掉了，然后让这个 `eval()` 直接返回原本装在 `Val` 里面的变量，然后 `Node` 的各种实现也都改了。  
这时候我们的业务代码已经是一坨红色了。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/18/2.png)

我们想批量去掉这个 `.getO()` 的结构，应该怎么办呢？

首先我们不考虑查找替换，因为

+ 有这种结构的文件很多（假设有一万个），很麻烦（不过 IntelliJ IDEA 有 "Replace in path" 功能）
+ 有很多其他的叫 `getO()` 但不需要被重构掉的函数，会受到波及（这才是最主要的）

这也是很常见的原因，对吧。

这时我们就需要技巧性地重构了。

### 解决方法

首先，我们先把库代码中的 `Node` 临时性地改成这个样子（也就是说，临时性地把 `Val` 弄回来，只是实现变得不一样了）：

```java
// code 0
class Val {
  public Object getO() { return this; }
}
interface Node { Val eval(); }
```

注意这里的 `getO()` 被改成了返回 `this` 。

这时我们刚刚的代码中， `.getO()` 上的红色已经消失了（毕竟这几乎就是改之前的样子）。

**然后，我们对 `public Object getO() { return this; }` 中的 `getO()` 使用 `inline`**，
这样所有的 `.getO()` 结构就被消除了（想想为什么，很简单的道理）：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/18/3.png)

然后我们 **把 `Val` 重命名为 `Object` 并直接删除** ，这样剩下的代码中用到 `Val` 的地方也就全部变成了 `Object` ，
也就是我们所期望使用的那个类型啦。

<!--
类似的对于 `inline` 功能的使用还有很多（比如你可以把 `getO()` 的 `return this` 改成 return 其他的东西，
比如调用某个 `static` 函数的返回值），
但都是一个道理。
-->

## 另一种情况

上面说的，是针对 "批量删除对于一个方法的调用" 的解决方案。  
但我们有时不是想删除，而是增加。这怎么办嘞？

比如，我们现在有上面那段重构完了的代码（which 没有 `getO()` ）。  
我们现在要把每一处 `eval()` 后面加上 `toString()` （反正就是需要加一层方法调用）。

这个也很好解决，我们只需要先把 `eval()` 随便改成（不是重命名，是直接改）另外一个名字（比如 `rua`）：

```java
// code 0
interface Node { Object rua(); }
```

然后我们可以看到业务代码全红了：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/18/4.png)

然后我们再写一个叫 `eval` 的方法，里面返回这个 `rua` 的调用结果再 `toString()` （就是加上你要的那个方法调用）：

```java
// code 0
interface Node {
  default Object eval() {
    return rua().toString();
  }

  Object rua();
}
```

这时业务代码已经不报错了。  
我们再对这个 `eval()` 进行 `inline` ，之后就是这个样子的了：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/18/5.png)

然后再把 `rua()` 使用 IntelliJ 的重命名功能改成之前的 `eval()` ，就一切照旧啦。

## 本文完

祝大家圣诞节快乐。

```
  __________________________________________________
 |                    _                             |
 | /|,/ _   _ _      / ` /_  _ .  _ _/_ _ _   _    _|
 |/  / /_' / / /_/  /_, / / / / _\  /  / / / /_| _\ |
 |             _/                                   |
 |                ~~** ice1000 **~~                 | 
 |__________________________________________________| 
 
 
                       ___
                    /`   `'.
                   /   _..---;
                   |  /__..._/  .--.-.
                   |.'  e e | ___\_|/____
                  (_)'--.o.--|    | |    |
                 .-( `-' = `-|____| |____|
                /  (         |____   ____|
                |   (        |_   | |  __|
                |    '-.--';/'/__ | | (  `|
                |      '.   \    )"";--`\ /
                \        ;   |--'    `;.-'
                |`-.__ ..-'--'`;..--'`

 :*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*
```

这是一个来自 coding.net 的惊喜，我在推送代码的时候看到的：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/18/1.png)

（论使用命令行的好处）
