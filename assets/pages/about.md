---
layout: page
title: About
description: About
keywords: ice1000
comments: true
permalink: /pages/about.html
---

Welcome to my blog *Intermediate Representation* (IR).
The name indicates that the content of this blog is an intermediate representation
of knowledge that I have *compiled* from books and papers.
The corresponding object code is obviously the comprehension of the knowledge in
readers' mind :).

I am a student, programming for interest,
Interested in code editor / programming language theory / mathematics (particularly algebra) / type theory,
loves animals (like snakes), and sports (football, swimming and yoyo).

Usually use *ice1000*, *千里冰封* or *Tesla Ice Zhang* as my ID.

+ [**Resume**](resume.html)
+ [**CodeWars Katas**](codewars.html)
+ [**Opensource Contributions**](/opensource-contributions/)

You can meet me on
[GitHub][gh] ([GitHub profile analysis][gh sum]),
[Bintray][bt],
[Crates.io][cr],
[StackOverflow][so],
[StackExchange Computer Science][secs],
[CodeWars][cw],
and [YouTrack][yt].

You can contact me by [E-mail][mail],
and subscribe this blog by [RSS](/feed.xml).

[![](http://stackexchange.com/users/flair/9532102.png)](http://stackoverflow.com/users/7083401/ice1000 "profile for ice1000 at Stack Overflow, Q&A for professional and enthusiast programmers")

 [gh]: https://github.com/{{ site.github_username }}
 [gh sum]: https://profile-summary-for-github.com/user/{{ site.github_username }}
 [bt]: https://bintray.com/ice1000
 [so]: http://stackoverflow.com/users/7083401
 [secs]: https://cs.stackexchange.com/users/79971
 [so ds]: http://stackoverflow.com/story/{{ site.stackoverflow_username }}
 [so ds pdf]: https://stackoverflow.com/users/story/pdf/7083401?View=Pdf
 [cw]: http://www.codewars.com/users/{{ site.github_username }}
 [yt]: https://youtrack.jetbrains.com/issues?q=by:%20ice1000
 [cr]: https://crates.io/users/ice1000
 [mail]: mailto:ice1000kotlin@foxmail.com

<!-- ## StackExchange Sites -->

<!-- + [![](https://gamedev.stackexchange.com/users/flair/106607.png)](https://gamedev.stackexchange.com/users/106607/ice1000 "profile for ice1000 at Game Development Stack Exchange, Q&A for professional and independent game developers") -->
<!-- + [![](https://codegolf.stackexchange.com/users/flair/70943.png)](https://codegolf.stackexchange.com/users/70943/ice1000 "profile for ice1000 at Programming Puzzles & Code Golf Stack Exchange, Q&A for programming puzzle enthusiasts and code golfers") -->
<!-- + [![](https://askubuntu.com/users/flair/721173.png)](https://askubuntu.com/users/721173/ice1000 "profile for ice1000 at Ask Ubuntu, Q&A for Ubuntu users and developers") -->
<!-- + [![](https://tex.stackexchange.com/users/flair/145304.png)](https://tex.stackexchange.com/users/145304/ice1000 "profile for ice1000 at TeX - LaTeX Stack Exchange, Q&amp;A for users of TeX, LaTeX, ConTeXt, and related typesetting systems") -->

<!-- ## Contact -->

<!-- {% for website in site.data.social %} -->
<!-- * {{ website.sitename }}：[@{{ website.name }}]({{ website.url }}) -->
<!-- {% endfor %} -->


## Blog Policy

<!--
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-nc-nd/4.0/)
<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" />
</a>
-->


All the posts and blogs here are licensed under a
<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">
Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 Generic License</a>.

## Friends

Listed in random order (refresh this page to see it in a different order).<br/>

<ul id="shuffle">
{% for link in site.data.links %}
<li><a href="{{ link.url }}">{{ link.name }}</a></li>
{% endfor %}
</ul>
<script>
var ul = document.getElementById('shuffle');
for (var i = ul.children.length; i >= 0; i--) {
  ul.appendChild(ul.children[Math.random() * i | 0]);
}
</script>
