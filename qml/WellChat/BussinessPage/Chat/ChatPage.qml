import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import "../../Component"
import Sparrow 1.0

Page {
    id: chatPage

    property string username

    focus: true
    Keys.onBackPressed: {
        event.accepted = true;
        try { Qt.inputMethod.hide(); stackView.pop();  }  catch(e) { }
    }

    Constant { id: constant }

    Heartbeat {
        id: heartbeat
        source: "./heart.js"
        // running: true
        interval: 3000
        onBeat: {
            /*
            id: chatModel
            //                ListElement {
            //                    chatContext: ""
            //                }
*/
            var msg = {"listModel":chatModel};
            sendMessage(msg);
        }
    }

    topBar: TopBar {
        id: topBar

        //! aviod looping binding
        Item { anchors.fill: parent }
        RowLayout {
            anchors.fill: parent
            spacing: 10

            Item { width:  topBar.height - 2; height: width }

            IconButton {
                height: topBar.height - 2
                width: topBar.height - 2
                anchors.verticalCenter: parent.verticalCenter
                activeIconSource: constant.backActiveIcon
                inactiveIconSource: constant.backInactiveIcon
                onClicked: {
                    try { stackView.pop(); }  catch(e) { }
                }

                Separator {
                    color: "black"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // such as menuBar

        Row {
            parent: topBar
            anchors.left: parent.left
            anchors.leftMargin: (topBar.height - 2) * 1.5
            anchors.fill: parent
            Label {
                text: username
                // Layout.alignment: Qt.AlignRight
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

    }

    bottomBar: BottomBar {
        RowLayout {
            anchors.fill: parent

            spacing: 5

            IconButton {
                width: topBar.height - 2
                height: topBar.height - 2
                activeIconSource: constant.soundActiveIcon
                inactiveIconSource: constant.soundInactiveIcon
            }

            Item {
                Layout.fillWidth: true
                implicitHeight: textInput.implicitHeight
                SampleTextArea {
                    id: textInput
                    width: parent.width
                    implicitHeight: {
                        if(lineCount >= 2) {
                            (topBar.height - 2) * 2
                        } else {
                            (topBar.height- 2) * lineCount
                        }
                    }
                    IconButton {
                        width: topBar.height * 0.9
                        height: topBar.height * 0.9
                        activeIconSource: constant.emoticonActiveIcon
                        inactiveIconSource: constant.emoticonInactiveIcon
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                    }

                }
            }

            SampleButton {
                id: sendButton
                Layout.alignment: Qt.AlignRight
                text: qsTr("Send")
                onClicked:  {
                    if(textInput.text != "" ) {
                        sendMessage(textInput.text);
                        //tryToNotify(textInput.text);
                        textInput.text = "";

                    }
                }
            }
            Item { width: 5; height: 5 }
        }
    }

    function sendMessage(text) {
        var doc = new XMLHttpRequest
        doc.open("POST","http://cnzxzc.tunnel.mobi/qyvlik/saveMess")
        doc.onreadystatechange = function() {
            if(doc.readyState == doc.DONE) {
                console.log(doc.responseText);
                try {
                    var response = JSON.parse(doc.responseText);
                    if(response.hasOwnProperty("flag")) {
                        if(response.flag === "OK")
                            chatModel.append({"chatContext":text});
                    }
                } catch(e) {
                    console.log(e);
                }


            }
        }
        var d = new Date;
        var sendPacket = {
            "user_id":"1",
            "timestamp": Date.now(),
            "content": text,
            "room_id":"1"
        }

        doc.send(JSON.stringify(sendPacket));
        console.log("you send:", JSON.stringify(sendPacket));
    }

    ListView {
        id: chatListView
        anchors.fill: parent
        model: ListModel {
            id: chatModel
            //                ListElement {
            //                    chatContext: ""
            //                }
        }

        spacing: 20

        readonly property int itemSpacing: 10
        readonly property int headPortraitPictureWidth: 60

        readonly property int
        chatContentAreaWidth: chatListView.width - chatListView.headPortraitPictureWidth*2 - 2 *chatListView.itemSpacing

        delegate: chatAreaComponent
    }


    Component {
        id: chatAreaComponent
        Row {
            id: chatArea
            spacing: chatListView.itemSpacing
            Image {
                // 头像
                id: headPortraitPic1
                width: chatListView.headPortraitPictureWidth
                height: chatListView.headPortraitPictureWidth
                sourceSize: Qt.size(width, height)
                source: constant.testPic
                opacity: 0
            }

            Item {
                id: chatContentArea
                width: chatListView.chatContentAreaWidth
                height: chatContentText.contentHeight > 60 ? chatContentText.contentHeight : 60

                Rectangle {
                    border.width: 1
                    border.color: "#ccc"
                    anchors.right: parent.right
                    height: parent.height
                    color: "green"
                    width: chatContentText.contentWidth > 200 ? chatContentText.contentWidth : 200
                    Text {
                        id: chatContentText
                        width: 300
                        anchors.right: parent.right
                        anchors.rightMargin: chatListView.itemSpacing
                        anchors.top: parent.top
                        anchors.topMargin: chatListView.itemSpacing
                        // anchors.centerIn: parent
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        text: chatContext
                        font.pointSize: constant.normalFontPointSize
                        font.family: "微软雅黑"
                    }
                }
            }

            Image {
                // 头像
                id: headPortraitPic2
                width: chatListView.headPortraitPictureWidth
                height: chatListView.headPortraitPictureWidth
                sourceSize: Qt.size(width, height)
                source: constant.testPic
            }
        }
    }

    function tryToNotify(notifiString) {
        try {
            console.log("will send", notifiString);
            BridgingAndroid.sendNotification(notifiString);
        }catch(e) {
            console.log(e)
        }
    }

    states: [
        State {
            name: "FixTopBar"
            PropertyChanges {
                target: chatPage.topBarArea
                anchors.topMargin: try {
                                       return Keyboard.keyboardRectangle.height;
                                   } catch(e) {
                                       return 0;
                                   }
            }
        }
    ]

    transitions: [
        Transition {
            from: "FixTopBar"
            to: ""
            NumberAnimation {
                property: "anchors.topMargin"
                duration: 350
            }
        },
        Transition {
            from: ""
            to: "FixTopBar"
            NumberAnimation {
                property: "anchors.topMargin"
                duration: 350
            }
        }
    ]

    function fixTopBar() {
        chatPage.state = "FixTopBar";
    }

    function resetTopBar() {
        chatPage.state = "";
    }

    signal keyboardOpen()
    onKeyboardOpen: {
        try {
            if(Keyboard.visible) {
                console.log("Keyboard open");
                fixTopBar();
            } else {
                console.log("Keyboard close");
                resetTopBar();
            }
        } catch(e) {
            console.log(e)
        }
    }

    onApplicationStateChanged: {
        if(applicationState == Qt.ApplicationInactive
                || applicationState ==  Qt.ApplicationSuspended
                || applicationState ==  Qt.ApplicationHidden) {
            Qt.inputMethod.hide();
        }
    }

    Component.onCompleted: {
        Qt.inputMethod.visibleChanged.connect(keyboardOpen);
    }
}

