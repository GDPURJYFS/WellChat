import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Rectangle {
    id: iconLabel

    color: "white"
    signal clicked()
    signal pressAndHold()
    property alias iconWidth: icon.width
    property alias iconHeight: icon.height
    property alias iconSource: icon.source
    property alias labelText: label.text
    property alias fontPointSize: label.font.pointSize
    property alias spacing: rowLayout.spacing

    RowLayout {
        id: rowLayout
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20
        Item { width: parent.spacing; height: parent.spacing  }
        Image {
            id: icon
            sourceSize: Qt.size(width, height)
            visible: icon.status == Image.Ready
        }
        Label {
            id: label
            font.family: "微软雅黑"
        }
        Item { Layout.fillWidth: true }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: iconLabel.clicked();
        onPressed:  iconLabel.color = "#555";
        onReleased: iconLabel.color = "white";
        onPressAndHold: iconLabel.pressAndHold();
        onPositionChanged: iconLabel.color = "white";
    }
}
