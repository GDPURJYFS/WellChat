//! Qt 5.0 or new

// internal import
// don't use the module import
import "./Delegate" as Delegate
import QtQuick 2.0

Rectangle {

    // Mask

    id: layer

    anchors.fill: parent
    visible: opacity != 0

    color: "#aa000000"

    property alias maskColor: layer.color
    readonly property alias popupItem: internalPopupItem
    default property alias data: internalPopupItem.data

    MouseArea {
        anchors.fill: parent
        onClicked: {
            layer.close()
            // _switch();
        }
    }

    Rectangle {
        id: internalPopupItem
        width: parent.width * 0.7
        height: internalPopupItem.width * 0.75
        MouseArea { anchors.fill: parent; onClicked: { } }
    }

    state: "Hide"

    states: [
        State {
            name: "Hide"
            changes: delegate.hideChanges
        },
        State {
            name: "Show"
            changes: delegate.showChanges
        }
    ]

    property PopupLayerDelegate delegate:
        Delegate.PopupLayerDialogDelegate {
        popupItem: internalPopupItem
        maskItem: layer
    }

    transitions: [
        Transition {
            id: hide_to_show
            from: "Hide"
            to: "Show"
            animations: delegate.showTransition.animaitons
        },
        Transition {
            id: show_to_hide
            from: "Show"
            to: "Hide"
            animations: delegate.hideTransition.animaitons
        }
    ]

    function open() {
        if(layer.state == "Hide") {
            layer.state = "Show";
        }
    }

    function close() {
        layer.state = "Hide";
    }

    function switchState() {
        if(layer.state == "Hide") {
            layer.state = "Show";
            return layer.state;
        } else {
            layer.state = "Hide";
            return layer.state;
        }
    }

    function _switch() {
        if(layer.state == "Hide") {
            layer.state = "Show";
        } else {
            layer.state = "Hide";
        }
    }

}
