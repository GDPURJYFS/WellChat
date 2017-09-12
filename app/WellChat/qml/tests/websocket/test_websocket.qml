import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtWebSockets 1.1
import QtQuick.Window 2.0

ApplicationWindow {
    id: applicationWindow
    width: 360
    height: 640

    visible: true
    title: sendId

    property real dpScale:  1.5
    readonly property real dp: Math.max(Screen.pixelDensity * 25.4 / 160 * dpScale, 1)

    ColumnLayout {
        anchors.margins: 5
        anchors.fill: parent

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: Rectangle {

                width: applicationWindow.width
                height: Math.max( 32 * dp, label.contentHeight)
                border.width:  dp
                border.color: "#ccc"
                Label {
                    id: label
                    anchors.centerIn: parent
                    width: parent.width
                    text: message
                }
            }

            model: ListModel {
                id: listModel
                onCountChanged: {
                    listView.positionViewAtEnd()
                }
            }
        }

        TextField {
            id: textField
            Layout.fillWidth: true
            placeholderText: "enter message..."
            onAccepted: sendMessage();
        }

        Button {
            Layout.fillWidth: true
            text: "sendMessage"
            onClicked: {
                sendMessage()
            }
        }
    }

    LoggingCategory {
        id: category
        name: "main.qml"
    }

    property string sendId: randomString(16)

    WebSocketClient {
        id: client
        url: "ws://localhost:8080"
        active: true
        ping: true
        pingInterval: 30000

        //@override
        function pingHandle() {
            var message = {
                'op': 'ping',
                'ts': Date.now()
            }
            client.sendText(JSON.stringify(message));
        }

        function sendChatMessage(msgContent) {
            var dataStr = {
                'op': 'chat',
                'ts': Date.now(),
                'data': {
                    'msg': msgContent,
                    'sid': sendId
                }
            };
            client.sendText(JSON.stringify(dataStr));
        }

        function sub(op, data) {
            var dataStr = {
                'op': op,
                'ts': Date.now(),
                'data': data,
            }
            client.sendText(JSON.stringify(dataStr));
        }

        onMessage: {
            var msgObj = JSON.parse(message);
            switch(msgObj.op) {
            case 'chat':
                var msgData = msgObj['data'];
                var msgContent = msgData['msg'];
                listModel.append({message: msgContent})
                break;
            case 'pong':
                console.log(category, 'pong');
                break;
            }
        }

        onOpen: {
            sub('login', {id: sendId});
            sub('sub_msg', {sid: 'all'});
        }
    }

    function sendMessage() {
        client.sendChatMessage(textField.text);
        listModel.append({message: textField.text});
        textField.text = "";
    }

    function randomString(length, special) {
        var iteration = 0;
        var password = "";
        var randomNumber;
        if(typeof special === 'undefined'){
            special = false;
        }
        while(iteration < length){
            randomNumber = (Math.floor((Math.random() * 100)) % 94) + 33;
            if(!special){
                if ((randomNumber >=33) && (randomNumber <=47)) { continue; }
                if ((randomNumber >=58) && (randomNumber <=64)) { continue; }
                if ((randomNumber >=91) && (randomNumber <=96)) { continue; }
                if ((randomNumber >=123) && (randomNumber <=126)) { continue; }
            }
            iteration++;
            password += String.fromCharCode(randomNumber);
        }
        return password;
    }


}
