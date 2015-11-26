import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import Sparrow 1.0
import "../Component"

Page {
    id: personalPage
    title: qsTr("Personal")
    color: "#ebebeb"

    Constant {  id: constant  }

    ScrollView {
        id: page
        anchors.fill: parent

        verticalScrollBarPolicy :Qt.ScrollBarAlwaysOff
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Item {
            id: content
            width: page.width
            height: Math.max(page.viewport.height, column.implicitHeight + 2 * column.spacing)

            FontMetrics {
                id: fontMetrics
                font.family: GeneralSettings.generalfontFamily
                font.pointSize: GeneralSettings.generalFontPointSize
            }

            ColumnLayout {
                id: column
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: fontMetrics.height

                Item {  width: parent.spacing;  height: parent.height }

                Rectangle {
                    Layout.fillWidth: true
                    height: rowLayout1.height + 10

                    RowLayout {
                        id: rowLayout1
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: Screen.pixelDensity * 1.5 // 1.5mn

                        Item {  width: parent.spacing;  height: parent.height }

                        Image {
                            height: column1.height * 1.8
                            width: column1.height * 1.8
                            sourceSize: Qt.size(width, height)
                            source: constant.testPic
                        }

                        ColumnLayout {
                            id: column1
                            Layout.fillHeight: true
                            Row {
                                spacing: 10
                                SampleLabel {
                                    id: personName
                                    text: "小屁孩"
                                }
                                Image {
                                    height: personName.height
                                    width: personName.height
                                    sourceSize: Qt.size(width, height)
                                    source: constant.maleSampleIcon
                                }
                            }
                            SampleLabel {
                                id: showId
                                text: qsTr("ID: qyvlik")
                                color: "#888"
                            }
//                            SampleLabel {
//                                id: showNick
//                                text: "昵称: " + "qyvlik"
//                                color: "#888"
//                            }
                        }

                        Item { Layout.fillWidth: true }

                    } // rowLayout1
                }

                Rectangle {
                    id: colmnLayout2Parent
                    Layout.fillWidth: true
                    height: columnLayout2.height
                    color: "white"
                    ColumnLayout {
                        id: columnLayout2
                        width: parent.width
                        spacing: 0
                        IconLabel {
                            Layout.fillWidth: true
                            iconSource: constant.myPostsLabelIcon
                            labelText:  qsTr("My Posts")
                            onClicked: {
                                __PushPage(Qt.resolvedUrl("./Personal/MyPostsPage.qml"), {} );
                            }
                        }

                        Separator {
                            Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                            color: "#666"; orientation: Qt.Horizontal ;
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        IconLabel {
                            Layout.fillWidth: true
                            iconSource: constant.favoritesLabelIcon
                            labelText:  qsTr("Favorites")
                            onClicked: {
                                __PushPage(Qt.resolvedUrl("./Personal/FavoritesPage.qml"), {} );
                            }
                        }
                    }
                }

                IconLabel {
                    Layout.fillWidth: true
                    iconSource: constant.walletLabelIcon
                    labelText:  qsTr("Wallet")
                }

                IconLabel {
                    Layout.fillWidth: true
                    iconSource: constant.faceLabelIcon
                    labelText:  qsTr("Face")
                }

                IconLabel {
                    Layout.fillWidth: true
                    iconSource: constant.settingsLabelIcon
                    labelText:  qsTr("Settings")
                    onClicked: {
                        __PushPage(Qt.resolvedUrl("./Personal/SettingsPage.qml"), {} );
                    }
                }
            }
        }
    }
}

