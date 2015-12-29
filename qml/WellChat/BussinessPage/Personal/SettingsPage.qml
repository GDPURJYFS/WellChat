import Resource 1.0 as R
import BussinessPage 1.0 as BR

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

import "../../Component"
import "./Settings"

import Sparrow 1.0
import Sparrow.PopupLayer 1.0
import Sparrow.PopupLayer.Delegate 1.0

Page {
    id: personalPage
    title: qsTr("Personal")

    focus: true
    Keys.onBackPressed: {
        event.accepted = true;
        try { stackView.pop(); }  catch(e) { }
    }

    topBar: TopBar {
        id: topBar
//        //! aviod looping binding
//        Item { anchors.fill: parent }
        RowLayout {
            anchors.fill: parent
            spacing: 10

            Item { width:  topBar.height - 2; height: width }

            SampleIcon {
                iconSource: R.R.activeIconBack
                iconSize: Qt.size( topBar.height - 2,  topBar.height - 2)
                anchors.verticalCenter: parent.verticalCenter
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
            SampleLabel {
                text: personalPage.title
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    ScrollView {
        id: page
        anchors.fill: parent

        verticalScrollBarPolicy :Qt.ScrollBarAlwaysOff
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Item {
            id: content
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
                        labelText:  qsTr("Notificatons")
                        onClicked: {
                            __PushPage(BR.R.personalSettingsNotificationsSettingsPage)
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("Do Not Disturb")

                        onClicked: {
                             __PushPage(BR.R.personalSettingsDoNotDisturbSettingsPage);
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("Chat")
                        onClicked: {
                            __PushPage(BR.R.personalSettingsChatSettingsPage)
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("Privacy")
                        onClicked: {
                            __PushPage(BR.R.personalSettingsPrivacySettingsPage)
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("General")
                        onClicked: {
                            __PushPage(BR.R.personalSettingsGeneralSettingsPage)
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("My Account")
                        onClicked: {
                            __PushPage(BR.R.personalSettingsMyAccountSettingsPage)
                        }
                    }
                } // First Settings Group

                SettingsGroup {
                    Layout.fillWidth: true
                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("About")
                        onClicked: {
                             __PushPage(BR.R.personalSettingsAboutPage)
                        }
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("Log Out")
                        onClicked: dialog.open()
                    }
                }
            }// First Settings Group
        } // content
    } // ScrollView

    PopupLayer {
        id: dialog
        popupItem.color: "white"
        popupItem.radius: personalPage.width * 0.05
        SampleButton {
            anchors.centerIn: parent
            text:qsTr("Log Out?")
            onClicked: {
                dialog.close()
            }
        }
    }
}
