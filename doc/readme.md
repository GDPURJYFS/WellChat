# 简单易用的页面栈框架

首先讲一讲 `QtQuick.Control` 这个模块。其实这个模块是专门为桌面平台准备的。对移动平台支持并不完善。这是因为 `QtQuick.Control` 主要以窗口编程，而移动平台的应用大多要维系一个页面栈。这就让 `QtQuick.Control` 在一些面对页面灵活性高的手机 `app` 时，显得力不从心。例如每个页面都要支持不同的 `ToolBar` 和 `StatusBar`。

在 `QtQuick.Control` 中，`ApplicationWindow` 这个窗体提供了 `ToolBar` 和 `StatusBar`。但是却不能很好地动态切换不同的 `ToolBar` 和 `StatusBar` 来适配不同的页面。例如微信中，在主页面，他的 `ToolBar` 主要用来显示一个 `WeChat` 的应用名字和摆放一些 `ToolButton`。而 `StatusBar` 主要用来切换页面。在点击一个联系人进行聊天时，页面进行切换，或者说，将聊天的页面压入页面栈，这个时候，你发现页面顶部的  `ToolBar` 变成了显示当前联系人以及添加了一个返回按钮。而底部的 `StatusBar` 变成了输入框的。

如果直接使用 `ApplicationWindow` 来进行界面的编写的话，就会发现更换 `ApplicationWindow` 的 `ToolBar` 和 `StatusBar` 是十分困难的。首先你要维护聊天页面压入页面栈之前的 `ApplicationWindow` 的 `ToolBar` 和 `StatusBar`，在页面弹出页面栈之后，恢复原有的 `ToolBar` 和 `StatusBar`。

于是你决定阅读 `ApplicationWindow` 的源代码，发现 `ApplicationWindow` 通过 `Binding` 分别将 `ToolBar` 和 `StatusBar` 的 `parent` 属性绑定到窗体的顶部和底部。然后 `ApplicationWindow` 内部还有一个 `contentItemArea` 的区域，用来容纳窗体内的 `Item`。

在你研究源码之后发现，如果要想像页面栈那样使用 `ApplicationWindow` 来维系不同的  `ToolBar` 和 `StatusBar`，界面逻辑会变得十分复杂。

在这里提出一个简单的框架——页面栈窗体，虽然在 `QtQuick.Control` 中有提供 `StackView` 这个页面栈，但是他是继承自 `Item` 的。于是通过使用组合的方式诞生一个很简单又好用的 `StackPageWindow` ~

分别查看 [Page 实现简述](page.md)，[PageStackWindow 实现简述](page-stack-window.md)，[`TopBar 实现简述`](top-bar.md)，[BottomBar 实现简述](bottom-bar.md) 了解详情。

查看[微信界面剖析](weixin-ui-analyse.md)，了解怎么使用 QML 编写手机界面。
