---
layout: post  
title: 把图片变成字符画
category: Tools
tags: Misc
keywords: Kotlin
description: Make image a textify
---

## 使用的技术

+ Kotlin
原因：我只会这个
+ C\+\+
原因：上次问我问题的人只会这个

## 工作流程

0. 拿到一张图片
0. 使用Kotlin读取并生成字符画
0. 生成对应的C\+\+代码
0. 满足知乎那个人的好奇心

### 选择一张图片

我选择出自[这篇博客](http://ice1000.org/2017/03/24/UseMemoPoolInFibMatrix/)
的这个图片：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/4/1.png)

### 选择填充符号

为了简单地解决问题，我选择单纯地二值化：

```□ ■```

就使用这两个符号，分别代表RGB值大于界限的和小于界限的像素。

界限暂定`0x7f`。

### 写一段代码输出到控制台

随手写就是了，很简单，纯粹意念编程：

```kotlin
fun main(args: Array<String>) {
  val image = ImageIO.read(URL("https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/4/1.png"))
  (0..image.height - 1 step 2).forEach { y ->
    (0..image.width - 1 step 2).forEach { x ->
      Color(image.getRGB(x, y)).run {
        print(if ((red + green + blue) / 3 <= 0x7f) '■' else '□')
      }
    }
    println()
  }
}
```

预览的时候，我们先调整一下IDEA的行间距（调整到0）。然后在控制台里面看到的是这样的：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/13/0.png)

很明显，有很多缺陷：

0. 太大了。
0. 白中黑不是很明显，应该是黑中白。
0. 我这个代码是“四个像素中，绘制左上角那个”，所以会有这种东西：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/13/1.png)

这个就是图片中窗口的标题。

现在我们改进一下

### 改进方案

首先，把这四个像素同时考虑进去，求平均值。

然后降低我们的标准RGB平均值，使最上面那些东西也能被完全显示出来。

改进后：

```kotlin
fun main(args: Array<String>) {
  val image = ImageIO.read(URL("https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/4/1.png"))
  (0..image.height - 1 step 2).forEach { y ->
    (0..image.width - 1 step 2).forEach { x ->
      val _1 = Color(image.getRGB(x, y))
      val _2 = Color(image.getRGB(x + 1, y))
      val _3 = Color(image.getRGB(x, y + 1))
      val _4 = Color(image.getRGB(x + 1, y + 1))
      val r = (_1.red + _2.red + _3.red + _4.red) / 4
      val g = (_1.green + _2.green + _3.green + _4.green) / 4
      val b = (_1.blue + _2.blue + _3.blue + _4.blue) / 4
      print(if ((r + g + b) / 3 <= 0x9f) '■' else '□')
    }
    println()
  }
}
```

现在标题栏看得清楚了：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/13/2.png)

实验结果证明这图不是很适合做这个实验，我中间换成了这个：

