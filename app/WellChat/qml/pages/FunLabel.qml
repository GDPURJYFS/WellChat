import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import "../component/view"

ViewItem {
        id: root
    height: dp * 64

    readonly property alias image: image
    property alias imageSource: image.source


    Image {
        id: image
        width: dp * root.height * 0.7
        height: dp * root.height * 0.7
        fillMode: Image.PreserveAspectFit

        anchors.left: parent.left
        anchors.leftMargin: dp * 8
        anchors.verticalCenter: parent.verticalCenter
        sourceSize: Qt.size(image.width, image.height)
    }

}
