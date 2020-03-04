---
layout: post
title: Different styles of equality reasoning
category: PLT
tags: PLT Agda
keywords: PLT
agda: true
description: Different styles of equality reasoning
---

<pre class="Agda"><a id="179" class="Symbol">{-#</a> <a id="183" class="Keyword">OPTIONS</a> <a id="191" class="Pragma">--cubical</a> <a id="201" class="Pragma">--safe</a> <a id="208" class="Symbol">#-}</a>
<a id="212" class="Keyword">module</a> <a id="219" href="" class="Module">2019-4-21-CuttMltt</a> <a id="238" class="Keyword">where</a>
<a id="244" class="Keyword">import</a> <a id="251" href="/lagda/Agda.Builtin.Equality.html" class="Module">Agda.Builtin.Equality</a> <a id="273" class="Symbol">as</a> <a id="276" class="Module">MLTT</a>
<a id="281" class="Keyword">import</a> <a id="288" href="/lagda/Cubical.Core.Everything.html" class="Module">Cubical.Core.Everything</a> <a id="312" class="Symbol">as</a> <a id="315" class="Module">CUTT</a>
<a id="320" class="Keyword">import</a> <a id="327" href="/lagda/Agda.Builtin.Nat.html" class="Module">Agda.Builtin.Nat</a> <a id="344" class="Symbol">as</a> <a id="347" class="Module">MNat</a>
<a id="352" class="Keyword">import</a> <a id="359" href="/lagda/Cubical.Data.Nat.html" class="Module">Cubical.Data.Nat</a> <a id="376" class="Symbol">as</a> <a id="379" class="Module">CNat</a>
<a id="384" class="Keyword">private</a> <a id="392" class="Keyword">variable</a> <a id="401" href="#401" class="Generalizable">A</a> <a id="403" href="#403" class="Generalizable">B</a> <a id="405" class="Symbol">:</a> <a id="407" class="PrimitiveType">Set</a>
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

<pre class="Agda"><a id="1025" class="Keyword">module</a> <a id="Intuitionistic"></a><a id="1032" href="#1032" class="Module">Intuitionistic</a> <a id="1047" class="Keyword">where</a>
 <a id="1054" class="Keyword">open</a> <a id="1059" href="/lagda/Agda.Builtin.Equality.html" class="Module">MLTT</a>
 <a id="1065" class="Keyword">open</a> <a id="1070" href="/lagda/Agda.Builtin.Nat.html" class="Module">MNat</a>
</pre>
In Intuitionistic Logic, we can prove new theorems via pattern matching on existing theorems,
because identity proofs are instances of the equality type:

<pre class="Agda"> <a id="Intuitionistic.trans"></a><a id="1240" href="#1240" class="Function">trans</a> <a id="1246" class="Symbol">:</a> <a id="1248" class="Symbol">{</a><a id="1249" href="#1249" class="Bound">a</a> <a id="1251" href="#1251" class="Bound">b</a> <a id="1253" href="#1253" class="Bound">c</a> <a id="1255" class="Symbol">:</a> <a id="1257" href="#401" class="Generalizable">A</a><a id="1258" class="Symbol">}</a> <a id="1260" class="Symbol">→</a> <a id="1262" href="#1249" class="Bound">a</a> <a id="1264" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1266" href="#1251" class="Bound">b</a> <a id="1268" class="Symbol">→</a> <a id="1270" href="#1251" class="Bound">b</a> <a id="1272" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1274" href="#1253" class="Bound">c</a> <a id="1276" class="Symbol">→</a> <a id="1278" href="#1249" class="Bound">a</a> <a id="1280" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1282" href="#1253" class="Bound">c</a>
 <a id="1285" href="#1240" class="Function">trans</a> <a id="1291" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a> <a id="1296" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a> <a id="1301" class="Symbol">=</a> <a id="1303" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>

 <a id="Intuitionistic.sym"></a><a id="1310" href="#1310" class="Function">sym</a> <a id="1314" class="Symbol">:</a> <a id="1316" class="Symbol">{</a><a id="1317" href="#1317" class="Bound">a</a> <a id="1319" href="#1319" class="Bound">b</a> <a id="1321" class="Symbol">:</a> <a id="1323" href="#401" class="Generalizable">A</a><a id="1324" class="Symbol">}</a> <a id="1326" class="Symbol">→</a> <a id="1328" href="#1317" class="Bound">a</a> <a id="1330" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1332" href="#1319" class="Bound">b</a> <a id="1334" class="Symbol">→</a> <a id="1336" href="#1319" class="Bound">b</a> <a id="1338" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1340" href="#1317" class="Bound">a</a>
 <a id="1343" href="#1310" class="Function">sym</a> <a id="1347" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a> <a id="1352" class="Symbol">=</a> <a id="1354" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>

 <a id="Intuitionistic.cong"></a><a id="1361" href="#1361" class="Function">cong</a> <a id="1366" class="Symbol">:</a> <a id="1368" class="Symbol">{</a><a id="1369" href="#1369" class="Bound">a</a> <a id="1371" href="#1371" class="Bound">b</a> <a id="1373" class="Symbol">:</a> <a id="1375" href="#401" class="Generalizable">A</a><a id="1376" class="Symbol">}</a> <a id="1378" class="Symbol">→</a> <a id="1380" class="Symbol">(</a><a id="1381" href="#1381" class="Bound">f</a> <a id="1383" class="Symbol">:</a> <a id="1385" href="#401" class="Generalizable">A</a> <a id="1387" class="Symbol">→</a> <a id="1389" href="#403" class="Generalizable">B</a><a id="1390" class="Symbol">)</a> <a id="1392" class="Symbol">→</a> <a id="1394" href="#1369" class="Bound">a</a> <a id="1396" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1398" href="#1371" class="Bound">b</a> <a id="1400" class="Symbol">→</a> <a id="1402" href="#1381" class="Bound">f</a> <a id="1404" href="#1369" class="Bound">a</a> <a id="1406" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1408" href="#1381" class="Bound">f</a> <a id="1410" href="#1371" class="Bound">b</a>
 <a id="1413" href="#1361" class="Function">cong</a> <a id="1418" class="Symbol">_</a> <a id="1420" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a> <a id="1425" class="Symbol">=</a> <a id="1427" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>
</pre>
or we can use `rewrite`, which is syntactic sugar of pattern matching
(and this definition is more Idris style):

<pre class="Agda"> <a id="Intuitionistic.trans₁"></a><a id="1556" href="#1556" class="Function">trans₁</a> <a id="1563" class="Symbol">:</a> <a id="1565" class="Symbol">{</a><a id="1566" href="#1566" class="Bound">a</a> <a id="1568" href="#1568" class="Bound">b</a> <a id="1570" href="#1570" class="Bound">c</a> <a id="1572" class="Symbol">:</a> <a id="1574" href="#401" class="Generalizable">A</a><a id="1575" class="Symbol">}</a> <a id="1577" class="Symbol">→</a> <a id="1579" href="#1566" class="Bound">a</a> <a id="1581" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1583" href="#1568" class="Bound">b</a> <a id="1585" class="Symbol">→</a> <a id="1587" href="#1568" class="Bound">b</a> <a id="1589" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1591" href="#1570" class="Bound">c</a> <a id="1593" class="Symbol">→</a> <a id="1595" href="#1566" class="Bound">a</a> <a id="1597" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1599" href="#1570" class="Bound">c</a>
 <a id="1602" href="#1556" class="Function">trans₁</a> <a id="1609" href="#1609" class="Bound">p</a> <a id="1611" href="#1611" class="Bound">q</a> <a id="1613" class="Keyword">rewrite</a> <a id="1621" href="#1609" class="Bound">p</a> <a id="1623" class="Symbol">=</a> <a id="1625" href="#1611" class="Bound">q</a>

 <a id="Intuitionistic.cong₁"></a><a id="1629" href="#1629" class="Function">cong₁</a> <a id="1635" class="Symbol">:</a> <a id="1637" class="Symbol">{</a><a id="1638" href="#1638" class="Bound">a</a> <a id="1640" href="#1640" class="Bound">b</a> <a id="1642" class="Symbol">:</a> <a id="1644" href="#401" class="Generalizable">A</a><a id="1645" class="Symbol">}</a> <a id="1647" class="Symbol">→</a> <a id="1649" class="Symbol">(</a><a id="1650" href="#1650" class="Bound">f</a> <a id="1652" class="Symbol">:</a> <a id="1654" href="#401" class="Generalizable">A</a> <a id="1656" class="Symbol">→</a> <a id="1658" href="#403" class="Generalizable">B</a><a id="1659" class="Symbol">)</a> <a id="1661" class="Symbol">→</a> <a id="1663" href="#1638" class="Bound">a</a> <a id="1665" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1667" href="#1640" class="Bound">b</a> <a id="1669" class="Symbol">→</a> <a id="1671" href="#1650" class="Bound">f</a> <a id="1673" href="#1638" class="Bound">a</a> <a id="1675" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1677" href="#1650" class="Bound">f</a> <a id="1679" href="#1640" class="Bound">b</a>
 <a id="1682" href="#1629" class="Function">cong₁</a> <a id="1688" class="Symbol">_</a> <a id="1690" href="#1690" class="Bound">p</a> <a id="1692" class="Keyword">rewrite</a> <a id="1700" href="#1690" class="Bound">p</a> <a id="1702" class="Symbol">=</a> <a id="1704" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>
</pre>
These three functions, `trans`, `sym` and `cong` are our equality proof
combinators.

Larger and more concrete theorems, such as the plus commutative law:

<pre class="Agda"> <a id="Intuitionistic.+-comm"></a><a id="1875" href="#1875" class="Function">+-comm</a> <a id="1882" class="Symbol">:</a> <a id="1884" class="Symbol">∀</a> <a id="1886" href="#1886" class="Bound">a</a> <a id="1888" href="#1888" class="Bound">b</a> <a id="1890" class="Symbol">→</a> <a id="1892" href="#1886" class="Bound">a</a> <a id="1894" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="1896" href="#1888" class="Bound">b</a> <a id="1898" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1900" href="#1888" class="Bound">b</a> <a id="1902" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="1904" href="#1886" class="Bound">a</a>
</pre>
can be proved by induction -- the base case is simply `a ≡ a + 0`,
where we can introduce a lemma for it:

<pre class="Agda"> <a id="2023" href="#1875" class="Function">+-comm</a> <a id="2030" href="/lagda/Agda.Builtin.Nat.html#210" class="InductiveConstructor">zero</a> <a id="2035" href="#2035" class="Bound">b</a> <a id="2037" class="Symbol">=</a> <a id="2039" href="#2117" class="Function">+-zero</a> <a id="2046" href="#2035" class="Bound">b</a>
</pre>
... and we prove the lemma by induction as well:

<pre class="Agda">  <a id="2109" class="Keyword">where</a>
  <a id="2117" href="#2117" class="Function">+-zero</a> <a id="2124" class="Symbol">:</a> <a id="2126" class="Symbol">∀</a> <a id="2128" href="#2128" class="Bound">a</a> <a id="2130" class="Symbol">→</a> <a id="2132" href="#2128" class="Bound">a</a> <a id="2134" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="2136" href="#2128" class="Bound">a</a> <a id="2138" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="2140" class="Number">0</a>
  <a id="2144" href="#2117" class="Function">+-zero</a> <a id="2151" href="/lagda/Agda.Builtin.Nat.html#210" class="InductiveConstructor">zero</a> <a id="2156" class="Symbol">=</a> <a id="2158" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>
  <a id="2165" href="#2117" class="Function">+-zero</a> <a id="2172" class="Symbol">(</a><a id="2173" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2177" href="#2177" class="Bound">a</a><a id="2178" class="Symbol">)</a> <a id="2180" class="Symbol">=</a> <a id="2182" href="#1361" class="Function">cong</a> <a id="2187" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2191" class="Symbol">(</a><a id="2192" href="#2117" class="Function">+-zero</a> <a id="2199" href="#2177" class="Bound">a</a><a id="2200" class="Symbol">)</a>
</pre>
Very small theorems can be proved by induction trivially using
a recursive call as the induction hypothesis and let the `cong`
function to finish the induction step.

Combining induction and our `trans` combinator we get the induction
step of the proof of the plus commutative law:

<pre class="Agda"> <a id="2495" href="#1875" class="Function">+-comm</a> <a id="2502" class="Symbol">(</a><a id="2503" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2507" href="#2507" class="Bound">a</a><a id="2508" class="Symbol">)</a> <a id="2510" href="#2510" class="Bound">b</a> <a id="2512" class="Symbol">=</a> <a id="2514" href="#1240" class="Function">trans</a> <a id="2520" class="Symbol">(</a><a id="2521" href="#1361" class="Function">cong</a> <a id="2526" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2530" class="Symbol">(</a><a id="2531" href="#1875" class="Function">+-comm</a> <a id="2538" href="#2507" class="Bound">a</a> <a id="2540" href="#2510" class="Bound">b</a><a id="2541" class="Symbol">))</a> <a id="2544" class="Symbol">(</a><a id="2545" href="#2566" class="Function">+-suc</a> <a id="2551" href="#2510" class="Bound">b</a> <a id="2553" href="#2507" class="Bound">a</a><a id="2554" class="Symbol">)</a>
  <a id="2558" class="Keyword">where</a>
  <a id="2566" href="#2566" class="Function">+-suc</a> <a id="2572" class="Symbol">:</a> <a id="2574" class="Symbol">∀</a> <a id="2576" href="#2576" class="Bound">a</a> <a id="2578" href="#2578" class="Bound">b</a> <a id="2580" class="Symbol">→</a> <a id="2582" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2586" class="Symbol">(</a><a id="2587" href="#2576" class="Bound">a</a> <a id="2589" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="2591" href="#2578" class="Bound">b</a><a id="2592" class="Symbol">)</a> <a id="2594" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="2596" href="#2576" class="Bound">a</a> <a id="2598" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="2600" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2604" href="#2578" class="Bound">b</a>
  <a id="2608" href="#2566" class="Function">+-suc</a> <a id="2614" href="/lagda/Agda.Builtin.Nat.html#210" class="InductiveConstructor">zero</a> <a id="2619" class="Symbol">_</a> <a id="2621" class="Symbol">=</a> <a id="2623" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>
  <a id="2630" href="#2566" class="Function">+-suc</a> <a id="2636" class="Symbol">(</a><a id="2637" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2641" href="#2641" class="Bound">a</a><a id="2642" class="Symbol">)</a> <a id="2644" href="#2644" class="Bound">b</a> <a id="2646" class="Symbol">=</a> <a id="2648" href="#1361" class="Function">cong</a> <a id="2653" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2657" class="Symbol">(</a><a id="2658" href="#2566" class="Function">+-suc</a> <a id="2664" href="#2641" class="Bound">a</a> <a id="2666" href="#2644" class="Bound">b</a><a id="2667" class="Symbol">)</a>
</pre>
On the other hand, even large theorems such as the plus commutative law
can also be proved without the help of lemmas.

Here's an example, by exploiting the `rewrite` functionality:

<pre class="Agda"> <a id="Intuitionistic.+-comm₁"></a><a id="2862" href="#2862" class="Function">+-comm₁</a> <a id="2870" class="Symbol">:</a> <a id="2872" class="Symbol">∀</a> <a id="2874" href="#2874" class="Bound">n</a> <a id="2876" href="#2876" class="Bound">m</a> <a id="2878" class="Symbol">→</a> <a id="2880" href="#2874" class="Bound">n</a> <a id="2882" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="2884" href="#2876" class="Bound">m</a> <a id="2886" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="2888" href="#2876" class="Bound">m</a> <a id="2890" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="2892" href="#2874" class="Bound">n</a>
 <a id="2895" href="#2862" class="Function">+-comm₁</a> <a id="2903" href="/lagda/Agda.Builtin.Nat.html#210" class="InductiveConstructor">zero</a> <a id="2908" href="/lagda/Agda.Builtin.Nat.html#210" class="InductiveConstructor">zero</a> <a id="2913" class="Symbol">=</a> <a id="2915" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>
 <a id="2921" href="#2862" class="Function">+-comm₁</a> <a id="2929" href="/lagda/Agda.Builtin.Nat.html#210" class="InductiveConstructor">zero</a> <a id="2934" class="Symbol">(</a><a id="2935" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2939" href="#2939" class="Bound">m</a><a id="2940" class="Symbol">)</a> <a id="2942" class="Keyword">rewrite</a> <a id="2950" href="#1310" class="Function">sym</a> <a id="2954" class="Symbol">(</a><a id="2955" href="#2862" class="Function">+-comm₁</a> <a id="2963" href="/lagda/Agda.Builtin.Nat.html#210" class="InductiveConstructor">zero</a> <a id="2968" href="#2939" class="Bound">m</a><a id="2969" class="Symbol">)</a>  <a id="2972" class="Symbol">=</a> <a id="2974" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>
 <a id="2980" href="#2862" class="Function">+-comm₁</a> <a id="2988" class="Symbol">(</a><a id="2989" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="2993" href="#2993" class="Bound">n</a><a id="2994" class="Symbol">)</a> <a id="2996" href="/lagda/Agda.Builtin.Nat.html#210" class="InductiveConstructor">zero</a> <a id="3001" class="Keyword">rewrite</a> <a id="3009" href="#2862" class="Function">+-comm₁</a> <a id="3017" href="#2993" class="Bound">n</a> <a id="3019" href="/lagda/Agda.Builtin.Nat.html#210" class="InductiveConstructor">zero</a> <a id="3024" class="Symbol">=</a> <a id="3026" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>
 <a id="3032" href="#2862" class="Function">+-comm₁</a> <a id="3040" class="Symbol">(</a><a id="3041" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="3045" href="#3045" class="Bound">n</a><a id="3046" class="Symbol">)</a> <a id="3048" class="Symbol">(</a><a id="3049" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="3053" href="#3053" class="Bound">m</a><a id="3054" class="Symbol">)</a> <a id="3056" class="Keyword">rewrite</a> <a id="3064" href="#2862" class="Function">+-comm₁</a> <a id="3072" href="#3045" class="Bound">n</a> <a id="3074" class="Symbol">(</a><a id="3075" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="3079" href="#3053" class="Bound">m</a><a id="3080" class="Symbol">)</a>
  <a id="3084" class="Symbol">|</a> <a id="3086" href="#1310" class="Function">sym</a> <a id="3090" class="Symbol">(</a><a id="3091" href="#2862" class="Function">+-comm₁</a> <a id="3099" class="Symbol">(</a><a id="3100" href="/lagda/Agda.Builtin.Nat.html#223" class="InductiveConstructor">suc</a> <a id="3104" href="#3045" class="Bound">n</a><a id="3105" class="Symbol">)</a> <a id="3107" href="#3053" class="Bound">m</a><a id="3108" class="Symbol">)</a> <a id="3110" class="Symbol">|</a> <a id="3112" href="#2862" class="Function">+-comm₁</a> <a id="3120" href="#3045" class="Bound">n</a> <a id="3122" href="#3053" class="Bound">m</a> <a id="3124" class="Symbol">=</a> <a id="3126" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a>
</pre>
What does `rewrite` do?
Let's look at it in detail.

To prove this theorem, whose goal is `a + c ≡ b + d`,

<pre class="Agda"> <a id="Intuitionistic.step-by-step"></a><a id="3249" href="#3249" class="Function">step-by-step</a> <a id="3262" class="Symbol">:</a> <a id="3264" class="Symbol">∀</a> <a id="3266" class="Symbol">{</a><a id="3267" href="#3267" class="Bound">a</a> <a id="3269" href="#3269" class="Bound">b</a> <a id="3271" href="#3271" class="Bound">c</a> <a id="3273" href="#3273" class="Bound">d</a><a id="3274" class="Symbol">}</a> <a id="3276" class="Symbol">→</a> <a id="3278" href="#3267" class="Bound">a</a> <a id="3280" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="3282" href="#3269" class="Bound">b</a> <a id="3284" class="Symbol">→</a> <a id="3286" href="#3271" class="Bound">c</a> <a id="3288" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="3290" href="#3273" class="Bound">d</a> <a id="3292" class="Symbol">→</a> <a id="3294" href="#3267" class="Bound">a</a> <a id="3296" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="3298" href="#3271" class="Bound">c</a> <a id="3300" href="/lagda/Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="3302" href="#3269" class="Bound">b</a> <a id="3304" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="3306" href="#3273" class="Bound">d</a>
 <a id="3309" href="#3249" class="Function">step-by-step</a> <a id="3322" class="Symbol">{</a><a id="3323" class="Argument">b</a> <a id="3325" class="Symbol">=</a> <a id="3327" href="#3327" class="Bound">b</a><a id="3328" class="Symbol">}</a> <a id="3330" class="Symbol">{</a><a id="3331" class="Argument">d</a> <a id="3333" class="Symbol">=</a> <a id="3335" href="#3335" class="Bound">d</a><a id="3336" class="Symbol">}</a> <a id="3338" href="#3338" class="Bound">p</a> <a id="3340" href="#3340" class="Bound">q</a>
</pre>
we first rewrite with `p`, which turns the goal to `b + c ≡ b + d`,
then rewrite with `q`, which turns the goal to `b + d ≡ b + d`,

<pre class="Agda">  <a id="3486" class="Keyword">rewrite</a> <a id="3494" href="#3338" class="Bound">p</a> <a id="3496" class="Symbol">|</a> <a id="3498" href="#3340" class="Bound">q</a>
</pre>
which is a specialized version of `refl`:

<pre class="Agda">  <a id="3554" class="Symbol">=</a> <a id="3556" href="/lagda/Agda.Builtin.Equality.html#208" class="InductiveConstructor">refl</a> <a id="3561" class="Symbol">{</a><a id="3562" class="Argument">x</a> <a id="3564" class="Symbol">=</a> <a id="3566" href="#3327" class="Bound">b</a> <a id="3568" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="3570" href="#3335" class="Bound">d</a><a id="3571" class="Symbol">}</a>
</pre>
It's like we're destructing our goal step by step and finally turn it into a specialized `refl`.

For more complicated proofs, we're not only destructing the goal -- we're also constructing
terms that can be used to destruct the goal.
`rewrite` is how we *use* the constructed terms to destruct terms.

Our proof is *bidirectional*.

# Cubical model

What if the identity proofs are not trivial?

<pre class="Agda"><a id="3979" class="Keyword">module</a> <a id="Cubical"></a><a id="3986" href="#3986" class="Module">Cubical</a> <a id="3994" class="Keyword">where</a>
 <a id="4001" class="Keyword">open</a> <a id="4006" href="/lagda/Cubical.Core.Everything.html" class="Module">CUTT</a> <a id="4011" class="Keyword">using</a> <a id="4017" class="Symbol">(</a><a id="4018" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">_≡_</a><a id="4021" class="Symbol">;</a> <a id="4023" href="/lagda/Agda.Primitive.Cubical.html#101" class="Datatype">I</a><a id="4024" class="Symbol">;</a> <a id="4026" href="/lagda/Cubical.Core.Primitives.html#549" class="Primitive">~_</a><a id="4028" class="Symbol">;</a> <a id="4030" href="/lagda/Cubical.Core.Primitives.html#667" class="Primitive">hcomp</a><a id="4035" class="Symbol">;</a> <a id="4037" href="/lagda/Agda.Builtin.Cubical.Sub.html#216" class="Postulate">inS</a><a id="4040" class="Symbol">;</a> <a id="4042" href="/lagda/Cubical.Core.Primitives.html#4544" class="Function">hfill</a><a id="4047" class="Symbol">;</a> <a id="4049" href="/lagda/Agda.Primitive.Cubical.html#143" class="InductiveConstructor">i0</a><a id="4051" class="Symbol">;</a> <a id="4053" href="/lagda/Agda.Primitive.Cubical.html#171" class="InductiveConstructor">i1</a><a id="4055" class="Symbol">)</a>
 <a id="4058" class="Keyword">open</a> <a id="4063" href="/lagda/Cubical.Data.Nat.html" class="Module">CNat</a>
</pre>
In the Cubical model, there's no pattern matching because you can never tell
how many proofs there can be (so no case analysis).
Instead, there are interval operations that can construct proofs via existing proofs
in a more detailed way.

Inverting an interval is `sym`:

<pre class="Agda"> <a id="Cubical.sym"></a><a id="4350" href="#4350" class="Function">sym</a> <a id="4354" class="Symbol">:</a> <a id="4356" class="Symbol">{</a><a id="4357" href="#4357" class="Bound">a</a> <a id="4359" href="#4359" class="Bound">b</a> <a id="4361" class="Symbol">:</a> <a id="4363" href="#401" class="Generalizable">A</a><a id="4364" class="Symbol">}</a> <a id="4366" class="Symbol">→</a> <a id="4368" href="#4357" class="Bound">a</a> <a id="4370" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="4372" href="#4359" class="Bound">b</a> <a id="4374" class="Symbol">→</a> <a id="4376" href="#4359" class="Bound">b</a> <a id="4378" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="4380" href="#4357" class="Bound">a</a>
 <a id="4383" href="#4350" class="Function">sym</a> <a id="4387" href="#4387" class="Bound">p</a> <a id="4389" href="#4389" class="Bound">i</a> <a id="4391" class="Symbol">=</a> <a id="4393" href="#4387" class="Bound">p</a> <a id="4395" class="Symbol">(</a><a id="4396" href="/lagda/Cubical.Core.Primitives.html#549" class="Primitive Operator">~</a> <a id="4398" href="#4389" class="Bound">i</a><a id="4399" class="Symbol">)</a>
</pre>
Creating a new interval by combining an old path with an arbitrary function
is `cong`:

<pre class="Agda"> <a id="Cubical.cong"></a><a id="4499" href="#4499" class="Function">cong</a> <a id="4504" class="Symbol">:</a> <a id="4506" class="Symbol">{</a><a id="4507" href="#4507" class="Bound">a</a> <a id="4509" href="#4509" class="Bound">b</a> <a id="4511" class="Symbol">:</a> <a id="4513" href="#401" class="Generalizable">A</a><a id="4514" class="Symbol">}</a> <a id="4516" class="Symbol">(</a><a id="4517" href="#4517" class="Bound">f</a> <a id="4519" class="Symbol">:</a> <a id="4521" href="#401" class="Generalizable">A</a> <a id="4523" class="Symbol">→</a> <a id="4525" href="#403" class="Generalizable">B</a><a id="4526" class="Symbol">)</a> <a id="4528" class="Symbol">→</a> <a id="4530" href="#4507" class="Bound">a</a> <a id="4532" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="4534" href="#4509" class="Bound">b</a> <a id="4536" class="Symbol">→</a> <a id="4538" href="#4517" class="Bound">f</a> <a id="4540" href="#4507" class="Bound">a</a> <a id="4542" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="4544" href="#4517" class="Bound">f</a> <a id="4546" href="#4509" class="Bound">b</a>
 <a id="4549" href="#4499" class="Function">cong</a> <a id="4554" href="#4554" class="Bound">f</a> <a id="4556" href="#4556" class="Bound">p</a> <a id="4558" href="#4558" class="Bound">i</a> <a id="4560" class="Symbol">=</a> <a id="4562" href="#4554" class="Bound">f</a> <a id="4564" class="Symbol">(</a><a id="4565" href="#4556" class="Bound">p</a> <a id="4567" href="#4558" class="Bound">i</a><a id="4568" class="Symbol">)</a>
</pre>
`trans` is far more complicated -- you'll need cubical kan operation:

<pre class="Agda"> <a id="Cubical.trans"></a><a id="4651" href="#4651" class="Function">trans</a> <a id="4657" class="Symbol">:</a> <a id="4659" class="Symbol">{</a><a id="4660" href="#4660" class="Bound">a</a> <a id="4662" href="#4662" class="Bound">b</a> <a id="4664" href="#4664" class="Bound">c</a> <a id="4666" class="Symbol">:</a> <a id="4668" href="#401" class="Generalizable">A</a><a id="4669" class="Symbol">}</a> <a id="4671" class="Symbol">→</a> <a id="4673" href="#4660" class="Bound">a</a> <a id="4675" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="4677" href="#4662" class="Bound">b</a> <a id="4679" class="Symbol">→</a> <a id="4681" href="#4662" class="Bound">b</a> <a id="4683" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="4685" href="#4664" class="Bound">c</a> <a id="4687" class="Symbol">→</a> <a id="4689" href="#4660" class="Bound">a</a> <a id="4691" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="4693" href="#4664" class="Bound">c</a>
 <a id="4696" href="#4651" class="Function">trans</a> <a id="4702" href="#4702" class="Bound">p</a> <a id="4704" href="#4704" class="Bound">q</a> <a id="4706" href="#4706" class="Bound">i</a> <a id="4708" class="Symbol">=</a> <a id="4710" href="/lagda/Cubical.Core.Primitives.html#4544" class="Function">hfill</a> <a id="4716" class="Symbol">(λ</a> <a id="4719" class="Symbol">{</a> <a id="4721" href="#4721" class="Bound">j</a> <a id="4723" class="Symbol">(</a><a id="4724" href="#4706" class="Bound">i</a> <a id="4726" class="Symbol">=</a> <a id="4728" href="/lagda/Agda.Primitive.Cubical.html#143" class="InductiveConstructor">i0</a><a id="4730" class="Symbol">)</a> <a id="4732" class="Symbol">→</a> <a id="4734" href="#4702" class="Bound">p</a> <a id="4736" href="#4706" class="Bound">i</a><a id="4737" class="Symbol">;</a> <a id="4739" href="#4739" class="Bound">j</a> <a id="4741" class="Symbol">(</a><a id="4742" href="#4706" class="Bound">i</a> <a id="4744" class="Symbol">=</a> <a id="4746" href="/lagda/Agda.Primitive.Cubical.html#171" class="InductiveConstructor">i1</a><a id="4748" class="Symbol">)</a> <a id="4750" class="Symbol">→</a> <a id="4752" href="#4704" class="Bound">q</a> <a id="4754" href="#4739" class="Bound">j</a><a id="4755" class="Symbol">})</a> <a id="4758" class="Symbol">(</a><a id="4759" href="/lagda/Agda.Builtin.Cubical.Sub.html#216" class="Postulate">inS</a> <a id="4763" class="Symbol">(</a><a id="4764" href="#4702" class="Bound">p</a> <a id="4766" href="#4706" class="Bound">i</a><a id="4767" class="Symbol">))</a> <a id="4770" href="#4706" class="Bound">i</a>
</pre>
Although we lose the ability to `rewrite`, we still have our combinators -- `sym`, `cong` and `trans`,
which means that several existing proofs are still perfectly valid under the Cubical model.

On the other hand, according to the design of `Path` types, some proofs become perfectly
natural. For instance, the `step-by-step` theorem shown above can be proved by:

<pre class="Agda"> <a id="Cubical.step-by-step"></a><a id="5148" href="#5148" class="Function">step-by-step</a> <a id="5161" class="Symbol">:</a> <a id="5163" class="Symbol">∀</a> <a id="5165" class="Symbol">{</a><a id="5166" href="#5166" class="Bound">a</a> <a id="5168" href="#5168" class="Bound">b</a> <a id="5170" href="#5170" class="Bound">c</a> <a id="5172" href="#5172" class="Bound">d</a><a id="5173" class="Symbol">}</a> <a id="5175" class="Symbol">→</a> <a id="5177" href="#5166" class="Bound">a</a> <a id="5179" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="5181" href="#5168" class="Bound">b</a> <a id="5183" class="Symbol">→</a> <a id="5185" href="#5170" class="Bound">c</a> <a id="5187" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="5189" href="#5172" class="Bound">d</a> <a id="5191" class="Symbol">→</a> <a id="5193" href="#5166" class="Bound">a</a> <a id="5195" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="5197" href="#5170" class="Bound">c</a> <a id="5199" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="5201" href="#5168" class="Bound">b</a> <a id="5203" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="5205" href="#5172" class="Bound">d</a>
 <a id="5208" href="#5148" class="Function">step-by-step</a> <a id="5221" href="#5221" class="Bound">p</a> <a id="5223" href="#5223" class="Bound">q</a> <a id="5225" href="#5225" class="Bound">i</a> <a id="5227" class="Symbol">=</a> <a id="5229" href="#5221" class="Bound">p</a> <a id="5231" href="#5225" class="Bound">i</a> <a id="5233" href="/lagda/Agda.Builtin.Nat.html#325" class="Primitive Operator">+</a> <a id="5235" href="#5223" class="Bound">q</a> <a id="5237" href="#5225" class="Bound">i</a>
</pre>
There can also be equality on functions, which is not even possible in the
Intuitionistic type theory:

<pre class="Agda"> <a id="Cubical.funExt"></a><a id="5353" href="#5353" class="Function">funExt</a> <a id="5360" class="Symbol">:</a> <a id="5362" class="Symbol">{</a><a id="5363" href="#5363" class="Bound">f</a> <a id="5365" href="#5365" class="Bound">g</a> <a id="5367" class="Symbol">:</a> <a id="5369" href="#401" class="Generalizable">A</a> <a id="5371" class="Symbol">→</a> <a id="5373" href="#403" class="Generalizable">B</a><a id="5374" class="Symbol">}</a> <a id="5376" class="Symbol">→</a> <a id="5378" class="Symbol">(∀</a> <a id="5381" href="#5381" class="Bound">x</a> <a id="5383" class="Symbol">→</a> <a id="5385" href="#5363" class="Bound">f</a> <a id="5387" href="#5381" class="Bound">x</a> <a id="5389" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="5391" href="#5365" class="Bound">g</a> <a id="5393" href="#5381" class="Bound">x</a><a id="5394" class="Symbol">)</a> <a id="5396" class="Symbol">→</a> <a id="5398" href="#5363" class="Bound">f</a> <a id="5400" href="/lagda/Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="5402" href="#5365" class="Bound">g</a>
 <a id="5405" href="#5353" class="Function">funExt</a> <a id="5412" href="#5412" class="Bound">p</a> <a id="5414" href="#5414" class="Bound">i</a> <a id="5416" href="#5416" class="Bound">a</a> <a id="5418" class="Symbol">=</a> <a id="5420" href="#5412" class="Bound">p</a> <a id="5422" href="#5416" class="Bound">a</a> <a id="5424" href="#5414" class="Bound">i</a>
</pre>
# Obvious Conclusions

+ The Cubical model introduces tons of primitives while it's fairly more powerful
  than the Intuitionistic type theory
+ Cubical model is harder implementation-wise
+ Intuitionistic type theory is more friendly for letting the compiler to solve some
  unification problems
+ Both of these two models are not gonna save Agda
