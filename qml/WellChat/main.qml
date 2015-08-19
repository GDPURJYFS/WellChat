import QtQuick 2.0

QtObject {

    property var mainWindow: MainWindow {

    }

    // 这里检测到应用处于非活跃状态时候，可以触发一个类似支付宝的解锁界面。
    readonly property int applicationState: Qt.application.state

    onApplicationStateChanged: {
        switch(applicationState){
        case Qt.ApplicationActive:
            console.log("ApplicationActive");
            break;
        case Qt.ApplicationInactive:
            console.log("ApplicationInactive");
            break;
        case Qt.ApplicationSuspended:
            console.log("ApplicationSuspended");
            break;
        case Qt.ApplicationHidden:
            console.log("ApplicationHidden");
            break;
        }
    }

    Component.onCompleted: {

    }
}
