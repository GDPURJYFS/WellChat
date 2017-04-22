import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

ApplicationWindow {

    color: "transparent"

    RowLayout {
        anchors.fill: parent
        Button {

            opacity: 0.5
            text: "Opacity"
        }

        Button {

            text: "UnOpacity"
        }
    }
}
