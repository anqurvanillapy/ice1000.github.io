---
layout: summary
title: 2019 年
permalink: /pages/2019-summary.html
---

如果 2018 年我的关键词是【理想】的话，那么 2019 年的关键词就是【现实】。
我仍然是一个理想主义者——我依然认为我会不断追随我认为正确的方向，对这件事我充满热情。
但是我却开始面临越来越多的现实问题，比如我自身实力的局限性，以及我周遭环境对我的影响，
这些是我不想面对但不得不面对的问题。

不过只考虑这一年的经历与心态上的变化的话，我想应该是【新生】。
我希望本文可以尽可能中性地讨论我在 2019 年的经历，但我实在不太擅长遣词造句，
所以实际写出来的文字在这方面可能无法直接达到我想要的效果，只能提前显式声明我的态度。

这一年，我开始蓄发，并在年底达到了可以扎出和我手一样长的马尾辫的长度。
形象上我与之前完全不同了，也是一件有趣的改变。
本文写作时间跨度接近半个月，可能语言较为零碎，不利于带着逻辑思维阅读。
本文看似叙事，实则作者一年来的情绪宣泄。
有诗为证：

> 满纸荒唐言，一把辛酸泪。<br/>
> 都云作者痴，谁解其中味。

## 超社会

在讲人生之前，先讲讲技术。

全世界的编程爱好者们有一个共同的社区，那就是开源世界——一个人们以代码与项目会友的世界，
就像古代文人墨客相聚的诗会一样。
自从 2016 年在 QQ 群被问了一句 "你 GitHub 多少" 后，我在开源世界厮混已达 3 年之久。
期间，我向世界输出了自己创造的价值（imgui 的 Java binding 等），
也不断向这个世界索取知识（学习 intellij-community 的代码等），
但最多的还是参与世界的建设，也就是开源贡献。

去年我因为给 Agda 编译器的 HTML 后端做了一些比较有趣的改进（是一个我自己想要的功能，
在 issues 里面挂了一段时间没人理后我就自己去做了）后，
这个功能开始被大幅使用，比如爱丁堡大学的
[Types and Semantics of Programming Languages][tspl]
这门课使用的在线教材 PLFA（由任课老师 Phil Wadler 和助教小姐姐 Wen Kokke 合著，
并且有我重要的朋友 Oling Cat 主导， Fangyi Zhou 参与翻译的中文版）的网页版，
还有一些奇怪的个人博客（比如 [James Wood 的][jwood]，和 [Jesper Cockx 的][jcockx]）
都是由我改进过的这个后端生成的。

 [tspl]: https://www.inf.ed.ac.uk/teaching/courses/tspl
 [jwood]: https://personal.cis.strath.ac.uk/james.wood.100/blog/html/VecMat.html
 [jcockx]: https://jesper.sikanda.be/posts/literate-agda.html

在这之后我开始参与越来越多的项目，比如 IntelliJ-Rust 和 Rust-Analyzer
（这里还要感谢草酸小姐姐，私底下指导我了解这个项目的结构，哈哈）
这两个 Rust IDE 插件里面都有我的代码。
我也进一步参与了 Agda 的开发——我开始仔细研究 Agda 对 pattern matching 的处理，
以及我还改进了 Agda 的 JSON interaction（用于我的另一个[玩具项目][toy]）
（所以其实我并没有做很多技术难度非常大的事情，只是和 Belleve
一样在技术难度极高的项目里写一些庸俗的代码）。
这些经历给我带来了一个人闭门造车所不能带来的关于大型代码的组织的经验，
以及快速上手一个陌生且规模不小的项目的经验，让我受益很多；
同时也让我充分练习了相关的编程语言，比如 Rust 和 Haskell。
在看到自己做的东西给别人带来了实际的帮助后，我自己也很快乐，这是我重要的快乐之源。

 [toy]: /2019/11-13-AgdaTac.html

### 黑 Haskell

现在我跟 Haskell 算是有不共戴天之仇（工具链太难用了），但我却越来越喜欢 Rust。
我在短暂的编程生涯中学到一件事，那就是一个编程语言越是想在语言本身和工具链与社区中两全其美，
就越会发现两边都做不好，典型的反面教材就是 Haskell。
Rust 作为一个有 trait 和泛型的编程语言，连 first-class 的 HKT 都没有，
可以算是牺牲了语言本身的强大，但是却换来了优质的社区，
同时开发团队也能更加重视对这个简单的语言模型的淬炼，打造出更称手的兵器。
而 Haskell 因为 effect 这种大量使用的功能是用纯函数式的模型模拟出来的，
导致编译和优化都变得比较麻烦，开发团队估计是为了省力，直接在 Windows 版本上包含了一个完整的 msys2
（而不是像 Rust 一样支持多个后端，然后用户可以做选择），
给了广大没有软件工程意识的学术界程序员乱搞的空间。一个典型的例子就是鼓励使用 msys2 的 pacman
来安装一些本该由 Haskell 包管理工具自己管理的第三方库，
然后语言本身由于隐藏过多编译时的细节导致对静态链接极度不友好，想发布一个二进制包给没有 Haskell
工具链的人使用变成了一件困难且奢侈的事情。

再者，目前最流行的 Haskell 编译器，GHC，有一个毒瘤一般的语言扩展，叫做 `CPP`，
这个扩展可以让程序员在 Haskell 代码里面使用 C 语言的宏。
由于 GHC 本身和 C 语言宏预处理器的对接不理想，导致大量的 Haskell 源码分析工具在分析使用了 CPP
的 Haskell 代码时变得几乎不可用。
Haskell 语言本身的词法规则和 C 语言的不同也导致了一个严重的问题，
就是在当一行代码包含了带单引号的标识符时，C 语言宏预处理器会认为这行代码存在词法错误
（不完整的字符字面量），然后不展开这行的宏。
这个问题不会被 GHC 识别，会造成极度迷惑的编译报错。
而在我刚开始参与 Agda 编译器的开发时，Agda 编译器使用了 C 语言宏中的 `__FILE__` 和 `__LINE__`
这两个宏用来获取代码的位置（这样在输出的错误信息里就有行号了），
导致大部分代码文件都使用了 `CPP` 这个扩展，开发起来非常难受，给我造成了不可磨灭的负面印象。

