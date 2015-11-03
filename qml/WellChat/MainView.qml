import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.0
import "./BussinessPage"
import "./Component"
import Sparrow 1.0

Page {
    id: mainView
    title: "WellChat 更新啦"

    Constant { id: constant }

    topBar: TopBar {
        id: topBar
        RowLayout {
            anchors.fill: parent
            // spacing: 20
            SampleLabel {
                Layout.leftMargin: 20
                text: title
                color: "white"
            }

            Item { Layout.fillWidth: true }

        }
        // such as menuBar
        Row {
            //! [0]
            parent: topBar
            anchors.right: parent.right
            anchors.rightMargin: 10
            //! [0]

            IconButton {
                id: iconButton2
                width: topBar.height - 2
                height: topBar.height - 2
                activeIconSource: constant.magnifierActiveIcon
                inactiveIconSource: constant.magnifierInactiveIcon
                onClicked: {
                    tryToNotify("我操！");
                }
            }

            IconButton {
                id: iconButton1
                width: topBar.height - 2
                height: topBar.height - 2
                activeIconSource: constant.plusActiveIcon
                inactiveIconSource: constant.plusInactiveIcon
                onClicked: {
                }
            }
        }
    }

    bottomBar: BottomBar {
        id: bottomBar
        property  int iconHeight: topBar.height
        property  int iconWidth: topBar.width
        RowLayout {
            id: iconBar
            spacing: 0
            anchors.fill: parent
            readonly property var iconNames: ["Chat","Contacts","Discover", "Me"]
            function getActiveIconUrl(index) {
                return "./resource/icons/bar-icons/active/"+iconNames[index].toLowerCase()+".png";
            }
            function getInctiveIconUrl(index) {
                return "./resource/icons/bar-icons/inactive/"+iconNames[index].toLowerCase()+".png";
            }

            // Item { Layout.fillWidth: true }

            Repeater {
                id: repeater
                model:iconBar.iconNames
                Icon {
                    Layout.fillWidth: true
                    iconSize: Qt.size(topBar.height, topBar.height)
                    iconText: iconBar.iconNames[index]
                    activeIconSource: iconBar.getActiveIconUrl(index)
                    inactiveIconSource: iconBar.getInctiveIconUrl(index)
                    activeIconOpacity: (mainListView.currentIndex == index)
                    onClicked: {
                        mainListView.currentIndex = index;
                        mainListView.currentItem.focus = true;
                    }
                }
            }
        }
    }

    MainListView {
        id: mainListView
        focus: mainView.focus
        anchors.fill: parent
        model: itemsModel
    }

    VisualItemModel {
        id: itemsModel

        ChatsView {
            id: chatsView
            pageStackWindow: mainView.pageStackWindow
            stackView: mainView.stackView
            width: mainListView.width
            height: mainListView.height
        }

        ContactsView {
            id: contactsView
            mainListView: mainListView
            pageStackWindow: mainView.pageStackWindow
            stackView: mainView.stackView
            width: mainListView.width
            height: mainListView.height
        }

        DiscoverPage {
            id: discoverPage
            pageStackWindow: mainView.pageStackWindow
            stackView: mainView.stackView
            width: mainListView.width
            height: mainListView.height
        }

        PersonalPage {
            id: personalPage
            pageStackWindow: mainView.pageStackWindow
            stackView: mainView.stackView
            width: mainListView.width
            height: mainListView.height
        }
    }

    function tryToNotify(notifiString) {
        try {
            console.log("here is qml, will send", notifiString);
            notificationClient.sendNotification(notifiString);
        }catch(e) {
            console.log(e)
        }
    }
}

