---
layout: post
title: 给Lice写了俩工具
category: Lisp
tags: Lisp
keywords: Lisp,Java,Lice
description: made 2 tools 4 lice
---

## 给Lice写了俩工具

最近在折腾我的Lice，由于暂时告一段落了（暂时想不到什么必须写的东西），

星期一作业比较少，于是就在那天拿了两节晚自习的时间给它造了俩工具。

灵感来源于丰恺同学[@lfkdsk](https://github.com/lfkdsk)
给他的HobbyScript写的解析器的一个彩蛋，
就是在Parse代码拿到AST之后把它显示为（非常友好，显示了很多元数据的）韦恩图，
不过他这个是调用了一个Python库的Java API。

我发现Java的Swing框架是有一个JTree的，可以显示树形结构。
JetBrains系列IDE用于显示文件树的控件应该就是魔改过后的JTree。

所以我就直接选择了它。

我在写这个东西之前对于JTree的了解仅限于它是一个Swing控件。
但是我却成功地拿它做出了可以用的东西。
这虽然大部分归功于Swing的封装很简单，但是我认为这也是一种平常情况下不会自动产生、
需要学习的一种非常重要的技能。我决定之后再找时间写一篇教程，
教你怎么在**没有文档没有网络只有IDE**的情况下使用一些库。

### 词法树阅读器

我不知道这门翻译对不对，反正原意是“Syntax Tree Viewer”。
它的功能就是读取一个Lice代码文件并进行词法分析，然后把AST通过swing的JTree显示出来。

大概效果是这样的，对应这样的一个Lice代码（SICP第一章那个费马检查的代码）：

```lisp
; SICP 1.2.6

(def exp-mod a b m (|>
  (-> ret 1)
  (while (!= 0 b) (|>
    (if (!= 0 (& b 1))
      (-> ret (% (* a ret) m)))
    (-> b (/ b 2))
    (-> a (% (* a a) m))))
  ret))
(def try-it a n (== (exp-mod a n n) a))
(def fermat-test n
  (try-it (+ 1 (rand (- n 1))) n))
(def say n
  (println n " => " (fermat-test n)))
(|>
  (say 101)
  (say 233)
  (say 777)
  (say 666)
  ()
)
```

以上代码精简了注释，原文在[GitHub上](https://github.com/ice1000/lice/blob/master/sample/sicp/1-2-6.lice)。

使用该工具显示出来的语法树是这样的：

![syntax tree1](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/1/1.PNG)

有点大，分成两张图算了：

![syntax tree2](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/1/2.PNG)

这是字符级别的语法树，相当于是只进行了Syntax级别的Parse。

Lice语言的Syntax级别的Parse和Semantic级别的Parse是分开的，
首先使用循环+栈（指数据结构）进行一次Syntax级别的Parse，
然后再递归遍历这棵树，建立一颗等同的Semantic分析过后的树。

上面的工具就是把Syntax分析过后的树给map了一遍之后代理给
JTree所需要的DefaultMutableTreeNode。

既然如此，我们还可以把Semantic级别的语法树拿来Parse。

我为此给那些Node分别添加了一个toString用来显示内容。
这是Parse之后的样子。

![semantic tree1](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/1/3.PNG)

还是有点大，分成两张图片：

![semantic tree2](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/1/4.PNG)

还是不错的对吧？字面量显示出了类型，函数调用显示出了参数数量。

注意def不是保留字而是一个内置的函数。
因此“函数定义”这一过程其实也算是一种函数调用。

按理说你们是可以在GitHub的release界面看到这俩工具的下载的，
打开jar之后会先弹出一个文件选择框，选择一个扩展名为lice的文件，
打开就可以看到语法树辣。

当然，这个和丰恺的输出图片也是有很多不同之处的。比如图片就只能是图片，
我这个可以展开、关闭一些语法树节点。

![collapse](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/1/5.PNG)

目前两个小工具代码都非常少。

甚至还可以做到：

+ 对现有AST节点进行编辑
+ 根据编辑后的AST，导出Lice代码
+ 合并、添加、删除等复杂操作
+ AST节点的复制粘贴

以上内容目前还只是YY，不知道我这二倍根号二脚猫水平能不能做出来。

—— 2017/3/7
