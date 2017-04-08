import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Control {
    id: root

    signal canceled()
    signal clicked()
    signal doubleClicked()
    signal pressAndHold()
    signal pressed()
    signal released()

    property bool showBottomLine: true
    property color bottomLineColor: "#eee"

    readonly property alias itemDelegate: delegate

    background: Rectangle {
        width: root.width
        height: root.height
        opacity: enabled ? 1 : 0.3
        color: root.down ? "#f0f0f0" : "white"
    }


    // for mouse event and ripple effect
    ItemDelegate {
        id: delegate
        anchors.fill: parent

        Connections {
            target: delegate
            onClicked: root.clicked()
            onCanceled: root.canceled()
            onDoubleClicked: root.doubleClicked()
            onPressAndHold: root.pressAndHold
            onPressed: root.pressed()
            onReleased: root.released()
        }
    }

    Rectangle {
        id: bottomLine
        visible: showBottomLine
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 12 * dp
        anchors.rightMargin: 12 * dp

        anchors.bottom: parent.bottom
        height: 1
        color: bottomLineColor
    }

}


