import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: pageStackWindow
    title: qsTr("WellChat")
    width: 640
    height: 480
    visible: true
    color: "#ebebeb"

    style: ApplicationWindowStyle {
        background: Rectangle {
            width: pageStackWindow.width
            height: pageStackWindow.height
            color: pageStackWindow.color
        }
    }

    property alias initialPage: __stackView.initialItem
    property alias focus: __stackView.focus
    property alias stackView: __stackView
    readonly property alias currentItem: __stackView.currentItem
    readonly property alias depth: __stackView.depth
    readonly property alias busy: __stackView.busy

    StackView {
        id: __stackView
        anchors.fill: parent
        focus: visible
    }

    function clear() { __stackView.clear(); }
    function push(item) { return  __stackView.push(item); }
    function pop(item) { return  __stackView.pop(item); }
}

