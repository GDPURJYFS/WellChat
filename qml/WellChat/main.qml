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

    Timer {
        id: timer
        interval: 1000
        // running: true
        repeat: true
        onTriggered: {
            var time = new Date;
            console.log(time.toTimeString(),
                        "--------------------1000:          qt don't sleep",
                        "-----------------------");
        }
    }
}