而 Haskell 的类型系统本身也很弱，对 Pi-type 的支持仅限于用 type family 语法写函数，
构造器的参数不能带 telescope（不过我在 Twitter 上看到他们好像在做了，静待好消息吧）
把它 dependent-type 编程的能力极大地限制了。
它作为一个使用 effect 的编程语言，只有 do notation，没有 idiom bracket，
在非 dependent type 编程时，体验也被 Idris 和 Agda 吊着打。
论 effect 本身，不论再怎么使用设计模式抽象 effect（Algebraic Effects，
Extensible Effect，mtl 等），也没法和其他在语言层面支持 effect 的半纯函数式编程语言相提并论，
比如内置 Dijkstra Monad 的 F\* 和支持 row polymorphism 的 Koka。
它的 typeclass 在支持 overlapping instance 的情况下却不支持 named instance，
在极端无奈的情况下只能选择开启 incoherent instance，彻底放弃精确选择 instance 的机会，
令人失望。唯一的好处，可能就是 GHCi 了。

至于为什么我现在开始喜欢 Rust 了，不仅因为我有很多朋友在使用它，
也是因为我今年上半年在一家北京的数据库公司 PingCAP 的 TiKV 组实习。
Rust 团队有两名前成员现在就在这家公司任职，他们给我留下了很深的印象
（在硅谷分舵见到了 Brian，然后我自己做的最累的一个任务是和 Nick 一起完成的），
我（似乎）也给他们留下了很深的印象，可能是因为我的年龄实在太小了
（Brian 看到我说以为我是正式员工而不是实习生，因为到处都能看到我，哈哈），
不过我也不是 PingCAP 唯一的 00 后（后面再讲实习的事）。
不过这些都是次要因素，主要还是 Rust 的工具链太棒了，
而且还有能单步运行和查看环境的调试工具，有中心化的包管理
（这点 Java 也做的不错，Haskell 只是比 C++ 好），令人满意。
这才是真正的大道至简啊！一个什么功能都不支持的编程语言是不能被冠以大道至简之名的。

（一件趣事：上面这段文章被我剪辑了发到知乎，引起了祖与占大佬的评论）

### 摸鱼

前半年在事业上比较摸鱼，当时在折腾一个 IntelliJ 插件，专门支持各种小众语言，
然后我为了简化开发流程，整了各种代码生成，最后基本上半个插件的代码都是生成的了。
在这个过程中顺便研究明白了 IntelliJ platform 的 "stub index" 这一概念是怎么运作的，
弥补了之前开发 Julia IntelliJ 时留下的遗憾。可惜我现在还是没有时间去继续维护那个插件。
现在我真的太忙了，有些老坑实在填不过来了。
不过还好的是我之前的习惯还是比较好的，挖的坑基本上都填了，没填的也是直接弃了，
没有给我造成过载的现象（同一时间坑过多）。

## 事业

今年在事业上还算顺利，结束了 PingCAP 为期一年的实习，
顺利完成了学校的 REU（还顺便跟学校里做 security 和 error message 的老师 Danfeng 混了个脸熟，
在 UW PLSE 的时候发现冯煜和张震等巨佬和我那边的老师是互相认识的，
可见我所在的学术圈子已经小到了什么程度w）项目，
做的是在 dependent type 里面的 row polymorphism，没有用 qualified type
而是用 kind 做的 constraint，给 row types 定义了一套 abstract syntax 和 core language，
给了 operational semantics 并证明了 reduction 的 soundness。
由于本人 TCS 和数理逻辑水平实在有限，不太懂 normalization 和 consistency 要怎么证明
（我知道 strong-normalization implies consistency，但是我不会证 normalization 啊！），
也不会写 termination checker，给这个项目留下了一些发展空间（所谓遗憾）。

期间为了在主校区蹭住一个周末，给另外一个参加 REU 的同学辅导了一下编程，
对方的水平实在是一言难尽，而且还没有任何学术上的上进心。
我也能理解就是了，毕竟世界上就是有人以混吃等死为目的生活的，薅学校羊毛脸不红心不跳，
什么都不会也能心安理得地把网上的代码和项目介绍抄下来做成论文，然后还拿奖学金。
这次经历也让我对当今人工智能行业的本科生的开始产生厌恶，只能控制自己在和他们接触时不去往学术方面想，
这样实践下来我还是能和他们相处的。
当然，这也仅限水平 "一言难尽" 的那部分人。今年下半年认识了一个住我隔壁宿舍楼的学长，特别好玩，
就是一个从事 CV 行业的也是很喜欢混的人，但是却没有之前我在 REU 时见到的人那么菜，
而且还有心思练习自己的编程技术，这种人我还是比较欣赏的。

比较好笑的是，REU 见到的那个同学选了一个 GitHub 上的项目来抄，
但是他选的项目代码不全、需要手动从别的仓库找剩下的代码不说，demo 也跑不通，文档也没说清楚环境，
总而言之就是一个典型的 "后现代人工智能项目"，倒是和那个同学很配。
我问他为什么选这个项目抄，因为我帮他搭建了半天环境，搞定了一大堆比如 git 和 conda
之类的他都不知道是啥的东西，我觉得这对他来说完全是不必要的麻烦，毕竟要抄你选个靠谱点的抄嘛，
人干啥和自己过不去。他说这个项目代码少，文档短，看起来就很简单，谁知道运行起来这么麻烦呢。
我当时差点把可乐喷到他键盘上。

