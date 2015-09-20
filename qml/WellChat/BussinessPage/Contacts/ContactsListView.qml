import QtQuick 2.5
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import Sparrow 1.0 as Sparrow

Rectangle {
    id: root
    width: 400
    height: 600
    color: "transparent"

    property ListView mainListView: null

    property alias model: listView.model
    property alias delegate: listView.delegate
    property alias section: listView.section

    ListView {
        id: listView
        anchors.fill: parent
        snapMode: ListView.NoSnap
        maximumFlickVelocity: 5000
        highlightRangeMode: ListView.NoHighlightRange
    }

    function getSectionHeadIndex(sectionModel, role, sectionText) {
        try {
            var count = sectionModel.count;
            var iter = 0;
            while(iter < count) {
                if(sectionModel.get(iter)[role].charAt(0) == sectionText) {
                    return iter;
                }
                ++iter;
            }
        } catch(e) {
            console.log(e);
        }
        return 0;
    }

    Rectangle {
        id: bar
        height: parent.height
        width: Screen.pixelDensity * 5 // 2mn
        anchors.right: parent.right
        color: Qt.rgba(0.5, 0.5, 0.5, 0.5)
        opacity: 0.2

        ColumnLayout {
            anchors.fill: parent
            Repeater {
                id: repeater

                model: ["↑", "☆","a", "b", "c", "d", "e", "f"
                    , "g", "h", "i", "j", "k", "l", "m", "n",
                    "o", "p", "q", "r", "s", "t", "u", "v", "w",
                    "x", "y", "z"]

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: repeater.model[index]
                        font.pointSize: Sparrow.UI.SmallFontPointSize - 1
                    }

            }
        }

        MouseArea {
            anchors.fill: parent

            onReleased: {
                listView.highlightRangeMode = ListView.NoHighlightRange;
                listView.snapMode = ListView.NoSnap;
                mainListView.interactive = true;
                bar.opacity = 0.2;
                showText.close();
            }

            onPositionChanged: {
                bar.opacity = 0.8;
                var itemHeight = parent.height / repeater.model.length;
                var pos = Math.floor(mouse.y / itemHeight);
                try {
                    mainListView.interactive = false;
                    showText.show(repeater.model[pos]);
                    listView.highlightRangeMode = ListView.StrictlyEnforceRange;
                    listView.snapMode = ListView.SnapOneItem;
                    listView.currentIndex =
                            getSectionHeadIndex(listView.model,
                                                listView.section.property,
                                                repeater.model[pos]);
                } catch(e) {
                    listView.highlightRangeMode = ListView.NoHighlightRange;
                    listView.snapMode = ListView.NoSnap;
                    mainListView.interactive = true;
                    console.log(pos);
                    console.log(e)
                }
            }
        }
    }


    Rectangle {
        id: showText
        width: Screen.pixelDensity * 20
        height: Screen.pixelDensity * 20
        color: Qt.rgba(0.8, 0.8,0.8, 0.8)
        anchors.centerIn: parent
        property alias text: text.text
        visible: false
        Sparrow.SampleLabel {
            id: text
            anchors.centerIn: parent
        }
        function show(t) {
            showText.text = t;
            showText.visible = true;
        }
        function close() {
            showText.text = "";
            showText.visible = false;
        }
    }

}

