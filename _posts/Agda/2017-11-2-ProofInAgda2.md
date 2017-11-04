---
layout: post
title: Agda 中的证明，从一到二
category: Agda
tags: Agda, Proof
keywords: Agda, Proof
description: Proof in Agda, from 1 to 2
inline_latex: true
---

上一篇我们说到了一个只有一步的证明，这一篇我们来看一个稍微复杂点的，组合命题的例子。
到目前为止，按理说所有的字符都还能正常显示。

## 前置知识

+ [上一篇文章](../../../../2017/11/01/ProofInAgda/)

以及，由于 Agda 语言的特殊性，本文将继续使用 LaTeX 和代码块来共同展示代码。
代码块唯一的作用在于便于复制，主要的呈现途径为 LaTeX 。
~~（其实是因为我的手机显示不出来很多字符，我又要自己看自己写的东西）~~

## 介绍符号

都是初中数学里面的，并且是只需要小学数学就可以看懂的符号。

### 与和或

我们知道，门电路里面都有与门和或门，对应逻辑上的与和或。
与的符号是：

$$
\land
$$

 ，或的符号是：
 
$$
\lor
$$

。
比如， $$ p \land q \rightarrow r $$ 表示 `p` 和 `q` 都必须成立， `r` 才成立。
而 $$ p \lor q \rightarrow r $$ 表示 `p` 和 `q` 中任意成立一个， `r` 就成立。

### 充要条件

我们知道，如果两个条件 `p` `q` 能使 $$ p \rightarrow q $$ 和 $$ q \rightarrow p $$
同时成立，我们称他们互为充要条件，使用：

$$
\Leftrightarrow
$$

表示，比如 $$ p \Leftrightarrow q $$ 。

我们将在接下来的代码里面使用这些符号。

## 定义 GADT

首先定义 $ \land $ 对应的 GADT ：

$$
\DeclareMathOperator{Set}{Set}
\DeclareMathOperator{where}{where}
\DeclareMathOperator{proof}{proof}
\DeclareMathOperator{data}{data}
\DeclareMathOperator{intro}{intro}
\DeclareMathOperator{comm}{comm}
\DeclareMathOperator{assoc}{assoc}
\DeclareMathOperator{elim}{elim}

\begin{align*}
& \data\ \_{\land}\_\ (P\ Q : \Set) : \Set \where \\
& \ \ {\land}{-}{\intro} : P \rightarrow Q \rightarrow (P \land Q)
\end{align*}
$$

```agda
data _∧_ (P Q : Set) : Set where
  ∧-intro : P → Q → (P ∧ Q)
```

这是一个 "条件" ，即前文一直强调的 "类型则命题" 中命题的最基本组成元素
（好像 Wikipedia 上也称之为 "公式" ，反正我对这个名称不负责，就是用来表示命题 $ p \rightarrow q $ 中的 `p` 和 `q` 的东西）。

这个 "条件" 是两个其他条件的组合，它拿到两个条件变成一个新条件。
这也体现在 Agda 代码中， $$ \_ {\land} \_ $$ 这个类型拿到两个 `Set` 作为
[类型 $$ \_{\land}\_ $$ 的参数](http://people.inf.elte.hu/divip/AgdaTutorial/Sets.Parametric.html#1)，
返回一个新类型。
对应的类型构造器我们称之为 $$ {\land}{-}{\intro} $$ 。

有了这个类型，我们首先可以做一些很简单的证明。

### 例〇：充要条件

比如，根据充要条件 $$ (p \rightarrow q) \land (q \rightarrow p) $$ 的定义，我们可以把它表达成一个函数：

$$
\begin{align*}
& \_{\Leftrightarrow}\_ : (P\ Q : \Set) \rightarrow \Set \\
& p \Leftrightarrow q = (p \rightarrow q) \land (q \rightarrow p)
\end{align*}
$$

```agda
_⇔_ : (P Q : Set) → Set
p ⇔ q = (p → q) ∧ (q → p)
```

这里我们在函数体（证明）里面使用了 $$ \rightarrow $$ ，这样的话 $$ (p \rightarrow q) $$ 就是一个类型为 $$ {\Set} _1 $$ 的东西。
因此，这实际上是一个 "高阶条件" ，和 "高阶函数" 道理差不多：
即它不是一个 "命题" ，而是由其他的条件组成的条件（顺带一提，这个名词也是我为了便于理解自己编的，不知道有没有其他人在用
（顺带一提，是类型的阶（顺带一提， Agda 中表示类型的阶的类型正好是 `Level` ，中文意思就有阶的意思，
因此这个说法可以说是很通用了，比如这里就是一个 __高阶顺带一提__ ）
在 dependent type 里面已经变得很模糊了，因此这个 "高阶" 的比喻是不太恰当的，这里就将就拿
Haskell 之类的简单语言的概念将就一下））。
再根据前文已经讲过的：

> 只要有 $$ p \rightarrow q $$ 这个函数成立，那么就证明了  " $$ p \rightarrow q $$ " 这个命题

这个函数的作用便变得很清晰了。
不理解没关系，下面会用到这个东西，然后你或许能从它的应用看懂它的意义。

另外，看到没有？函数体（证明）（下文不再进行这样的强调，感觉很辣鸡）
和定义 $$ (p \rightarrow q) \land (q \rightarrow p) $$ 写起来都是完全一样的。
这里可以体现一些 Agda 语言的优势，就是因为 Unicode 语法的存在，它可以把代码写的很接近数学语言。

不过这并不代表 Agda 就只能用于学术，毕竟类型安全的社区和人气火爆的社区结合起来才是最好的，
Idris 都用强大的 ffi 和官方强推的 `Control.ST` 了，为什么 Agda 不能写成 imperative language 呢。

### 例一：定义

比如，在 $$ p \land q $$ 成立的时候， `p` 和 `q` 分别成立（就是 $$ \land $$ 的定义啦，很简单的）。
用数学语言表达的话，就是（几乎就是废话）：

$$
p \land q \rightarrow p \\
p \land q \rightarrow q
$$

写成代码的话，就是：

$$
\begin{align*}
& \proof _3 : \forall \{P\ Q\} \rightarrow (P \land Q) \rightarrow P \\
& \proof _3\ ({\land}{-}{\intro}\ p\ q) = p \\
\\
& \proof _4 : \forall \{P\ Q\} \rightarrow (P \land Q) \rightarrow Q \\
& \proof _4\ ({\land}{-}{\intro}\ p\ q) = q
\end{align*}
$$

```agda
proof₃ : ∀ {P Q} → (P ∧ Q) → P
proof₃ (∧-intro p q) = p

proof₄ : ∀ {P Q} → (P ∧ Q) → Q
proof₄ (∧-intro p q) = q
```

### 例二：交换律

然后还有一个很简单的例子——交换律（ Commutative Law ）。
用数学语言表达的话，就是（几乎也是废话）：

$$
(P \land Q) \Leftrightarrow (Q \land P)
$$

这个命题写成 Agda 代码，就是这样的类型（我们称之为 $$ {\land}{-}{\comm} $$ ）：

$$
{\land}{-}{\comm} : \forall \{P\ Q\} \rightarrow (P \land Q) \Leftrightarrow (Q \land P)
$$

```agda
∧-comm : ∀ {P Q} → (P ∧ Q) ⇔ (Q ∧ P)
```

这里我们就已经使用到之前的代码—— $$ \Leftrightarrow $$ 啦。

如何证明它呢？

首先，我们的证明需要返回一个由 $$ \Leftrightarrow $$ 组合的两个类型。
由于

TODO



