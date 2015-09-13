import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import Sparrow 1.0

Button {
    id: button
    readonly property color beforePressColor:  "#45c01a"
    readonly property color afterPressColor: "#7f8c8d"

    style: ButtonStyle {
        background: Rectangle{
            anchors.fill: parent
            radius: 2
            color:button.pressed?afterPressColor:beforePressColor
        }
        label:Rectangle {
            color: "transparent"
            implicitWidth: buttonText.implicitWidth * 1.5
            implicitHeight: buttonText.implicitHeight * 1.5
            baselineOffset: buttonText.y + buttonText.y + buttonText.baselineOffset
            SampleLabel{
                id:buttonText
                anchors.centerIn: parent
                text: button.text
                horizontalAlignment: Text.AlignHCenter
                color:"white";
            }
        }
    }
}
