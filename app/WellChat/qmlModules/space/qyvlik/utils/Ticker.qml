import QtQuick 2.5

/*!
    \qmltype Lazyer

    Example:
    \qml
    Ticker {
        id: ticker
        Component.onCompleted: {
            ticker.tick(1000, function(){
                console.log("tick....");
            });
        }
    }
    \endqml
*/
Timer {
    id: ticker
    interval: 100
    repeat: true
    triggeredOnStart: true
    property var callable
    onTriggered: {
        try {
            callable();
        } catch(e) {
            console.trace();
            console.log(e);
        }
    }

    function tick(time, callable) {
        interval = time;
        ticker.callable = callable;
        ticker.start();
    }
}
