import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

import "./pages"
import "./pages/me"
import "./pages/common"
import "./pages/chat"


ApplicationWindow {
    visible: true
    title: qsTr("Chat")

    width: 360
    height: 640

    property real dpScale:  1.5
    readonly property real dp: Math.max(Screen.pixelDensity * 25.4 / 160 * dpScale, 1)

    readonly property alias stackView: __stackView

    font.family: "微软雅黑"

    Database {
        id: dataBase
    }

    Settings {
        id: globalSettings
        category: "MessageNotification"
        property bool notification: true
    }

    StackView {
        id: __stackView
        anchors.fill: parent
        initialItem: LoginPage {
            id: loginPage
            onLoginSuccess: {
                __stackView.push(mainPageCom);
            }
        }       
    }

    Component {
        id: mainPageCom
        MainPage { }
    }

    Component {
        id: settingsPageCom
        SettingsPage { }
    }

    Component {
        id: aboutPageCom
        AboutPage { }
    }

    Component {
        id: chatPageCom
        ChatPage { }
    }

    Component.onCompleted: {
        dataBase.transaction(function (tx){
            var sql = "
            CREATE TABLE IF NOT EXISTS `message` (
            `id`  varchar(64) NOT NULL,
            `content`  varchar(2000) NOT NULL,
            `sender_id`  varchar(64) NOT NULL,
            `receiver_id`  varchar(64) NOT NULL,
            `group_id`  varchar(64) NOT NULL,
            `read`  varchar(5) NOT NULL DEFAULT '0',
            `create_time`  bigint(20) NOT NULL,
            PRIMARY KEY (`id`)
            );";
            tx.executeSql(sql);
        });
    }

    Component.onDestruction:  {
//        dataBase.transaction(function (tx){
//            var sql = 'DROP TABLE message';
//            tx.executeSql(sql);
//            console.log("sql: ", sql)
//        });
    }


}
