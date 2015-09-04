import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ToolBar {
    id: toolBar
    // #FAFAFA
    property color backgroundColor: "#22292c"
    property var inline: ToolBar {
        id: i
        visible: false
    }
    style: ToolBarStyle {
        background: Rectangle {
            color: backgroundColor
            implicitWidth: i.width * 0.9
            implicitHeight: i.height * 0.9
        }
    }
}
