import QtQuick 2.0
import QtWebSockets 1.1

QtObject {
    id: client
    signal connecting()
    signal open()
    signal closing()
    signal closed()
    signal error(string errorString)

    signal message(string message)
    signal binary(string message)

    readonly property alias errorString: webSocket.errorString
    readonly property alias status: webSocket.status
    property alias active: webSocket.active
    property alias url: webSocket.url

    //@abstract
    function pingHandle(){

    }

    property alias ping: timer.running
    property alias pingInterval: timer.interval

    readonly property WebSocket __webSocket: WebSocket {
        id: webSocket
        onStatusChanged: {
            switch(webSocket.status) {
            case WebSocket.Connecting:
                client.connecting();
                break;
            case WebSocket.Open:
                client.open();
                break;
            case WebSocket.Closing:
                client.closing();
                break;
            case WebSocket.Closed:
                client.closed();
                break;
            case WebSocket.Error:
            default:
                client.error(webSocket.errorString)
            }
        }
        onTextMessageReceived: {
            client.message(message)
        }
        onBinaryMessageReceived: {
            client.binary(message)
        }
    }

    readonly property Timer __timer : Timer {
        id: timer
        repeat: true
        running: false
        interval: 30000
        onTriggered: client.pingHandle();
    }

    function sendText(text) {
        if (webSocket.active && webSocket.status === WebSocket.Open) {
            webSocket.sendTextMessage(text);
        }
    }

    // ArrayBuffer binary
    function sendBinary(binary) {
        if (webSocket.active && webSocket.status === WebSocket.Open) {
            webSocket.sendBinaryMessage(binary);
        }
    }
}
