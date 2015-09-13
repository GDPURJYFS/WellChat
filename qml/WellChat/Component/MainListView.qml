import QtQuick 2.2

ListView {
    clip: true
    preferredHighlightBegin: 0
    preferredHighlightEnd: 0
    highlightMoveDuration: 250
    highlightRangeMode: ListView.StrictlyEnforceRange
    snapMode: ListView.SnapOneItem
    orientation: ListView.Horizontal
    maximumFlickVelocity: 3000
    boundsBehavior: ListView.StopAtBounds

    onCurrentIndexChanged: forceActiveFocus()
}
