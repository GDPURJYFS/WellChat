import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import "../../Component"
import "./Settings"

Page {
    id: personalPage
    title: qsTr("Personal")

    focus: true
    Keys.onBackPressed: {
        event.accepted = true;
        try { stackView.pop(); }  catch(e) { }
    }


    Constant {  id: constant  }


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
                    // console.log(x, y)
                }

                //! [0] fix the bug
                // 在本页面压入一个页面之后再弹出
                // x 的值会变成 180
                // 需要将其设置回 0
                onXChanged: {
                    if(x != 0 ) {
                        x = 0
                    }
                }
                //! [0] fix the bug

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
                text: personalPage.title
                // Layout.alignment: Qt.AlignRight
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                font.family: "微软雅黑"
                font.pointSize: constant.middleFontPointSize
            }
        }
    }

    ScrollView {
        id: page
        anchors.fill: parent

        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Item {
            id: content

            //width: Math.max(page.viewport.width, column.implicitWidth + 2 * column.spacing)
            width: page.width
            height: Math.max(page.viewport.height, column.implicitHeight + 2 * column.spacing)

            ColumnLayout {
                id: column
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 20

                Item {  width: parent.spacing;  height: parent.height }

                SettingsGroup {
                    Layout.fillWidth: true

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("Notificatons")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        onClicked: {
                            __PushPage(Qt.resolvedUrl("./Settings/NotificationsSettingsPage.qml"));
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("Do Not Disturb")
                        fontPointSize: constant.middleFontPointSize + 1.0

                        onClicked: {
                            __PushPage(Qt.resolvedUrl("./Settings/DoNotDisturbSettingsPage.qml"));
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("Chat")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        onClicked: {
                            __PushPage(Qt.resolvedUrl("./Settings/ChatSettingsPage.qml"))
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("Privacy")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        onClicked: {
                            __PushPage(Qt.resolvedUrl("./Settings/PrivacySettingsPage.qml"))
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("General")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        onClicked: {
                            __PushPage(Qt.resolvedUrl("./Settings/GeneralSettingsPage.qml"))
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("My Account")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        onClicked: {
                            __PushPage(Qt.resolvedUrl("./Settings/MyAccountSettingsPage.qml"))
                        }
                    }
                } // First Settings Group

                SettingsGroup {
                    Layout.fillWidth: true
                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        iconWidth: 40
                        iconHeight: 40
                        labelText:  qsTr("About")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        onClicked: {
                            __PushPage(Qt.resolvedUrl("./Settings/AboutPage.qml"))
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        iconWidth: 40
                        iconHeight: 40
                        labelText:  qsTr("Log Out")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        onClicked: messageDialog.open()
                        MessageDialog {
                            id: messageDialog
                            title: qsTr("Log Out")
//                            informativeText: qsTr("Clear all message history")
                            standardButtons: StandardButton.Yes | StandardButton.Cancel
                            onYes: console.log("Yes")
                            onRejected: console.log("Cancel")
                        }
                    }
                }
            }// First Settings Group
        } // content
    } // ScrollView
}
