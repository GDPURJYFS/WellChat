import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "./UI.js" as UI

Button {
    id: button
    readonly property color beforePressColor:  "#45c01a"
    readonly property color afterPressColor: "#7f8c8d"

    property int buttonSize: UI.middleFontPointSize

    style: ButtonStyle {
        background: Rectangle{
            anchors.fill: parent
            radius: 2
            color:button.pressed?afterPressColor:beforePressColor
        }
        label:Rectangle {
            color: "transparent"
            implicitWidth: buttonText.implicitWidth
            implicitHeight: buttonText.implicitHeight
            baselineOffset: buttonText.y + buttonText.y + buttonText.baselineOffset
            Text{
                id:buttonText
                anchors.centerIn: parent
                text: button.text
                font.pointSize: buttonSize
                horizontalAlignment: Text.AlignHCenter
                font.family: "微软雅黑"
                color:"white";
            }
        }
    }
}
