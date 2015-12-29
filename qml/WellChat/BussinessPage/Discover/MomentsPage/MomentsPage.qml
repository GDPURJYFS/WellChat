import Resource 1.0 as R

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

import Sparrow 1.0

import "../../../Component"

Page {
    id: momentsPage
    title: "moments"
    color: "#22292c"

    focus: true
    Keys.onBackPressed: {
        event.accepted = true;
        if(webPage.canGoBack) {
            webPage.goBack();
        } else {
            try { stackView.pop(); }
            catch(e) { console.log(e); }
        }
    }

    Constant {
        id: constant
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
                iconSize: Qt.size( topBar.height - 2,  topBar.height - 2)
                anchors.verticalCenter: parent.verticalCenter
                iconSource: R.R.activeIconBack
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
                font.family: GeneralSettings.generalfontFamily
                font.pointSize: constant.middleFontPointSize
            }
        }
    }

    Item {
        anchors.fill: parent

        Item {
            id: loadProgressArea
            width: momentsPage.width
            height: Screen.pixelDensity
            visible: webPage.loadProgress != 100
            Rectangle {
                height: parent.height
                width: parent.width * (100/webPage.loadProgress)
                color: "green"
            }
        }

        WebPage {
            id: webPage
            width: momentsPage.width
            anchors.top: loadProgressArea.bottom
            anchors.bottom: parent.bottom
            url: "https://github.com/GDPURJYFS/WellChat"
//            {
//                if(Qt.platform.os == "android") {
//                    return Qt.resolvedUrl("file:///android_asset/html/index.html");
//                }  else  {
//                    return "../../../Resource/html/index.html";
//                }
//            }
        }
    }
}

