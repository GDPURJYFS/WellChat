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
