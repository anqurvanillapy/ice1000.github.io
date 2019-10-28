# 路漫漫其区间兮, 吾将归纳而求索

看到这个编译器选项，是不是有些兴♂奋？

```agda
{-# OPTIONS --cubical #-}
module PathToHigherInductiveTypes where

open import Cubical.Foundations.Prelude
open import Cubical.Core.Everything

open import Cubical.Data.Nat
```

老规矩：

```agda
variable
  ℓ : Level
  A B : Set ℓ
  F : A -> Set ℓ
```

我用打油诗重命名了一些最近的 lagda 文章，感觉现在这样要文艺一些。

这篇文章是写给魔理沙（并感谢 review）和 Parker Liu 看的，但理论上任何会 CH 同构和 Dependent Type 的人都可以看（不需要前置的 Cubical Type Theory 知识）。
本文假定读者熟悉以下知识：

+ Dependent Type
+ GADT
+ 模式匹配
+ CH 同构

我曾经在浙大的一个地下社团 ZJU Lambda （社团活动主要是膜人和复读）进行过一次小分享，大致介绍了 Dependent Type 的出现原因、细节实现和一些扩展的内容（比如 `Dec`，Coinduction，Termination 等有趣的东西）。在这个分享中，我简要介绍了一个很酷炫的概念——高阶归纳类型（Higher Inductive Types）。这是一种全新的描述数据的思路（甚至获得了社长龙先生的赞许，可以说是人间一大奇迹，无上的荣耀了），但当时限于我根本没学过 Cubical Type Theory，没法把这个东西讲的很清楚。现在我大概入了点门，对这个东西有一定完整的了解了。Parker Liu 在朋友圈让我写一篇文章，于是我就奉命行事。

## 点线面五块钱一碗

### Motivation：有理数

熟悉各种 Proof Assistant 的同学，应该都想过定义如下的『有理数』定义（目前暂不考虑分母为零的情况，后面再说）：

```agda
module Simpleℚ where
  data ℚ : Set where
    _÷_ : ℕ -> ℕ -> ℚ
```

我们需要一个公理——任何有理数，分子分母同时乘以一个数，得到的有理数和原本的有理数相等。这直接就是数学上的有理数的一部分，但是我们上面的定义则无法表示。事实上，那个沙雕定义只是一个自然数的二元组而已。

那么我们应该怎么描述这一公理呢？我在一百年前写的小证明库里面使用 `TrustMe` 『假设』了这个公理，并完成了有理数上的一些运算律。这令人感到憋屈，因为我们把原本应该是定义一部分的公理假设出来了，但『假设』是一个不安全的特性，而且不能参与运算。所以，我们给出这样一种操作：允许在 GADT 里面定义除了数据的**构造器**之外的另一种东西——数据的**关系**。

```agda
    frac : ∀ a b c -> (a * c) ÷ (b * c) ≡ a ÷ b
```

于是，根据定义，我们可以轻易地证明 `4 ÷ 2 ≡ 2 ÷ 1`：

```agda
  4÷2≡2÷1 : 4 ÷ 2 ≡ 2 ÷ 1
  4÷2≡2÷1 = frac 2 1 2
```

仔细阅读的读者可能已经发现了，我们此处使用的相等运算符 `≡` 其实并不是我们之前知道的那个可以用 congruence 和 transitivity 进行证明的相等关系，而是另一个类型的别名—— `Path`。我们先不管这个 `Path` 类型，来看另一个更简单的例子——整数（有理数本身较为复杂，整数讲起来更简单）。

### Application：整数

相信大家都已经见识过这个混乱邪恶的沙雕 `ℤ` 了：

```agda
module Stupidℤ where
  data ℤ : Set where
    +_      : ℕ -> ℤ
    -[1+ _] : ℕ -> ℤ
```

