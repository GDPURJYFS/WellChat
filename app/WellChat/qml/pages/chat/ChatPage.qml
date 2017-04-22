import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import "../../component/utils"
import "../../component/view"
import "../../component"
import "../../service/chat"
import "../../js/common/common.js" as Common

Page {
    id: chatPage
    title: qsTr("Chat")

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                text: qsTr("‹")
                onClicked: {
                    stackView.pop()
                }
            }

            Label {
                text:qsTr("Chat")
                elide: Label.ElideRight
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listView.positionViewAtEnd()
                    }
                }
            }
        }
    }

    ListView {

        id: listView
        anchors.fill: parent
        anchors.bottomMargin: 8 * dp
        anchors.leftMargin: 8 * dp
        anchors.rightMargin:  8 *dp
        clip: true
        model: ListModel {
            id: listModel
        }

        spacing: 10 * dp

        delegate: Item {
            width: parent.width
            height: rowLayout.implicitHeight

            Rectangle {
                anchors.fill: parent
                color: "red"
            }

            RowLayout {
                id: rowLayout
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: 8 * dp
                anchors.leftMargin:  8 * dp

                Item {
                    Layout.fillWidth: true
                }

                Label {
                    id: contentLabel
                    width: parent.width
                    text: content
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    Layout.preferredWidth: Math.min(rowLayout.width, contentWidth)
                    Layout.maximumWidth: rowLayout.width * 0.5
                    Layout.alignment: Qt.AlignLeft

                    Rectangle {
                        anchors.fill: parent

                        color : "green"
                        opacity: 0.1
                    }

                }

                Image {
                    id: headerImage
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    width: 48 * dp
                    height: 48* dp
                    sourceSize: Qt.size(headerImage.width, headerImage.height)
                    source: "../../assets/images/default.png"
                }
            }
        }
        Component.onCompleted: {
            var query = {
                "groupId": "0"
            }

            chatMessageService.findList(query, function(list){
                for(var iter in list) {
                    listModel.append(list[iter]);
                }
            });
        }
    }


    footer: ToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.rightMargin: 8 * dp
            anchors.leftMargin:  8 * dp

            TextField {
                id: messageContent
                selectByMouse: true
                Layout.fillWidth: true
                onAccepted: sendMessage(messageContent.text)
            }

            ToolButton {
                text: qsTr("send")
                onClicked: {
                    sendMessage(messageContent.text);
                }
            }
        }
    }

    ChatMessageService {
        id: chatMessageService
        connection: dataBase
    }

    Lazyer {
        id: lazyer
    }

    Component.onCompleted: {

        lazyer.lazyDo(200, function(){
            listView.positionViewAtEnd();
        })

//        listView.positionViewAtEnd();
    }

    function sendMessage(msgContent) {

        if(msgContent === "") {
            return;
        }

        var message = {
            id: Common.randomString(32, false),
            senderId: "0",
            receiverId: "1",
            content: msgContent,
            groupId: "0",
            read: "0",
            createTime: Date.now()
        };

        chatMessageService.saveMessage(message, function() {
            listModel.append(message);
            messageContent.text = "";
            listView.positionViewAtEnd();
        });

    }
}

