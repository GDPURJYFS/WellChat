# TopBar 实现简述

```
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ToolBar {
    id: toolBar
    property var inline: ToolBar {
        id: i
        visible: false
    }
    style: ToolBarStyle {
        background: Rectangle {
            color: "#22292c"
            implicitWidth: i.width * 0.9
            implicitHeight: i.height * 0.9
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: "#ccc"
            }
        }
    }
}
```

> 由于 `ToolBar` 本身可以自动适应到平台相关的 `ToolBar` 高度。所以内部会添加一个未经修饰的 `ToolBar` 来获取平台相关的 `ToolBar` 高度。