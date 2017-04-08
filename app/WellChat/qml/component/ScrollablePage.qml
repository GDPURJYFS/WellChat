import QtQuick 2.6
import QtQuick.Controls 2.0

Page {
    id: page

//    width: 360
//    height: 640

    default property alias content: pane.contentItem

    Flickable {
        anchors.fill: parent
        contentHeight: pane.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded

        Pane {
            id: pane
            width: parent.width
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