在这个上面定义的整数[加减法](https://github.com/agda/agda/blob/2680cb86ab5720eb9a391335c57a9f01e975437f/examples/lib/Data/Integer.agda)和[交换律结合律](http://agda.github.io/agda-stdlib/Data.Integer.Properties.html#8213)证明起来非常非常的蛋疼，代码无比之长。简单思考一下原因，我们能很轻易地发现问题：**这个整数的正负两部分是不对称的**。

根据上面介绍的『定义数据的等价关系』，我们可以定义出对称的整数：

```agda
data ℤ : Set where
  pos : (n : ℕ) -> ℤ
  neg : (n : ℕ) -> ℤ
  posneg : pos 0 ≡ neg 0
```

直接给出『正』和『负』的构造器，然后定义『正的零等于负的零』。这看起来很美好，比如它的 `succ` 应该是非常符合直觉（加减因为[一个 bug](https://github.com/agda/agda/issues/3314)暂时写不出来）的：

```agda
succ : ℤ -> ℤ
succ (pos n) = pos (suc n)
succ (neg zero) = pos 1
succ (neg (suc n)) = neg n
```

等等……我们似乎漏掉了一个情况。我们还有一个构造器 `posneg` 没有被模式匹配！对于一个等价关系要怎么模式匹配啊？这是个等价关系，这根本不是一个数据。使用我们一贯的思路，是无法处理这种情况的。因为我们一直就在犯规——数据构造器构造的就应该是数据，关系怎么能是数据的一部分呢？现在好了，我们把关系和数据放在了一起，函数写不出来了吧？傻了吧？面对音乐吧？哈哈哈。

这时我们就要详细介绍一下这个相等关系具体是什么东西了。剧透一下，对于这种情况，可以使用 Agda 的自动填写函数实现的功能填出来。对于这种情况，Agda 选择直接返回 `pos 1`。

```agda
succ (posneg _) = pos 1
```

## 山重水复疑无路

`Path` 这个东西呢，说来也简单，不过还得结合一个叫 `Interval` 的类型来讲。实现上来说，`Interval` 是一个只有两个实例 `i0` 和 `i1` 的数据类型，分别表达一条线段的两个端点。知道这一事实可以辅助我们理解一些概念，但我们并不能在编程上这么想。

想象一条线段，连接两个点。

```text
a         b
<--------->
```

我们使用代码描述它：这是一个 Lambda 表达式，接收一个 `Interval` 类型的变量，返回它对应的端点。然后，我们给出这样的定义，或者说规则：

+ `Interval` 不能被判断，因为它不仅有端点，还有整条线段上的所有点
+ 接收 `Interval` 返回任意对象的函数叫做 `PathP`，几何意义是『根据点，取出线段上的值』

我们可以轻松地得到如下极为重要的推论：

+ 不能对 `Interval` 进行模式匹配
+ 但 `Interval` 和 `PathP` 都是有两个**端点**的

和这些不算极为重要但是非常重要的推论：

+ 不知道当前在 `PathP` 的哪个地方，因此我们一般只能不管这个 `Interval` 参数
+ `PathP` 类型看似有四个参数——两个端点的类型，以及两个端点的值
  + 实际上，两个端点的类型也应该被表达为一个 `PathP`
    + 之所以我们*可以*这么做，是因为我们有 Dependent Type
    + 之所以我们*需要*这么做，是因为我们不能只写出『端点』上的类型，这条线段上所有的点都有类型
  + 因此 `PathP` 有三个参数：另一个 `PathP`，以及两个端点的值
+ 如果两个端点的值类型相同，就正好对应 Homogeneous Equality，不同则正好对应 Heterogeneous Equality
  + 我们给 Homogeneous Equality 起别名，为 `Path`

因此，我们可以很轻易地得到自反性—— `reflexivity` 在 `Path` 下的定义：

```agda
reflexivity : {a : A} -> Path A a a
reflexivity {a = a} = λ i -> a
```

它就是这样的线段：

```text
a         a
<--------->
```

然后，我们要引入一个新操作（其实还有好几个，但是本文并不准备介绍一维以上的几何，可能以后会出文章）——取反。它把一个区间变量反转。因此，我们可以定义出对称性—— `symmetry` 在 `Path` 下的定义：

```agda
symmetry : {a b : A} -> Path A a b -> Path A b a
symmetry p = λ i -> p (~ i)
```

我们现在已经能逐渐接受这样的 `Path` 类型作为相等关系了（因为我们目前好像也就能凭空构造自反性、相等性……传递性需要其他基础定义，暂时不说啦）。因此，我们把相等关系的符号 `≡` 定义为 `Path` 的别名（避免命名冲突，下面只是展示 `≡` 的实际定义）：

```agda
Equivalence : {A : Set ℓ} -> (a b : A) -> Set ℓ
Equivalence {A = A} a b = Path A a b
```

## 回到高阶归纳类型

根据我们之前的讨论：类型为 `A` 的两个变量 `a b` 之间的相等关系（`Path A a b`）是一个函数，参数是 `Interval`，返回 `A` 的实例。

那么，**既然是返回 `A` 实例的函数，为什么不可以是一个数据构造器呢**？

是不是有一种醍醐灌顶的感觉。所以说，如果我们把 `zeroEq : pos 0 ≡ neg 0` 这个『高阶』构造器写成函数，就是：

```text
  zeroEq : Interval -> ℤ
```

返回的两个可能的实例 `pos 0` 和 `neg 0` 都是 0，那么在模式匹配到这里的时候，自然也就应该返回 `succ 0` aka `pos 1` 啦。

在理解了这一点之后，我们可以写出更多有趣的证明，比如一个更完善的 `ℚ`，把 `nan` 单独处理出来:

```agda
data ℚ : Set where
  _÷_  : ℕ -> ℕ -> ℚ
  frac : ∀ a b c -> (a * c) ÷ (b * c) ≡ a ÷ b
  nan  : ∀ a b -> a ÷ 0 ≡ b ÷ 0
```

这样，我们就不再是『构造不出来除数为零的有理数』，而是『除数为零的有理数都是 `NaN`』了，带来了更多的灵活性（我们可以编写能够处理 `NaN` 的函数）。

## 简单应用

函数的外延性就是 `flip` （下面这是依赖函数的函数外延性）：

```agda
flip : {f g : (a : A) -> F a} ->
       (∀ a -> f a ≡ g a) ->
       (f ≡ g)
flip f i a = f a i
```

如果你看不懂依赖函数，试试非依赖的：

```agda
flip′ : {f g : A -> B} ->
       (∀ a -> f a ≡ g a) ->
       (f ≡ g)
flip′ f i a = f a i
```

再看不懂就是你撒谎啦。

[这个问题](https://cs.stackexchange.com/q/103146/79971)的[这个回答](https://cs.stackexchange.com/a/103151/79971) 给了我很大帮助。

dram 吐槽我没介绍 `comp`，但介绍这个东西又涉及 `Partial`, `hcomp`, `fill` 之类的一大堆定义以及 `Path` 的几何意义，我还没做好那个准备啦。
