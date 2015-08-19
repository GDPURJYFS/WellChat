import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.0

ToolBar {
    id: toolBar
    // #FAFAFA
    //    style: ToolBarStyle {
    //        padding {
    //            left: 0
    //            right: 0
    //            top: 0
    //            bottom: 0
    //        }
    //        background: Item {
    //            implicitHeight: 40 * Screen.devicePixelRatio
    //            implicitWidth: 200 * Screen.devicePixelRatio
    //            Rectangle {
    //                anchors.fill: parent
    //                gradient: Gradient{
    //                    GradientStop{color: "#eee" ; position: 0}
    //                    GradientStop{color: "#ccc" ; position: 1}
    //                }
    //                Rectangle {
    //                    anchors.bottom: parent.bottom
    //                    width: parent.width
    //                    height: 1
    //                    color: "#999"
    //                }
    //            }
    //        }
    //    }
    property var inline: ToolBar {
        id: i
        visible: false
    }
    // property int trueHeight: i.height
    style: ToolBarStyle {
        background: Rectangle {

            color: "#22292c"

            implicitWidth: i.width * 0.9
            implicitHeight: i.height * 0.9

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: "#ccc"
            }
        }
    }

}
