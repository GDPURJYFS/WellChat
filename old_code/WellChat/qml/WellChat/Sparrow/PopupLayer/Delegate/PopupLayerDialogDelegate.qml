//~ PopupLayerDialogDelegate

// internal import
// don't use the module import
import "../"
import QtQuick 2.0

PopupLayerDelegate {

    showTransition: PopupLayerTransition {
        SequentialAnimation {
            NumberAnimation {
                easing.overshoot: 5
                easing.type: Easing.OutBack
                properties: "opacity"
                duration: 50
            }
            AnchorAnimation {
                duration: 250
            }
            PauseAnimation { duration: 50 }
            NumberAnimation {
                easing.overshoot: 5
                easing.type: Easing.OutBack
                properties: "rotation,anchors.bottomMargin"
                duration: 150
            }
        }
    }

    hideTransition: PopupLayerTransition {
        SequentialAnimation {
            NumberAnimation {
                easing.overshoot: 5
                easing.type: Easing.OutBack
                properties: "anchors.bottomMargin"
                duration: 150
            }
            AnchorAnimation { duration: 250 }
            NumberAnimation {
                easing.overshoot: 5
                easing.type: Easing.OutBack
                properties: "rotation,opacity"
                duration: 50
            }
        }
    }

    hideChanges: [
        AnchorChanges {
            target: popupItem
            anchors.bottom: maskItem.top
            anchors.horizontalCenter: maskItem.horizontalCenter
        },
        PropertyChanges {
            target: popupItem
            anchors.bottomMargin: Math.sin(Math.PI*2/360*10) * (popupItem.width/2)
            rotation: 10
        },
        PropertyChanges {
            target: maskItem
            opacity: 0
        }
    ]

    showChanges: [
        AnchorChanges {
            target: popupItem
            anchors.verticalCenter: maskItem.verticalCenter
            anchors.horizontalCenter: maskItem.horizontalCenter
        },
        PropertyChanges {
            target: popupItem
            anchors.bottomMargin: Math.sin(Math.PI*2/360*10) * (popupItem.width/2)
            rotation: 0
        },
        PropertyChanges {
            target: maskItem
            opacity: 1
        }
    ]
}
