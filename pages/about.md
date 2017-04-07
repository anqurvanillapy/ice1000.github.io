---
layout: page
title: About
description: About
keywords: ice1000
comments: true
menu: About
permalink: /about/
---

I am [ice1000](https://github.com/ice1000)，in Chinese is 千里冰封。

I am a student, Otaku, big fan of JetBrains, programming for interest, working with JVM and CLR.

Welcome to join the [QQ group ProgramLeague](http://shang.qq.com/wpa/qunwpa?idkey=b75f6d506820d00cd5e7fc78fc5e5487a3444a4a6af06e9e6fa72bccf3fa9d1a).

To contact me please send an E-mail.

View me on GitHub is also a good choice to know me better.

## Personal Projects

+ [algo4j, an algorithm library for Java use, JNI implemented](https://github.com/ice1000/algo4j).
+ [Gen4DP, it generates dynamic programming code from given state translation equation](https://github.com/ice1000/Gen4DP).
+ [Frice Engine, a simple, light, easy, cross-language game engine for education use](https://github.com/icela/FriceEngine).
+ [Frice Engine C# implementation](https://github.com/icela/FriceEngine-CSharp).
+ [A simple music player, materially designed](https://github.com/ice1000/Dekoder).
+ [An Android app, for playing kitiku music(German boy, Van, Billy, etc.)](https://github.com/ice1000/KitikuMaker).
+ [A Lisp running on JVM](https://github.com/lice-lang/lice).

## Contact

{% for website in site.data.social %}
* {{ website.sitename }}：[@{{ website.name }}]({{ website.url }})
{% endfor %}

## Skill Keywords

{% for category in site.data.skills %}
### {{ category.name }}
<div class="btn-inline">
{% for keyword in category.keywords %}
<button class="btn btn-outline" type="button">{{ keyword }}</button>
{% endfor %}
</div>
{% endfor %}

### As far as I am concerned,

+ Dynamic type is full of shit
+ Prototype is a rubbish(but for some cases, it's good)
+ Comparing to metaprogramming, reflection really sucks
+ It is such great fun to teach others programming
+ One day, LOP will take the place of OOP
+ JVM is the most powerful runtime in the universe
+ Functional Programming and Object Oriented Programming will finally combined with each other

## Policy

[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-nc-nd/4.0/)

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/2.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/2.0/88x31.png" />
</a>
<br/>All the posts and blogs here are licensed under a 
<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/2.0/">
Creative Commons Attribution-NonCommercial-NoDerivs 2.0 Generic License</a>.
