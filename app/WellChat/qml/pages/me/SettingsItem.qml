import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import "../../component/view"

ViewItem {

    id: root

    readonly property alias label: label
    property alias labelText: label.text

    Item {
        anchors.fill: parent
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 16 * dp
            anchors.rightMargin: 16 * dp

            Label {
                id: label
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }


}
