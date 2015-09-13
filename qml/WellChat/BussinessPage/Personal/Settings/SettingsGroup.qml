import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import "../../../Component"
import Sparrow 1.0

Item  {
    id: settingsGroup

    Constant {  id: constant  }

    property alias title: title.text
    property alias backgroundColor: background.color
    property alias spacing: columnLayout.spacing
    default property alias data: columnLayout.data

    height: columnLayout.implicitHeight + titleArea.height

    Rectangle {
        id: titleArea
        color: "transparent"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        height: title.text != "" ? title.height : 1

        SampleLabel {
            id: title
            color: "#666"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: background
        color: "white"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: titleArea.height
        height: parent.height
    }

    ColumnLayout {
        id: columnLayout
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: titleArea.height
        spacing: 0
    }
}
