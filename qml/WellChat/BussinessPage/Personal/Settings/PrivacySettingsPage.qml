import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "../../../Component"

Page {
    id: privacySettingsPage
    title: qsTr("Privacy")
    color: "#ccc"

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
                text: privacySettingsPage.title
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
                        labelText:  qsTr("Friend Confirmation")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        Switch {
                            checked: true
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: column.spacing
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
                        labelText:  qsTr("Find QQ Contacts")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        Switch {
                            checked: true
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: column.spacing
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
                        labelText:  qsTr("Find Mobile Contacts")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        Switch {
                            checked: true
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: column.spacing
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
                        labelText:  qsTr("Blocked List")
                        fontPointSize: constant.middleFontPointSize + 1.0
                    }

                } // First Setting Group


                SettingsGroup {
                    Layout.fillWidth: true

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("Find Me by WeChat ID")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        Switch {
                            checked: true
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: column.spacing
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
                        labelText:  qsTr("Find Me by Phone No.")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        Switch {
                            checked: true
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: column.spacing
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
                        labelText:  qsTr("Find Me By QQ ID")                // 震动
                        fontPointSize: constant.middleFontPointSize + 1.0
                        Switch {
                            checked: true
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: column.spacing
                        }

                    }
                }  // Second Setting Group

                SettingsGroup {
                    Layout.fillWidth: true
                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("Don't Share My Moments")
                        fontPointSize: constant.middleFontPointSize + 1.0
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("Hide User's Moments")
                        fontPointSize: constant.middleFontPointSize + 1.0
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("Moments Groups")
                        fontPointSize: constant.middleFontPointSize + 1.0
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        height: 70
                        labelText:  qsTr("Public Moments")
                        fontPointSize: constant.middleFontPointSize + 1.0
                        Switch {
                            checked: true
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: column.spacing
                        }
                    }
                } //  Third Setting Group

            } // Main ColumnLayout
        } // content
    } // ScollView
}
