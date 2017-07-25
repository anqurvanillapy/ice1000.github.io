---
layout: page
title: Resume
description: Resume
keywords: Resume, resume, CV
comments: false
menu: resume
permalink: /resume/
---

# Tech Resume

## English

Here's my resume, click to download (multiple formats supported but pdf is recommended):

+ [__pdf__](https://raw.githubusercontent.com/ice1000/resume/master/resume.pdf)(recommended)
+ [ps](https://raw.githubusercontent.com/ice1000/resume/master/resume.ps)
+ [LaTeX source](https://raw.githubusercontent.com/ice1000/resume/master/resume.tex)

I'm available for intern at the moment, emails are welcomed.

## 简体中文

这里是我的简历，请点击下载（支持多种格式，但推荐 pdf ）:

+ [__pdf__](https://raw.githubusercontent.com/ice1000/resume/master/resume-cn.pdf)(推荐)
+ [ps](https://raw.githubusercontent.com/ice1000/resume/master/resume-cn.ps)
+ [LaTeX 源码](https://raw.githubusercontent.com/ice1000/resume/master/resume-cn.tex)

现在接受实习。欢迎来信（电子邮件）。

# Application Resume

Here's my resume for college application, click to download (multiple formats supported but pdf is recommended):

+ [__pdf__](https://raw.githubusercontent.com/ice1000/resume/master/resume-ap.pdf)(recommended)
+ [ps](https://raw.githubusercontent.com/ice1000/resume/master/resume-ap.ps)
+ [LaTeX source](https://raw.githubusercontent.com/ice1000/resume/master/resume-ap.tex)

It's unfinished yet. I'm still working on it.

# About These Resumes

These resumes are written in LaTeX, which means they can be exported into various formats.
But the dvi converters are really buggy so the other unstable formats are not listed here.

If you're so curious about the other ugly stuffs or how do I manage my resumes, you can view
[this resume on GitHub](https://github.com/ice1000/resume)

Let me explain the procedure here first. I have a shell script to:

0. Build all of the LaTeX sources into dvi format
0. Use the dvi tools to convert them into various formats
0. Clear the useless(log/backup) files
0. Reinit the Git repo
0. Force push all the exported files onto GitHub

I just have to click the script to do all of those dirty and repeatitive works after editing the LaTeX source.
