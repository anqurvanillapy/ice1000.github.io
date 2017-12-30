---
layout: post
title: 在Chrome里面重定向网页资源
category: Arkirina
tags: Chrome, Zhihu, Resource Overriding
keywords: Chrome, Zhihu, Resource Overriding
description: Resource overriding in Chrome
---

直接引出下文吧，发现并没有开头。

## 首先是插件

我们会用到以下两个插件：

* [Resource Override](https://chrome.google.com/webstore/detail/pkoacgokdfckfpndoffpifphamojphii)
* [Disable CSP](https://chrome.google.com/webstore/detail/disable-content-security/ieelmcmcagommplceebfedjlakkhpden)

（其实第二个不是很需要但是我当时脑子回路不太对所以就用上了）

其实这个商店还真的只有具有科学的上网观念的人才能看见。所以我就告诉你一个下载插件的地方吧

[这里](https://chrome-extension-downloader.com/)

然而我也不是很知道这个能不能很方便地下载到(◐‿◑)﻿


## 插件安装

呃先把插件安装了吧。然后你就可以看到这两个在地址栏旁边了（如果看不见就看下面的另外一张图）：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/misc/chrome-toolbar-w-plugins.png)

如果安装了图标还是看不见的话：

1. 右键图标 ![](https://coding.net/u/ice1000/p/Images/git/raw/master/misc/hidden-plugin-icon-show-1.png)

2. 然后选这个 ![](https://coding.net/u/ice1000/p/Images/git/raw/master/misc/hidden-plugin-icon-show-2.png)

## 先是在知乎身上动手脚

（现在我很怀疑我写这篇有没有意义）

点一下那个R的按钮弹出一个管理界面（事实上devtools也加了这么一个标签），然后点那个“Add Rule”就能发现这么一个东西：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/akirina/resource-override-2.png)

好的那么我们用URL to URL加了这么两个：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/akirina/resource-override-1.png)

贴一下原地址：

1. https://zhihu-web-analytics.zhihu.com/api/v1/logs/batch
2. https://sugar.zhihu.com/track （然而这个并不能被匹配到，不知道为什么）

（都是一下神奇的不知道干了什么的后台自动发送数据的东西看起来像用户跟踪什么的）

然后后面的to就是自己搭个本地服务器啦然后弄上去。

最后override的效果是这样子的：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/akirina/redirection-in-devtools.png)

（虽然并没有什么惊喜

接下来的就是利用这一种方法来一步一步地摸出使用爬虫怎么登陆知乎了。
（devtools那个修改脚本的方法我不会用……orz所以就想出了这样子的一种麻烦的方式

至于下面的捐助，如果你需要向这篇文章的真正作者捐助的话请注明 `to Arkirna` 哟