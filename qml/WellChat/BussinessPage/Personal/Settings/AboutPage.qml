import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "../../../Component"
import Sparrow 1.0

Page {
    id: aboutPage
    title: qsTr("My Account")
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
            SampleLabel {
                text: aboutPage.title
                // Layout.alignment: Qt.AlignRight
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    ScrollView {
        id: page
        anchors.fill: parent

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


                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: page.width * 0.4
                    height: page.width * 0.4
                    sourceSize: Qt.size(page.width * 0.4, page.width * 0.4)
                    source: constant.testPic
                }

                SettingsGroup {
                    Layout.fillWidth: true
                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("Rete WellChat")
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("Features")
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("Help & Feedback")
                    }

                    Separator {
                        Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                        color: "#666"; orientation: Qt.Horizontal ;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    IconLabel {
                        Layout.fillWidth: true
                        labelText:  qsTr("Version Update")
                        Label {
                            text: qsTr("1.0.0")
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: column.spacing
                            color: "#666"
                            font.family: "微软雅黑"
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            font.pointSize: constant.smallFontPointSize + 2
                        }
                    }
                }

                Label {
                    Layout.fillWidth: true
                    text: qsTr("Terms and Privacy")
                    color: "blue"
                    font.family: "微软雅黑"
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: constant.smallFontPointSize + 2
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                Label {
                    Layout.fillWidth: true
                    text: qsTr("Copyright © 2015 qyvlik\n All Rights Reserved.")
                    color: "#666"
                    font.family: "微软雅黑"
                    font.pointSize: constant.smallFontPointSize + 2
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

            } // Main ColumnLayout
        } // content
    } // ScrollView
}