### REU 趣闻

在参加 REU 的项目的时候，因为当时觉得实现一个 Proof Assistant 有比较重的编码工作，
就想找个队友来和我一起写代码和论文，这样既能让我不必走向一些因为当局者迷导致的误区，
也能拓宽未来潜在的人脉。我先找了初三认识的一个美高党（一段时间没联系了，现在他就在我附近的州上大学），
后来我嫌他太菜就放弃了这个人选，随后在很多 QQ 微信群发布了 "寻队友" 的广告。
此时一位来自 Coq 群的华中师范大学研究生响应了号召，我给他了一个小考验（给我当时正在写的
一个 Mini-TT 的 Rust 实现添加 universe level 支持），给出了充分的 context，
然后他在一个周末顺利完成，于是事情就这么成了，我们变成了朋友和队友（下称队友）。

我在那段时间建了一个 QQ 群，拉了一些在我看来对 dependent type 有真正兴趣，以及有一定技术力的人
（但实际上也只有一小部分人有……呃，很遗憾），每周举行线上聚会。我带头讲了一次 dependent type
的基本组成和 bidirectional typechecking 的思路，期间有幸听到 molikto 同学分享的
inductive type（大概说了下 positivity 是怎么回事，然后提出了 induction recursion 的概念），
增长了一些奇奇怪怪的知识，非常开心。我在组里和大家讨论了一下我准备用于 REU 的那个 idea，
还得感谢那时草酸、队友和 hex 给我的一些建议和纠正。
后来写到一半时查资料发现 POPL 2018 就有一篇 Monoidal 版本的 row-polymorphism，
给我带来了很大的压力（很有料，不得不服），不过还好和我的 idea 不冲突。

写的过程中我参考了很多相关从业人员的意见（主要是 UWPLSE 的人，他们都很 nice），
总结下来就是 "想法不错，但是你写的太简单了"。我想想觉得十分有道理，但是我也不想再修改 topic 了，
于是就转而想找个规模比较小的会议发表（而不是四大）。
但是我又只知道四大和 JFP 这种欧洲基本上相当于四大的会议，所以我就把 "寻找一个合适的会议"
这个任务交给了队友，因为他当时在苏黎世联邦理工当交换生，然后他有一个很厉害的老板——
姜还是老的辣，老板一定能给出更好的建议。队友是他的组员，所以他也有义务帮忙。
他找了老板后，老板回答了问题，不过奇怪的是老板竟然对我这个人本身产生了兴趣。
先说会议，现在已经投了然后被拒啦。审稿人都非常认真，给出的意见基本上都是我自己也认可的文章不足之处，
不过我要是解决这些问题（基本上等于重写一大半，所以当时没有这么做）的话就会投顶会了，
所以这个结局算是一个 true end（而不是 happy end）。
这同时也体现出 PL 学术界非常健康，和某些已经被钱熏坏，彻底内卷的行业截然不同，保持着认真做学术的态度，
让我对未来的发展除了钱之外都充满期待（至少这是健康的圈子）。

老板对我产生了兴趣是因为他似乎阅读了我在 GitHub 上开源的简历和博客，
了解到我曾经和 IDE 有关的奇妙经验（所以积累这种奇特的技术栈似乎真的能在一些非常奇怪的场合发挥作用，
这是我在最初研究 IDE 技术时远远没有想到的，当初只是兴趣使然），
正好他也有一些关于新型智能 IDE 的想法，就想让我去他的组里实习。他还使用 "she" 称呼我，
原因应该是我 GitHub 头像是我长发的照片（以为我是跨性别者），充分体现了对我的尊重。
不过无论如何，被别人认可实力这件事都让我非常爽，
这直接消除了我那段时间突如其来的非常严重的抑郁（后面再讲），让我整个人重新回到了正常的精神状态。
老板给出了两个选项，首先是成为他组里的实习生，其次是参加苏黎世联邦理工的学生暑研计划，
两者可以同时进行（意味着两份工资），并保证提供签证方面的帮助。
但是前者可以由老师钦点，后者只能自己向学校申请。申请条件里面写着请勿直接联系相关老师，
但我情况特殊（我是被相关老师联系的），老师也鼓励我把我们联系过的事情写进申请。
申请材料包含了很多内容，其中就有成绩单，生成一份 PDF 版本的成绩单还花了我 10 🔪，简直抢钱。
比较糟糕的是我的成绩一贯很差，老师说这个申请也很 competitive，所以就祝我武运昌隆吧。

申请这个玩意儿花费了我差不多一周的时间，各种和学校行政部门打交道，累死个人，
不过也让我那段时间过的很充实，防止抑郁，所以某种意义上反而是很好的。
忙起来，就会有种幸福感，觉得自己实实在在地活着。

### PingCAP

从去年暑假结束到今年暑假结束，我都在一家叫 PingCAP 的数据库公司实习，公司业务几乎是纯 2B，
就只做一个产品——TiDB，及其周边设施。客户有很多国内的中型公司，比如知乎美团等。
总部位于北京，我去过北京和成都分舵，去北京是面试（其实当时是去参加一次 [Julia 的 Conf][Julia]，
讲解一下我做的 IDE 插件，顺便去面试），成都是去年年底在那边全职工作了一段时间。
这对我来说是宝贵的经历，我见证了一个开源导向的商业公司的生存方式——这是做两三年开源世界混子也无法看到的。
我不知道这些经验什么时候可以派上用场，但是我很重视这些经验，
我不能排除以后自己也走上技术创业道路的可能性。
同时我还学到了很多分布式存储的知识，在公司的 mentor 也很 nice，我很喜欢他。

