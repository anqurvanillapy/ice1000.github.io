---
layout: page
permalink: /lagda/Cubical.Data.Maybe.Base.html
inline_latex: true
agda: true
---
<body>
{% raw %}
<pre class="Agda">
<a id="1" class="Symbol">{-#</a> <a id="5" class="Keyword">OPTIONS</a> <a id="13" class="Pragma">--cubical</a> <a id="23" class="Pragma">--safe</a> <a id="30" class="Symbol">#-}</a>
<a id="34" class="Keyword">module</a> <a id="41" href="Cubical.Data.Maybe.Base.html" class="Module">Cubical.Data.Maybe.Base</a> <a id="65" class="Keyword">where</a>

<a id="72" class="Keyword">open</a> <a id="77" class="Keyword">import</a> <a id="84" href="Cubical.Core.Everything.html" class="Module">Cubical.Core.Everything</a>

<a id="109" class="Keyword">private</a>
  <a id="119" class="Keyword">variable</a>
    <a id="132" href="Cubical.Data.Maybe.Base.html#132" class="Generalizable">ℓ</a> <a id="134" class="Symbol">:</a> <a id="136" href="Agda.Primitive.html#423" class="Postulate">Level</a>
    <a id="146" href="Cubical.Data.Maybe.Base.html#146" class="Generalizable">A</a> <a id="148" href="Cubical.Data.Maybe.Base.html#148" class="Generalizable">B</a> <a id="150" class="Symbol">:</a> <a id="152" href="Cubical.Core.Primitives.html#957" class="Function">Type</a> <a id="157" href="Cubical.Data.Maybe.Base.html#132" class="Generalizable">ℓ</a>

<a id="160" class="Keyword">data</a> <a id="Maybe"></a><a id="165" href="Cubical.Data.Maybe.Base.html#165" class="Datatype">Maybe</a> <a id="171" class="Symbol">(</a><a id="172" href="Cubical.Data.Maybe.Base.html#172" class="Bound">A</a> <a id="174" class="Symbol">:</a> <a id="176" href="Cubical.Core.Primitives.html#957" class="Function">Type</a> <a id="181" href="Cubical.Data.Maybe.Base.html#132" class="Generalizable">ℓ</a><a id="182" class="Symbol">)</a> <a id="184" class="Symbol">:</a> <a id="186" href="Cubical.Core.Primitives.html#957" class="Function">Type</a> <a id="191" href="Cubical.Data.Maybe.Base.html#181" class="Bound">ℓ</a> <a id="193" class="Keyword">where</a>
  <a id="Maybe.nothing"></a><a id="201" href="Cubical.Data.Maybe.Base.html#201" class="InductiveConstructor">nothing</a> <a id="209" class="Symbol">:</a> <a id="211" href="Cubical.Data.Maybe.Base.html#165" class="Datatype">Maybe</a> <a id="217" href="Cubical.Data.Maybe.Base.html#172" class="Bound">A</a>
  <a id="Maybe.just"></a><a id="221" href="Cubical.Data.Maybe.Base.html#221" class="InductiveConstructor">just</a>    <a id="229" class="Symbol">:</a> <a id="231" href="Cubical.Data.Maybe.Base.html#172" class="Bound">A</a> <a id="233" class="Symbol">→</a> <a id="235" href="Cubical.Data.Maybe.Base.html#165" class="Datatype">Maybe</a> <a id="241" href="Cubical.Data.Maybe.Base.html#172" class="Bound">A</a>

<a id="caseMaybe"></a><a id="244" href="Cubical.Data.Maybe.Base.html#244" class="Function">caseMaybe</a> <a id="254" class="Symbol">:</a> <a id="256" class="Symbol">(</a><a id="257" href="Cubical.Data.Maybe.Base.html#257" class="Bound">n</a> <a id="259" href="Cubical.Data.Maybe.Base.html#259" class="Bound">j</a> <a id="261" class="Symbol">:</a> <a id="263" href="Cubical.Data.Maybe.Base.html#148" class="Generalizable">B</a><a id="264" class="Symbol">)</a> <a id="266" class="Symbol">→</a> <a id="268" href="Cubical.Data.Maybe.Base.html#165" class="Datatype">Maybe</a> <a id="274" href="Cubical.Data.Maybe.Base.html#146" class="Generalizable">A</a> <a id="276" class="Symbol">→</a> <a id="278" href="Cubical.Data.Maybe.Base.html#148" class="Generalizable">B</a>
<a id="280" href="Cubical.Data.Maybe.Base.html#244" class="Function">caseMaybe</a> <a id="290" href="Cubical.Data.Maybe.Base.html#290" class="Bound">n</a> <a id="292" class="Symbol">_</a> <a id="294" href="Cubical.Data.Maybe.Base.html#201" class="InductiveConstructor">nothing</a>  <a id="303" class="Symbol">=</a> <a id="305" href="Cubical.Data.Maybe.Base.html#290" class="Bound">n</a>
<a id="307" href="Cubical.Data.Maybe.Base.html#244" class="Function">caseMaybe</a> <a id="317" class="Symbol">_</a> <a id="319" href="Cubical.Data.Maybe.Base.html#319" class="Bound">j</a> <a id="321" class="Symbol">(</a><a id="322" href="Cubical.Data.Maybe.Base.html#221" class="InductiveConstructor">just</a> <a id="327" class="Symbol">_)</a> <a id="330" class="Symbol">=</a> <a id="332" href="Cubical.Data.Maybe.Base.html#319" class="Bound">j</a>

<a id="map-Maybe"></a><a id="335" href="Cubical.Data.Maybe.Base.html#335" class="Function">map-Maybe</a> <a id="345" class="Symbol">:</a> <a id="347" class="Symbol">(</a><a id="348" href="Cubical.Data.Maybe.Base.html#146" class="Generalizable">A</a> <a id="350" class="Symbol">→</a> <a id="352" href="Cubical.Data.Maybe.Base.html#148" class="Generalizable">B</a><a id="353" class="Symbol">)</a> <a id="355" class="Symbol">→</a> <a id="357" href="Cubical.Data.Maybe.Base.html#165" class="Datatype">Maybe</a> <a id="363" href="Cubical.Data.Maybe.Base.html#146" class="Generalizable">A</a> <a id="365" class="Symbol">→</a> <a id="367" href="Cubical.Data.Maybe.Base.html#165" class="Datatype">Maybe</a> <a id="373" href="Cubical.Data.Maybe.Base.html#148" class="Generalizable">B</a>
<a id="375" href="Cubical.Data.Maybe.Base.html#335" class="Function">map-Maybe</a> <a id="385" class="Symbol">_</a> <a id="387" href="Cubical.Data.Maybe.Base.html#201" class="InductiveConstructor">nothing</a>  <a id="396" class="Symbol">=</a> <a id="398" href="Cubical.Data.Maybe.Base.html#201" class="InductiveConstructor">nothing</a>
<a id="406" href="Cubical.Data.Maybe.Base.html#335" class="Function">map-Maybe</a> <a id="416" href="Cubical.Data.Maybe.Base.html#416" class="Bound">f</a> <a id="418" class="Symbol">(</a><a id="419" href="Cubical.Data.Maybe.Base.html#221" class="InductiveConstructor">just</a> <a id="424" href="Cubical.Data.Maybe.Base.html#424" class="Bound">x</a><a id="425" class="Symbol">)</a> <a id="427" class="Symbol">=</a> <a id="429" href="Cubical.Data.Maybe.Base.html#221" class="InductiveConstructor">just</a> <a id="434" class="Symbol">(</a><a id="435" href="Cubical.Data.Maybe.Base.html#416" class="Bound">f</a> <a id="437" href="Cubical.Data.Maybe.Base.html#424" class="Bound">x</a><a id="438" class="Symbol">)</a>

</pre>
{% endraw %}
</body>