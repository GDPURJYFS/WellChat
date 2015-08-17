# PageStackWindow 实现简述

```qml
import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: pageStackWindow
    title: qsTr("WellChat")
    width: 640
    height: 480
    visible: true
    color: "#ebebeb"

    property alias initialPage: __stackView.initialItem
    property alias focus: __stackView.focus
    readonly property alias currentItem: __stackView.currentItem
    ......
    
    StackView {
        id: __stackView
        anchors.fill: parent
        focus: visible
    }
    ......
}
```

内部填充了一个 `StackView`，用于管理页面栈，在使用过程中，不直接使用 `StackPageWindow::toolBar` 以及 `StackPageWindow::statusBar`。所以还要配合一个 [`Page`](page.md) 才可以发挥它的最大潜力。
