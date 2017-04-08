import Resource 1.0 as R

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

import "../../Component"
import "./Settings"

import Sparrow 1.0

Page {
    id: myPostPage
    title: qsTr("My Post")
    color: "white"

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
                text: myPostPage.title
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        maximumFlickVelocity: 5000
        model: 100
        spacing: 30
        header: Item {
            width: myPostPage.width
            height: fengmian.height + (touxiang.height)
            Image {
                id: fengmian
                source: R.R.testPic
                sourceSize.width: myPostPage.width
                width: myPostPage.width
                fillMode: Image.PreserveAspectCrop
            }
            Image {
                id: touxiang
                anchors.right: parent.right
                anchors.rightMargin: touxiang.height * 0.2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: touxiang.height / 2
                source: R.R.testPic
                sourceSize.width: myPostPage.width * 0.23
            }
        }
        delegate: RowLayout {
            width:  myPostPage.width
            SampleLabel {
                text: "今天"
            }
            Image {
                source: R.R.testPic
                sourceSize.width: myPostPage.width * 0.23
                fillMode: Image.PreserveAspectCrop
            }
            SampleLabel {
                Layout.fillWidth: true
                text: "正文之今天选课，炸了dddddddddddddddddddddddddddddddddddddddddddddddd炸了炸了炸了"
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

        }
    }
}
