---
layout: post
title: JavaFX 在 Ubuntu 上的一个 bug ，万恶的向前不兼容
category: Java
tags: Java
keywords: Java,JavaFX,Java8
description: Java8 bug openjdk
---

最近在写一些多媒体相关的代码，当了一回 API 拼接工程师，然后踩了不少坑，现在又有了写博客的欲望。

首先来说说这个 OpenJDK 的 bug ，这只是我最近踩坑的一个很小的插曲。

## 发现问题

这是一个多媒体相关的 bug ，在使用 JavaFX 的 `MediaPlayer` 播放 mp3 格式的音频和 mp4 格式的视频时出现的。

JavaFX 抛出 `com.sun.media.jfxmedia.MediaException` 异常，然后又说些什么

> Could not create player!

引得 [StackOverflow](https://stackoverflow.com/questions/38164044/javafx-media-player-on-ubuntu-16-04)
上的人哄堂大笑。还有人[尝试强行解决](https://stackoverflow.com/questions/26896798/javafx-media-player-not-working)
，但他并没有意识到这其实是天灾而不是人祸。

## 解决方法

### 方法一

使用我的私货。

即，不使用 JavaFX 的 Media ，而是使用 [FriceEngine](https://github.com/icela/FriceEngine) 提供的 `org.frice.utils.media.AudioManager` 类，
里面的方法看名字你就会用了。

### 方法二

使用其他格式的媒体文件。

比如 wav ，就是正常支持的。

### 方法三

让你的程序不在 Ubuntu 16.04 下调用这个代码。

### 方法四

也是最有效的方法，就是使用 OpenJDK 9 ，也就是 Java 9 。  
这个 bug 早就被发现了，只不过它是在 Java 9 的库里被修复的。

## bug 出现的原因

是因为 JavaFX 的 `MediaPlayer` 在 Linux 上的实现实际上是调用了一个叫 `libav` 的东西。

这个东西很罪恶，它的版本从 53 到 56 是不兼容的，也就是不向下兼容。  
Ubuntu 已经默认让用户更新到 56 ，而 OpenJDK 却还调用着 53 的 API ，场面一度十分尴尬。

这证明了向下兼容的重要性，以及及时修复的重要性。

## 参考

+ 踩坑涉及的 [GitHub issue](https://github.com/icela/FriceEngine/issues/29)
+ [JDK bug report](https://bugs.openjdk.java.net/browse/JDK-8150503)
+ [StackOverflow 问题 1](https://stackoverflow.com/questions/38164044/javafx-media-player-on-ubuntu-16-04)
+ [StackOverflow 问题 2](https://stackoverflow.com/questions/26896798/javafx-media-player-not-working)

## 补充一个推荐

夜雀聚聚写了[一篇关于 Kotlin 的坑的博客](https://lgzh1215.github.io/2017/10/18/huadian/)，
我看了感觉非常有收获，都是些我不知道的坑。

推荐一波。

