---
layout: post
title: Thoughts on literate programming tools
category: Tools
keywords: Arend Agda Literate-Programming
---

TL;DR:
I'm thinking about a next-generation literate programming tool,
and I want to improve the "woven" part, say, documentation generation
(particularly, HTML).

 [IntelliJ-Pest]: https://github.com/pest-parser/intellij-pest/blob/master/src/rs/pest/livePreview/html.kt
 [IntelliJ-DTLC]: https://github.com/owo-lang/intellij-dtlc/blob/master/src/org/ice1000/tt/action/html-export.kt
 [tweet]: https://twitter.com/ice1000ard/status/1236003248731033602
 [Arend]: https://arend-lang.github.io

I have contributed to the HTML backend of literate Agda,
and have made several similar tools (generate clickable and highlighted HTML)
in both [IntelliJ-Pest] and [IntelliJ-DTLC].

# Motivation

If you have followed me on Twitter, you may have seen my recent [shitposts][tweet]
on a markup language.
The motivation was to create a blog about programming/theorem proving in the [Arend]
programming language, which requires a literate programming tool.
Markdown with codeblocks may work, but that's too weak -- even literate Agda
supports dumping highlighting and navigation for references (say, the variables in
code blocks are clickable and they jumps you to their definitions),
and the two highlighting engines used by Jekyll (the default blog renderer used by
GitHub Pages), Rouge and Pygments, neither support Arend syntax highlighting.

Also, the official website of Arend uses a [Jekyll plugin](https://github.com/arend-lang/site/blob/master/src/_plugins/arend-highlighter.rb) to highlight Arend
code -- and it's token-based.

Providing all these banes and pains, why not create my own literate mode for Arend
then? I can do whatever I want in my own tool -- there's a broad space for us.

# Plan

So, since I'm already creating a my own literate mode, why not create my own
markup language? Markdown is already millions behind AsciiDoc and reStructuredText,
but we're aiming a even more powerful literate programming tool, so I consider a
brand new markup language necessary.

I think I need to rely highly on compiler integration, say,
users will probably need to add some very complicated plugins to the markup
language compiler in order to support their own programming language.
Well, at the very first stage, I'll support Arend only because I am aware how
complicated a plugin system is :)

Since Arend it written in Java, my markup language will probably be in Java or
Kotlin.

# Details

First, I need to make an Arend-to-HTML generator, so I can have references
to an external file (since there's `Prelude.ard`).
This should be easily done, and I may add it to the compiler as an extra
functionality directly.

Here's some ideas come into my mind
(the following content is similar but different from my tweets):

+ It targets HTML, with navigation support for references in codeblocks.
  Other backends are considered but not in priority.
  + This is basically literate Agda's HTML/Markdown backend.
+ It should pretty print the code with richer visual effects comparing to what
  cliché IDEs can offer (like generation Unicode), preferably using customisable
  pretty printing rules.
  + In Arend, there's keywords like `\lam`, `\Sigma`, etc. and they're all
    backslashed. Maybe we can pretty print 'em into Unicode symbols.
  + This is basically literate Agda's LaTeX backend.
+ I also want out-of-the-box KaTeX/MathJax integration, preferably
  offline rendering.
  + Few lines of configuration solves your problem :)
+ You should be able to write expressions in-text and they can be highlighted
  with navigation provided. Mouse-hover should show the type or other code insight
  information (synthesize from the compiler) of the expression.
  + This is what I didn't find in the tools I've seen til now.
+ You can also highlight code blocks with type errors. Compiler will insert an
  error message there, and they will be filtered out when extracting/compiling
  code from the markup file.
  + Highlighting ill-typed code blocks is what I wanted long ago from literate Agda.
    It seems hopeless to see it from Agda though (I had a discussion in the issue
    tracker, but I can't find the link now).
+ You can insert the normalized and pretty printed version of expressions into the
  generated doc, so when your compiler gets changed, the normalized expression gets
  changed, but you only need a recompilation to update all the normalized results.
+ Most importantly, it should have a decent IDE support.

*So, what's the actual syntax and markup features it'll support?*

Well, I'm still thinking about it. I talked to Oling Cat and KiWA,
but none of which seem to be passionate about the idea.
Probably I can only design it myself, and let potential users suffer from my
personal taste, which is often weird :(