有一个比较遗憾的地方就是没能参与比较核心的功能的开发，我捯饬的基本上都是比较小的组件，
比如那个 grpc 的 binding（之前都不知道 grpc 是啥……这次学习了一下，rpc 框架的想法还是很不错的），
还有改进了一下某个访问进程信息的库，然后迁移了 TiKV 整套生态用的 protobuf 库。
之前用的那个是一个很奇怪的人写的（Rust 社区有很多人不喜欢他，但是他 GitHub 上 star 特别多），
风格很 C++，生成的代码奇丑无比，每次生成的代码不一样，还搞得编译耗时很长，非常垃圾。
内部 profile 发现这个库上耗时比较长，于是大家决定换个库用。
换的新的是一个生成的代码比较简短的库，结构感觉比较适合 Rust 那种 move 的设计，干净得多。
换了库之后并没有带来可观的性能改进（nrc 还给上游提交了一些改进），是另一个遗憾。
但是开发这些东西依然是很有挑战性的，比如改进 rpc 框架是需要搭建集群测试的，
然后如果我写出 bug 了我就得调试这个集群，which 在我看来是调试难度远高于并发程序的。

公司里的海外成员构成一个单独的组，和我一起做项目的 nrc 很有意思，另外两位和我接触相对较多的 brson
（在硅谷分舵见到 brson 本人啦！他表示对我的年轻很羡慕，哈哈，被这种级别的大佬羡慕也是一种别样的感受。
我向他表达了我的敬仰，毕竟他是那种级别的大佬啊，哈哈）和飘飘熊也都很有意思，我也很喜欢他们。
公司里还有一位来自 Haskell 社区的人物 Greg（在 Haskell 相关的 issue tracker 里面见过的那种），
曾经是做 Cloud 的，现在也做 Cloud，不过在 PingCAP 做 Cloud 那肯定是写 Go 了。
他向我吐槽 Rust 的增量编译速度，比起 ghci 里就能更新的 Haskell 来说很残念。
我本来应该跟他说这是允许模块互递归的 tradeoff，但是当时太紧张语次无伦了，没有表达清楚意思，很遗憾。
我问了他写 Go 什么感受，他的回答耐人寻味：

> You'll have to get used to it.

 [Julia]: https://cn.julialang.org/meetups

暑假结束后谈了离职（实习签约签了一年，暑假结束的时候就到期了），HR 姐姐向我提了很多问题，
比如对公司有没有什么不满意的地方，还打算继续实习吗，etc.。
我在回答不满意的地方的时候，基本上是把公司夸了一番（毕竟我确实很喜欢这个地方），
然后指出 TiKV 组成员加班过于严重，有些令人担忧（看他们 debug 刷夜还是很心疼的）。
HR 姐姐指出 TiKV 在 CNCF 里算是个有头有脸的萌新，大家要在这个关头努力给整个业界留下好印象、
开个好头，所以忙是肯定的，也是暂时的。
我也认可了这个说法（毕竟今后我也是参与过 CNCF 旗下项目的人了）。
后来的打算就是因为我要混学术界了，所以我要找学术方面的实习（而不是 PingCAP 这种工业界公司），
所以就暂时地再见吧，以后有缘再会，PingCAP 也是我今后找工作的一个很有力的 candidate。
于是这件事就这么告一段落了，人生中的一个章节就这么结束了（很有仪式感）。

暑假到离职期间，我的生产力急剧下降，原因应该是我本来在学校的计算机实验室（电脑很好）
里搭建了完整的 TiKV 开发环境（可远远不止一套 Rust 工具链那么简单）的，但是我中途去美国旅游了，
笔记本上维护这种中型项目感觉还是很残念的，导致那段时间几乎没什么产出。以后要尽量避免这种问题。
离职前问了问 mentor 对我的看法，他表示产出不是实习生里面最好的，但感觉我是实习生里面很厉害的，
还是让我有点小激动。离职的时候 HR 姐姐跟我说我在网上知名度很高，有很多实习生都说认识我。
我当时就有点纳闷，为什么他们不在内部 IM 找我聊天呢，我都一直不知道有人认识我。
不过总的来说知道这些还是很开心的，哈哈。

### Arend

从 PingCAP 离职时，我看上了另一个做 dependent type 和 HoTT 的小组，很想去他们那里实习。
他们组规模看起来非常小（个位数），人员都是圣彼得堡的几个大学的 postdoc 或者教授
（SPbAU 和 SPbU），可能也有别名为本科生的免费劳动力，不过那都是附属的，不重要。
更重要的是，这个研究小组所属的公司，正是我从高二开始就一直铁粉的 JetBrains。
我从 PingCAP 离职后就开始联系他们，结果正好碰上他们放假，
神秘的 supervisor 又忙到总是不回消息，所以就断断续续拖到年底，也就是最近。
他们在开发一个叫 Arend 的编程语言及其 IntelliJ 插件，其中编译器基本上只有一个人在贡献代码。
那个人就是和我主要联络的人，也是后来面试我的人（下称面试官）。

这个编程语言有点东西。它参考了现有的 Proof Assistant 里的 HoTT 实现，
总结了其中的缺陷（比如 HIT 需要 `Axiom`），设计了新的语言特性（比如 `Condition`）
来支持这些功能，并做了一个类似 Cubical model 的 Path type 和 Interval type，
这样就免费得到了函数的外延性、`ap` 等结论。
Arend 还有一个 `Path` 上的 `coe` 运算，面试官说这可以看作是 Interval 的 eliminator，
然后与 Cubical model 不同的是，这个 Interval 也是可以被 `coe` 的，
这样就可以用 `coe` 构造 `hcomp` 的 filler，从而在不引入 computation complication
的情况下支持原本 Cubical 支持的东西。然后 Arend 的 univalence 是硬编码的 primitive，
这可以视为是对模型的简化，也可以视为模型过于简陋的缺陷，总之仁者见仁智者见智。

