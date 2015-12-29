import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import Sparrow 1.0

Button {
    id: button
    property color buttonColor: "#45c01a"

    readonly property alias pressed: mouseArea.pressed
    readonly property alias hovered: mouseArea.hovered

    style: ButtonStyle {
        background: Rectangle{
            anchors.fill: parent
            radius: button.height * 0.1
            color: buttonColor
        }
        label:Rectangle {
            color: "transparent"
            implicitWidth: buttonText.implicitWidth * 1.5
            implicitHeight: buttonText.implicitHeight * 2.0
            baselineOffset: buttonText.y + buttonText.y + buttonText.baselineOffset
            SampleLabel {
                id:buttonText
                anchors.centerIn: parent
                text: button.text
                horizontalAlignment: Text.AlignHCenter
                color:"white";
            }
        }
    }

    MouseArea {
        id: mouseArea
        property bool pressed: false
        property bool hovered: false
        hoverEnabled: true
        anchors.fill: parent

        onEntered: hovered = true;

        onExited: hovered = false;

        onReleased: pressed = false;

        onPressed: {
            pressed = true;
            shaderEffect.touchStart(mouse.x, mouse.y);
        }

        onClicked: lazyClicked.start();
    }

    Timer {
        id: lazyClicked
        interval: 100
        onTriggered: {
            button.clicked();
        }
    }

    ClickedShaderEffect {
        id: shaderEffect
        anchors.fill: parent
    }
}
