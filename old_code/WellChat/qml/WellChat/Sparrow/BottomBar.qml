import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

StatusBar {
    id: statusBar

    property color backgroundColor: "white"

    style: StatusBarStyle {
        background: Rectangle {
            implicitHeight: 16
            implicitWidth: 200
            color: backgroundColor
            Rectangle {
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: "#999"
            }
        }
    }
}