期末的时候基本上时间都花在这上面了，因为这不仅牵扯到 JetBrains 单方面的面试，
还涉及 CPT（像我这样在美国上学的国际学生参与工作是需要专门的许可的）和 SSN
（这是拿工资所需要的号码，应该类似于国内的身份证号），所以我需要把这些全部申请到。
实习还可以算学分，所以我还需要 enroll 一门叫做 internship 的课程（学分不要白不要），
所以又要和计算机学院的行政部门打交道。不过这些人都还算很好说话，轻松搞定啦。
现在就差 JetBrains 的一纸 offer 来给我申请 SSN 了。
我现在基本上也体验到了非美国人在美国生活的种种不便之处了，开始了我的受难记，
希望命运能一直站在我这边，成为我的伙伴，和我一起打开人生新的篇章。
JetBrains 的 HR 看起来也很好说话，面试官也很有趣，希望今后的实习可以顺利进行下去。

在西五区，纽约时间 17, Dec 2019 下午 5 点，我收到了来自 JetBrains 的 HR 的邮件，
对我说 "Welcome to JetBrains Inc."。
我终于实现了高二时一直想做的事情！以后我就可以用 "我司" 来称呼 JetBrains 了，
想想就令人很激动。知乎用户 vczh 在高中时期就是软粉，[大三时开始在微软实习][vczh-ms]，
带着无数奇妙的个人项目通过了面试（本来当事人理论上大二就能去，但是他当时年龄太小了老师放弃了），
加入了自己热爱的企业。同样的事情我也做到了，我很开心！

 [vczh-ms]: http://www.cppblog.com/vczh/archive/2011/12/16/162252.html

## 不愉快的事

今年上半年精神状态比较好，过的十分坚强，也可能是因为当时有很多朋友在我诉苦的时候安慰我，谢谢他们。
暑假过程中经历了一件非常不愉快的事情，但我不想写在这篇文章里，总之这件事对我的打击几乎是毁灭性的，
但是当时我借助社交网络一定程度上缓解了情绪，勉强撑了下来。
暑假结束后有一段崩溃期，可能是因为从繁忙中突然闲下来导致的，也可能是之前的经历累计导致的；
可能的触发因素除了突如其来的轻松还有在 REU 时期的种种经历（比如遇到的那个同学），
以及突如其来的青春期侯症群，总而言之这是一段在现在看来非常危险的时期。

### 穷 & 酸

作为一个家里没矿的中产阶级出国党，我对那些过着桃色校园生活的同学是充满了嫉妒与不甘的。
这常常给我带来严重的低落情绪，也可能是暑假情绪低落的触发因素。
但我又深知家庭条件这种先天因素并不是因为我做错了什么导致的——这是命运的安排，和性别一样
（而且说白了我其实就是大部分人的情况，而且我相对来说已经很优渥了），
所以也没有办法说服自己坦然接受，毕竟道理是假大空的，而痛苦却是实实在在的。
这其中也有我自己的原因，比如我根本就没有向父母表达过要大规模花钱的想法（除了暑假到处跑报销机票），
他们自然也就没有必要给我很多钱（我也根本用不到），买车之类的事情在我看来距离都太遥远了。

对比我和大部分同学的生活状况，总是能产生很有戏剧性的效果的。
我一直忙着找实习，套磁，追每年的顶会论文；我的同学忙着谈恋爱，约炮，刷抖音探探 Tinder，
"我们都有光明的未来"（也许这就是穷人的悲哀，天生就有一种危机感，和富家子弟的思维方式有根本上的不同）。
有的时候这真的会给我带来很强烈的嫉妒心，毕竟我要做奋斗逼，我要坚守原则，
但是别人不需要像我这么努力一样可以过上快乐的生活，还能底气十足地说出 "天下论文一大抄" 这种话
（这和去年的一次自主招生造假事件有关，关键词 `苏小妹` `郑州一中` `自主招生` 以及两位曝光者网名 `荒城半秋` 和
`邹禹同`。互联网这把双刃剑的核心威力之一就在于它去中心化的记忆，这一事件应该会在被网民遗忘后永远的保留下来），
不患寡而患不均，这种不平衡带来的痛苦可以让我彻夜难眠，
况且我连一个倾诉对象都没有，我身边的人肯定不会认可这种阴暗又负面的想法的，
绿眼的怪物从存在的那一刻起就是光明的驱逐对象。

天网恢恢，有的时候也会有一些浑水摸鱼之士遭遇天谴，然后被互联网这个催化剂放大好几个数量级地打击。
比如今年年初翟天临的著名事件、年底的曹雪涛 P 图事件和饶毅草稿事件
（突然发现我还是关注了不少新闻的，只是和大部分人侧重点不一样），
尽管这些事情不仅离我很遥远（都是我不认识的人），而且还不属于我的行业（除了翟天临之外都是生物），
但我总能在这些新闻里获得很强的代入感，这些看似遥远的事情仿佛就发生在我身边。
总是为学术界的负面新闻牵动神经也是我需要克服的缺点之一，今年由于心态还在调整，为这些新闻徒增了不少烦恼，
希望明年我能更加平静地看待这个世界的变化（主要是这个世界的发展越来越魔幻了，
我只能拿贴吧里的人看进击的巨人的态度看待这个世界，毕竟我不是书写故事的那个人）。

