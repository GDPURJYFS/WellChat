import QtQuick 2.0
import QtQuick.Controls 1.4
// import "../"

Item {
    id: iconButton
    // Constant { id: constant }
    height: 40
    width: 40

    signal clicked()


    property bool active: false
    property url activeIconSource: ""
    property url inactiveIconSource: ""

    Accessible.role: Accessible.Button
    Accessible.name: "iconButton"
    Accessible.description: "shows the icon"
    Accessible.onPressAction: {
        // do a button click
        clicked()
    }

    Image {
        id: icon
        height: iconButton.height * 0.65
        width: iconButton.width * 0.65
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        sourceSize: Qt.size(width, height)
        source: active ? activeIconSource : inactiveIconSource
    }

    MouseArea {
        anchors.fill: parent
        onClicked: iconButton.clicked()
        onPressed: {
            active = true;
        }

        onReleased: {
            active = false;
        }
    }
}
