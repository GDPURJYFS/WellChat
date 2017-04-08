import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import "../component/view"
import "../component"
import "me"

ScrollablePage {
    title: qsTr("Me")

    ColumnLayout {
        anchors.fill: parent

        FunLabel {
            id: userInfoLabel
            height: 72 * dp
            Layout.fillWidth: true
            imageSource:  Qt.resolvedUrl("../assets/images/default.png")
            showBottomLine: false


            ColumnLayout {
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height * 0.75
                anchors.left: userInfoLabel.image.right
                anchors.leftMargin: 8 * dp

                Label {
                    text: qsTr("User Name")
                }
            }

            onClicked: {
                // console.log("bbb")
            }

            Image {
                id: qrCode
                width: dp * userInfoLabel.height * 0.3
                height: dp * userInfoLabel.height * 0.3
                fillMode: Image.PreserveAspectFit
                anchors.right: parent.right
                anchors.rightMargin: dp * userInfoLabel.height * 0.3
                anchors.verticalCenter: parent.verticalCenter
                sourceSize: Qt.size(qrCode.width, qrCode.height)
                source: Qt.resolvedUrl("../assets/images/qrcode.png")

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // console.log("clicked qrcode")
                    }
                }
            }
        }

        Column {
            Layout.fillWidth: true
            spacing: 0
            FunLabel {
                height: 48 * dp
                width: parent.width
                imageSource: Qt.resolvedUrl("../assets/images/favorites.png")
            }

            FunLabel {
                height: 48 * dp
                width: parent.width
                imageSource: Qt.resolvedUrl("../assets/images/my-posts.png")
                showBottomLine: false
            }
        }

        FunLabel {
            height: 48 * dp
            Layout.fillWidth: true
            imageSource: Qt.resolvedUrl("../assets/images/settings.png")
            showBottomLine: false

            onClicked: {
                stackView.push(settingsPageCom);
            }
        }
    }



}

