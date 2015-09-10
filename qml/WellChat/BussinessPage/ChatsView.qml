import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "../Component"
import Sparrow 1.0
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

/////////////////////////////////////////////////////////////////////////////////////////
        /*
        highlightRangeMode: ListView.StrictlyEnforceRange
        readonly property alias topSideBarIsOpen: listView.__topSideBarIsOpen
        property bool __topSideBarIsOpen: false
        onAtYBeginningChanged: {
            try {
                if(listView.atYBeginning) {
                    console.log(-listView.contentY, listView.headerItem.height)
                    if( -contentY > listView.headerItem.height) {
                        listView.__topSideBarIsOpen = true;
                    }
                } else {
                    listView.__topSideBarIsOpen = false;
                }
            } catch(e) {    }
        }

        onTopSideBarIsOpenChanged: {
            if(listView.topSideBarIsOpen) {
                listView.highlightRangeMode = ListView.ApplyRange   // 焦点Item允许停止的位置
            } else {
                listView.highlightRangeMode  = ListView.StrictlyEnforceRange
            }
        }

        header: Rectangle {
            id: headerItem
            width: listView.width;
            height: listView.height
            color: "black"
        }
        //*/
/////////////////////////////////////////////////////////////////////////////////////////
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

            property int chatItemHeight: chatItemRowLayout.height

            width: chatsView.width
            height: chatItem.chatItemHeight
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
                id: chatItemRowLayout
                width: parent.width
                height: (chatItemName.contentHeight+chatItemContext.contentHeight) * 1.5
                anchors.margins: spacing
                Image {
                    width: chatItem.chatItemHeight
                    height: chatItem.chatItemHeight
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize.width: chatItem.chatItemHeight - 2
                    sourceSize.height: chatItem.chatItemHeight - 2
                    source: "../resource/tests/tests001.jpg"
                    fillMode: Image.PreserveAspectFit
                }
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    RowLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        SampleLabel { id: chatItemName; Layout.fillWidth: true; text: name }
                        SampleLabel { id: chatItemTime; Layout.fillWidth: true; text: chatTime }
                    }
                    RowLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        SampleLabel { id: chatItemContext; Layout.fillWidth: true; text: chatContext }
                        SampleLabel { id: chatItemisBool;Layout.fillWidth: true; text: chatisBool }
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
    }

}

