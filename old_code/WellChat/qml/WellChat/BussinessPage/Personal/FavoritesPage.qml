import Resource 1.0 as R

import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../Component"
import "./Settings"

import Sparrow 1.0

import WellChat 1.0

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
        model: CollectionsModel {
            id: collectionsModel

            //            enum CollectionRole {
            //                Author        // 作者
            //                CreateTime,   // 创建时间
            //                Title,        // 标题
            //                Source,       // 来源地址：http://baidu.com
            //                SourceName,   // 来源名字：baidu
            //                Summary,      // 摘要
            //                CollectionType// 收藏的类型，例如链接，音乐，图片等
            //            };

            Component.onCompleted: {
                console.log();
            }

        }
        spacing: 30

        delegate: RowLayout {
            width:  myPostPage.width
            SampleLabel {
                text: Author
            }
            SampleLabel {
                Layout.fillWidth: true
                text: "Author " + Author + "\n"
                      + "CreateTime: " + CreateTime + "\n"
                      + "Title: " + Title + "\n"
                      + "Source: " + Source + "\n"
                      + "SourceName: " + SourceName + "\n"
                      + "Summary: " + Summary + "\n"
                      + "CollectionType: " + CollectionType + "\n"
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }
    }
}
