---
layout: post
title: Java 里的类型推导，上篇文章中的一个问题
category: Java
tags: Java
keywords: Java
description: Java type inferencer
---

看看我刚刚脑子里闪出了什么！

刚刚发了[这篇文章](../../03/KotlinFucksJavaAgain)，突然发现我说的那个 "Java 没有类型推导" 是错的。

于是我就写出了这样的代码。这玩意正确地推导了这个匿名类的准确的类型：

```java
static <T> void doWith(T obj, Consumer<T> consumer) {
  consumer.accept(obj);
}

public static void main(String[] args) {
  doWith(new Object() {
    void starPlatinum() {
      System.out.println("Star finger!");
    }
  }, obj -> obj.starPlatinum());
}
```

这个代码是正确的，能编译能运行，并且这个 lambda 只能被写成这种形式，不能展开成匿名内部类，不能改成方法引用。

因为我觉得这灵光一闪太牛逼了，我就单独发文章了。

![mikecovlee](https://user-images.githubusercontent.com/16398479/34515492-392146e6-f0ad-11e7-9077-36433151a367.png)