与造假频出的生物行业不同，我同行的负面新闻近年来基本上都是老师过度压迫（往往是本科以上学历的）学生，
比如去年武理工的陶崇园与六个字，今年佛罗里达大学的陈慧祥和李涛、华科研究生血书事件（逝者安息），
这些事情有很大一部分都伴随着生命的消逝，千里无坟，何处话凄凉？中国的学术界会因为这些事而改革吗？
饶毅事件只警醒了造假者，还没有惩罚在学术界搞官僚主义的人，这些人又将何去何从呢？
如果我要参与中国的学术界，是不是也必须参与这种官僚主义的政治斗争呢？为什么这些人就不能好好做学术呢？
一个巧合是计算机科研行业出事的人大多都是从事 "体系结构" 方向的，导致这个方向就给了我一种很自闭的整体印象。
我很珍惜的一个高中同学友人还正准备从计算机图形学转型体系结构，让我不禁有些担忧（不过他本人心态很好，
比我好很多。希望我能在明年向他多多学习）。
这些新闻总能让我对自己的价值与理想产生怀疑。

### 抑郁

我向我爸就我暑假那段时间的抑郁心态进行了一些倾诉和讨论，
我爸很正式地给我发了个文档作为回复，对我进行了一些劝说，向我摆出一些他认为可行的未来之路。
这似乎正是他从我 12 岁左右开始就想要的沟通方式（那时我很抵触，闹了很大矛盾），在我 19 岁时终于实现了。
他对我说 "你应该克服这种想法！你多休息，你没有必要这样想！"，
这种换成网友一定会被我拉黑的口吻在我看来却非常温暖，至少他希望我好起来，并且没有给我施加额外的负担，
就事论事，至少摆出了我比较认可的讨论问题的态度，一改之前我对他的印象。

我只能尽可能让自己正面地看待父母的这些行为，这样的话感觉他们对我还不错。
根据我爸的性格，只要我们一旦出现观点不合，他就会再次把我对他的正面印象全部刷没，
毕竟他虽然真心关心我，却（至少在之前）不懂得如何和我相处。不过考虑到他对现在的我的成长度的满意度来看，
他应该会越来越尊重我。当然，这也只是我的期望。
为人父母确实是非常困难的，至少我自己认为自己还不够格成为我理想中的父亲（或者母亲）。
这一点我在和一个网名叫 "星野" 的初中生网友的相处过程中已经体现得很清楚了，
小孩子是会任性、耍脾气的，会用各种方式让你不舒服。作为大人要时刻给予他们 "他们想要的形式" 的关心，
而且小孩子心灵脆弱，导致容错度低。所以这很困难，希望我今后能在这些地方有所领悟。

我现在变得越来越 "开心至上" 了，一切的努力都是建立在我现在或者以后能开心的基础上的，
这样活着才有动力，才有盼头。可能我想的比较开，总是认为 "人活着连动力都没有，为什么不去死呢"，
然后有时就会突然陷入低落，觉得自己的人生没有意义，然后就会想死。
如果找不到人生的意义，那么就让自己人生的意义变成 "寻找意义" 本身，这也是我现在正在做的。
探索这个大千世界，人生有那么多可能性，不应该以转瞬即逝的失败而懊恼不已，也不应该以昙花一现的成功而沾沾自喜。
有那么多有趣的灵魂没有和我对话过，有那么多可以实现的类型系统我还没有看过，我还没有经历过大部分人经历过的很多事，
为什么我不把心思放在这些更有意义的事情上，而是要一头栽在眼前的苟且上呢？
希望这种心态能让我继续好好活着，毕竟我还年轻，我还不想死（我也不应该死）。

这和我爸给出的建议是比较吻合的。他希望我衣食无忧的情况下做自己想做的事情，而从事学术研究是可以满足这个要求的
（但是不会很富有，赚钱需要去贴市场而不是发展尖端技术，而我不喜欢贴市场）。
他指出，从事高等教育与科学研究相关的工作一定可以给我出路，而且这条路走出来的社会地位一定是很高的，
优秀的研究人员都是受人尊敬的，再加上我能做自己喜欢的事情，一定会很开心。我深以为然。
那些学术界的负面新闻是一回事，但是曝光的是一部分，藏匿得很好的坏人是一部分，剩下的还有 considerably large
的一部分人是纯粹的，我自己的努力学习的目的就是主动选择和这部分人为伍。
这样我不就找到学习和生活的动力了吗？

由于深知自己的情绪特点，在想尽办法让自己作息规律（是经过检验的避免抑郁的有效方式）之外，
我也学会了给自己找乐子，比如去网上找点沙雕视频看，丰富一下自己除了学习和编码之外的生活。
去年准备托福的时候了解到了一个年龄很小的快手网红，网名 "国服第五骚"，视频以装疯卖傻为主，
但因为他的行为过于疯过于傻而在网上有极大的关注。这种哗众取宠的行为给当事人带来了极大的经济利益，
小小年纪心机真的很深，让我捧腹的同时也不禁对互联网时代成长起来的一代人感到深深的佩服（简言之 "我老了"）。
我作为一个挤进 00 后行业的老人，还是应该去掺和正规的行业——年龄从来都不是什么优势，
毕竟闻道有先后，我去年的年终总结就写了这些感受，今年更加坚定了这样的想法。

## 展望未来

我观测了帝国理工数学系教授 Kevin Buzzard 在 MSR 的演讲 [The future of Mathematics][tfom]，
这是我第一次完整地了解数学界支持计算机证明系统的人的想法，包括他们支持计算机证明系统的理由，
数学学术界有什么已知问题，有哪些人遭遇了这些问题，这些人怎么想，等等。
我作为一个软件工程出身转 PL 的民间爱好者，这些想法对我而言是非常有价值的，我之前只是站在 PL 的角度，
认为 "proof term 写起来越简单越好，constructivity 越多越好（毕竟经典逻辑有很多不构造的定理和没有被形式化的结构，
如果一个新的模型能给出更多常用数学公理的构造定义的话，我就会很感兴趣，比如同伦类型论里的外延性）"，
但事实上大部分数学家都不这么想。Kevin 个人和我看法一致（也就是说他是数学家中比较与众不同的那个），
但他是一个浸淫在正经数学界数十载的老江湖，他更能设身处地地站在数学家的角度思考。
事实上我之前也有认识的纯数方向的大佬，但是我都没有机会这么完整地聆听他们对这么多捆绑的信息的总结。
我以前只见到了 "对计算机证明系统感兴趣的数学家"，没有见到 "对**在数学界传播**计算机证明系统感兴趣的数学家"。

 [tfom]: https://www.bilibili.com/video/av71583469

