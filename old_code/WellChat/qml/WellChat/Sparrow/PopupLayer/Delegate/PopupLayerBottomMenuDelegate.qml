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
        }
    }

    hideTransition: PopupLayerTransition {
        SequentialAnimation {
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
            anchors.top: maskItem.bottom
            anchors.horizontalCenter: maskItem.horizontalCenter
        },
        PropertyChanges {
            target: maskItem
            opacity: 0
        }
    ]

    showChanges: [
        AnchorChanges {
            target: popupItem
            anchors.bottom: maskItem.bottom
            anchors.horizontalCenter: maskItem.horizontalCenter
        },
        PropertyChanges {
            target: maskItem
            opacity: 1
        }
    ]
}
