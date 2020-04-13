---
layout: post
title: PingCAP 面试
description: PingCAP interview
permalink: /interview/pingcap-tikv.html
---

这曾经是一篇知乎回答，现在转载到我自己的博客里。

大概几个月前面了 PingCAP，现在入职了，想谈点面试的时候发生的事情。
之所以要说这个，是因为在面试的时候面试官教了我很多东西。。

## 大致过程

首先，和源伞（我上家）一样，在入职很久以前我就和公司的人建立了联系，并表明了实习意向。考虑到地理位置比较远（那时我在成都）而且我工作肯定是 remote 形式的，面试也就安排成了远程面试。在准备面试的时候我没有进行任何复习，因为懒，而且我不擅长数据结构与算法，也不是特别感兴趣。 HR 在微信上给我出了两个题，第二个题目居然是让我去 TiKV/pd/TiDB 之类的项目里找 1-2 个 issue 去修了……这个面试题我觉得十分有创意，简直是神操作，以后要是我招人我也这么出题（当然，公司肯定要有开源项目）。
这个面试题给我留下了十分好的印象，但是在完成到一半的时候，我突然多了去北京的安排（就是[这个 conf 啦](http://juliacn.com/meetups/)），于是就改成了直接去公司面试（有很多分部，北京只是之一，最主要的）。这是一个小插曲。

然后我就去面试啦。一共走了四道面试，一下午走完，和 zzj、虎哥、lfkdsk 他们那种大公司不一样。

## 流程

首先是HR面，内容基本上就是通知我一些制度和安排上的事情，以及让我问HR一些问题。不过我已经记不得问了什么了。然后是两道技术面。

### 现场面

第一道是一个 Lisp 原教旨主义者，开源酱那类人。
他一上来就问我是不是知乎上那个『大笨蛋千里冰封』，把我吓出一声冷汗（因为我还在用这个 id 的时候写的东西现在看基本上都是黑历史了，他知道这个 id 的话可能会对我有些成见，所以我十分害怕）。
我强作淡定地承认，实则慌得一匹。然后他问了我一些简历上的东西，我就该咋说咋说。
他说我是 Haskell 教派的人，他是 Lisp 教派的人，然后跟我说 Lisp 怎么怎么好，这让我越来越慌了（我没有宗教信仰的）。
然后他让我写一个 CPS 变换的阶乘函数，不熟悉就算了，我就说不熟悉（事后还被魔理沙吐槽了，泪奔啊）。当时我开始觉得我在作死了。然后他又让我写一个类似 proof search 的东西（很简单的，都不需要你自己去检查 induction 和 termination 什么的），相当于是有一堆 postulate 的命题和函数然后列所有的可证明的命题。因为我事先猜测，面试嘛，不就是人生观价值观，八百年老前端，数据结构与算法，开源项目与简历吗。所以我这个时候思维就特别 OI，就想着『不就是一个判有向无环图联通性的dfs题吗，连最短路都不需要，这有什么难的（狗头）』，抱着面试官递给我的 Spacemacs 写了一个 dfs。
写到一半的时候面试官问我，**你没发现这就是一个 fixed point 吗。**此时我脑子浮现出一句『你个辣鸡，思维怎么这么死板』。居然没有把自己在 OI 和 Haskell 里学到的东西联系起来的能力，我真是太挫了.jpg（所以其实就是写一个遍历+单步推导过程然后把它不断求值直到不动点就可以了。这是我的理解，因为面试官没有说下去）。
这个时候我的心态已经有些紧张了。后来 HR 给我看了他基佬网帐号，居然有个 Go 实现的神语言，流石硬核 Lisp 玩家，比我之前在网上看到的那些 Racket 都不知道的 Scheme 吹不知道高到哪里去了.jpg（狗头）。后来了解了他的履历，对这个人发自内心的佩服。

第二道是两个电脑上贴着 Rust 贴纸的面试官一起面试我，在气势上就已经完全把我打倒了，因为之前那个人笑眯眯的，这两个人都没笑（可能是我自己的原因，毕竟我没什么面试经验）。这道面试内容比较硬核，是纯算法和数据结构的。我记得的部分只有数据库相关的几个数据结构的问题了。涉及到的数据结构有 B 和 B+ 树 (查询的复杂度是 `log(m)`，问这个 `m` 是啥)，以及 Hashtable。
虽然我没学过 B/B+ 树，但我脸皮还是比较厚，不会就说不会（每说一次不会我就变得更紧张。。而且特不好意思，感觉自己就是个不谙世事的小毛孩子（似乎确实是（捂脸）））。面试官遇到我不会的就现场教我（真・现学现卖.jpg），然后我都回答了，根据面试官的表情和回家百度的结果应该是对的。最后问了一个算法设计的问题，就是给了我有限的内存和很多数据，让我实现一个算法实现找出一部分数据满足 xxx 条件的功能。最后我只写出来了最优解的前面一半(利用 hash 的性质给数据分类，然后复杂度就变得很小了)，向面试官问了最优解，被自己蠢哭。

### 电话面

然后就是一次电话面，把我的个人项目问了一半，问了实现细节，问了 Rust 和 JVM 的 ffi，Kotlin 和 C++ 的 ffi，和我去年写的辣鸡项目（捂脸*2）。总的来说除了 IDE 之外基本上还是把我想让面试官知道的都让他们知道了，也给了我提问的机会。

以及我现在都不知道那两个考我算法的人是谁（后来知道了，是我的 Mentor 和另一个同组的人。Mentor 很可爱，pair 的时候编译不了项目就直接换服务器 www）。。

综上所述，我司（似乎应该叫贵司）在招人上是很有诚意的。以及之前崔老板问我对招聘流程有什么看法，当时我回答的含含糊糊，现在这算是一个正经的回答吧。如果有什么触犯了机密的地方，或者其实不是机密但是我没说的地方，可以在评论区告知。

似乎我没有遇到最恐怖的面试官，难度最高的那个人会在面试前先请你喝格瓦斯。

## 最后

有静态分析方向兴趣的同学可以联系我，我可以内推源伞（有零食和内部技术讲座，比较硬核。你还能看到 Eclipse 写 C++，Emacs 写 Java 等奇观）。有数据库/分布式/Rust 方向兴趣的同学也可以联系我，你进 PingCAP 我请你吃饭。

+ 我司官网： [https://www.pingcap.com](https://www.pingcap.com)
+ 源伞官网： [https://www.sourcebrella.com](https://www.sourcebrella.com)
