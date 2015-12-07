import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import Sparrow 1.0

PageStackWindow {
    id: mainWindow
    title: qsTr("WellChat")
    initialPage: MainView {
        id: mainView
        focus: mainWindow.focus
        stackView: mainWindow.stackView
        pageStackWindow: mainWindow
        width: stackView.width
        height: stackView.height

        Keys.onBackPressed: {
            event.accepted = true;
            // console.log("back")
            Qt.quit();
        }
    }

    property int applicationState : Qt.application.state

    onApplicationStateChanged: {
        if(applicationState == Qt.ApplicationActive) {
            try {
                var topBarColor = mainView.topBar.backgroundColor;
                console.log("get topBarColor:", topBarColor);
                console.log("try to set status bar color:");
                BridgingAndroid
                .setStatusBarColor(topBarColor);
                console.log("success!");
            }　catch(e) {console.log(e);}
        }
    }
}
