---
layout: page
title: Open Source Projects
keywords: projects,GitHub
description: My Projects
permalink: /projects/
---

<script async defer src="https://buttons.github.io/buttons.js"></script>

Here are my personal projects.

I have some larger projects whose whole toolchains were put into organizations.

+ [Frice Engine](https://github.com/icela) <br/>
A simple, light, easy, **cross-language** game engine.<br/>
Sub projects:
   + JVM Version(Kotlin) <a class="github-button" href="https://github.com/icela/FriceEngine"
     data-show-count="true" aria-label="Star icela/FriceEngine on GitHub">Star</a> ([![Awesome Kotlin Badge](https://kotlin.link/awesome-kotlin.svg)](https://kotlin.link/?q=Frice) launched!)
   + Kotlin DSL <a class="github-button" href="https://github.com/icela/FriceEngine-DSL"
     data-show-count="true" aria-label="Star icela/FriceEngine-DSL on GitHub">Star</a>
   + CLR Version(C\#) <a class="github-button" href="https://github.com/icela/FriceEngine-CSharp"
     data-show-count="true" aria-label="Star icela/FriceEngine-CSharp on GitHub">Star</a>
   + Lisp Version(Racket) <a class="github-button" href="https://github.com/icela/FriceEngine-Racket"
     data-show-count="true" aria-label="Star icela/FriceEngine-Racket on GitHub">Star</a>
   + Ruby Version(Ruby) <a class="github-button" href="https://github.com/icela/FriceEngine-Ruby"
     data-show-count="true" aria-label="Star icela/FriceEngine-Ruby on GitHub">Star</a>
   + Demos (Various Languages) <a class="github-button" href="https://github.com/icela/FriceDemo"
     data-show-count="true" aria-label="Star icela/FriceDemo on GitHub">Star</a>
   + Designer (Kotlin with JavaFX) <a class="github-button" href="https://github.com/icela/FriceDesigner"
     data-show-count="true" aria-label="Star icela/FriceDesigner on GitHub">Star</a>


<br/><br/>

+ [Lice Language](https://github.com/lice-lang) <br/>
A Lisp dialect running on JVM<br/>perfectly works with other JVM Languages.<br/>
Sub projects:
   + Interpreter (Kotlin JVM) <a class="github-button" href="https://github.com/lice-lang/lice"
     data-show-count="true" aria-label="Star lice-lang/lice on GitHub">Star</a> ([![Awesome Kotlin Badge](https://kotlin.link/awesome-kotlin.svg)](https://kotlin.link/?q=lice) launched!)
   + REPL (Kotlin JVM) by [@Glavo](https://github.com/Glavo) <a class="github-button" href="https://github.com/lice-lang/lice-repl"
     data-show-count="true" aria-label="Star lice-lang/lice-repl on GitHub">Star</a>
   + Android REPL (Kotlin Android) <a class="github-button" href="https://github.com/lice-lang/lice-android"
     data-show-count="true" aria-label="Star lice-lang/lice-android on GitHub">Star</a>
   + Examples and library (Lice) <a class="github-button" href="https://github.com/lice-lang/lice-library"
     data-show-count="true" aria-label="Star lice-lang/lice-library on GitHub">Star</a>

<br/><br/>

{% if site.github.public_repositories != null %}
{% assign sorted_repos = (site.github.public_repositories | sort: 'stargazers_count') | reverse %}

<section class="container">
    <header class="text-center">
        <h1>Other Projects</h1>
        <p class="lead">I have <span class="repo-count">{{ sorted_repos.size }}</span> projects on Github</p>
    </header>
    <div class="repo-list">
        <!-- Check here for github metadata -->
        <!-- https://help.github.com/articles/repository-metadata-on-github-pages/ -->
        {% for repo in sorted_repos %}
        <a href="{{ repo.html_url }}" target="_blank" class="one-third-column card text-center">
            <div class="thumbnail">
                <div class="card-image geopattern" data-pattern-id="{{ repo.name }}">
                    <div class="card-image-cell">
                        <h3 class="card-title">
                            {{ repo.name }}
                        </h3>
                    </div>
                </div>
                <div class="caption">
                    <div class="card-description">
                        <p class="card-text">{{ repo.description }}</p>
                    </div>
                    <div class="card-text">
                        <span class="meta-info" title="{{ repo.stargazers_count }} stars">
                            <span class="octicon octicon-star"></span> {{ repo.stargazers_count }}
                        </span>
                        <span class="meta-info" title="{{ repo.forks_count }} forks">
                            <span class="octicon octicon-git-branch"></span> {{ repo.forks_count }}
                        </span>
                        <span class="meta-info" title="Last updated：{{ repo.updated_at }}">
                            <span class="octicon octicon-clock"></span>
                            <time datetime="{{ repo.updated_at }}">{{ repo.updated_at | date: '%Y-%m-%d' }}</time>
                        </span>
                    </div>
                </div>
            </div>
        </a>
        {% endfor %}
    </div>
</section>
{% endif %}
