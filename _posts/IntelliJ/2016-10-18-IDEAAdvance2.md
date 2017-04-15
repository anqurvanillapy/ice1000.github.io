---
layout: post
title: IntelliJ IDEA进阶教程： IDE背景图片
category: Java
tags: Java, IntelliJ IDEA
keywords: Java,IDEA, PhpStorm,WebStorm,PyCharm,Rider,RubyMine,CLion,Android Studio
description: IDEA advance chapter 2
---

今天在openjudge上AC了不少水题，想颓一会，于是打开[https://www.jetbrains.com](https://www.jetbrains.com)去看看自己的信仰。然后就发现了这个，关于自定义IDE背景的事情。

话说IDE自定义背景是VS不知道多少年以前玩的了，估计是JetBrains看不惯了，自己也在JetBrains系列产品的2016.2系列中加入了这个叫**Set Background Image**的功能。在这之前，我是通过一个插件来实现IDE自定义背景的。

## 12月15日更新
我才发现我的截图全部都是 Sexy Editor 和自带插件混用的效果。。。可以看到两张图片重叠的痕迹。。。<br/>
被自己蠢哭。。。另附一张最近截的没有重叠的图片。。。

![image without error](https://coding.net/u/ice1000/p/Images/git/raw/master/test1.png)

## 依赖
+ JetBrains系列IDE的2016.2以上的版本

## 先看看插件的效果吧

IDE是[Project Rider](https://www.jetbrains.com/rider)，JetBrains系列的C# IDE。
这是Sexy Editor的效果，只能让代码编辑画面变成图片：
<p><img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea6/1.jpg" align="center"></p>

这个插件叫Sexy Editor。它的设置界面长这样：
<p><img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea6/2.png" align="center"></p>

之前我一直都在用这个。直到我发现了自带的。

可以通过IntelliJ IDEA自带的插件管理器找到它。不过我已经发现了更好的显示背景图片的方法，于是我就很果断地Uninstall了这个插件。不过我主观上还是很欣赏这个插件的。卸载只是因为找到了替代品。
<p><img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea6/4.png" align="center"></p>

来看看官方的图片背景插件吧。IDE是Project Rider。
<p><img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea6/3.jpg" align="center"></p>

这次又是IntelliJ IDEA了（不要吐槽我老是换IDE，我同时写Kotlin和C#你管我），
官方的插件可以把整个IDE的画面变成图片。而且我曾经舍不得拿来用的低清图片放到这个插件来用，莫名其妙地变得谜之高清了：
<p><img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea6/5.jpg" align="center"></p>

这让我再一次认识到了IntelliJ IDEA系列的神奇。

## 使用方法

不好意思没图，我已经关了IDE了，现在寝室里面电力是个问题Orz。

首先**Ctrl+Alt+S**打开设置。在搜索栏输入**Set Background Image**，在Keymaps里面找到唯一的搜索结果。然后给这个搜索结果增加一个快捷键。增加一个尽可能复杂的、你平时不会用的快捷键。我选择的是**Ctrl+Shift+Alt+Q**。然后保存设置退出。
### 方法一

首先**Ctrl+Alt+S**打开设置。在搜索栏输入**Set Background Image**，在Keymaps里面找到唯一的搜索结果。然后给这个搜索结果增加一个快捷键。
增加一个尽可能复杂的、你平时不会用的快捷键。我选择的是**Ctrl+Shift+Alt+Q**。然后保存设置退出。

在编辑器里面按下你刚才设置的快捷键。弹出一个窗口。这时已经是属于那种是个人都会的操作了。设置一张图片。然后可以看到预览。点击确定，就可以看到你的自定义IDE了。

### 方法二

按下**Ctrl+Shift+A**，你会看到弹出了一个框框，在里面输入一些操作的名字可以跳转到相应的操作界面（你可以通过这个方法找到你猜测IntelliJ可能会有的黑科技），
输入**Set Background Image**，弹出一个窗口，根据窗口的提示进行操作即可。还有实时预览哦。


快去给你的IDE添加一些~~奇怪~~有趣的图片吧。



