import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import "./chat"

Page {
    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            Label {
                text: qsTr("WellChat")
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 8 * dp
            }

            ToolButton {
                text: qsTr("⋮")
                onClicked: menu.open()
                Layout.alignment: Qt.AlignRight

                Menu {
                    id: menu

                    MenuItem {
                        text: qsTr("Logout")
                        onClicked: stackView.pop()
                    }
                }
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        clip: true

        ChatListPage {

        }

        Page {

        }

        Page {

        }

        MePage {
        }
    }


    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Chat")
        }
        TabButton {
            text: qsTr("Contract")
        }
        TabButton {
            text: qsTr("Ad")
        }
        TabButton {
            text: qsTr("Me")
        }
    }
}
