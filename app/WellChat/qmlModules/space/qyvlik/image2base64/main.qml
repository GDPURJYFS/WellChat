import QtQuick 2.0

Item {
    width: 360
    height: 640


    Image2Base64 {
        id: image2Base64
        visible: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            image2Base64.toBase64(Qt.resolvedUrl("../images/qyvlik.png"));
        }
    }
}
