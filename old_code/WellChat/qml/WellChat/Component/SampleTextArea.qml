/*
 * author qyvlik
 * email qyvlik@qq.com
 * time 2015/4/10
 * FLatUI element FlatTextField
 *
*/
import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import Sparrow 1.0

TextArea {
    id:textArea
    font.family: GeneralSettings.generalfontFamily
    font.pointSize: GeneralSettings.generalFontPointSize
    wrapMode: TextEdit.Wrap
    backgroundVisible: false
    // 微信绿 #71d01d
    // 普通灰 #ccc

//    style: TextAreaStyle {
//        renderType: Text.NativeRendering
//    }

    FontMetrics {
        id: fontMetrics
        font.family: GeneralSettings.generalfontFamily
        font.pointSize: GeneralSettings.generalFontPointSize
        font.weight: Font.Thin
        font.bold: false
    }

    Rectangle {
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        height: 1
        color: parent.focus? "#71d01d" : "#ccc"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: fontMetrics.height * 0.2
    }
}
