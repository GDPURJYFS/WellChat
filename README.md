# WellChat

WellChat is a Application that is a WeChat-like APP by qml.

> Qt version > 5.5.0

> Android SDK APi > 19

使用 qml 来仿制安卓微信的 Qt 程序，可以运行在安卓上。

## 界面展示

### 480 * 800

微信界面

![](Screenshot/480x800/WeChat.png)

仿制界面

![](Screenshot/480x800/WellChat-01.png)

![](Screenshot/480x800/WellChat-02.png)

![](Screenshot/480x800/WellChat-03.png)

![](Screenshot/480x800/WellChat-04.png)

### 1080P

微信界面

![](Screenshot/1080x1920/WellChat01.jpg)

![](Screenshot/1080x1920/WellChat02.jpg)

![](Screenshot/1080x1920/WellChat03.jpg)

![](Screenshot/1080x1920/WellChat04.jpg)  

![](Screenshot/1080x1920/WellChat05.jpg)  

![](Screenshot/1080x1920/WellChat06.jpg)

![](Screenshot/1080x1920/WellChat07.jpg)

![](Screenshot/1080x1920/WellChat08.jpg)

## QML开发安卓应用上的局限

`QtQuick.Control` 这个模块是专门为桌面平台准备的，对移动平台支持并不完善。不能很好地动态切换不同的 `ToolBar` 和 `StatusBar` 来适配不同的页面。

如何设计一个简单的页面栈呢？查看[简单易用的页面栈框架](https://github.com/GDPURJYFS/Sparrow)

## 剖析界面

微信界面的主要操作交互逻辑有首界面的四个可以切换的分页，以及一个页面栈。查看[微信界面剖析](doc/weixin-ui-analyse.md)

---

***images and protocol Copyright (C) by [Tencent] (http://weixin.qq.com/)*** 

***图片、协议版权归[腾讯] (http://weixin.qq.com/) 所有！***