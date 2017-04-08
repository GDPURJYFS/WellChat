//~ PopupLayerSideMenuDelegate

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
                duration: 150
            }
            NumberAnimation {
                easing.overshoot: 5
                properties: "x"
                duration: 150
            }
        }
    }

    hideTransition: PopupLayerTransition {
        SequentialAnimation {
            NumberAnimation {
                easing.overshoot: 5
                properties: "x"
                duration: 150
            }
            NumberAnimation {
                easing.overshoot: 5
                easing.type: Easing.OutBack
                properties: "opacity"
                duration: 100
            }
        }
    }

    hideChanges: [
        PropertyChanges {
            target: popupItem
            x: -popupItem.width
        },
        PropertyChanges {
            target: maskItem
            opacity: 0
        }
    ]

    showChanges: [
        PropertyChanges {
            target: popupItem
            x: 0
        },
        PropertyChanges {
            target: maskItem
            opacity: 1
        }
    ]
}
