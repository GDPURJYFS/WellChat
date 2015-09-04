import QtQuick 2.0

ListView {
    anchors.fill: parent
    model: ListModel {
        id: chatModel
        //                ListElement {
        //                    chatContext: ""
        //                }
    }
    delegate: Row {

        spacing: 10
        Rectangle {
            width: parent.width
            height: 70
            border.width: 1
            border.color: "#ccc"
            Text {
                anchors.centerIn: parent
                text: chatContext
            }
        }

        Image {
            width: 60
            height: 60
            sourceSize: Qt.size(width, height)
        }
        Item { }
    }


    // messagesType: ["text", "picture", "video", "emoji"]
    function addMessage(who, messageType, messageContent) {

    }

}
