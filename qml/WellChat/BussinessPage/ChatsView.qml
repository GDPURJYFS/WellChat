import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "../Component"

Page {
    id: chatsView
    title: "FriendList"
    color: "white"
    property int headPrtraitSize: 90
    signal openNewChat(int userid, string username)

    onOpenNewChat: {
        if(__find(username) !== null) {
            // go to the chat page
            __LoadChatPage(userid, name);
        } else {
            chatItemsModel.append(
                        {
                            "chatTime": (new Date).toDateString(),
                            "chatName":username,
                            "chatisBool": false,
                            "chatContext":userid
                        });
            // go to the chat page
            __LoadChatPage(userid, username);
        }
    }

    ListView {
        id: listView
        width: chatsView.width
        height: chatsView.height
        model: chatItemsModel
        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
        }
        move: Transition {
            NumberAnimation { properties: "x,y"; duration: 800; easing.type: Easing.OutBack }
        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }
        }
        states: [
            State {
                name: "ShowBar"
                when: listView.movingVertically
                PropertyChanges { target: verticalScrollBar; opacity: 1 }
            },
            State {
                name: "HideBar"
                when: !listView.movingVertically
                PropertyChanges { target: verticalScrollBar; opacity: 0 }
            }
        ]

        transitions: [
            Transition {
                from: "ShowBar"
                to: "HideBar"
                NumberAnimation { properties: "opacity"; duration: 400 }
            },
            Transition {
                from: "HideBar"
                to: "ShowBar"
                NumberAnimation { properties: "opacity"; duration: 400 }
            }
        ]

        ScrollBar {
            id: verticalScrollBar
            width: 10 * Screen.devicePixelRatio
            height: listView.height - width
            anchors.right: listView.right
            orientation: Qt.Vertical
            position: listView.visibleArea.yPosition
            pageSize: listView.visibleArea.heightRatio
        }

        delegate: Rectangle {
            id: chatItem
            // chatItem
            width: chatsView.width
            height: headPrtraitSize
            color: "transparent"
            border.width: 1
            border.color: "#ccc"
            state: "UnSelected"
            states: [
                State {
                    name: "Selected"
                    PropertyChanges { target:chatItem; color: "#ccc" }
                },
                State {
                    name: "UnSelected"
                    PropertyChanges { target:chatItem; color: "transparent" }
                }
            ]

            transitions: [
                Transition {
                    from: "Selected"
                    to: "UnSelected"
                    NumberAnimation { properties: "color"; duration: 400 }
                },
                Transition {
                    from: "UnSelected"
                    to: "Selected"
                    NumberAnimation { properties: "color"; duration: 400 }
                }
            ]

            RowLayout {
                anchors.fill: parent
                anchors.margins: spacing
                Image {
                    width: headPrtraitSize
                    height: headPrtraitSize
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize.width: headPrtraitSize - 2
                    sourceSize.height: headPrtraitSize - 2
                    source: "../resource/tests/tests001.jpg"
                    fillMode: Image.PreserveAspectFit
                    //clip: true
                }
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    RowLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Label { Layout.fillWidth: true; text: name }
                        Label { Layout.fillWidth: true; text: chatTime }
                    }
                    RowLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Label { Layout.fillWidth: true; text: chatContext }
                        Label { Layout.fillWidth: true; text: chatisBool }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onPressAndHold: {
                    chatItem.state = "Selected";
                    chatItemMenu.aboutToHide.connect(function(){
                        chatItemMenu.aboutToHide.disconnect(arguments.callee);
                        chatItem.state = "UnSelected";
                    });
                    chatItemMenu.aboutToShow.connect(function(){
                        chatItemMenu.aboutToShow.disconnect(arguments.callee);
                        chatItem.state = "Selected";
                    });
                    chatItemMenu.chatItemIndex = index;
                    chatItemMenu.popup();
                }
                onClicked: {
                    __LoadChatPage(1, name);
                }
            }
        }

        Menu {
            id: chatItemMenu
            property int chatItemIndex: 0
            MenuItem {
                text: qsTr("Delete conversation")
                onTriggered: {
                    listView.model.remove(chatItemMenu.chatItemIndex);
                }
            }
            MenuItem {
                text: qsTr("Sticky on top")
                onTriggered: {
                    listView.model.move(chatItemMenu.chatItemIndex, 0, 1);
                }
            }
            MenuItem {
                text: qsTr("Clear")
                onTriggered: {
                    listView.model.clear();
                }
            }
        }

        ListModel {
            id: chatItemsModel
            //            ListElement {
            //                username: "Apple"
            //                chatContext: "2333"
            //                chatTime: 2.45
            //                chatisBool: true
            //            }

            /*
                  联系人名字
                  聊天记录
                  时间
                  是否
                 */
            Component.onCompleted: {
                for(var i=0; i<100; i++) {

                    chatItemsModel
                    .append(
                         {
                             "chatTime": i,
                             "name":"Jackfruit: "+i,
                             "chatisBool": false,
                             "chatContext":"233" + i
                         });
                }
            }
        }
    }

    function __find(name) {
        if(chatItemsModel.count == 0) return null;
        var chatItemsCount = chatItemsModel.count;
        for(var i=0; i<chatItemsCount; i++) {
            // console.log("chatItemsModel.get(i).chatName: ", chatItemsModel.get(i).chatName, ", name: ",name);
            if(chatItemsModel.get(i).chatName === name) {
                return chatItemsModel.get(i);
            }
        }
        return null;
    }

    function __LoadChatPage(userid, username){

        __PushPage(Qt.resolvedUrl("./Chat/ChatPage.qml"), {username: username} );

//        var component = Qt.createComponent("./Chat/ChatPage.qml");
//        if(component.status === Component.Ready) {

//            // 防止点击过快，开启过多画面
//            chatsView.enabled = false;

//            var page = component.createObject(chatsView.stackView);
////            page.entered.connect(function() {
////                // page.entered.disconnect(arguments.callee);
////                // 在页面进入之后，设置enable为true，才可以处理按键
////                chatsView.enabled = true;
////                console.log("entered")
////            })
//            page.exited.connect(function() {
//                page.exited.disconnect(arguments.callee);
//                chatsView.enabled = true;
//            });

//            page.username = username;
//            page.focus = true;
//            page.width = Qt.binding(function(){ return stackView.width });
//            page.height = Qt.binding(function(){ return stackView.height });
//            page.stackView = chatsView.stackView;
//            stackView.push({item: page, destroyOnPop:true});
//        } else {
//            console.log(component.errorString())
//            chatsView.enabled = true;
//        }
    }

}

