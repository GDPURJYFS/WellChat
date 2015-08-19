import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "../Component"
import "./Personal"

Page {
    id: discoverPage
    title: qsTr("Discover")
    color: "#ebebeb"

    Constant {  id: constant  }

    ScrollView {
        id: page
        anchors.fill: parent

        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Item {
            id: content

            width: page.width
            height: Math.max(page.viewport.height, column.implicitHeight + 2 * column.spacing)

            ColumnLayout {
                id: column
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 20

                Item {  width: parent.spacing;  height: parent.height }

                IconLabel {
                    Layout.fillWidth: true
                    height: 70
                    iconWidth: 40
                    iconHeight: 40
                    iconSource: constant.momentsLabelIcon
                    labelText:  qsTr("Moments")
                    fontPointSize: constant.middleFontPointSize + 1.0

                    Image {
                        id: momentsCurrentActiveFriend
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: column.spacing
                        width: 60
                        height: 60
                        sourceSize: Qt.size(width, height)
                        source: constant.testPic
                    }

                } // First Group

                Rectangle {
                    id: colmnLayout2Parent
                    Layout.fillWidth: true
                    height: columnLayout2.height
                    color: "white"
                    ColumnLayout {
                        id: columnLayout2
                        width: parent.width
                        spacing: 0
                        IconLabel {
                            Layout.fillWidth: true
                            height: 70
                            iconWidth: 40
                            iconHeight: 40
                            iconSource: constant.scanQRCodeLabelIcon
                            labelText:  qsTr("Scan QR Code")
                            fontPointSize: constant.middleFontPointSize + 1.0
                        }

                        Separator {
                            Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                            color: "#666"; orientation: Qt.Horizontal ;
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        IconLabel {
                            Layout.fillWidth: true
                            height: 70
                            iconWidth: 40
                            iconHeight: 40
                            iconSource: constant.shakeLabelIcon
                            labelText:  qsTr("Shake")
                            fontPointSize: constant.middleFontPointSize + 1.0
                        }
                    }
                } // Second Group


                Rectangle {
                    Layout.fillWidth: true
                    height: columnLayout3.height
                    color: "white"
                    ColumnLayout {
                        id: columnLayout3
                        width: parent.width
                        spacing: 0
                        IconLabel {
                            Layout.fillWidth: true
                            height: 70
                            iconWidth: 40
                            iconHeight: 40
                            iconSource: constant.peopleNearbyLabelIcon
                            labelText:  qsTr("People Nearby")
                            fontPointSize: constant.middleFontPointSize + 1.0
                        }

                        Separator {
                            Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                            color: "#666"; orientation: Qt.Horizontal ;
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        IconLabel {
                            Layout.fillWidth: true
                            height: 70
                            iconWidth: 40
                            iconHeight: 40
                            iconSource: constant.driftBottleLabelIcon
                            labelText:  qsTr("Drift Bottle")
                            fontPointSize: constant.middleFontPointSize + 1.0
                        }
                    }
                } // Thrid Group

                IconLabel {
                    Layout.fillWidth: true
                    height: 70
                    iconWidth: 40
                    iconHeight: 40
                    iconSource: constant.gamesLabelIcon
                    labelText:  qsTr("Games")
                    fontPointSize: constant.middleFontPointSize + 1.0
                } // First Group
            } // Main ColumnLayout
        } // content
    } // ScrollView
}
