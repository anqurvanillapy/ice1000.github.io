---
layout: page
title: Open Source Contributions
description: Open Source Contributions
keywords: ice1000
comments: true
permalink: /opensource-contributions/
---

I love helping improving this excellent world.

Contributing to opensource projects is a part of my life.
This is also an effective way to learn programming languages that I am
not familiar with.

That does not mean I do not submit typo-fixing pull requests.
Instead, I usually submit pull requests like that, but I do not call this "contributions" and I do not list them here as well.

There are {{ site.data.contribs.size }} contributions listed here in total.

## Overview

<table>
  <thead>
    <tr>
      <th style="text-align: left">Repo</th>
      <th style="text-align: left">Language</th>
      <th style="text-align: right">Status</th>
    </tr>
  </thead>
  <tbody>
    {% for con in site.data.contribs %}
    <tr>
      <td style="text-align: left">
        <a href="#{{ con.user }}{{ con.repo }}{{ con.num }}">
          {{ con.repo }}
        </a>
      </td>
      <td style="text-align: left">{{ con.lang }}</td>
      <td style="text-align: left">
        <a href="https://github.com/{{ con.user }}/{{ con.repo }}/pull/{{ con.num }}/">
          <img src="https://img.shields.io/github/pulls/detail/s/{{ con.user }}/{{ con.repo }}/{{ con.num }}.svg?label="
               alt="GitHub issue state" />
        </a>
      </td>
    </tr>
    {% endfor %}
  </tbody>
</table>

{% for con in site.data.contribs %}
## {{ con.user }}/{{ con.repo }}\#{{ con.num }}

[![](https://img.shields.io/github/status/contexts/pulls/{{ con.user }}/{{ con.repo }}/{{ con.num }}.svg?label=)](https://github.com/{{ con.user }}/{{ con.repo }}/pull/{{ con.num }})
[pull request](https://github.com/{{ con.user }}/{{ con.repo }}/pull/{{ con.num }}/)
 in {{ con.lang }}.

{% if con.ref == nil %}
{% else %}
+ {{ con.ref }}
{% endif %}

+ {{ con.content }}
{% endfor %}
