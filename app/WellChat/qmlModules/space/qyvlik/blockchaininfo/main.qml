import QtQuick 2.0
import QtQuick.Window 2.2

Item {

    width: 360 * dp
    height: 640 * dp

    focus: true

    Keys.onEscapePressed: {
        Qt.quit();
    }

    property real dpScale:  1.5
    readonly property real dp: Math.max(Screen.pixelDensity * 25.4 / 160 * dpScale, 1)

    ListView {
        anchors.fill: parent
        anchors.margins: 8 * dp
        model: ListModel {
            id: listModel
        }
        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 200 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 200 }
        }

        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 200; easing.type: Easing.OutBounce }
        }

        delegate: Rectangle {
            width: parent.width
            height: 48 * dp
            border.width: 1 * dp
            border.color: "#ccc"

            Text {
                width: parent.width
                text: txid
                elide: Text.ElideMiddle
            }
        }
    }

    BlockChainInfo {
        id: blockChainInfo
        active: true
        subscribingAfterActive: true

        onTransaction: {
            console.info("txid:", txObj.hash);

            listModel.insert(0, {txid: txObj.hash});

            if (listModel.count > 20) {
                listModel.remove(20);
            }
        }

        onBlock: {
            console.info(blockObj.hash);
        }

        onError: {
            console.error(errorString);
        }
    }

}

