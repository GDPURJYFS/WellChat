# BottomBar 实现简述

```qml
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

StatusBar {
    id: statusBar

    style: StatusBarStyle {
        background: Rectangle {
            implicitHeight: 16
            implicitWidth: 200
            Rectangle {
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: "#999"
            }
        }
    }
}
```

由于 `BottomBar` 高度一般与 `TopBar` 高度一样活着略低。可以根据页面中的 `TopBar` 决定高度。

```qml
Page {
    id: mainPage
    title: "WellChat"

    topBar: TopBar {
        id: topBar
        RowLayout {
            anchors.fill: parent
            Label {
                Layout.leftMargin: 20
                text: title
                color: "white"
            }
        }
    }
    bottomBar: BottomBar {
        id: bottomBar
        RowLayout {
            id: iconBar
            spacing: 0
            anchors.fill: parent
            Icon {
                Layout.fillWidth: true
                // 这里获取 `TopBar` 的高度。然后 `BottomBar` 会根据内部子控件的高度进行调整。
                iconSize: Qt.size(topBar.height, topBar.height)
            }
        }
    }
}
```