![](https://imgsa.baidu.com/baike/w%3D268/sign=9dca18bd593d26972ed30f5b6dfbb24f/d52a2834349b033b6693d9ad1dce36d3d539bda9.jpg)

彩色滑稽别有一番风味啊。

### 分析颜色分布

但是我们的目的是看图啊！这样的颜色分步有些诡异，我们需要先分析图片的颜色分布。

首先把它每个像素的颜色分步都输出一下：

```kotlin
fun main(args: Array<String>) {
  val image = ImageIO.read(URL("https://imgsa.baidu.com/baike/w%3D268/sign=9dca18bd593d2697" +
      "2ed30f5b6dfbb24f/d52a2834349b033b6693d9ad1dce36d3d539bda9.jpg"))
  (0..image.height - 1 step 2).forEach { y ->
    (0..image.width - 1 step 2).forEach { x ->
      val _1 = Color(image.getRGB(x, y))
      val _2 = Color(image.getRGB(x + 1, y))
      val _3 = Color(image.getRGB(x, y + 1))
      val _4 = Color(image.getRGB(x + 1, y + 1))
      val r = (_1.red + _2.red + _3.red + _4.red) / 4
      val g = (_1.green + _2.green + _3.green + _4.green) / 4
      val b = (_1.blue + _2.blue + _3.blue + _4.blue) / 4
      System.out.printf("%4d", (r + g + b) / 3)
    }
    println()
  }
}
```

我们得到这样的结果：

```
   0   0   0   0   0   0  50  97  90  90  94  49   0   0   0   0   0   0
   0   0   0  65  63  64 109 117 119 119 115 104  66  60  68   0   0   0
   0   0   0 107 106 104 104 123 123 122 122 108  94  97 109   0   0   0
   0   0  81 108 119 122 122 123 123 123 123 121 118 114  98  72   0   0
   0 132  58 165 248 242 190 153 122 122 108  53 188 255 221 185  89   0
   0 141 104 120 122 122 123 122 122 122 122 104 123 121 120 118 116   0
  28  94 108 111 112 122 123 122 123 123 122 123 114 104 102  99  88  21
  74  92 116 121 122 123 122 123 123 123 123 122 119 114 111 102  84  49
 111  94 117 123 123 123 123 123 123 122 122 121 118 114 108 102  84 110
 114  90 110 119 123 122 123 122 123 122 121 118 115 110 104  98  84 116
 110  84 109 101 122 122 122 122 121 120 118 114 110 108  91 100  79 100
  49  92 106  92 106 120 120 119 118 116 114 111 109  97  88 100  94  49
  21 103  82 108  84  87 114 117 115 113 111 107  82  83 108  78 107   0
   0  75  87  92 107 101  74  71  75  75  69  73 101 109  89  89  76   0
   0  21 105  79  86 100 107 110 109 110 112 111 104  85  81 103   0   0
   0   0  21 104  86  66  85  97  99 100  97  85  66  87  99  21   0   0
   0   0   0  21  75 109  87  66  61  61  66  88 109  77   0   0   0   0
   0   0   0   0   0  21  49 108 113 113 115  49   0   0   0   0   0   0
```

初步分析可知，眼睛部位的RGB值大约为250左右，面部是120左右，嘴巴是75左右，最外面是0.

再看看这张图，你会爱上它的：

![](https://imgsa.baidu.com/baike/w%3D268/sign=9dca18bd593d26972ed30f5b6dfbb24f/d52a2834349b033b6693d9ad1dce36d3d539bda9.jpg)

### 选择合适的字符

我们这里就随便选几个：

`8 7 .`

以及空格，分布代表眼睛、脸、嘴、最外面。

### 重新输出

先把行距调回来。

然后我们可以这样整：

```kotlin
fun main(args: Array<String>) {
  val image = ImageIO.read(URL("https://imgsa.baidu.com/baike/w%3D268/sign=9dca18bd593d2697" +
      "2ed30f5b6dfbb24f/d52a2834349b033b6693d9ad1dce36d3d539bda9.jpg"))
  (0..image.height - 1 step 2).forEach { y ->
    (0..image.width - 1 step 2).forEach { x ->
      val _1 = Color(image.getRGB(x, y))
      val _2 = Color(image.getRGB(x + 1, y))
      val _3 = Color(image.getRGB(x, y + 1))
      val _4 = Color(image.getRGB(x + 1, y + 1))
      val r = (_1.red + _2.red + _3.red + _4.red) / 4
      val g = (_1.green + _2.green + _3.green + _4.green) / 4
      val b = (_1.blue + _2.blue + _3.blue + _4.blue) / 4
      System.out.print(when ((r + g + b) / 3) {
        in 0..20 -> '0'
        in 21..95 -> '.'
        in 96..130 -> '8'
        else -> '8'
      })
      print(" ")
    }
    println()
  }
}

```

效果大概是这样的：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/13/3.png)

然后我们可以再改进一下，比如让它更密集，每次只取两个字符的值（上下），
然后再把四个字符改为

``` - * 0```

先看代码：

```kotlin
fun main(args: Array<String>) {
  val image = ImageIO.read(URL("https://imgsa.baidu.com/baike/w%3D268/sign=9dca18bd593d2697" +
      "2ed30f5b6dfbb24f/d52a2834349b033b6693d9ad1dce36d3d539bda9.jpg"))
  (0..image.height - 1 step 2).forEach { y ->
    (0..image.width - 1 step 1).forEach { x ->
      val _1 = Color(image.getRGB(x, y))
//      val _2 = Color(image.getRGB(x + 1, y))
      val _3 = Color(image.getRGB(x, y + 1))
//      val _4 = Color(image.getRGB(x + 1, y + 1))
      val r = (_1.red +   _3.red   ) / 2
      val g = (_1.green + _3.green ) / 2
      val b = (_1.blue +  _3.blue  ) / 2
      print(when ((r + g + b) / 3) {
        in 0..20 -> ' '
        in 21..95 -> '-'
        in 96..130 -> '*'
        else -> '0'
      })
    }
    println()
  }
}
```

效果就更好了：

```
            ---*----*---            
      ------************------      
      *****--**********--**--*      
    -************************---    
  *0---00000000******---*0000000*-  
  *0******************************  
 --*****************************--- 
-*-******************************-* 
-*-******************************-**
**-***************************-**-**
**-***-**********************-**--*-
 **-***--******************--***-** 
 -**-****--*************---***--**  
  -**--****--------------****--**-  
   --*----****************---**-    
     --**------*******-----**--     
       --****----------****-        
           ---********--            
```

是不是已经很有“滑稽”的范了？

我们再来进行C\+\+的Code Generation。

### 生成C\+\+代码

首先把代码写了：

```kotlin
fun main(args: Array<String>) {
  val image = ImageIO.read(URL("https://imgsa.baidu.com/baike/w%3D268/sign=9dca18bd593d2697" +
      "2ed30f5b6dfbb24f/d52a2834349b033b6693d9ad1dce36d3d539bda9.jpg"))
  println("""
#include <stdio.h>
int main(const int argc, const char *argv[]) {""")
  (0..image.height - 1 step 2).forEach { y ->
    print("\tputs(\"")
    (0..image.width - 1 step 1).forEach { x ->
      val _1 = Color(image.getRGB(x, y))
      val _3 = Color(image.getRGB(x, y + 1))
      val r = (_1.red +  _3.red  ) / 2
      val g = (_1.green +_3.green) / 2
      val b = (_1.blue + _3.blue ) / 2
      System.out.print(when ((r + g + b) / 3) {
        in 0..20 -> ' '
        in 21..95 -> '-'
        in 96..130 -> '*'
        else -> '0'
      })
    }
    println("\");")
  }
  println("}")
}
```

生成的代码：

```
#include <stdio.h>
int main(const int argc, const char *argv[]) {
  puts("            ---*----*---            ");
  puts("      ------************------      ");
  puts("      *****--**********--**--*      ");
  puts("    -************************---    ");
  puts("  *0---00000000******---*0000000*-  ");
  puts("  *0******************************  ");
  puts(" --*****************************--- ");
  puts("-*-******************************-* ");
  puts("-*-******************************-**");
  puts("**-***************************-**-**");
  puts("**-***-**********************-**--*-");
  puts(" **-***--******************--***-** ");
  puts(" -**-****--*************---***--**  ");
  puts("  -**--****--------------****--**-  ");
  puts("   --*----****************---**-    ");
  puts("     --**------*******-----**--     ");
  puts("       --****----------****-        ");
  puts("           ---********--            ");
}
```

运行之后我发现我做了一件不明智的事情。。。

我自己在运行的时候选择了中文的`-`符号输出，这个符号在很多字体里面是和中文字一样大的，
我在写博客的时候已经把前面所以的`-`换成了`-`，读者看到的是修订后的版本，照着弄就是了。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/13/4.png)

