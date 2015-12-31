import Resource 1.0 as R

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

import Sparrow 1.0
import Sparrow.PopupLayer 1.0

import "../../Component"

Timer {
    id: lazy
    interval: 100
    running: false
    repeat: false
    property var callback
    onTriggered: {
        try {
            callback();
        } catch(e) {
            
        }
    }
    function startCallback(time, callback) {
        time = time || 500;
        callback = callback || function() { };
        interval = time;
        lazy.callback = callback;
        lazy.start();
    }
}
