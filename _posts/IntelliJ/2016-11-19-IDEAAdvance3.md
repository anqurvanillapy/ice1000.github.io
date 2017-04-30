---
layout: post
title: IntelliJ IDEA进阶教程： IDEA中工程的基本概念 上
category: IntelliJ
tags: Java, IntelliJ IDEA
keywords: Java,IDEA, PhpStorm,WebStorm,PyCharm,Rider,RubyMine,CLion,Android Studio
description: IDEA advance chapter 3
---

## 依赖
+ 一个JetBrains系的IDE

这期我说说IntelliJ IDEA系的IDE中的“工程”这一概念。所谓工程到底是什么我觉得我应该不需要解释了，看我博客的人应该都知道吧（逃

## 和AS的不同

AS是IJ的Android魔改版，钦定了Gradle作为构建工具，因此弱化了IDEA中的工程概念（破事情都让你自己写Gradle脚本去，AS甩锅）。事实上，IntelliJ的工程还是比较复杂的。

对于每一个工程(Project)，IDEA会在开启界面显示：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea7/0.jpg)

红框中的都是Project。右边的 Create New Project 就是创建一个新工程，这个过程是使用IDEA的第一关。

随便打开一个工程，可以看到左边的文件树。IDEA根据对不同文件类型的支持情况会显示不同的图标，比如你安装了各种语言的插件支持之后，文件树就会变得五颜六色。如果看不到文件树，那么请使用召唤术**Alt + 1**。

### Project

一个IDEA窗口只能打开一个Project，可以理解为工作区，管理一个Project是通过操作Project Structure 实现的，快捷键**Ctrl + Alt + Shift + S**。记住它，它非常、非常常用。

如图所示是一个什么都没有的文件树，这就是一个一无所有的Project。（其实是“几乎”一无所有，因为有一个LICENSE文件和一个dll，和一个gitignore。这是一个还未进行导入的Project，下文将导入它）

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea7/1.jpg)

然后我们平时的工作是基于Module这一概念的。一个Module相当于是Project的元素，一个Project是Module的集合。小型项目或者结构相对简单的项目，一般情况下都是一个Project对应一个Module。

### Module

一个Module有如下特特征：

+ 一个Module对应一个Makefile文件，并且这个Makefile对用户不可见。
+ 每次运行一个Module中的main方法，将对这个Module的Makefile进行一次构建————也就是增量编译。 如果你一个Module中有未完成的代码（比如一个表达式只写了一半），那么就会错误，无法运行。不同Module中的代码如果不能编译，不会影响当前Module。
+ 同一个Module编译生成的内容将会被放到一起，并一视同仁（即在打包jar之类的时候，同一个Module的目标文件将会被当做一个整体）。

于是我们来导入一个Module。首先根据上文的介绍，打开Project Structure，并打开Modules选项卡，点击绿色的加号，选择 New Module。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea7/2.png)

在弹出界面选择 Java ，然后下面的啥也别选。这个创建的文件最少，也是最适合拿来新建一个高度定制的 Module 的。上面还会根据你的插件显示其他的 Module 选项，选择这些选项之后IDEA会根据插件进行一些默认的配置。比如Java的话就会给你创建一个src，并选好SDK什么的。Kotlin的话就会导入一个Kotlin-runtime.jar等三个标配包，Rust会新建main.rs和Cargo文件，还会顺便开启Git支持（还给你git init了）。可以看到我的IDEA是有很多插件的。。。

可以看到我的IDEA是有很多插件的。。。但是啥也别勾，直接下一步。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea7/3.jpg)

然后让你输文件路径，直接选择项目根目录，这里是 JniMath 。

然后选择那个被你创建出的 Module 。可以看到，它已经非常聪明地根据 src 目录的名称识别出了这个目录就是存放源码的目录，并且使用蓝色标记出来了。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea7/4.jpg)

选中 src ，可以看到上面的 Mark as 这一栏中的 Sources 被标出来了。取消选中它， src 就会变得和别的目录一样————栗色。还有别的几个目录类型：

类型|作用
:---|---:
Sources|源码，在debug和release的时候被编译，同一Module的所有 Sources 的目标文件都放在一起。
Tests|测试代码，同一Module的所有 Tests 的目标文件放到一起，和 Sources 区别对待。右键这种类型的目录，会有一个选项，执行目录下所有的测试代码。
Excluded|目标文件，测试代码和源码的目标文件在这个目录下分开放置，clean的时候会被清空，里面的东西因为都是目标文件，所以不要放置你的劳动成果，因为这个目录被IDEA当成垃圾桶。
剩下的|用的太少懒得说

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea7/5.jpg)

了解完作用之后我们可以把所有的目录正确标注出来————test对应Tests，src对应Sources，out对应Excluded。然后src和test目录下的文件就会被识别成Java的包了。这几个文件也是编译时执行javac的根目录。因此，包从这里开始放。test也一样。包的图标和普通目录图标不一样，下图有个很明显的对比。 然后下图中的Language Level选的是1.3 Plain Old Java，我们改成8。可以看到，似乎JetBrains已经早就把Java10的解析器写好了。。。

然后在左边的选项卡中选择 Project ，把SDK设置成你的JDK，然后把 Language Level改成8。然后把 Project compile output 设置成你刚刚在 Module 里面设置的out目录。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea7/6.jpg)

然后回到刚才的 Modules ，看到上面的选项卡，选择 Paths ， compile output 选择 Inherit from Project output ，这样你的编译输出就重定向到了刚才设置的out里面。在 Dependencies 里面可以设置依赖，这次先不讲。

选择OK，保存设置，然后你就会发现它在 Indexing ，过一会就能看到你设置好的Module了。我安装了一个 gitignore 的插件，可以智能管理被Git忽略的文件。没有加入Git监控的文件它会提示你加入 gitignore ，被 gitignore 忽略的文件它会在文件树中灰色标记。可以看到我的out目录就是被灰色标记的，作为一个使用GitHub的程序员的基本素质就是不把目标文件上传，对吧。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/idea7/7.jpg)


#### 祝你用IDEA用的愉快。


