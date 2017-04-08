import Resource 1.0 as R

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

import Sparrow 1.0
import Sparrow.PopupLayer 1.0

import "./Tuling123.js" as Tuling123

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
            SampleLabel {
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

    ///////////////////////////////////////////////////////////////////////////////////

    property string chatContentBuffer: ""

    Lazy {
        id: lazy
    }

    property int readKeyboardHeight: Keyboard.keyboardRectangle.height

    onReadKeyboardHeightChanged: {
        //        console.log("onReadKeyboardHeightChanged, readKeyboardHeight:",
        //                    readKeyboardHeight);
        if(readKeyboardHeight != 0) {
            keyboardHeight = Keyboard.keyboardRectangle.height;
            //            console.log("onReadKeyboardHeightChanged, keyboardHeight:",
            //                        keyboardHeight)
        }
    }

    property int keyboardHeight: 0
    onKeyboardHeightChanged: {
        if(Qt.platform.os === "android") {
            if(keyboardHeight != 0) {
                upAnimation.to = keyboardHeight;
                upAnimation.start();
            }
        }
    }

    NumberAnimation {
        id: upAnimation
        target: chatPage.bottomBarArea
        duration: 50
        from: 0
        properties: "anchors.bottomMargin"
    }

    function inputMethodShowHelper() {
        // 如果是安卓
        if(Qt.platform.os === "android") {
            // 第一次打开
            if(keyboardHeight == 0) {
                Qt.inputMethod.visibleChanged.connect(function() {
                    if(Qt.inputMethod.visible) {
                        Qt.inputMethod.visibleChanged.disconnect(arguments.callee);
                        lazy.startCallback(50, function() {
                            // 动态生成TextArea
                            loader_input.sourceComponent = component_input;
                            loader_input.item.focus = true;
                        });
                    }
                });
                Qt.inputMethod.show();
            } else {
                upAnimation.to = keyboardHeight;
                upAnimation.start();
                lazy.startCallback(50, function() {
                    // 动态生成TextArea
                    loader_input.sourceComponent = component_input;
                    Qt.inputMethod.show();
                });
            }
        } else {
            loader_input.sourceComponent = component_input;
            loader_input.item.focus = true;
        }
    }

    signal keyboardOpen()
    onKeyboardOpen: {
        if(Qt.platform.os === "android") {
            try {
                if(!Keyboard.visible) {
                    // 关闭键盘
                    loader_input.sourceComponent = undefined;
                    upAnimation.to = 0;
                    upAnimation.start();
                }
            } catch(e) {
                console.log(e)
            }
        }
    }

    Component.onCompleted: {
        Qt.inputMethod.visibleChanged.connect(keyboardOpen);
    }

    bottomBar: BottomBar {
        id: bottombar

        focus: true

        RowLayout {
            focus: true
            anchors.fill: parent

            spacing: 5

            IconButton {
                width: topBar.height - 2
                height: topBar.height - 2
                activeIconSource: R.R.activeIconSound
                inactiveIconSource: R.R.inactiveIconSound
            }

            Item {
                focus: true
                Layout.fillWidth: true
                implicitHeight: topBar.height

                IconButton {
                    width: topBar.height * 0.9
                    height: topBar.height * 0.9
                    activeIconSource: R.R.activeIconEmoticon
                    inactiveIconSource: R.R.inactiveIconEmoticon
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                }

                Rectangle {
                    FontMetrics {
                        id: fontMetrics
                        font.family: GeneralSettings.generalfontFamily
                        font.pointSize: GeneralSettings.generalFontPointSize
                        font.weight: Font.Thin
                        font.bold: false
                    }
                    width: parent.width - 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 1
                    color: parent.focus? "#71d01d" : "#ccc"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: fontMetrics.height * 0.2
                }

                Component {
                    id: component_input
                    // Sample
                    TextArea {
                        id: input

                        //readOnly: true

                        focus: true

                        font.family: GeneralSettings.generalfontFamily
                        font.pointSize: GeneralSettings.generalFontPointSize
                        wrapMode: TextEdit.Wrap
                        backgroundVisible: false

                        Component.onDestruction: {
                            chatContentBuffer = input.text;
                        }

                        Component.onCompleted: {
                            input.text = chatContentBuffer;
                            input.cursorPosition = input.length;
                        }

                        // textFormat: TextEdit.RichText
                        width: parent.width
                        implicitHeight: {
                            if(lineCount >= 2) {
                                (topBar.height - 2) * 2
                            } else {
                                (topBar.height- 2) * lineCount
                            }
                        }

                        // Tracker { }
                    }
                }

                Loader {
                    id: loader_input
                    focus: true

                    anchors.fill: parent
                    onLoaded: {
                        loader_input.item.focus = true;
                        loader_input.item.forceActiveFocus();
                    }

                    MouseArea {
                        anchors.fill: parent
                        visible: {
                            if(loader_input.item) {
                                return loader_input.item.readOnly
                            } else {
                                return true;
                            }
                        }

                        onClicked: inputMethodShowHelper();

                        // 当关闭输入框的时候
                        // 用来显示上次输入的文本
                        SampleLabel {
                            width: parent.width
                            elide: Text.ElideRight
                            text: chatContentBuffer
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }

            SampleButton {
                id: sendButton
                width: topBar.height * 0.9
                height: topBar.height * 0.9
                Layout.alignment: Qt.AlignRight
                text: qsTr("Send")
                onClicked:  {
                    __sendHelp();
                }
            }

            Item { width: 5; height: 5 }
        }
    }

    /*
    states: [
        //        State {
        //            name: "FixTopBar"
        //            PropertyChanges {
        //                target: chatPage.topBarArea
        //                anchors.topMargin: try {
        //                                       return Keyboard.keyboardRectangle.height;
        //                                   } catch(e) {
        //                                       return 0;
        //                                   }
        //            }
        //        }
        State {
            name: "FixBottomBar"
            PropertyChanges {
                target: chatPage.bottomBarArea
                anchors.bottomMargin: keyboardHeight
            }
        }
    ]

    transitions: [
        //        Transition {
        //            from: "FixTopBar"
        //            to: ""
        //            NumberAnimation {
        //                property: "anchors.topMargin"
        //                duration: 350
        //            }
        //        },
        //        Transition {
        //            from: ""
        //            to: "FixTopBar"
        //            NumberAnimation {
        //                property: "anchors.topMargin"
        //                duration: 350
        //            }
        //        }
        Transition {
            // 回落，键盘收回
            from: "FixBottomBar"
            to: ""
            SequentialAnimation {
                ScriptAction {
                    script: {
                        loader_input.sourceComponent = undefined;
                        console.log("from FixBottomBar to '', readOnly is true");
                    }
                }
                NumberAnimation {
                    property: "anchors.bottomMargin"
                    duration: 150
                }
            }
        },
        Transition {
            from: ""
            to: "FixBottomBar"
            SequentialAnimation {
                NumberAnimation {
                    property: "anchors.bottomMargin"
                    duration: 150
                }
                ScriptAction {
                    script: {
                        loader_input.sourceComponent = component_input;

                        console.log("from '' to FixBottomBar, readOnly is false");
                    }
                }
            }
        }
    ]
    */

    ////////////////////////////////////////////////////////////////////////

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

    property bool __dontFixBottomBar: false

    PopupLayer {
        id: inputYourNicoName
        parent: chatPage
        popupItem.width: chatPage.width * 0.8
        popupItem.height: popupItem.width * 0.5
        onStateChanged: {
            if(inputYourNicoName.state == "Hide") {
                __dontFixBottomBar = false;
            } else {
                __dontFixBottomBar = true;
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

    onApplicationStateChanged: {
        if(applicationState == Qt.ApplicationInactive
                || applicationState ==  Qt.ApplicationSuspended
                || applicationState ==  Qt.ApplicationHidden) {
            Qt.inputMethod.hide();
        }
    }

    function __sendHelp() {
        if(loader_input.item.text !== "" ) {
            chatModels.append({
                                  "ChatText": loader_input.item.text,
                                  "ChatId": userId
                              });
            view.positionViewAtIndex(view.count-1, ListView.End );
            Tuling123.sendTextToTuling123(loader_input.item.text,
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
                                  Tuling123.errorCodeHandle
                                  );
            loader_input.item.text = "";
        }
    }
}
