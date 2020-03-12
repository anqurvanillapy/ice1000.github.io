---
layout: page
permalink: /lagda/Cubical.Foundations.Everything.html
inline_latex: true
agda: true
---
<body>
{% raw %}
<pre class="Agda">
<a id="1" class="Symbol">{-#</a> <a id="5" class="Keyword">OPTIONS</a> <a id="13" class="Pragma">--cubical</a> <a id="23" class="Pragma">--safe</a> <a id="30" class="Symbol">#-}</a>
<a id="34" class="Keyword">module</a> <a id="41" href="Cubical.Foundations.Everything.html" class="Module">Cubical.Foundations.Everything</a> <a id="72" class="Keyword">where</a>

<a id="79" class="Comment">-- Basic cubical prelude</a>
<a id="104" class="Keyword">open</a> <a id="109" class="Keyword">import</a> <a id="116" href="Cubical.Foundations.Prelude.html" class="Module">Cubical.Foundations.Prelude</a> <a id="144" class="Keyword">public</a>

<a id="152" class="Comment">-- Definition of Identity types and definitions of J, funExt,</a>
<a id="214" class="Comment">-- univalence and propositional truncation using Id instead of Path</a>
<a id="282" class="Keyword">open</a> <a id="287" class="Keyword">import</a> <a id="294" href="Cubical.Foundations.Id.html" class="Module">Cubical.Foundations.Id</a>
  <a id="319" class="Keyword">hiding</a> <a id="326" class="Symbol">(</a> <a id="328" href="Cubical.Core.Id.html#1063" class="Function Operator">_≡_</a> <a id="332" class="Symbol">;</a> <a id="334" href="Cubical.Foundations.Id.html#2986" class="Function Operator">_≡⟨_⟩_</a> <a id="341" class="Symbol">;</a> <a id="343" href="Cubical.Foundations.Id.html#3057" class="Function Operator">_∎</a> <a id="346" class="Symbol">)</a>
  <a id="350" class="Keyword">renaming</a> <a id="359" class="Symbol">(</a> <a id="361" href="Cubical.Foundations.Id.html#4632" class="Function Operator">_≃_</a>           <a id="375" class="Symbol">to</a> <a id="_≃_"></a><a id="378" href="Cubical.Foundations.Everything.html#378" class="Function Operator">EquivId</a>
           <a id="397" class="Symbol">;</a> <a id="399" href="Cubical.Foundations.Id.html#9046" class="Function">EquivContr</a>    <a id="413" class="Symbol">to</a> <a id="EquivContr"></a><a id="416" href="Cubical.Foundations.Everything.html#416" class="Function">EquivContrId</a>
           <a id="440" class="Symbol">;</a> <a id="442" href="Cubical.Foundations.Id.html#2136" class="Function">J</a>             <a id="456" class="Symbol">to</a> <a id="459" href="Cubical.Foundations.Everything.html#459" class="Function">JId</a>
           <a id="474" class="Symbol">;</a> <a id="476" href="Cubical.Foundations.Id.html#2757" class="Function">ap</a>            <a id="490" class="Symbol">to</a> <a id="ap"></a><a id="493" href="Cubical.Foundations.Everything.html#493" class="Function">apId</a>
           <a id="509" class="Symbol">;</a> <a id="511" href="Cubical.Foundations.Id.html#4725" class="Function">equivFun</a>      <a id="525" class="Symbol">to</a> <a id="equivFun"></a><a id="528" href="Cubical.Foundations.Everything.html#528" class="Function">equivFunId</a>
           <a id="550" class="Symbol">;</a> <a id="552" href="Cubical.Foundations.Id.html#4878" class="Function">equivCtr</a>      <a id="566" class="Symbol">to</a> <a id="equivCtr"></a><a id="569" href="Cubical.Foundations.Everything.html#569" class="Function">equivCtrId</a>
           <a id="591" class="Symbol">;</a> <a id="593" href="Cubical.Foundations.Id.html#4163" class="Function">fiber</a>          <a id="608" class="Symbol">to</a> <a id="fiber"></a><a id="611" href="Cubical.Foundations.Everything.html#611" class="Function">fiberId</a>
           <a id="630" class="Symbol">;</a> <a id="632" href="Cubical.Foundations.Id.html#3986" class="Function">funExt</a>        <a id="646" class="Symbol">to</a> <a id="funExt"></a><a id="649" href="Cubical.Foundations.Everything.html#649" class="Function">funExtId</a>
           <a id="669" class="Symbol">;</a> <a id="671" href="Cubical.Foundations.Id.html#4280" class="Function">isContr</a>       <a id="685" class="Symbol">to</a> <a id="isContr"></a><a id="688" href="Cubical.Foundations.Everything.html#688" class="Function">isContrId</a>
           <a id="709" class="Symbol">;</a> <a id="711" href="Cubical.Foundations.Id.html#4344" class="Function">isProp</a>        <a id="725" class="Symbol">to</a> <a id="isProp"></a><a id="728" href="Cubical.Foundations.Everything.html#728" class="Function">isPropId</a>
           <a id="748" class="Symbol">;</a> <a id="750" href="Cubical.Foundations.Id.html#4399" class="Function">isSet</a>         <a id="764" class="Symbol">to</a> <a id="isSet"></a><a id="767" href="Cubical.Foundations.Everything.html#767" class="Function">isSetId</a>
           <a id="786" class="Symbol">;</a> <a id="788" href="Cubical.Foundations.Id.html#4468" class="Record">isEquiv</a>       <a id="802" class="Symbol">to</a> <a id="isEquiv"></a><a id="805" href="Cubical.Foundations.Everything.html#805" class="Record">isEquivId</a>
           <a id="826" class="Symbol">;</a> <a id="828" href="Cubical.Foundations.Id.html#4788" class="Function">equivIsEquiv</a>  <a id="842" class="Symbol">to</a> <a id="equivIsEquiv"></a><a id="845" href="Cubical.Foundations.Everything.html#845" class="Function">equivIsEquivId</a>
           <a id="871" class="Symbol">;</a> <a id="873" href="Cubical.Foundations.Id.html#1974" class="Function">refl</a>           <a id="888" class="Symbol">to</a> <a id="refl"></a><a id="891" href="Cubical.Foundations.Everything.html#891" class="Function">reflId</a>
           <a id="909" class="Symbol">;</a> <a id="911" href="Cubical.HITs.PropositionalTruncation.Base.html#259" class="Datatype Operator">∥_∥</a>           <a id="925" class="Symbol">to</a> <a id="Base.∥_∥"></a><a id="928" href="Cubical.Foundations.Everything.html#928" class="Datatype Operator">propTruncId</a>
           <a id="951" class="Symbol">;</a> <a id="953" href="Cubical.HITs.PropositionalTruncation.Base.html#297" class="InductiveConstructor Operator">∣_∣</a>           <a id="967" class="Symbol">to</a> <a id="Base.∥_∥.∣_∣"></a><a id="970" href="Cubical.Foundations.Everything.html#970" class="InductiveConstructor Operator">incId</a>
           <a id="987" class="Symbol">;</a> <a id="989" href="Cubical.Foundations.Id.html#7152" class="Function">isPropIsContr</a> <a id="1003" class="Symbol">to</a> <a id="isPropIsContr"></a><a id="1006" href="Cubical.Foundations.Everything.html#1006" class="Function">isPropIsContrId</a>
           <a id="1033" class="Symbol">;</a> <a id="1035" href="Cubical.Foundations.Id.html#7862" class="Function">isPropIsEquiv</a> <a id="1049" class="Symbol">to</a> <a id="isPropIsEquiv"></a><a id="1052" href="Cubical.Foundations.Everything.html#1052" class="Function">isPropIsEquivId</a>
           <a id="1079" class="Symbol">)</a>

<a id="1082" class="Keyword">open</a> <a id="1087" class="Keyword">import</a> <a id="1094" href="Cubical.Foundations.GroupoidLaws.html" class="Module">Cubical.Foundations.GroupoidLaws</a> <a id="1127" class="Keyword">public</a>
<a id="1134" class="Keyword">open</a> <a id="1139" class="Keyword">import</a> <a id="1146" href="Cubical.Foundations.CartesianKanOps.html" class="Module">Cubical.Foundations.CartesianKanOps</a> <a id="1182" class="Keyword">public</a>
<a id="1189" class="Keyword">open</a> <a id="1194" class="Keyword">import</a> <a id="1201" href="Cubical.Foundations.Function.html" class="Module">Cubical.Foundations.Function</a> <a id="1230" class="Keyword">public</a>
<a id="1237" class="Keyword">open</a> <a id="1242" class="Keyword">import</a> <a id="1249" href="Cubical.Foundations.Embedding.html" class="Module">Cubical.Foundations.Embedding</a> <a id="1279" class="Keyword">public</a>
<a id="1286" class="Keyword">open</a> <a id="1291" class="Keyword">import</a> <a id="1298" href="Cubical.Foundations.Equiv.html" class="Module">Cubical.Foundations.Equiv</a> <a id="1324" class="Keyword">public</a>
<a id="1331" class="Keyword">open</a> <a id="1336" class="Keyword">import</a> <a id="1343" href="Cubical.Foundations.Equiv.Properties.html" class="Module">Cubical.Foundations.Equiv.Properties</a> <a id="1380" class="Keyword">public</a>
<a id="1387" class="Keyword">open</a> <a id="1392" class="Keyword">import</a> <a id="1399" href="Cubical.Foundations.PathSplitEquiv.html" class="Module">Cubical.Foundations.PathSplitEquiv</a> <a id="1434" class="Keyword">public</a>
<a id="1441" class="Keyword">open</a> <a id="1446" class="Keyword">import</a> <a id="1453" href="Cubical.Foundations.BiInvEquiv.html" class="Module">Cubical.Foundations.BiInvEquiv</a> <a id="1484" class="Keyword">public</a>
<a id="1491" class="Keyword">open</a> <a id="1496" class="Keyword">import</a> <a id="1503" href="Cubical.Foundations.FunExtEquiv.html" class="Module">Cubical.Foundations.FunExtEquiv</a> <a id="1535" class="Keyword">public</a>
<a id="1542" class="Keyword">open</a> <a id="1547" class="Keyword">import</a> <a id="1554" href="Cubical.Foundations.HLevels.html" class="Module">Cubical.Foundations.HLevels</a> <a id="1582" class="Keyword">public</a>
<a id="1589" class="Keyword">open</a> <a id="1594" class="Keyword">import</a> <a id="1601" href="Cubical.Foundations.Path.html" class="Module">Cubical.Foundations.Path</a> <a id="1626" class="Keyword">public</a>
<a id="1633" class="Keyword">open</a> <a id="1638" class="Keyword">import</a> <a id="1645" href="Cubical.Foundations.Pointed.html" class="Module">Cubical.Foundations.Pointed</a> <a id="1673" class="Keyword">public</a>
<a id="1680" class="Keyword">open</a> <a id="1685" class="Keyword">import</a> <a id="1692" href="Cubical.Foundations.Structure.html" class="Module">Cubical.Foundations.Structure</a> <a id="1722" class="Keyword">public</a>
<a id="1729" class="Keyword">open</a> <a id="1734" class="Keyword">import</a> <a id="1741" href="Cubical.Foundations.Transport.html" class="Module">Cubical.Foundations.Transport</a> <a id="1771" class="Keyword">public</a>
<a id="1778" class="Keyword">open</a> <a id="1783" class="Keyword">import</a> <a id="1790" href="Cubical.Foundations.Univalence.html" class="Module">Cubical.Foundations.Univalence</a> <a id="1821" class="Keyword">public</a>
<a id="1828" class="Keyword">open</a> <a id="1833" class="Keyword">import</a> <a id="1840" href="Cubical.Foundations.UnivalenceId.html" class="Module">Cubical.Foundations.UnivalenceId</a> <a id="1873" class="Keyword">public</a>
<a id="1880" class="Keyword">open</a> <a id="1885" class="Keyword">import</a> <a id="1892" href="Cubical.Foundations.GroupoidLaws.html" class="Module">Cubical.Foundations.GroupoidLaws</a> <a id="1925" class="Keyword">public</a>
<a id="1932" class="Keyword">open</a> <a id="1937" class="Keyword">import</a> <a id="1944" href="Cubical.Foundations.Isomorphism.html" class="Module">Cubical.Foundations.Isomorphism</a> <a id="1976" class="Keyword">public</a>
<a id="1983" class="Keyword">open</a> <a id="1988" class="Keyword">import</a> <a id="1995" href="Cubical.Foundations.Surjection.html" class="Module">Cubical.Foundations.Surjection</a> <a id="2026" class="Keyword">public</a>
<a id="2033" class="Keyword">open</a> <a id="2038" class="Keyword">import</a> <a id="2045" href="Cubical.Foundations.TotalFiber.html" class="Module">Cubical.Foundations.TotalFiber</a> <a id="2076" class="Keyword">public</a>
<a id="2083" class="Keyword">open</a> <a id="2088" class="Keyword">import</a> <a id="2095" href="Cubical.Foundations.Logic.html" class="Module">Cubical.Foundations.Logic</a>
<a id="2121" class="Keyword">open</a> <a id="2126" class="Keyword">import</a> <a id="2133" href="Cubical.Foundations.SIP.html" class="Module">Cubical.Foundations.SIP</a>
<a id="2157" class="Keyword">open</a> <a id="2162" class="Keyword">import</a> <a id="2169" href="Cubical.Foundations.HoTT-UF.html" class="Module">Cubical.Foundations.HoTT-UF</a>

</pre>
{% endraw %}
</body>