import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "../../../Component"

Page {
    id: generalSettingsPage
    title: qsTr("General")
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
                text: generalSettingsPage.title
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
                            iconWidth: 40
                            iconHeight: 40
                            labelText:  qsTr("Landscape Display")
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
                            iconWidth: 40
                            iconHeight: 40
                            labelText:  qsTr("Low-bitrate Recording")
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
                            iconWidth: 40
                            iconHeight: 40
                            labelText:  qsTr("Low-bitrate Recording")
                            fontPointSize: constant.middleFontPointSize + 1.0
                            Label {
                                text: qsTr("3G / 4G and Wi-Fi")
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.rightMargin: column.spacing
                                color: "#666"
                                font.family: "微软雅黑"
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                font.pointSize: constant.smallFontPointSize + 2
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
                            labelText:  qsTr("Auto-Update WellChat")
                            fontPointSize: constant.middleFontPointSize + 1.0
                            Label {
                                text: qsTr("Never")
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.rightMargin: column.spacing
                                color: "#666"
                                font.family: "微软雅黑"
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                font.pointSize: constant.smallFontPointSize + 2
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
                            labelText:  qsTr("Language")
                            fontPointSize: constant.middleFontPointSize + 1.0
                            Label {
                                text: qsTr("English")
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.rightMargin: column.spacing
                                color: "#666"
                                font.family: "微软雅黑"
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                font.pointSize: constant.smallFontPointSize + 2
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
                            labelText:  qsTr("Font Size")
                            fontPointSize: constant.middleFontPointSize + 1.0
                            Label {
                                text: qsTr("Standard")
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.rightMargin: column.spacing
                                color: "#666"
                                font.family: "微软雅黑"
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                font.pointSize: constant.smallFontPointSize + 2
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
                            labelText:  qsTr("Features")
                            fontPointSize: constant.middleFontPointSize + 1.0
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
                            labelText:  qsTr("Data Usage")
                            fontPointSize: constant.middleFontPointSize + 1.0
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
                            labelText:  qsTr("Web WellChat")
                            fontPointSize: constant.middleFontPointSize + 1.0
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
                            labelText:  qsTr("Manage Storage")
                            fontPointSize: constant.middleFontPointSize + 1.0
                        }
                } // First Settings Group
            } // Main ColumnLayout
        } // content
    } // ScrollView
}
