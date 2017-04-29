import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtWebSockets 1.1

ApplicationWindow {

    id: applicationWindow
    width: 360
    height: 640

    ColumnLayout {
        anchors.margins: 5
        anchors.fill: parent

        ListView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: Item {
                width: applicationWindow.width
                height: label.contentHeight
                Label {
                    id: label
                    width: parent.width
                    text: message
                }
            }

            model: ListModel {
                id: listModel
            }
        }

        TextField {
            id: textField
            Layout.fillWidth: true
            placeholderText: "enter message..."
        }

        Button {
            Layout.fillWidth: true
            text: "sendMessage"
            onClicked: {
                sendMessage(textField.text)
            }
        }
    }

    WebSocket {
        id: webSocket
        url: "ws://localhost:8080"
        active: true
        onTextMessageReceived: {
            listModel.append({message:message});
        }

        Component.onDestruction: {
            webSocket.active = false;
        }
    }


    function sendMessage(message) {
        if(webSocket.status !== WebSocket.Open) {
            console.log("status:", webSocket.status);
            return;
        }

        webSocket.sendTextMessage(message);
        listModel.append({message:message});
        textField.text = "";
    }

}
