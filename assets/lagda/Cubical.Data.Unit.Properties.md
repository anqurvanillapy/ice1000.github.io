---
layout: page
permalink: /lagda/Cubical.Data.Unit.Properties.html
inline_latex: true
agda: true
---
<body>
{% raw %}
<pre class="Agda">
<a id="1" class="Symbol">{-#</a> <a id="5" class="Keyword">OPTIONS</a> <a id="13" class="Pragma">--cubical</a> <a id="23" class="Pragma">--safe</a> <a id="30" class="Symbol">#-}</a>
<a id="34" class="Keyword">module</a> <a id="41" href="Cubical.Data.Unit.Properties.html" class="Module">Cubical.Data.Unit.Properties</a> <a id="70" class="Keyword">where</a>

<a id="77" class="Keyword">open</a> <a id="82" class="Keyword">import</a> <a id="89" href="Cubical.Core.Everything.html" class="Module">Cubical.Core.Everything</a>

<a id="114" class="Keyword">open</a> <a id="119" class="Keyword">import</a> <a id="126" href="Cubical.Foundations.Prelude.html" class="Module">Cubical.Foundations.Prelude</a>
<a id="154" class="Keyword">open</a> <a id="159" class="Keyword">import</a> <a id="166" href="Cubical.Foundations.HLevels.html" class="Module">Cubical.Foundations.HLevels</a>

<a id="195" class="Keyword">open</a> <a id="200" class="Keyword">import</a> <a id="207" href="Cubical.Data.Nat.html" class="Module">Cubical.Data.Nat</a>
<a id="224" class="Keyword">open</a> <a id="229" class="Keyword">import</a> <a id="236" href="Cubical.Data.Unit.Base.html" class="Module">Cubical.Data.Unit.Base</a>

<a id="isContrUnit"></a><a id="260" href="Cubical.Data.Unit.Properties.html#260" class="Function">isContrUnit</a> <a id="272" class="Symbol">:</a> <a id="274" href="Cubical.Foundations.Prelude.html#5524" class="Function">isContr</a> <a id="282" href="Cubical.Data.Unit.Base.html#141" class="Record">Unit</a>
<a id="287" href="Cubical.Data.Unit.Properties.html#260" class="Function">isContrUnit</a> <a id="299" class="Symbol">=</a> <a id="301" href="Agda.Builtin.Unit.html#201" class="InductiveConstructor">tt</a> <a id="304" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="306" class="Symbol">λ</a> <a id="308" class="Symbol">{</a><a id="309" href="Agda.Builtin.Unit.html#201" class="InductiveConstructor">tt</a> <a id="312" class="Symbol">→</a> <a id="314" href="Cubical.Foundations.Prelude.html#856" class="Function">refl</a><a id="318" class="Symbol">}</a>

<a id="isPropUnit"></a><a id="321" href="Cubical.Data.Unit.Properties.html#321" class="Function">isPropUnit</a> <a id="332" class="Symbol">:</a> <a id="334" href="Cubical.Foundations.Prelude.html#5588" class="Function">isProp</a> <a id="341" href="Cubical.Data.Unit.Base.html#141" class="Record">Unit</a>
<a id="346" href="Cubical.Data.Unit.Properties.html#321" class="Function">isPropUnit</a> <a id="357" class="Symbol">_</a> <a id="359" class="Symbol">_</a> <a id="361" href="Cubical.Data.Unit.Properties.html#361" class="Bound">i</a> <a id="363" class="Symbol">=</a> <a id="365" href="Agda.Builtin.Unit.html#201" class="InductiveConstructor">tt</a> <a id="368" class="Comment">-- definitionally equal to: isContr→isProp isContrUnit</a>

<a id="isOfHLevelUnit"></a><a id="424" href="Cubical.Data.Unit.Properties.html#424" class="Function">isOfHLevelUnit</a> <a id="439" class="Symbol">:</a> <a id="441" class="Symbol">(</a><a id="442" href="Cubical.Data.Unit.Properties.html#442" class="Bound">n</a> <a id="444" class="Symbol">:</a> <a id="446" href="Agda.Builtin.Nat.html#192" class="Datatype">ℕ</a><a id="447" class="Symbol">)</a> <a id="449" class="Symbol">→</a> <a id="451" href="Cubical.Foundations.HLevels.html#1040" class="Function">isOfHLevel</a> <a id="462" href="Cubical.Data.Unit.Properties.html#442" class="Bound">n</a> <a id="464" href="Cubical.Data.Unit.Base.html#141" class="Record">Unit</a>
<a id="469" href="Cubical.Data.Unit.Properties.html#424" class="Function">isOfHLevelUnit</a> <a id="484" href="Cubical.Data.Unit.Properties.html#484" class="Bound">n</a> <a id="486" class="Symbol">=</a> <a id="488" href="Cubical.Foundations.HLevels.html#1828" class="Function">isContr→isOfHLevel</a> <a id="507" href="Cubical.Data.Unit.Properties.html#484" class="Bound">n</a> <a id="509" href="Cubical.Data.Unit.Properties.html#260" class="Function">isContrUnit</a>

</pre>
{% endraw %}
</body>