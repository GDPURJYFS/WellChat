import QtQuick 2.0

QtObject {
    id: heartbeat

    property alias source: worker.source
    property alias interval: timer.interval
    property alias running: timer.running

    signal message(var msg)
    signal beat()

    property Timer timer: Timer {
        id: timer
        repeat: true
        interval: 1500
        triggeredOnStart: true
        running: false
    }

    property WorkerScript worker: WorkerScript {
        id: worker
    }

    function sendMessage(msg) { worker.sendMessage(msg); }
    function start() { timer.start(); }
    function stop() { timer.stop(); }

    Component.onCompleted: {
        worker.message.connect(message);
        timer.triggered.connect(beat);
    }
}

