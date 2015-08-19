/*
 * author qyvlik
 * email qyvlik@qq.com
 * time 2015/4/10
 * FLatUI element FlatTextField
 *
*/
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import "./UI.js" as UI

TextArea {
    id:textArea
    font.pointSize: UI.normalFontPointSize
    font.family: "微软雅黑"
    wrapMode: TextEdit.Wrap
    backgroundVisible: false
    // 微信绿 #71d01d
    // 普通灰 #ccc

    Rectangle {
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        height: 1
        color: parent.focus? "#71d01d" : "#ccc"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
    }
}
