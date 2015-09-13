import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "../../../Component"
import Sparrow 1.0

Page {
    id: momentsPage
    title: "moments"
    color: "#22292c"

    focus: true
    Keys.onBackPressed: {
        event.accepted = true;
        try { stackView.pop(); }  catch(e) { }
    }

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
                text: momentsPage.title
                // Layout.alignment: Qt.AlignRight
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                font.family: "微软雅黑"
                font.pointSize: constant.middleFontPointSize
            }
        }
    }

    Item {
        id: loadProgressArea
        width: parent.width
        height: 3
        Rectangle {
            height: parent.height
            width: parent.width * (1/webPage.loadProgress)
            color: "blue"
        }
    }

    WebPage {
        id: webPage
        anchors.top: loadProgressArea.bottom
        url: "http://www.baidu.com"
        anchors.fill: parent
    }

}

