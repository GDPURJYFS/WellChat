import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "../Component"
import "./Personal"
import Sparrow 1.0

Page {
    id: discoverPage
    title: qsTr("Discover")
    color: "#ebebeb"

    Constant {  id: constant  }

    ScrollView {
        id: page
        anchors.fill: parent

        verticalScrollBarPolicy :Qt.ScrollBarAlwaysOff
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Item {
            id: content

            width: page.width
            height: Math.max(page.viewport.height, column.implicitHeight + 2 * column.spacing)


            FontMetrics {
                id: fontMetrics
                font.family: GeneralSettings.generalfontFamily
                font.pointSize: GeneralSettings.generalFontPointSize
            }

            ColumnLayout {
                id: column
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: fontMetrics.height
                Item {  width: parent.spacing;  height: parent.height }

                IconLabel {
                    Layout.fillWidth: true
                    iconSource: constant.momentsLabelIcon
                    labelText:  qsTr("Moments")
                    onClicked: {
                        __PushPage(Qt.resolvedUrl("./Discover/MomentsPage/MomentsPage.qml"))
                    }

                    Image {
                        id: momentsCurrentActiveFriend
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: column.spacing
                        width: parent.height
                        height: parent.height
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
                            iconSource: constant.scanQRCodeLabelIcon
                            labelText:  qsTr("Scan QR Code")
                        }

                        Separator {
                            Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                            color: "#666"; orientation: Qt.Horizontal ;
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        IconLabel {
                            Layout.fillWidth: true
                            iconSource: constant.shakeLabelIcon
                            labelText:  qsTr("Shake")
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
                            iconSource: constant.peopleNearbyLabelIcon
                            labelText:  qsTr("People Nearby")
                        }

                        Separator {
                            Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                            color: "#666"; orientation: Qt.Horizontal ;
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        IconLabel {
                            Layout.fillWidth: true
                            iconSource: constant.driftBottleLabelIcon
                            labelText:  qsTr("Drift Bottle")
                        }
                    }
                } // Thrid Group

                IconLabel {
                    Layout.fillWidth: true
                    iconSource: constant.gamesLabelIcon
                    labelText:  qsTr("Games")
                } // First Group
            } // Main ColumnLayout
        } // content
    } // ScrollView
}
