import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0

import "../component/view"
import "../component"

ScrollablePage {
    id: loginPage
    title: qsTr("Login")

    signal loginSuccess();

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                text: qsTr("⋮")
                onClicked: menu.open()
                Layout.alignment: Qt.AlignRight

                Menu {
                    id: menu

                    MenuItem {
                        text: qsTr("About")
                        onClicked: stackView.push(aboutPageCom)
                    }
                }

            }
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        anchors.margins: 16 * dp
        spacing: 16 * dp

        Image {
            id: loginImage
            width: columnLayout.width
            sourceSize: Qt.size(loginPage.width - 32 * dp, 0)
            fillMode: Image.PreserveAspectFit
            source: Qt.resolvedUrl("../assets/images/jade_by_wlop-d9n5wvp.jpg")
        }

        TextField {
            selectByMouse: true
            Layout.fillWidth: true
            placeholderText: qsTr("Enter UserName")
        }

        TextField {
            selectByMouse: true
            Layout.fillWidth: true
            placeholderText: qsTr("Enter Password")
        }

        Button {
            text: qsTr("Login")
            Layout.fillWidth: true
            onClicked: {
                loginSuccess();
            }
        }
    }

    Component.onCompleted: {
        loginSuccess()
    }

}
