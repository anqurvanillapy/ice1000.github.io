---
layout: page
title: 友情链接
description: Everyone needs friends..
keywords: links
comments: true
menu: Links
permalink: /links-cn/
---

> 欢迎访问我的朋友们的网站。

{% for link in site.data.links_cn %}
* [{{ link.name }}]({{ link.url }})
{% endfor %}
