import QtQuick 2.5
import QtQuick.Layouts 1.1
import "./UI.js" as UI

Rectangle {
    id: icon
    width: columnLayout.width
    height: columnLayout.height
    color: "transparent"

    signal clicked()

    property alias iconTextVisible: iconText.visible
    property size iconSize: Qt.size(33, 33)
    property alias iconText: iconText.text
    property alias activeIconOpacity: activeIconImage.opacity
    property alias activeIconSource: activeIconImage.source
    property alias inactiveIconSource: inactiveIconImage.source

    ColumnLayout {
        id: columnLayout
        anchors.centerIn: parent
        spacing: 0
        Item {
            width:  iconSize.width - iconText.height
            height: iconSize.height - iconText.height
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                id: activeIconImage
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                opacity: 1
                Behavior on opacity {
                    NumberAnimation { duration: 300 }
                }
            }
            Image {
                id: inactiveIconImage
                anchors.centerIn: parent
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                opacity: 1 - activeIconImage.opacity
            }
        }

        Text {
            id: iconText
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: UI.smallFontPointSize
            color: activeIconImage.opacity == 0? "#999999": "#45c01a"
            font.family: "微软雅黑"
        }
    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            icon.clicked();
        }
    }
}
