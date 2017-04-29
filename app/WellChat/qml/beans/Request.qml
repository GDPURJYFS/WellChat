import QtQuick 2.0
import QtWebSockets 1.1

//    Signals
//      binaryMessageReceived(QString message)
//      statusChanged(Status status)
//      textMessageReceived(QString message)
//    Methods
//      void sendBinaryMessage(ArrayBuffer message)
//      void sendTextMessage(string message)

WebSocket {
    id: webSocket

    property Conf conf: null
    property Auth auth: null

    url: conf ? conf.webSocketUrl : undefined

    //    signal error(var errorMessage)

    signal receiveUserMessage(var message)

    function sendMessage4User(message) {
        if(auth == null) {
            throw new Error('auth is null!');
        }

        if(auth.token == '') {
            throw new Error('auto token is empty!')
        }

        var sendData = {
            token: auth.token,
            data: message
        }

        var str = JSON.stringify(sendData);

        if(webSocket.active) {
            webSocket.sendTextMessage(str);
        }
    }



    onTextMessageReceived: {
        if(message == '')
            return;

        var messageObj = JSON.parse(message);
        if(messageObj['type'] === 'message') {
            receiveUserMessage(message.data);
        }
    }

}


//! ArrayBuffer: [JS里的ArrayBuffer](http://www.cnblogs.com/copperhaze/p/6149041.html)