运行效果稳如狗。

## 接下来的玩法

我们可以换一下图片的URL，看看别的图片效果如何。

我这里试了好几个图片：

![](https://imgsa.baidu.com/baike/w%3D268/sign=4733e98d0b087bf47dec50efcad1575e/0b46f21fbe096b63ac82889605338744eaf8ac59.jpg)

这张图稍微大了点，我们可以看到这样的效果：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/13/5.png)

文本经过我裁去边角之后是这样的：

```
00000000000000000000000000000000000000000000*-----------*0000000000000000000000000000000000000----------*-*000000000000000000000000000
0000000000000000000000000000000000000000000000000000**----0000000000000000000000000000000000*----*000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000--*000000000000000000000000000000000--*000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000*-*000000000000000000000000000000000**0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000**---*0000000000000000000000000000000000000000000000*----*00000000000000000000000000000000000000
0000000000000000000000000000000000000-------000000000000000000000000000000000000000000000--------0000000000000000000000000000000000000
00000000000000000000000000000000000000-----00000000000000000000000000000000000000000000000------00000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000*00000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000*00000000000
0000000000000000000000000000*000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000*00000000000
0000000000000000000000000000*000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000*00000000000
00000000000000000000000000000*00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000-00000000000
00000000000000000000000000000*000*0000**00000000000000000000000000000000000000000000000000000000000000000000000*000000000**00000000000
000000000000000000000000000000*00000000***00000000000000000000000000000000000000000000000000000000000000000000*000000000*-000000000000
000000000000000000000000000000**00000000*-*000000000000000000000000000000000000000000000000000000000000000000**000000000--000000000000
00000000000000000000000000000000*00000000*--*00000000000000000000000000000000000000000000000000000000000000*-*000000000*-0000000000000
00000000000000000000000000000000**00000000*--*00000000000000000000000000000000000000000000000000000000000*-*0000000000*-00000000000000
00000000000000000000000000000000**0000000000*--**000000000000000000000000000000000000000000000000000000*--*000000*000-**00000000000000
0000000000000000000000000000000000000000000000*---*000000000000000000000000000000000000000000000000**---000000000000*-0000000000000000
00000000000000000000000000000000000**00000000000**----*00000000000000000000000000000000000000000**---*000000000000*-*00000000000000000
0000000000000000000000000000000000000*00000000000000*----***0000000000000000000000000000000***----*00000000000000*-*000000000000000000
0000000000000000000000000000000000000***0000000000000000*---------****0000000000000***--------*0000000000000000*--*0000000000000000000
0000000000000000000000**0000000000000000***000000000000000000***------------------------**000000000000000000**-**000000000000000000000
00000000000000000000*--*000--000000000000***00000000000000000000000000*********0*00000000000000000000000000*-**00000000000000000000000
00000000000000000000--*000--*000000000000000--*000000000000000000000000000000000000000000000000000000000*--**0000000000000000000000000
0000000000000000000* -0000*-000000000000000*---**00000000000000000000000000000000000000000000000000000*0* -000000000000000000000000000
0000000000000000000* -0000*-000000000000000--00000***0000000000000000000000000000000000000000000000000000--*00000000000000000000000000
00000000000000000000--0000--0000000000000--*0000000000*****00000000000000000000000000000000*******0000000---00000000000000000000000000
00000000000000000000--0000* -0000000000*--0000*0000000000000******00000000000000000000*******0000000000000--00000000000000000000000000
00000000000000000000- 00000- 00000000*--*000** -000000000000000000*******************0*0000000000000000000--00000000000000000000000000
000000000000000000000--0000- 000000*--*000*-----*0000000000000000000000000000000000000000000000000000000000 -0000000000000000000000000
000000000000000000000*--*000--000*-*0000--*0000-*0000000000000000000000000000000000000000000000000000000000--0000000000000000000000000
00000000000000000000000-*0000*0*--000*---000000--0000000000000000000000000000000000000000000000000000000000--*000000000000000000000000
000000000000000000000000000000--000---000000000-*00000000000000000000000000000000000000000000000000000000000--000000000000000000000000
000000000000000000000000000*--*00--*00000000000- 00000000000000000000000000000000000000000000000000000000000--000000000000000000000000
000000000*---------------- -*0-----------------  -------------------------------*******---------------------  ------------------------
0000000*--00000000000000- --- *0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000- -
00000*--000000000000000- ---000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000--*0
000*--000000000--000000--0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000---000
0*--000000000000-*000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000*--00000
--00000000000000*-00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000--*000000
000000000000000*--0**--0*--0000000000000000000-000******--000**--*00*-*00*000000000*--*****000000000*0000000000000000000000--*0000000-
000000000000000000000* -*0000000000000000000000000-***000-00000-000*--*-*0*00000000*-000000000000000 00000000000000000000*--0000000*--
000000000000000000000*-*000000000000000000000-*00--**--*---000--*0*-000--*--00--***0***** -000000000 0000000000000000000--*0000000--00
00000000000000000000000000000000000000000000000000**0****0*000*-*0*-***000*-00*-000000000-*000000000-*000000000000000*--*0000000*---00
0000000000000000000000000000000000000000000000-000-0*0*0--000*--0000**0****000*-**0***0*--*0000000000000000000000000---0000000*--- -00
000000000000000000000000000000000000000000000--000-*****--00*00*000*******-0000000000*0000*000000000*0000000000000*--00000000--000--00
000000000000000000000000000000000000000000000-0000*0000*--00000-000-***-0--00*-000-000-000-0000000000000000000000--*0000000---000* -00
000000000000000000000000000000000000000000000000000000000000000*000-****0**00*000000000000000000000000000000000- -0000000* -00000* -00
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000*--0000000*---000000- -00
```

