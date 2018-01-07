---
layout: post
title: 安卓知乎客户端当然也会收集用户信息
category: Arkirina
tags: Zhihu
keywords: china-apps, zhihu, android
description: Indeed Zhihu's android app is also collecting user data
---

![Zhihu App Splash Screen](https://pic1.zhimg.com/v2-79f1f95eb4f8c4ded879c7bef82d5124_hdpi.png)

哪个国产大牌安卓软件不会收集用户信息？

作者这次就看到了安卓知乎客户端干的东西了。

作者使用了Charles抓包，在手机上使用了代理指向Charles的WIFI测试。
我们看到在大量请求里夹着这么一个：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/akirina/zhihu-collecting-user-data-1.png)

是的这不新鲜。再看看发了什么？

目标URL是 `https://appcloud.zhihu.com/v1/device` ，使用了PUT。记住要开启SSL Proxy并在手机导入Charles的证书。然后他的请求UA并不是知乎手机客户端的（`com.zhihu.android/Futureve/5.7.2 ...`）。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/akirina/zhihu-collecting-user-data-2.png)

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/akirina/zhihu-collecting-user-data-3.png)

其中d\_n为手机型号，大概是ph\_br和ph\_md用空格连接在一起吧。
im\_e是IMEI。
mc\_ad是MAC地址。
ph\_br是手机厂商。
ph\_md是真·手机型号。
ph\_os是操作系统。
ph\_sn是这个手机的序列号。
剩下的自己也明白吧。

看见一个APP收集了这么多东西，看来真是把个人信息给一个公司都比把个人信息全给网站要好啊。
