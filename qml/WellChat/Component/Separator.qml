/*
 * author qyvlik
 * email qyvlik@qq.com
 * time 2015/4/10
 * FlatUI.Private element
 *
 * this qml file (element type) just for build module
 * not allow used by user
 *
 *
 * such as drow a line
*/

import QtQuick 2.0

Rectangle {
    id:separator
    property int orientation : Qt.Vertical // Qt.Horizontal
    property int length:orientation == Qt.Vertical ? parent.height*0.6 : parent.width*0.6
    property int separatorWidth : 1

    onOrientationChanged: __fix();
    onLengthChanged: __fix()
    onSeparatorWidthChanged: __fix()

    // private function
    function __fix(){
        switch(orientation){
        case Qt.Vertical:  // 垂直的
            height = length;
            width = separatorWidth;
            break;
        case Qt.Horizontal: // 水平的
            width = length;
            height = separatorWidth;
            break;
        default:
            height = length;
            width = separatorWidth;
            break;
        }
    }
    Component.onCompleted: __fix();
}

