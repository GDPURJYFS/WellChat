import Resource 1.0 as R

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

import Sparrow 1.0
import Sparrow.PopupLayer 1.0

import "../../Component"

Page {
    id: chatPage

    property string username

    focus: true
    Keys.onBackPressed: {
        event.accepted = true;
        stackView.pop();
        Qt.inputMethod.hide();
    }

    topBar: TopBar {
        id: topBar
        RowLayout {
            anchors.fill: parent
            spacing: 10

            Item { width:  topBar.height - 2; height: width }

            SampleIcon {
                iconSize: Qt.size( topBar.height - 2,  topBar.height - 2)
                anchors.verticalCenter: parent.verticalCenter
                iconSource: R.R.activeIconBack
                // iconSource: constant.backActiveIcon
                onClicked: {
                    Qt.inputMethod.hide();
                    stackView.pop();
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

            SampleIcon {
                iconSource: R.R.labelIconSettings
                iconSize: Qt.size( topBar.height - 2,  topBar.height - 2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                onClicked: {
                    if(Qt.inputMethod.visible === false) {
                        inputYourNicoName.changeYourNicoName()
                    } else {
                        Qt.inputMethod.visible = false;
                        inputYourNicoName.changeYourNicoName()
                    }
                }
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
                activeIconSource: R.R.activeIconSound
                inactiveIconSource: R.R.inactiveIconSound
            }

            Item {
                Layout.fillWidth: true
                implicitHeight: input.implicitHeight
                SampleTextArea {
                    id: input
                    // textFormat: TextEdit.RichText
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
                        activeIconSource: R.R.activeIconEmoticon
                        inactiveIconSource: R.R.inactiveIconEmoticon
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
                    __sendHelp();
                }
            }
            Item { width: 5; height: 5 }
        }
    }

    property string userId: "垃圾君"

    ListView {
        id: view
        anchors.fill: parent
        model: chatModels

        delegate: Rectangle {
            width: view.width
            height: chatText.contentHeight * 1.5
            color: "transparent"
            border.color: "black"
            border.width: 1

            SampleLabel {
                id: chatText
                width: parent.width * 0.8 >= chatText.contentWidth
                       ? chatText.contentWidth
                       : parent.width * 0.8

                anchors.right: ChatId != "JiJiZhaZha" ? parent.right : undefined
                text: ChatText
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }

        ListModel {
            id: chatModels
            //                ListElement {
            //                    ChatText: "这是文本"
            //                    ChatId: "JiJiZhaZha"
            //                }
            //                ListElement {
            //                    ChatText: "我是垃圾君"
            //                    ChatId: "垃圾君"
            //                }
        }
    }

    property bool __dontFixTopBar: false

    PopupLayer {
        id: inputYourNicoName
        parent: chatPage
        popupItem.width: chatPage.width * 0.8
        popupItem.height: popupItem.width * 0.5
        onStateChanged: {
            if(inputYourNicoName.state == "Hide") {
                __dontFixTopBar = false;
            } else {
                __dontFixTopBar = true;
            }
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: parent.width * 0.05
            SampleTextField {
                id: getNicoName
                Layout.fillWidth: true
            }
            SampleButton {
                text: qsTr("OK")
                onClicked: {
                    chatPage.userId = getNicoName.text;
                    inputYourNicoName.close();
                    Qt.inputMethod.hide();
                }
            }
        }
        function changeYourNicoName () {
            getNicoName.text = chatPage.userId;
            inputYourNicoName.open();
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
            if(Keyboard.visible && !__dontFixTopBar) {
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

    function __sendHelp() {
        if(input.text != "" ) {
            chatModels.append({
                                  "ChatText": input.text,
                                  "ChatId": userId
                              });
            view.positionViewAtIndex(view.count-1, ListView.End );
            __sendTextToTuling123(input.text,
                                  userId,
                                  function(responseText){
                                      chatModels
                                      .append(
                                           {
                                               "ChatText": responseText,
                                               "ChatId": "JiJiZhaZha"
                                           });
                                      view.positionViewAtIndex(view.count-1, ListView.End );
                                  },
                                  errorCodeHandle
                                  );
            input.text = "";
        }
    }

    // callback(responseText)
    // err(errorCode)
    function __sendTextToTuling123(text, chatUserId, callback, err) {
        // http://www.tuling123.com/openapi/api?key=b77b735b2797bc613e7623f4406fe342&info=你好
        var host = "http://www.tuling123.com/openapi/api?";

        // 这里填写你在图灵机器人网站申请的apiKey
        // 现在图灵机器人网站是免费申请的哦。
        var apiKey = "b77b735b2797bc613e7623f4406fe342";
        var info = text;

        var dataTemplate = {
            "code": 10000,              // 返回的错误码
            "text": "回复的内容",
            "url": "",                  // 返回单条链接
            "list": []                  // 返回多条信息
        }

        var xhr = new XMLHttpRequest;
        xhr.onreadystatechange = function() {
            if(xhr.readyState == xhr.DONE) {
                console.log("xhr.responseText: ", xhr.responseText);
                try {
                    var dataObject = JSON.parse(xhr.responseText);
                    if(!isErrorCode(dataObject.code)) {
                        callback(dataObject.text);
                    } } catch(e) {
                    console.log(e);
                }

            }
        }
        xhr.open("GET", host+ "key=" + apiKey +"&userid=" + chatUserId +"&info="+info );
        xhr.send()
    }


    function isErrorCode(code) {
        var errorCodes = [
                    {
                        "code":40001,
                        "description":"参数key长度错误（应该是32位）"
                    },
                    {
                        "code":40002,
                        "description":"请求内容info为空"
                    },
                    {
                        "code":40003,
                        "description":"key错误或帐号未激活"
                    },
                    {
                        "code":40004,
                        "description":"当天请求次数已使用完"
                    },
                    {
                        "code":40005,
                        "description":"暂不支持所请求的功能"
                    },
                    {
                        "code":40006,
                        "description":"图灵机器人服务器正在升级"
                    },
                    {
                        "code":40007,
                        "description":"数据格式异常"
                    },
                ];
        for(var iter in errorCodes) {
            if(errorCodes[iter].code === code) {
                return true;
            }
        }
        return false;
    }

    function errorCodeHandle(code) {

        var errorCodes = [
                    {
                        "code":40001,
                        "description":"参数key长度错误（应该是32位）"
                    },
                    {
                        "code":40002,
                        "description":"请求内容info为空"
                    },
                    {
                        "code":40003,
                        "description":"key错误或帐号未激活"
                    },
                    {
                        "code":40004,
                        "description":"当天请求次数已使用完"
                    },
                    {
                        "code":40005,
                        "description":"暂不支持所请求的功能"
                    },
                    {
                        "code":40006,
                        "description":"图灵机器人服务器正在升级"
                    },
                    {
                        "code":40007,
                        "description":"数据格式异常"
                    },
                ];
        for(var iter in errorCodes) {
            if(errorCodes[iter].code === code) {
                console.log(errorCodes[iter].description);
            }
        }
    }
}

