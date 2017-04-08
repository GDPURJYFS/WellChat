import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import "../../component"

ScrollablePage {
    id: aboutPage

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                text: qsTr("‹")
                onClicked: {
                    stackView.pop()
                }
            }

            Label {
                text: qsTr("About")
                elide: Label.ElideRight
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
            }

        }
    }

    ColumnLayout {
        id:columnLayout
        anchors.fill: parent

        Image {
            id: loginImage
            width: columnLayout.width
            sourceSize: Qt.size(aboutPage.width, 0)
            fillMode: Image.PreserveAspectFit
            source: Qt.resolvedUrl("../../assets/images/jade_by_wlop-d9n5wvp.jpg")
        }

        Label {
            Layout.fillWidth: true
            text: qsTr("1.0.0")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }



    }


}
