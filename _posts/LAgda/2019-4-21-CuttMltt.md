---
layout: post
title: Different styles of equality reasoning
category: PLT
tags: PLT, Agda
keywords: PLT
agda: true
description: Different styles of equality reasoning
---

<pre class="Agda"><a id="180" class="Symbol">{-#</a> <a id="184" class="Keyword">OPTIONS</a> <a id="192" class="Pragma">--cubical</a> <a id="202" class="Pragma">--safe</a> <a id="209" class="Symbol">#-}</a>
<a id="213" class="Keyword">module</a> <a id="220" href="" class="Module">2019-4-21-CuttMltt</a> <a id="239" class="Keyword">where</a>
<a id="245" class="Keyword">import</a> <a id="252" href="/lagda/Agda.Builtin.Equality.html" class="Module">Agda.Builtin.Equality</a> <a id="274" class="Symbol">as</a> <a id="277" class="Module">MLTT</a>
<a id="282" class="Keyword">import</a> <a id="289" href="/lagda/Cubical.Core.Everything.html" class="Module">Cubical.Core.Everything</a> <a id="313" class="Symbol">as</a> <a id="316" class="Module">CUTT</a>
<a id="321" class="Keyword">import</a> <a id="328" href="/lagda/Agda.Builtin.Nat.html" class="Module">Agda.Builtin.Nat</a> <a id="345" class="Symbol">as</a> <a id="348" class="Module">MNat</a>
<a id="353" class="Keyword">import</a> <a id="360" href="/lagda/Cubical.Data.Nat.html" class="Module">Cubical.Data.Nat</a> <a id="377" class="Symbol">as</a> <a id="380" class="Module">CNat</a>
<a id="385" class="Keyword">private</a> <a id="393" class="Keyword">variable</a> <a id="402" href="#402" class="Generalizable">A</a> <a id="404" href="#404" class="Generalizable">B</a> <a id="406" class="Symbol">:</a> <a id="408" class="PrimitiveType">Set</a>
</pre>
In dependently-typed programming languages, we do equality proofs.

Type Theory folks formed two groups; one stands for "proofs are not important",
one stands for "proofs are important".
Someone claims that the identity proof between two objects is unique -- which
is related to the K rule.
The other people believe that the proof of identity is significant -- the same
theorem can
have different proofs, where the identity relation on these *proofs* are also
nontrivial and can be proved to be equivalent or not.

# Intuitionistic Logic

First, let's take a look at the world of unique identity proofs.

<pre class="Agda"><a id="1026" class="Keyword">module</a> <a id="Intuitionistic"></a><a id="1033" href="#1033" class="Module">Intuitionistic</a> <a id="1048" class="Keyword">where</a>
 <a id="1055" class="Keyword">open</a> <a id="1060" href="/lagda/Agda.Builtin.Equality.html" class="Module">MLTT</a>
 <a id="1066" class="Keyword">open</a> <a id="1071" href="/lagda/Agda.Builtin.Nat.html" class="Module">MNat</a>
</pre>
In Intuitionistic Logic, we can prove new theorems via pattern matching on existing theorems,
because identity proofs are instances of the equality type:

<pre class="Agda"> <a id="Intuitionistic.trans"></a><a id="1241" href="#1241" class="Function">trans</a> <a id="1247" class="Symbol">:</a> <a id="1249" class="Symbol">{</a><a id="1250" href="#1250" class="Bound">a</a> <a id="1252" href="#1252" class="Bound">b</a> <a id="1254" href="#1254" class="Bound">c</a> <a id="1256" class="Symbol">:</a> <a id="1258" href="#402" class="Generalizable">A</a><a id="1259" class="Symbol">}</a> <a id="1261" class="Symbol">→</a> <a id="1263" href="#1250" class="Bound">a</a> <a id="1265" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1267" href="#1252" class="Bound">b</a> <a id="1269" class="Symbol">→</a> <a id="1271" href="#1252" class="Bound">b</a> <a id="1273" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1275" href="#1254" class="Bound">c</a> <a id="1277" class="Symbol">→</a> <a id="1279" href="#1250" class="Bound">a</a> <a id="1281" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1283" href="#1254" class="Bound">c</a>
 <a id="1286" href="#1241" class="Function">trans</a> <a id="1292" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a> <a id="1297" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a> <a id="1302" class="Symbol">=</a> <a id="1304" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>

 <a id="Intuitionistic.sym"></a><a id="1311" href="#1311" class="Function">sym</a> <a id="1315" class="Symbol">:</a> <a id="1317" class="Symbol">{</a><a id="1318" href="#1318" class="Bound">a</a> <a id="1320" href="#1320" class="Bound">b</a> <a id="1322" class="Symbol">:</a> <a id="1324" href="#402" class="Generalizable">A</a><a id="1325" class="Symbol">}</a> <a id="1327" class="Symbol">→</a> <a id="1329" href="#1318" class="Bound">a</a> <a id="1331" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1333" href="#1320" class="Bound">b</a> <a id="1335" class="Symbol">→</a> <a id="1337" href="#1320" class="Bound">b</a> <a id="1339" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1341" href="#1318" class="Bound">a</a>
 <a id="1344" href="#1311" class="Function">sym</a> <a id="1348" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a> <a id="1353" class="Symbol">=</a> <a id="1355" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>

 <a id="Intuitionistic.cong"></a><a id="1362" href="#1362" class="Function">cong</a> <a id="1367" class="Symbol">:</a> <a id="1369" class="Symbol">{</a><a id="1370" href="#1370" class="Bound">a</a> <a id="1372" href="#1372" class="Bound">b</a> <a id="1374" class="Symbol">:</a> <a id="1376" href="#402" class="Generalizable">A</a><a id="1377" class="Symbol">}</a> <a id="1379" class="Symbol">→</a> <a id="1381" class="Symbol">(</a><a id="1382" href="#1382" class="Bound">f</a> <a id="1384" class="Symbol">:</a> <a id="1386" href="#402" class="Generalizable">A</a> <a id="1388" class="Symbol">→</a> <a id="1390" href="#404" class="Generalizable">B</a><a id="1391" class="Symbol">)</a> <a id="1393" class="Symbol">→</a> <a id="1395" href="#1370" class="Bound">a</a> <a id="1397" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1399" href="#1372" class="Bound">b</a> <a id="1401" class="Symbol">→</a> <a id="1403" href="#1382" class="Bound">f</a> <a id="1405" href="#1370" class="Bound">a</a> <a id="1407" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1409" href="#1382" class="Bound">f</a> <a id="1411" href="#1372" class="Bound">b</a>
 <a id="1414" href="#1362" class="Function">cong</a> <a id="1419" class="Symbol">_</a> <a id="1421" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a> <a id="1426" class="Symbol">=</a> <a id="1428" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>
</pre>
or we can use `rewrite`, which is syntactic sugar of pattern matching
(and this definition is more Idris style):

<pre class="Agda"> <a id="Intuitionistic.trans₁"></a><a id="1557" href="#1557" class="Function">trans₁</a> <a id="1564" class="Symbol">:</a> <a id="1566" class="Symbol">{</a><a id="1567" href="#1567" class="Bound">a</a> <a id="1569" href="#1569" class="Bound">b</a> <a id="1571" href="#1571" class="Bound">c</a> <a id="1573" class="Symbol">:</a> <a id="1575" href="#402" class="Generalizable">A</a><a id="1576" class="Symbol">}</a> <a id="1578" class="Symbol">→</a> <a id="1580" href="#1567" class="Bound">a</a> <a id="1582" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1584" href="#1569" class="Bound">b</a> <a id="1586" class="Symbol">→</a> <a id="1588" href="#1569" class="Bound">b</a> <a id="1590" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1592" href="#1571" class="Bound">c</a> <a id="1594" class="Symbol">→</a> <a id="1596" href="#1567" class="Bound">a</a> <a id="1598" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1600" href="#1571" class="Bound">c</a>
 <a id="1603" href="#1557" class="Function">trans₁</a> <a id="1610" href="#1610" class="Bound">p</a> <a id="1612" href="#1612" class="Bound">q</a> <a id="1614" class="Keyword">rewrite</a> <a id="1622" href="#1610" class="Bound">p</a> <a id="1624" class="Symbol">=</a> <a id="1626" href="#1612" class="Bound">q</a>

 <a id="Intuitionistic.cong₁"></a><a id="1630" href="#1630" class="Function">cong₁</a> <a id="1636" class="Symbol">:</a> <a id="1638" class="Symbol">{</a><a id="1639" href="#1639" class="Bound">a</a> <a id="1641" href="#1641" class="Bound">b</a> <a id="1643" class="Symbol">:</a> <a id="1645" href="#402" class="Generalizable">A</a><a id="1646" class="Symbol">}</a> <a id="1648" class="Symbol">→</a> <a id="1650" class="Symbol">(</a><a id="1651" href="#1651" class="Bound">f</a> <a id="1653" class="Symbol">:</a> <a id="1655" href="#402" class="Generalizable">A</a> <a id="1657" class="Symbol">→</a> <a id="1659" href="#404" class="Generalizable">B</a><a id="1660" class="Symbol">)</a> <a id="1662" class="Symbol">→</a> <a id="1664" href="#1639" class="Bound">a</a> <a id="1666" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1668" href="#1641" class="Bound">b</a> <a id="1670" class="Symbol">→</a> <a id="1672" href="#1651" class="Bound">f</a> <a id="1674" href="#1639" class="Bound">a</a> <a id="1676" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1678" href="#1651" class="Bound">f</a> <a id="1680" href="#1641" class="Bound">b</a>
 <a id="1683" href="#1630" class="Function">cong₁</a> <a id="1689" class="Symbol">_</a> <a id="1691" href="#1691" class="Bound">p</a> <a id="1693" class="Keyword">rewrite</a> <a id="1701" href="#1691" class="Bound">p</a> <a id="1703" class="Symbol">=</a> <a id="1705" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>
</pre>
These three functions, `trans`, `sym` and `cong` are our equality proof
combinators.

Larger and more concrete theorems, such as the plus commutative law:

<pre class="Agda"> <a id="Intuitionistic.+-comm"></a><a id="1876" href="#1876" class="Function">+-comm</a> <a id="1883" class="Symbol">:</a> <a id="1885" class="Symbol">∀</a> <a id="1887" href="#1887" class="Bound">a</a> <a id="1889" href="#1889" class="Bound">b</a> <a id="1891" class="Symbol">→</a> <a id="1893" href="#1887" class="Bound">a</a> <a id="1895" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="1897" href="#1889" class="Bound">b</a> <a id="1899" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="1901" href="#1889" class="Bound">b</a> <a id="1903" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="1905" href="#1887" class="Bound">a</a>
</pre>
can be proved by induction -- the base case is simply `a ≡ a + 0`,
where we can introduce a lemma for it:

<pre class="Agda"> <a id="2024" href="#1876" class="Function">+-comm</a> <a id="2031" href="/lagda/Agda.Builtin.Nat.html#183" class="InductiveConstructor">zero</a> <a id="2036" href="#2036" class="Bound">b</a> <a id="2038" class="Symbol">=</a> <a id="2040" href="#2118" class="Function">+-zero</a> <a id="2047" href="#2036" class="Bound">b</a>
</pre>
... and we prove the lemma by induction as well:

<pre class="Agda">  <a id="2110" class="Keyword">where</a>
  <a id="2118" href="#2118" class="Function">+-zero</a> <a id="2125" class="Symbol">:</a> <a id="2127" class="Symbol">∀</a> <a id="2129" href="#2129" class="Bound">a</a> <a id="2131" class="Symbol">→</a> <a id="2133" href="#2129" class="Bound">a</a> <a id="2135" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="2137" href="#2129" class="Bound">a</a> <a id="2139" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="2141" class="Number">0</a>
  <a id="2145" href="#2118" class="Function">+-zero</a> <a id="2152" href="/lagda/Agda.Builtin.Nat.html#183" class="InductiveConstructor">zero</a> <a id="2157" class="Symbol">=</a> <a id="2159" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>
  <a id="2166" href="#2118" class="Function">+-zero</a> <a id="2173" class="Symbol">(</a><a id="2174" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2178" href="#2178" class="Bound">a</a><a id="2179" class="Symbol">)</a> <a id="2181" class="Symbol">=</a> <a id="2183" href="#1362" class="Function">cong</a> <a id="2188" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2192" class="Symbol">(</a><a id="2193" href="#2118" class="Function">+-zero</a> <a id="2200" href="#2178" class="Bound">a</a><a id="2201" class="Symbol">)</a>
</pre>
Very small theorems can be proved by induction trivially using
a recursive call as the induction hypothesis and let the `cong`
function to finish the induction step.

Combining induction and our `trans` combinator we get the induction
step of the proof of the plus commutative law:

<pre class="Agda"> <a id="2496" href="#1876" class="Function">+-comm</a> <a id="2503" class="Symbol">(</a><a id="2504" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2508" href="#2508" class="Bound">a</a><a id="2509" class="Symbol">)</a> <a id="2511" href="#2511" class="Bound">b</a> <a id="2513" class="Symbol">=</a> <a id="2515" href="#1241" class="Function">trans</a> <a id="2521" class="Symbol">(</a><a id="2522" href="#1362" class="Function">cong</a> <a id="2527" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2531" class="Symbol">(</a><a id="2532" href="#1876" class="Function">+-comm</a> <a id="2539" href="#2508" class="Bound">a</a> <a id="2541" href="#2511" class="Bound">b</a><a id="2542" class="Symbol">))</a> <a id="2545" class="Symbol">(</a><a id="2546" href="#2567" class="Function">+-suc</a> <a id="2552" href="#2511" class="Bound">b</a> <a id="2554" href="#2508" class="Bound">a</a><a id="2555" class="Symbol">)</a>
  <a id="2559" class="Keyword">where</a>
  <a id="2567" href="#2567" class="Function">+-suc</a> <a id="2573" class="Symbol">:</a> <a id="2575" class="Symbol">∀</a> <a id="2577" href="#2577" class="Bound">a</a> <a id="2579" href="#2579" class="Bound">b</a> <a id="2581" class="Symbol">→</a> <a id="2583" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2587" class="Symbol">(</a><a id="2588" href="#2577" class="Bound">a</a> <a id="2590" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="2592" href="#2579" class="Bound">b</a><a id="2593" class="Symbol">)</a> <a id="2595" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="2597" href="#2577" class="Bound">a</a> <a id="2599" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="2601" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2605" href="#2579" class="Bound">b</a>
  <a id="2609" href="#2567" class="Function">+-suc</a> <a id="2615" href="/lagda/Agda.Builtin.Nat.html#183" class="InductiveConstructor">zero</a> <a id="2620" class="Symbol">_</a> <a id="2622" class="Symbol">=</a> <a id="2624" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>
  <a id="2631" href="#2567" class="Function">+-suc</a> <a id="2637" class="Symbol">(</a><a id="2638" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2642" href="#2642" class="Bound">a</a><a id="2643" class="Symbol">)</a> <a id="2645" href="#2645" class="Bound">b</a> <a id="2647" class="Symbol">=</a> <a id="2649" href="#1362" class="Function">cong</a> <a id="2654" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2658" class="Symbol">(</a><a id="2659" href="#2567" class="Function">+-suc</a> <a id="2665" href="#2642" class="Bound">a</a> <a id="2667" href="#2645" class="Bound">b</a><a id="2668" class="Symbol">)</a>
</pre>
On the other hand, even large theorems such as the plus commutative law
can also be proved without the help of lemmas.

Here's an example, by exploiting the `rewrite` functionality:

<pre class="Agda"> <a id="Intuitionistic.+-comm₁"></a><a id="2863" href="#2863" class="Function">+-comm₁</a> <a id="2871" class="Symbol">:</a> <a id="2873" class="Symbol">∀</a> <a id="2875" href="#2875" class="Bound">n</a> <a id="2877" href="#2877" class="Bound">m</a> <a id="2879" class="Symbol">→</a> <a id="2881" href="#2875" class="Bound">n</a> <a id="2883" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="2885" href="#2877" class="Bound">m</a> <a id="2887" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="2889" href="#2877" class="Bound">m</a> <a id="2891" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="2893" href="#2875" class="Bound">n</a>
 <a id="2896" href="#2863" class="Function">+-comm₁</a> <a id="2904" href="/lagda/Agda.Builtin.Nat.html#183" class="InductiveConstructor">zero</a> <a id="2909" href="/lagda/Agda.Builtin.Nat.html#183" class="InductiveConstructor">zero</a> <a id="2914" class="Symbol">=</a> <a id="2916" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>
 <a id="2922" href="#2863" class="Function">+-comm₁</a> <a id="2930" href="/lagda/Agda.Builtin.Nat.html#183" class="InductiveConstructor">zero</a> <a id="2935" class="Symbol">(</a><a id="2936" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2940" href="#2940" class="Bound">m</a><a id="2941" class="Symbol">)</a> <a id="2943" class="Keyword">rewrite</a> <a id="2951" href="#1311" class="Function">sym</a> <a id="2955" class="Symbol">(</a><a id="2956" href="#2863" class="Function">+-comm₁</a> <a id="2964" href="/lagda/Agda.Builtin.Nat.html#183" class="InductiveConstructor">zero</a> <a id="2969" href="#2940" class="Bound">m</a><a id="2970" class="Symbol">)</a>  <a id="2973" class="Symbol">=</a> <a id="2975" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>
 <a id="2981" href="#2863" class="Function">+-comm₁</a> <a id="2989" class="Symbol">(</a><a id="2990" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="2994" href="#2994" class="Bound">n</a><a id="2995" class="Symbol">)</a> <a id="2997" href="/lagda/Agda.Builtin.Nat.html#183" class="InductiveConstructor">zero</a> <a id="3002" class="Keyword">rewrite</a> <a id="3010" href="#2863" class="Function">+-comm₁</a> <a id="3018" href="#2994" class="Bound">n</a> <a id="3020" href="/lagda/Agda.Builtin.Nat.html#183" class="InductiveConstructor">zero</a> <a id="3025" class="Symbol">=</a> <a id="3027" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>
 <a id="3033" href="#2863" class="Function">+-comm₁</a> <a id="3041" class="Symbol">(</a><a id="3042" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="3046" href="#3046" class="Bound">n</a><a id="3047" class="Symbol">)</a> <a id="3049" class="Symbol">(</a><a id="3050" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="3054" href="#3054" class="Bound">m</a><a id="3055" class="Symbol">)</a> <a id="3057" class="Keyword">rewrite</a> <a id="3065" href="#2863" class="Function">+-comm₁</a> <a id="3073" href="#3046" class="Bound">n</a> <a id="3075" class="Symbol">(</a><a id="3076" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="3080" href="#3054" class="Bound">m</a><a id="3081" class="Symbol">)</a>
  <a id="3085" class="Symbol">|</a> <a id="3087" href="#1311" class="Function">sym</a> <a id="3091" class="Symbol">(</a><a id="3092" href="#2863" class="Function">+-comm₁</a> <a id="3100" class="Symbol">(</a><a id="3101" href="/lagda/Agda.Builtin.Nat.html#196" class="InductiveConstructor">suc</a> <a id="3105" href="#3046" class="Bound">n</a><a id="3106" class="Symbol">)</a> <a id="3108" href="#3054" class="Bound">m</a><a id="3109" class="Symbol">)</a> <a id="3111" class="Symbol">|</a> <a id="3113" href="#2863" class="Function">+-comm₁</a> <a id="3121" href="#3046" class="Bound">n</a> <a id="3123" href="#3054" class="Bound">m</a> <a id="3125" class="Symbol">=</a> <a id="3127" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a>
</pre>
What does `rewrite` do?
Let's look at it in detail.

To prove this theorem, whose goal is `a + c ≡ b + d`,

<pre class="Agda"> <a id="Intuitionistic.step-by-step"></a><a id="3250" href="#3250" class="Function">step-by-step</a> <a id="3263" class="Symbol">:</a> <a id="3265" class="Symbol">∀</a> <a id="3267" class="Symbol">{</a><a id="3268" href="#3268" class="Bound">a</a> <a id="3270" href="#3270" class="Bound">b</a> <a id="3272" href="#3272" class="Bound">c</a> <a id="3274" href="#3274" class="Bound">d</a><a id="3275" class="Symbol">}</a> <a id="3277" class="Symbol">→</a> <a id="3279" href="#3268" class="Bound">a</a> <a id="3281" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="3283" href="#3270" class="Bound">b</a> <a id="3285" class="Symbol">→</a> <a id="3287" href="#3272" class="Bound">c</a> <a id="3289" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="3291" href="#3274" class="Bound">d</a> <a id="3293" class="Symbol">→</a> <a id="3295" href="#3268" class="Bound">a</a> <a id="3297" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="3299" href="#3272" class="Bound">c</a> <a id="3301" href="/lagda/Agda.Builtin.Equality.html#125" class="Datatype Operator">≡</a> <a id="3303" href="#3270" class="Bound">b</a> <a id="3305" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="3307" href="#3274" class="Bound">d</a>
 <a id="3310" href="#3250" class="Function">step-by-step</a> <a id="3323" class="Symbol">{</a><a id="3324" class="Argument">b</a> <a id="3326" class="Symbol">=</a> <a id="3328" href="#3328" class="Bound">b</a><a id="3329" class="Symbol">}</a> <a id="3331" class="Symbol">{</a><a id="3332" class="Argument">d</a> <a id="3334" class="Symbol">=</a> <a id="3336" href="#3336" class="Bound">d</a><a id="3337" class="Symbol">}</a> <a id="3339" href="#3339" class="Bound">p</a> <a id="3341" href="#3341" class="Bound">q</a>
</pre>
we first rewrite with `p`, which turns the goal to `b + c ≡ b + d`,
then rewrite with `q`, which turns the goal to `b + d ≡ b + d`,

<pre class="Agda">  <a id="3487" class="Keyword">rewrite</a> <a id="3495" href="#3339" class="Bound">p</a> <a id="3497" class="Symbol">|</a> <a id="3499" href="#3341" class="Bound">q</a>
</pre>
which is a specialized version of `refl`:

<pre class="Agda">  <a id="3555" class="Symbol">=</a> <a id="3557" href="/lagda/Agda.Builtin.Equality.html#182" class="InductiveConstructor">refl</a> <a id="3562" class="Symbol">{</a><a id="3563" class="Argument">x</a> <a id="3565" class="Symbol">=</a> <a id="3567" href="#3328" class="Bound">b</a> <a id="3569" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="3571" href="#3336" class="Bound">d</a><a id="3572" class="Symbol">}</a>
</pre>
It's like we're destructing our goal step by step and finally turn it into a specialized `refl`.

For more complicated proofs, we're not only destructing the goal -- we're also constructing
terms that can be used to destruct the goal.
`rewrite` is how we *use* the constructed terms to destruct terms.

Our proof is *bidirectional*.

# Cubical model

What if the identity proofs are not trivial?

<pre class="Agda"><a id="3980" class="Keyword">module</a> <a id="Cubical"></a><a id="3987" href="#3987" class="Module">Cubical</a> <a id="3995" class="Keyword">where</a>
 <a id="4002" class="Keyword">open</a> <a id="4007" href="/lagda/Cubical.Core.Everything.html" class="Module">CUTT</a> <a id="4012" class="Keyword">using</a> <a id="4018" class="Symbol">(</a><a id="4019" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">_≡_</a><a id="4022" class="Symbol">;</a> <a id="4024" href="/lagda/Agda.Primitive.Cubical.html#86" class="Datatype">I</a><a id="4025" class="Symbol">;</a> <a id="4027" href="/lagda/Agda.Primitive.Cubical.html#276" class="Primitive">~_</a><a id="4029" class="Symbol">;</a> <a id="4031" href="/lagda/Agda.Primitive.Cubical.html#1352" class="Primitive">hcomp</a><a id="4036" class="Symbol">;</a> <a id="4038" href="/lagda/Agda.Builtin.Cubical.Sub.html#188" class="Postulate">inS</a><a id="4041" class="Symbol">;</a> <a id="4043" href="/lagda/Cubical.Core.Primitives.html#4544" class="Function">hfill</a><a id="4048" class="Symbol">;</a> <a id="4050" href="/lagda/Agda.Primitive.Cubical.html#128" class="InductiveConstructor">i0</a><a id="4052" class="Symbol">;</a> <a id="4054" href="/lagda/Agda.Primitive.Cubical.html#156" class="InductiveConstructor">i1</a><a id="4056" class="Symbol">)</a>
 <a id="4059" class="Keyword">open</a> <a id="4064" href="/lagda/Cubical.Data.Nat.html" class="Module">CNat</a>
</pre>
In the Cubical model, there's no pattern matching because you can never tell
how many proofs there can be (so no case analysis).
Instead, there are interval operations that can construct proofs via existing proofs
in a more detailed way.

Inverting an interval is `sym`:

<pre class="Agda"> <a id="Cubical.sym"></a><a id="4351" href="#4351" class="Function">sym</a> <a id="4355" class="Symbol">:</a> <a id="4357" class="Symbol">{</a><a id="4358" href="#4358" class="Bound">a</a> <a id="4360" href="#4360" class="Bound">b</a> <a id="4362" class="Symbol">:</a> <a id="4364" href="#402" class="Generalizable">A</a><a id="4365" class="Symbol">}</a> <a id="4367" class="Symbol">→</a> <a id="4369" href="#4358" class="Bound">a</a> <a id="4371" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="4373" href="#4360" class="Bound">b</a> <a id="4375" class="Symbol">→</a> <a id="4377" href="#4360" class="Bound">b</a> <a id="4379" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="4381" href="#4358" class="Bound">a</a>
 <a id="4384" href="#4351" class="Function">sym</a> <a id="4388" href="#4388" class="Bound">p</a> <a id="4390" href="#4390" class="Bound">i</a> <a id="4392" class="Symbol">=</a> <a id="4394" href="#4388" class="Bound">p</a> <a id="4396" class="Symbol">(</a><a id="4397" href="/lagda/Agda.Primitive.Cubical.html#276" class="Primitive Operator">~</a> <a id="4399" href="#4390" class="Bound">i</a><a id="4400" class="Symbol">)</a>
</pre>
Creating a new interval by combining an old path with an arbitrary function
is `cong`:

<pre class="Agda"> <a id="Cubical.cong"></a><a id="4500" href="#4500" class="Function">cong</a> <a id="4505" class="Symbol">:</a> <a id="4507" class="Symbol">{</a><a id="4508" href="#4508" class="Bound">a</a> <a id="4510" href="#4510" class="Bound">b</a> <a id="4512" class="Symbol">:</a> <a id="4514" href="#402" class="Generalizable">A</a><a id="4515" class="Symbol">}</a> <a id="4517" class="Symbol">(</a><a id="4518" href="#4518" class="Bound">f</a> <a id="4520" class="Symbol">:</a> <a id="4522" href="#402" class="Generalizable">A</a> <a id="4524" class="Symbol">→</a> <a id="4526" href="#404" class="Generalizable">B</a><a id="4527" class="Symbol">)</a> <a id="4529" class="Symbol">→</a> <a id="4531" href="#4508" class="Bound">a</a> <a id="4533" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="4535" href="#4510" class="Bound">b</a> <a id="4537" class="Symbol">→</a> <a id="4539" href="#4518" class="Bound">f</a> <a id="4541" href="#4508" class="Bound">a</a> <a id="4543" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="4545" href="#4518" class="Bound">f</a> <a id="4547" href="#4510" class="Bound">b</a>
 <a id="4550" href="#4500" class="Function">cong</a> <a id="4555" href="#4555" class="Bound">f</a> <a id="4557" href="#4557" class="Bound">p</a> <a id="4559" href="#4559" class="Bound">i</a> <a id="4561" class="Symbol">=</a> <a id="4563" href="#4555" class="Bound">f</a> <a id="4565" class="Symbol">(</a><a id="4566" href="#4557" class="Bound">p</a> <a id="4568" href="#4559" class="Bound">i</a><a id="4569" class="Symbol">)</a>
</pre>
`trans` is far more complicated -- you'll need cubical kan operation:

<pre class="Agda"> <a id="Cubical.trans"></a><a id="4652" href="#4652" class="Function">trans</a> <a id="4658" class="Symbol">:</a> <a id="4660" class="Symbol">{</a><a id="4661" href="#4661" class="Bound">a</a> <a id="4663" href="#4663" class="Bound">b</a> <a id="4665" href="#4665" class="Bound">c</a> <a id="4667" class="Symbol">:</a> <a id="4669" href="#402" class="Generalizable">A</a><a id="4670" class="Symbol">}</a> <a id="4672" class="Symbol">→</a> <a id="4674" href="#4661" class="Bound">a</a> <a id="4676" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="4678" href="#4663" class="Bound">b</a> <a id="4680" class="Symbol">→</a> <a id="4682" href="#4663" class="Bound">b</a> <a id="4684" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="4686" href="#4665" class="Bound">c</a> <a id="4688" class="Symbol">→</a> <a id="4690" href="#4661" class="Bound">a</a> <a id="4692" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="4694" href="#4665" class="Bound">c</a>
 <a id="4697" href="#4652" class="Function">trans</a> <a id="4703" href="#4703" class="Bound">p</a> <a id="4705" href="#4705" class="Bound">q</a> <a id="4707" href="#4707" class="Bound">i</a> <a id="4709" class="Symbol">=</a> <a id="4711" href="/lagda/Cubical.Core.Primitives.html#4544" class="Function">hfill</a> <a id="4717" class="Symbol">(λ</a> <a id="4720" class="Symbol">{</a> <a id="4722" href="#4722" class="Bound">j</a> <a id="4724" class="Symbol">(</a><a id="4725" href="#4707" class="Bound">i</a> <a id="4727" class="Symbol">=</a> <a id="4729" href="/lagda/Agda.Primitive.Cubical.html#128" class="InductiveConstructor">i0</a><a id="4731" class="Symbol">)</a> <a id="4733" class="Symbol">→</a> <a id="4735" href="#4703" class="Bound">p</a> <a id="4737" href="#4707" class="Bound">i</a><a id="4738" class="Symbol">;</a> <a id="4740" href="#4740" class="Bound">j</a> <a id="4742" class="Symbol">(</a><a id="4743" href="#4707" class="Bound">i</a> <a id="4745" class="Symbol">=</a> <a id="4747" href="/lagda/Agda.Primitive.Cubical.html#156" class="InductiveConstructor">i1</a><a id="4749" class="Symbol">)</a> <a id="4751" class="Symbol">→</a> <a id="4753" href="#4705" class="Bound">q</a> <a id="4755" href="#4740" class="Bound">j</a><a id="4756" class="Symbol">})</a> <a id="4759" class="Symbol">(</a><a id="4760" href="/lagda/Agda.Builtin.Cubical.Sub.html#188" class="Postulate">inS</a> <a id="4764" class="Symbol">(</a><a id="4765" href="#4703" class="Bound">p</a> <a id="4767" href="#4707" class="Bound">i</a><a id="4768" class="Symbol">))</a> <a id="4771" href="#4707" class="Bound">i</a>
</pre>
Although we lose the ability to `rewrite`, we still have our combinators -- `sym`, `cong` and `trans`,
which means that several existing proofs are still perfectly valid under the Cubical model.

On the other hand, according to the design of `Path` types, some proofs become perfectly
natural. For instance, the `step-by-step` theorem shown above can be proved by:

<pre class="Agda"> <a id="Cubical.step-by-step"></a><a id="5149" href="#5149" class="Function">step-by-step</a> <a id="5162" class="Symbol">:</a> <a id="5164" class="Symbol">∀</a> <a id="5166" class="Symbol">{</a><a id="5167" href="#5167" class="Bound">a</a> <a id="5169" href="#5169" class="Bound">b</a> <a id="5171" href="#5171" class="Bound">c</a> <a id="5173" href="#5173" class="Bound">d</a><a id="5174" class="Symbol">}</a> <a id="5176" class="Symbol">→</a> <a id="5178" href="#5167" class="Bound">a</a> <a id="5180" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="5182" href="#5169" class="Bound">b</a> <a id="5184" class="Symbol">→</a> <a id="5186" href="#5171" class="Bound">c</a> <a id="5188" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="5190" href="#5173" class="Bound">d</a> <a id="5192" class="Symbol">→</a> <a id="5194" href="#5167" class="Bound">a</a> <a id="5196" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="5198" href="#5171" class="Bound">c</a> <a id="5200" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="5202" href="#5169" class="Bound">b</a> <a id="5204" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="5206" href="#5173" class="Bound">d</a>
 <a id="5209" href="#5149" class="Function">step-by-step</a> <a id="5222" href="#5222" class="Bound">p</a> <a id="5224" href="#5224" class="Bound">q</a> <a id="5226" href="#5226" class="Bound">i</a> <a id="5228" class="Symbol">=</a> <a id="5230" href="#5222" class="Bound">p</a> <a id="5232" href="#5226" class="Bound">i</a> <a id="5234" href="/lagda/Agda.Builtin.Nat.html#298" class="Primitive Operator">+</a> <a id="5236" href="#5224" class="Bound">q</a> <a id="5238" href="#5226" class="Bound">i</a>
</pre>
There can also be equality on functions, which is not even possible in the
Intuitionistic type theory:

<pre class="Agda"> <a id="Cubical.funExt"></a><a id="5354" href="#5354" class="Function">funExt</a> <a id="5361" class="Symbol">:</a> <a id="5363" class="Symbol">{</a><a id="5364" href="#5364" class="Bound">f</a> <a id="5366" href="#5366" class="Bound">g</a> <a id="5368" class="Symbol">:</a> <a id="5370" href="#402" class="Generalizable">A</a> <a id="5372" class="Symbol">→</a> <a id="5374" href="#404" class="Generalizable">B</a><a id="5375" class="Symbol">}</a> <a id="5377" class="Symbol">→</a> <a id="5379" class="Symbol">(∀</a> <a id="5382" href="#5382" class="Bound">x</a> <a id="5384" class="Symbol">→</a> <a id="5386" href="#5364" class="Bound">f</a> <a id="5388" href="#5382" class="Bound">x</a> <a id="5390" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="5392" href="#5366" class="Bound">g</a> <a id="5394" href="#5382" class="Bound">x</a><a id="5395" class="Symbol">)</a> <a id="5397" class="Symbol">→</a> <a id="5399" href="#5364" class="Bound">f</a> <a id="5401" href="/lagda/Agda.Builtin.Cubical.Path.html#353" class="Function Operator">≡</a> <a id="5403" href="#5366" class="Bound">g</a>
 <a id="5406" href="#5354" class="Function">funExt</a> <a id="5413" href="#5413" class="Bound">p</a> <a id="5415" href="#5415" class="Bound">i</a> <a id="5417" href="#5417" class="Bound">a</a> <a id="5419" class="Symbol">=</a> <a id="5421" href="#5413" class="Bound">p</a> <a id="5423" href="#5417" class="Bound">a</a> <a id="5425" href="#5415" class="Bound">i</a>
</pre>
# Obvious Conclusions

+ The Cubical model introduces tons of primitives while it's fairly more powerful
  than the Intuitionistic type theory
+ Cubical model is harder implementation-wise
+ Intuitionistic type theory is more friendly for letting the compiler to solve some
  unification problems
+ Both of these two models are not gonna save Agda
