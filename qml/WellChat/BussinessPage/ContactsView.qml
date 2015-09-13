import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "../Component"
import Sparrow 1.0

Page {
    id: contactsView

    // contactsView

    title: qsTr("Contacts")
    property int headPrtraitSize: 50

    Constant { id: constant }

    ListView {
        id: contactsListView
        width: contactsView.width
        height: contactsView.height
        //model: contactsItemsModel
        model: 20
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
                when: contactsListView.movingVertically
                PropertyChanges { target: verticalScrollBar; opacity: 1 }
            },
            State {
                name: "HideBar"
                when: !contactsListView.movingVertically
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
            height: contactsListView.height - width
            anchors.right: contactsListView.right
            orientation: Qt.Vertical
            position: contactsListView.visibleArea.yPosition
            pageSize: contactsListView.visibleArea.heightRatio
        }

        delegate: ColumnLayout {
            width: contactsView.width
            height: l.height
            IconLabel {
                id: l
                spacing: 10
                Layout.fillWidth: true;
                iconSource: constant.testPic
                labelText: "哔哩哔哩"
                onPressAndHold: {
                    menu.chatItemIndex = index;
                    menu.popup();
                }
                Separator {
                    color: "#666"; orientation: Qt.Horizontal ;
                    length: parent.width * 0.8
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                onClicked: {
                    console.log("go to the person profile");
                    __PushPage(Qt.resolvedUrl("./ProfilePage.qml"));
                }
            }

        }

        Menu {
            id: menu
            property int chatItemIndex: 0
            MenuItem {
                text: qsTr("Set Remarks and Tags")
                onTriggered: {
                    contactsListView.model.remove(menu.chatItemIndex);
                }
            }
        }

        ListModel {
            id: contactsItemsModel
        }
    }

}

