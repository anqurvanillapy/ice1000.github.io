---
layout: page
title: Me on CodeWars
description: CodeWars Kata authoring
comments: true
permalink: /pages/codewars.html
---

[![](https://www.codewars.com/users/ice1000/badges/large)](https://www.codewars.com/users/ice1000)

Completing Katas primarily in Haskell, Idris and Agda.
I am one of the principals of Gensokyo (a clan).

# My Katas

Only those (at least to me) very meaningful Katas are listed.

{% for topic in site.data.codewars %}
## {{ topic.title }}
{% for kata in topic.katas %}
+ [{{ kata.name }}](https://www.codewars.com/kata/{{ kata.hash }})
{% endfor %}
{% endfor %}