他指出，数学界不太关心证明的严谨性，他们更关心定理本身，以及证明中用到的核心思路——定理是数学界的货币，
而证明中的非平凡的核心思路能启发人们产生新的命题与证明。这些东西才是数学家关心的。
证明的边边角角他们根本就不会去想，他们可能会漏掉一些情况、可能会犯错，但是大部分情况下他们的直觉是对的。
如果一位数学界的学阀想到了一个绝妙的定理，但是他不想给出证明，他可以献祭一个 PhD 来召唤一个证明。
他们对严谨的证明不感兴趣，最关心证明的严谨性的群体是逻辑学家，其次是计算机科学家，然后才轮到数学家
（这是一个来自人大 HoTT seminar 中第二次 lecture 孙振宇老师的说法，我自己很赞成）。
试图劝说数学家变得更严谨是徒劳的，这对他们来说只是纯粹的负担。他们没有这样的传统，反倒是我们还比他们更严谨。

再者，现在开发计算机证明系统的学过点基本的数学的程序员们形式化了很多关于有限群的定理（Kevin 给出的例子是奇阶定理），
给出了范畴论的基本结构的性质与一些常见结构的证明（我个人印象中，数学家们觉得范畴论没什么用，
首先不是所有数学领域都需要范畴论，一般是给数论这种东西打造工具的学科比如代数几何，或者代数拓扑学，才会用到范畴论。
当然，在 Haskell 社区吹水也可以用），给出了常见计算机算法的性质的数学证明
（这是这个小众领域的一个热门方向，又名 "形式化验证"，我对这个没啥兴趣，但是考虑到这还是个工资有救的行业，不得不关心啊），
给出了简单结构（比如群、环、域等）上的 solver（在数学家看来，都非常平凡，只能起到定理证明中软件工程层面的帮助），
给出了更强力的归纳结构（induction-recursion 就是其中之一），更
<ruby>优美<rp>(</rp><rt>复杂</rt><rp>)</rp></ruby>
的数据类型（高阶归纳类型等），然后他们自以为这些东西能吸引数学界的人们的眼球。
很遗憾，Kevin 指出 "数学家不关心这些"。他自己关心，但是他的同事不关心。用这些东西打不了广告的。
现代数学真的有人关心数学归纳法吗？他们用到的归纳可能也就是自然数上的归纳了。
一个比较重要的结构是商集（带等价类的 hSet），但是这东西也不是绝对需要高阶归纳类型的（Lean 就有一个内置的）。

数学家关心什么？
Kevin 认为，我们应该直接追随数学界的 state of the art，抛弃那些表达起来很容易的老学校定义
（尤其是不能给数学家看计算机科学家自嗨的东西，比如 syntax with binding），
转而用计算机形式化一些更性感的结构，这样才能体现出计算机的优势。计算机里一切定义都很清晰，
这种大家也不太精通的东西正好适合用来做成程序，然后才能通过和计算机交互产生价值，同时也可以用于教育。
Kevin 给出的例子是 perfectoid space，这是 2018 年菲尔茨奖得主的成果之一，也是数学家现今比较追捧的。
Kevin 花了 8 个月时间，一边学 Lean 一边形式化这个，最后做出了[一个完整定义][pers]。
不管这个东西对不对，至少我们有了一个很接近这个数学模型的形式化版本，这就是好的。
他认为这个过程下来他更懂 Lean 和 dependent type theory 了，今后要做类似的工作时间只会更短。

数学家们可以在网上免费下载这个定义，试图构造一些实例，证明一些小性质。这才是他们想要的！
这种年轻的结构是整个业界都还在好奇地探索的，此时如果多了一位精通这个结构的老师（也就是加载了 perfectoid space
的定义的计算机定理证明系统）能告诉你你什么地方做对了什么地方做错了，那他们一定会很感兴趣。
相比之下，奇阶定理（虽然也是一个菲尔茨奖级的结论）只是一个 50 年前就凉了的行业里面的一个道中 boss 级的结论，
因为那时有限单群分类的问题得到了解决，基本上掏空了有限群里所有能做的事情，所以所有人都离开了这个行业，
然后这个行业就 "没有开挂" 了。计算机科学家证明这里面的东西其实就是炒冷饭。
这当然是有意义的，但是对于推广和传播没有帮助。我们应该做的，是一边做这些默默无闻但是又很有意义的事情
（这样大家在用计算机重塑一百年来上万个常用数学结构时，可以简化很多工作），一边吸引更多数学家们的注意，
这样才能让业界蓬勃发展。

 [pers]: https://arxiv.org/abs/1910.12320

视频中 Kevin 指出了他眼中 Coq、Agda、Isabelle 比起 Lean 的不足之处，这些观点如果出自一个计算机科学家，我会嗤之以鼻
（观点很有意思，我就不在文章里讨论了，免得你们不去看那么好看的演讲），但是从数学家的口中说出来，又别有一番风味。
这里不是说我会以一个人的出身 judge 他说的话，而是因为 "数学家们怎么想" 本身就是一个和人的出身有关的话题，
这是一个本来文科生才会关心的问题，是纯人文的，思考这些问题的时候不能过度理性。
不然我早就觉得数学家都是傻子了，他们写论文引用那么多别人的结论，真能保证这些人的论文里没点纰漏吗？
这很明显不是思考这个问题的正确态度。
Vladimir Voevodsky 和 Kevin Buzzard 都意识到了数学界不严谨的 practice，他们都认为数学界需要革新，
这给了我更多的信心投入自己的时间到相关工作里去。我才大二，有足够的时间观察业界并准备转型，所以我充满希望。
让我惊讶的是 Kevin 知道 Arend 并对其抱有正面态度，果然数学界和计算机科学界有着完全不同的消息网，世界真奇妙。

