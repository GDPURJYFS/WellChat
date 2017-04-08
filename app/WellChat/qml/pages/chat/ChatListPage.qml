import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import "../../component/view"
import "../../component"
import "../"

Page {
    id: chatPage
    title: qsTr("Chat")

    ListView {
        anchors.fill: parent
        model: 2

        delegate: FunLabel {
            height: 48 * dp
            width: parent.width
            imageSource: Qt.resolvedUrl("../../assets/images/default.png")
            showBottomLine: false

            onClicked: {
                 stackView.push(chatPageCom);
            }
        }

    }



    function open(msgContent) {

    }
}

