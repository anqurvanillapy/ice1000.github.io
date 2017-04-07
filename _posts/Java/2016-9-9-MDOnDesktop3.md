---
layout: post
title: 在JavaFX中进行Material Design：第三章
category: Java
tags: Java
keywords: Java,JavaFX,MaterialDesign
description: Use Material Design on desktop 3
---

## 准备

1. 阅读上一篇和上上篇教程。

## 开始

打开上篇教程中的工程，和JavaFX Scene Builder。

然后你需要对“依赖注入”这个概念有一定的了解。需要的了解程度不多，只需要知道这个概念就行了。

## 添加事件

我们首先选中那个按钮。按照下图所示，选择箭头所指的项，填写方框内的内容。id是该变量的变量名，On Action你可以简单理解为点击事件。
<img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/javafx3/0.png" align="center">

填好之后，选择View -> Show开头那个。它会给你一个示例代码。
<img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/javafx3/1.png" align="center">

复制这段代码，并删除最下面那个方法名奇怪的方法。复制到你的代码里。打开IntelliJ IDEA，把类名改得和文件名相同，import对应的缺少的包。
<img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/javafx3/2.png" align="center">

现在我们写一些代码。缺少创意的同学可以直接复制我这里提供的一份样例。注意，我删除了包名，请读者手动添加自己设置的包名。

```java
import com.jfoenix.controls.JFXButton;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;

public class Controller {

  private static final String ASS_WE_CAN = "Ass we can";
  private static final String BOY_NEXT_DOOR = "Boy next door";

  @FXML
  private JFXButton button;

  @FXML
  void onButonCLick(ActionEvent event) {
    if (button.getText().equals(ASS_WE_CAN)) button.setText(BOY_NEXT_DOOR);
    else button.setText(ASS_WE_CAN);
  }

}

```

然后跑一跑程序。然后喜闻乐见地报错了。
<img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/javafx3/3.png" align="center">

于是我们转到sample.fxml文件中，并在根元素中添加如下属性，属性值就是你的Controller的完整包名+类名。整个fxml不报错之后，我们来再次跑一跑程序。
<img src="https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/old/java/javafx3/4.png" align="center">

恭喜你，你已经学会了添加点击事件，和操作界面元素。

剩下的就是查API了，可以通过翻API文档和直接使用IntelliJ IDEA内置的反编译工具来查看类，或者是补全功能来浏览API，顾名思义就好。人家的Javadoc写的还是挺良心的。

可以看看这个Demo，虽然是Kotlin写的，但是还用到了好几个别的控件（列表、进度条），可以作为参考。[这是链接](https://github.com/ice1000/Dekoder)。

呐。









