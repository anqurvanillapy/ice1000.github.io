---
layout: post
title: 安卓知乎客户端当然也会收集用户信息
category: Arkirina
tags: Zhihu
keywords: china-apps, zhihu, android
description: Indeed Zhihu's android app is also collecting user data
---

哪个国产大牌安卓软件不会收集用户信息？我这次就看到了安卓知乎客户端干的东西了。

![Zhihu App Splash Screen](https://pic1.zhimg.com/v2-79f1f95eb4f8c4ded879c7bef82d5124_hdpi.png)

我使用了 Charles 抓包，在手机上使用了代理指向 Charles 的 WIFI 测试。  
我们看到在大量请求里夹着这么一个：

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/akirina/zhihu-collecting-user-data-1.png)

是的这不新鲜。再看看发了什么？

目标 URL 是 `https://appcloud.zhihu.com/v1/device` ，使用了 PUT 。
记住要开启 SSL Proxy 并在手机导入 Charles 的证书。
然后他的请求 UA 并不是知乎手机客户端的（`com.zhihu.android/Futureve/5.7.2 ...`）。

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/akirina/zhihu-collecting-user-data-2.png)

![](https://coding.net/u/ice1000/p/Images/git/raw/master/blog-img/akirina/zhihu-collecting-user-data-3.png)

其中：

+ `d_n` 为手机型号，大概是 `ph_br` 和 `ph_md` 用空格连接在一起吧
+ `im_e` 是 IMEI 
+ `mc_ad` 是 MAC 地址
+ `ph_br` 是手机厂商
+ `ph_md` 是真·手机型号
+ `ph_os` 是操作系统
+ `ph_sn` 是这个手机的序列号

剩下的自己也明白吧。

看见一个 APP 收集了这么多东西，看来真是把个人信息给一个公司都比把个人信息全给网站要好啊。
