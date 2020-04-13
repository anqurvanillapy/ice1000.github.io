---
layout: page
permalink: /lagda/Cubical.Foundations.Pointed.Base.html
inline_latex: true
agda: true
---
<body>
{% raw %}
<pre class="Agda">
<a id="1" class="Symbol">{-#</a> <a id="5" class="Keyword">OPTIONS</a> <a id="13" class="Pragma">--cubical</a> <a id="23" class="Pragma">--safe</a> <a id="30" class="Symbol">#-}</a>
<a id="34" class="Keyword">module</a> <a id="41" href="Cubical.Foundations.Pointed.Base.html" class="Module">Cubical.Foundations.Pointed.Base</a> <a id="74" class="Keyword">where</a>

<a id="81" class="Keyword">open</a> <a id="86" class="Keyword">import</a> <a id="93" href="Cubical.Foundations.Prelude.html" class="Module">Cubical.Foundations.Prelude</a>
<a id="121" class="Keyword">open</a> <a id="126" class="Keyword">import</a> <a id="133" href="Cubical.Foundations.Equiv.html" class="Module">Cubical.Foundations.Equiv</a>

<a id="160" class="Keyword">open</a> <a id="165" class="Keyword">import</a> <a id="172" href="Cubical.Foundations.Structure.html" class="Module">Cubical.Foundations.Structure</a>
<a id="202" class="Keyword">open</a> <a id="207" class="Keyword">import</a> <a id="214" href="Cubical.Foundations.Structure.html" class="Module">Cubical.Foundations.Structure</a> <a id="244" class="Keyword">using</a> <a id="250" class="Symbol">(</a><a id="251" href="Cubical.Foundations.Structure.html#484" class="Function">typ</a><a id="254" class="Symbol">)</a> <a id="256" class="Keyword">public</a>

<a id="Pointed"></a><a id="264" href="Cubical.Foundations.Pointed.Base.html#264" class="Function">Pointed</a> <a id="272" class="Symbol">:</a> <a id="274" class="Symbol">(</a><a id="275" href="Cubical.Foundations.Pointed.Base.html#275" class="Bound">ℓ</a> <a id="277" class="Symbol">:</a> <a id="279" href="Agda.Primitive.html#423" class="Postulate">Level</a><a id="284" class="Symbol">)</a> <a id="286" class="Symbol">→</a> <a id="288" href="Cubical.Core.Primitives.html#957" class="Function">Type</a> <a id="293" class="Symbol">(</a><a id="294" href="Agda.Primitive.html#606" class="Primitive">ℓ-suc</a> <a id="300" href="Cubical.Foundations.Pointed.Base.html#275" class="Bound">ℓ</a><a id="301" class="Symbol">)</a>
<a id="303" href="Cubical.Foundations.Pointed.Base.html#264" class="Function">Pointed</a> <a id="311" href="Cubical.Foundations.Pointed.Base.html#311" class="Bound">ℓ</a> <a id="313" class="Symbol">=</a> <a id="315" href="Cubical.Foundations.Structure.html#368" class="Function">TypeWithStr</a> <a id="327" href="Cubical.Foundations.Pointed.Base.html#311" class="Bound">ℓ</a> <a id="329" class="Symbol">(λ</a> <a id="332" href="Cubical.Foundations.Pointed.Base.html#332" class="Bound">x</a> <a id="334" class="Symbol">→</a> <a id="336" href="Cubical.Foundations.Pointed.Base.html#332" class="Bound">x</a><a id="337" class="Symbol">)</a>

<a id="pt"></a><a id="340" href="Cubical.Foundations.Pointed.Base.html#340" class="Function">pt</a> <a id="343" class="Symbol">:</a> <a id="345" class="Symbol">∀</a> <a id="347" class="Symbol">{</a><a id="348" href="Cubical.Foundations.Pointed.Base.html#348" class="Bound">ℓ</a><a id="349" class="Symbol">}</a> <a id="351" class="Symbol">(</a><a id="352" href="Cubical.Foundations.Pointed.Base.html#352" class="Bound">A∙</a> <a id="355" class="Symbol">:</a> <a id="357" href="Cubical.Foundations.Pointed.Base.html#264" class="Function">Pointed</a> <a id="365" href="Cubical.Foundations.Pointed.Base.html#348" class="Bound">ℓ</a><a id="366" class="Symbol">)</a> <a id="368" class="Symbol">→</a> <a id="370" href="Cubical.Foundations.Structure.html#484" class="Function">typ</a> <a id="374" href="Cubical.Foundations.Pointed.Base.html#352" class="Bound">A∙</a>
<a id="377" href="Cubical.Foundations.Pointed.Base.html#340" class="Function">pt</a> <a id="380" class="Symbol">=</a> <a id="382" href="Cubical.Foundations.Structure.html#526" class="Function">str</a>

<a id="Pointed₀"></a><a id="387" href="Cubical.Foundations.Pointed.Base.html#387" class="Function">Pointed₀</a> <a id="396" class="Symbol">=</a> <a id="398" href="Cubical.Foundations.Pointed.Base.html#264" class="Function">Pointed</a> <a id="406" href="Agda.Primitive.html#590" class="Primitive">ℓ-zero</a>

<a id="414" class="Comment">{- Pointed functions -}</a>
<a id="_→*_"></a><a id="438" href="Cubical.Foundations.Pointed.Base.html#438" class="Function Operator">_→*_</a> <a id="443" class="Symbol">:</a> <a id="445" class="Symbol">∀{</a><a id="447" href="Cubical.Foundations.Pointed.Base.html#447" class="Bound">ℓ</a> <a id="449" href="Cubical.Foundations.Pointed.Base.html#449" class="Bound">ℓ&#39;</a><a id="451" class="Symbol">}</a> <a id="453" class="Symbol">→</a> <a id="455" class="Symbol">(</a><a id="456" href="Cubical.Foundations.Pointed.Base.html#456" class="Bound">A</a> <a id="458" class="Symbol">:</a> <a id="460" href="Cubical.Foundations.Pointed.Base.html#264" class="Function">Pointed</a> <a id="468" href="Cubical.Foundations.Pointed.Base.html#447" class="Bound">ℓ</a><a id="469" class="Symbol">)</a> <a id="471" class="Symbol">(</a><a id="472" href="Cubical.Foundations.Pointed.Base.html#472" class="Bound">B</a> <a id="474" class="Symbol">:</a> <a id="476" href="Cubical.Foundations.Pointed.Base.html#264" class="Function">Pointed</a> <a id="484" href="Cubical.Foundations.Pointed.Base.html#449" class="Bound">ℓ&#39;</a><a id="486" class="Symbol">)</a> <a id="488" class="Symbol">→</a> <a id="490" href="Cubical.Core.Primitives.html#957" class="Function">Type</a> <a id="495" class="Symbol">(</a><a id="496" href="Agda.Primitive.html#636" class="Primitive">ℓ-max</a> <a id="502" href="Cubical.Foundations.Pointed.Base.html#447" class="Bound">ℓ</a> <a id="504" href="Cubical.Foundations.Pointed.Base.html#449" class="Bound">ℓ&#39;</a><a id="506" class="Symbol">)</a>
<a id="508" href="Cubical.Foundations.Pointed.Base.html#438" class="Function Operator">_→*_</a> <a id="513" href="Cubical.Foundations.Pointed.Base.html#513" class="Bound">A</a> <a id="515" href="Cubical.Foundations.Pointed.Base.html#515" class="Bound">B</a> <a id="517" class="Symbol">=</a> <a id="519" href="Cubical.Core.Primitives.html#5705" class="Function">Σ[</a> <a id="522" href="Cubical.Foundations.Pointed.Base.html#522" class="Bound">f</a> <a id="524" href="Cubical.Core.Primitives.html#5705" class="Function">∈</a> <a id="526" class="Symbol">(</a><a id="527" href="Cubical.Foundations.Structure.html#484" class="Function">typ</a> <a id="531" href="Cubical.Foundations.Pointed.Base.html#513" class="Bound">A</a> <a id="533" class="Symbol">→</a> <a id="535" href="Cubical.Foundations.Structure.html#484" class="Function">typ</a> <a id="539" href="Cubical.Foundations.Pointed.Base.html#515" class="Bound">B</a><a id="540" class="Symbol">)</a> <a id="542" href="Cubical.Core.Primitives.html#5705" class="Function">]</a> <a id="544" href="Cubical.Foundations.Pointed.Base.html#522" class="Bound">f</a> <a id="546" class="Symbol">(</a><a id="547" href="Cubical.Foundations.Pointed.Base.html#340" class="Function">pt</a> <a id="550" href="Cubical.Foundations.Pointed.Base.html#513" class="Bound">A</a><a id="551" class="Symbol">)</a> <a id="553" href="Agda.Builtin.Cubical.Path.html#381" class="Function Operator">≡</a> <a id="555" href="Cubical.Foundations.Pointed.Base.html#340" class="Function">pt</a> <a id="558" href="Cubical.Foundations.Pointed.Base.html#515" class="Bound">B</a>

<a id="_→*_*"></a><a id="561" href="Cubical.Foundations.Pointed.Base.html#561" class="Function Operator">_→*_*</a>  <a id="568" class="Symbol">:</a> <a id="570" class="Symbol">∀{</a><a id="572" href="Cubical.Foundations.Pointed.Base.html#572" class="Bound">ℓ</a> <a id="574" href="Cubical.Foundations.Pointed.Base.html#574" class="Bound">ℓ&#39;</a><a id="576" class="Symbol">}</a> <a id="578" class="Symbol">→</a> <a id="580" class="Symbol">(</a><a id="581" href="Cubical.Foundations.Pointed.Base.html#581" class="Bound">A</a> <a id="583" class="Symbol">:</a> <a id="585" href="Cubical.Foundations.Pointed.Base.html#264" class="Function">Pointed</a> <a id="593" href="Cubical.Foundations.Pointed.Base.html#572" class="Bound">ℓ</a><a id="594" class="Symbol">)</a> <a id="596" class="Symbol">(</a><a id="597" href="Cubical.Foundations.Pointed.Base.html#597" class="Bound">B</a> <a id="599" class="Symbol">:</a> <a id="601" href="Cubical.Foundations.Pointed.Base.html#264" class="Function">Pointed</a> <a id="609" href="Cubical.Foundations.Pointed.Base.html#574" class="Bound">ℓ&#39;</a><a id="611" class="Symbol">)</a> <a id="613" class="Symbol">→</a> <a id="615" href="Cubical.Foundations.Pointed.Base.html#264" class="Function">Pointed</a> <a id="623" class="Symbol">(</a><a id="624" href="Agda.Primitive.html#636" class="Primitive">ℓ-max</a> <a id="630" href="Cubical.Foundations.Pointed.Base.html#572" class="Bound">ℓ</a> <a id="632" href="Cubical.Foundations.Pointed.Base.html#574" class="Bound">ℓ&#39;</a><a id="634" class="Symbol">)</a>
<a id="636" href="Cubical.Foundations.Pointed.Base.html#636" class="Bound">A</a> <a id="638" href="Cubical.Foundations.Pointed.Base.html#561" class="Function Operator">→*</a> <a id="641" href="Cubical.Foundations.Pointed.Base.html#641" class="Bound">B</a> <a id="643" href="Cubical.Foundations.Pointed.Base.html#561" class="Function Operator">*</a>  <a id="646" class="Symbol">=</a> <a id="648" class="Symbol">(</a><a id="649" href="Cubical.Foundations.Pointed.Base.html#636" class="Bound">A</a> <a id="651" href="Cubical.Foundations.Pointed.Base.html#438" class="Function Operator">→*</a> <a id="654" href="Cubical.Foundations.Pointed.Base.html#641" class="Bound">B</a><a id="655" class="Symbol">)</a> <a id="657" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="659" class="Symbol">(λ</a> <a id="662" href="Cubical.Foundations.Pointed.Base.html#662" class="Bound">x</a> <a id="664" class="Symbol">→</a> <a id="666" href="Cubical.Foundations.Pointed.Base.html#340" class="Function">pt</a> <a id="669" href="Cubical.Foundations.Pointed.Base.html#641" class="Bound">B</a><a id="670" class="Symbol">)</a> <a id="672" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="674" href="Cubical.Foundations.Prelude.html#856" class="Function">refl</a>

</pre>
{% endraw %}
</body>