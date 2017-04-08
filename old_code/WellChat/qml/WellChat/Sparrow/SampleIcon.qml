import QtQuick 2.5
import QtQuick.Layouts 1.1
import Sparrow 1.0

Item {
    id: icon

    property alias backgroundColor: clickedShaderEffect.backgroundColor
    property alias spreadColor: clickedShaderEffect.spreadColor

    signal clicked()

    height: iconSize.height
    width: iconSize.width

    property size iconSize: Qt.size(33, 33)
    property alias iconSource: iconImage.source

    clip: true

    Image {
        id: iconImage
        sourceSize: iconSize
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignHCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked:  icon.clicked()
        onPressed: clickedShaderEffect.touchStart(mouse.x, mouse.y)
    }

    ClickedShaderEffect {
        id: clickedShaderEffect
        anchors.fill: parent
        backgroundColor: "#10ffffff"
        spreadColor: "#50ffffff"
    }
}