### 关于 "展望未来"

另一件趣事：上面这段也被我剪辑了发到知乎，引起了数学迷及其党羽的评论区战争。
杨博、包遵信等用户也出现了，可谓热闹非凡。其中，我认为有一些很有趣的评价，在这里顺便带过：

> 你对数学家的很多印象和我的体验很不一样啊。
> 我高二高三就开始知道范畴这个词的含义，大学几年都在不断接触其实例，
> 而且我随时能把学过的证明还原为ZFC，你可以现考我。
>
> —— 数学迷

> 提到范畴论居然没有提到代数拓扑。明明代数拓扑才是范畴论的大本营。
> 还有，虽然范畴论不是所有数学家都会的，但是它也没那么小众，无穷范畴还有辛几何最近是真的特别火。
>
> —— ChroniCat

> 作为一个数学系出身，将来想做逻辑的人。
>
> 一方面我同意数学家没有那么不严谨，我自己的学习经验也同样告诉我，
> 大家学习的时候是注意知识的基础严不严格的，而且对于严格性的判断也不是简单依赖直觉，
> 更像是依赖自己的经验，因为自己做过类似的检验了，所以只是为了简洁才不写。
> 迷神所说的能把自己学过的东西用ZFC改写出来我也是绝对相信的。
>
> 但是另一方面从我学逻辑的体验来看，有些东西的公理化是有本质困难的，已被公理化的基本没有问题，
> 但是逻辑学里还有大量不好公理化的东西，虽然大多不来自数学，
> 但也足以让我们认识到公理化有些东西不是一个平凡的事情。或者说在这个过程中还会挖掘到不一样的东西，
> 尤其是对一些最基础的逻辑概念。
>
> 另外对数学严格性的关心这样一种数学基础工作，确实是离数学家有距离，数学家重要的是往前走，
> 数学基础是往回走。北大做逻辑的某位老师曾说过第三次数学危机其实根本不是数学危机，而是数学基础危机，
> 最终引发的更多的是逻辑学家的讨论。事实上也是他并没有颠覆任何具体的数学，该有的古典数学基本都没丢，
> 只是在研究如何严格表述。当然我们也没有能力有信心的说古典数学已有的结论都没错，但是似乎，
> 认为可能有错也只是可能，对比两边的信念的话，
> 至少我认为还是认为它是一致的或者说可以通过小的修补做好的是更让我有信念的。
>
> 我个人未来也是想做数学基础的，但是我们显然没有理由让数学家停下来先等数学基础做好，
> 而是应当鼓励数学家大踏步的往前走，出了问题再回来。
>
> —— Pluto

以及我有一位朋友私下发表了这样的看法。因为我一开始写的时候说了这么一句话：

> 然而数学家们大多觉得范畴论没什么用

然后引起了较大的争议，因此我就修改了原文，你们现在看不到了。朋友是这么说的：

> 我可以给你 paint 一个更明确的图像。
>
> 数学里面做很具体的数学的，比如分析，组合，概率论这块的，完全不屌范畴论，连 category 定义都不知道。
> 数论 非常 advanced 但一定意义下也很 ”具体“ 所以也不太用到范畴论，只是用范畴论的语言陈述东西。
> 给数论这种东西打造工具的学科比如代数几何，用到范畴论（很具体的代数几何，也不会用到范畴论）。
> 代数拓扑这些也离不开范畴论（除非做很具体的计算，但很多时候计算也是 model category / ∞-category
> 里的计算），大概这样。
>
> 所以基本上还是看你遇到什么人。

当事人顺便表达了一些对 Lean 的看法：

> 我其实最近还考虑过写一篇学 Lean 的感受。
>
> 我觉得这个 learning curve 真的陡峭。但真的用 Agda 或者任何 constructive
> 的东西基本没可能在实数上 work。拒绝了 classical logic 实在是很多简单的东西太难做了。
> 我其实还是不太 care 实数的那种……但 lean 允许我吭哧吭哧很费劲地在实数上 work
> （证明一些很弱的不等式）我还是觉得很感动 😂
>
> 倒是还可以跟你讲个观点，Voevodsky 稍微 "浪漫" 一点，想东西也更从本原出发，
> Kevin Buzzard 明显更实际一点，比如他也承认做 perfectoid space 定义的 formalization
> 既是测试 lean 的能力也是 PR stunt。
>
> HoTT 要被数学界接受（成为一个比较底层的东西）可能会比让人在 Lean 上写形式化证明要难。
> 但也不排除基于 HoTT 发现比较新颖的数学然后突然在数学里热起来。
>
> 我觉得选择了 lean 也是很 practical 的。现在说的 "用 lean 写证明" 没人真正 care
> 底层用了什么 type theory 而是更多关心 mathlib 给的 API。
> 反倒是 Voevodsky 真的 take a stab on type theory, 问了很多很底层的问题。
>
> 对了我还有个感受，就是 Kevin 想做的这些东西真的不太需要 type theory 很多创新，
> 反倒是需要语法糖之类的东西给予 lean 一些用起来顺手的用于表达的东西。
>
> 我现在真的老卡在简单的东西上。

## 结语

说了这么多，基本上囊括了我这一年来的风风雨雨和喜怒哀乐。希望我的未来可以一帆风顺。
且听诗云：

> 纷纷世事无穷尽，天数茫茫不可逃。<br/>
> 鼎足三分已成梦，后人凭吊空牢骚。