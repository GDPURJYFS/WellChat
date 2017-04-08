import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import "../../component"

ScrollablePage {
    id: loginPage

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                text: qsTr("‹")
                onClicked: {
                    stackView.pop()
                }
            }

            Label {
                text: qsTr("Settings")
                elide: Label.ElideRight
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
            }

        }
    }

    ColumnLayout {
        anchors.fill: parent

        spacing: 10

        Column {
            Layout.fillWidth: true
            spacing: 0

            SettingsItem {
                width: parent.width
                height: 48 * dp
                labelText: qsTr("Message0")
            }

            SettingsItem {
                width: parent.width
                height: 48 * dp
                labelText: qsTr("Message1")
            }

            SettingsItem {
                width: parent.width
                height: 48 * dp
                labelText: qsTr("Message0")
            }

            SettingsItem {
                width: parent.width
                height: 48 * dp
                labelText: qsTr("Message1")
            }

            SettingsItem {
                width: parent.width
                height: 48 * dp
                labelText: qsTr("Message0")
            }


            SettingsItem {
                width: parent.width
                height: 48 * dp
                labelText: qsTr("Message2")
                showBottomLine: false
            }
        }


        Column {
            Layout.fillWidth: true
            spacing: 0

            SettingsItem {
                width: parent.width
                height: 48 * dp
                labelText: qsTr("Message3")
            }

            SettingsItem {
                width: parent.width
                height: 48 * dp
                labelText: qsTr("About")
                onClicked: {
                    stackView.push(aboutPageCom)
                }
            }

            SettingsItem {
                width: parent.width

                height: 48 * dp
                labelText: qsTr("Message4")
                showBottomLine: false
            }

        }

    }


}