停不下来，我们再看看笑哭的表情：

![](http://img.9553.com/upload/2014/1107/20141107042404877.png)

```
"000000000000000000000000000000000000000000000000000000000000000
"00  ---------------------00000000000000---------------------  0
"00  ----***********00000000000000000000000000***********----  0
"00  ----*******-00000000000000000000000000000000-*******----  0
"00  ----***--*000000000000000000000000000000000000*--***----  0
"00  ----*--*0000000000000000000000000000000000000000*--*----  0
"00  ---- *00000000000000000000000000000000000000000000* ----  0
"00  ----*0000000000000000000000000000000000000000000000*----  0
"00  ---*000000000000000000000000000000000000000000000000*---  0
"00  --*00000000000000000000000000000000000000000000000000*--  0
"00   *00000000*0000000000000000000000000000000000*00000000*   0
"00  -000000000000000000000000000000000000000000000000000000-  0
"00  *0000000000000*******00000000000000*******0000000000000*  0
"00  *000000000*--**0000**---00000000---**000***--*000000000*  0
"00  *000000000*0000000000000000000000000000000000**00000000*  0
"00  *000000000*00000000000000000000000000000000000000000000*  0
"00  *000000000*00000000000000000000000000000000000000000000*  0
"00  *000000000000000000**000000000000000**00000000000000000*- 0
"00 *00000000000000000000000000000000000000000000000000000000* 0
"00 *0000000000----**000000000000000000000000**00000000000000* 0
"00 -*000000000----------------------------*---*0000000000000*-0
"00  --000000000--------------------------*0000000000000000000*0
"00 *    -00000000------------------------*0000000000000000000*0
"00       -*00000000*--------------------*0000000000000000000**0
"00         -000000000**--**************--0000000000000000000**0
"00  ----    --*00000000000****----****0000000000000000000000* 0
"00  -----      -*0000000000000000000000000000000000000000000* 0
"00  --------      --*0000000000000000000000*-*0000000000000*- 0
"00  -----------       ----**00000000**----   --*0000000000*   0
"00      ---------                               --*0000*--    0
"00                                             --   --        0
```

还有这个

![](http://img.9553.com/upload/2014/1107/20141107042428254.png)

```
00       --0000-                              --000000-       0
00      -00000000-0000000000000000000000000000000000000-      0
00      0000000000000*00*00000000000000*0000000000000000      0
00      *0000000000000000000000000000000000000000000000*      0
00      *0000000000000000000000000000000000000000000000*      0
00      *0000000000000000000000000000000000000000000000*      0
00      *0000000000000000000000000000000000000000000000*      0
00       *000000000000000000000000000000000000000000000*      0
00  ----*0000000000000000000000000000000000000000000000*-     0
00  ---*0000000000000000000000000000000******00000000000*-    0
00  --*00000*0000---*00000000000000*000000000----*0000000*-   0
00   *0000-0000*--00--*0000000000*0000000--**------0000000*   0
00  -0000-0000---------0000000000-000000-----------00000000-  0
00  *0000-0000-----*---0000000000*-000000---------000000000*  0
00  *00000**000*------0000000000000***0000*----*00000000000*  0
00  *00000000**---**000000000000000000000000000000000000000*  0
00  *00000000000000**---***00000000000000000000000000000000*  0
00  *00000000000-------000000000000000-----0000000000000000*  0
00  *000000000*---------**00000000000*-------*0000000000000*  0
00  -*00000000--------------------------------*00000000000*-  0
00   *00000000---------------------------------00000000000*   0
00    *0000000---------------------------------0000000000*    0
00    -*0000000--------------------------------000000000*-    0
00      *000000*------------------------------000000000*      0
00       -*000000-------******----*****------00000000*-       0
00        --000000*----********--*******----0000000*--        0
00          --*00000*---------------------0000000*--          0
00             -*0000000*-------------*00000000*-             0
00                --*00000000*****000000000*--                0
00                    ----**00000000**----       -            0
00                                             ---            0
00                                                            0
```

差不多了，你们开心就好。