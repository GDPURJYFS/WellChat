import QtQuick 2.2

ListView {
    clip: true                                         //此属性的默认值是false，表示不会自动截掉超出显示区域的部分。
    preferredHighlightBegin: 0
    preferredHighlightEnd: 0
    highlightMoveDuration: 250
    highlightRangeMode: ListView.StrictlyEnforceRange
    snapMode: ListView.SnapOneItem
    orientation: ListView.Horizontal
    boundsBehavior: ListView.StopAtBounds

    onCurrentIndexChanged: forceActiveFocus()
}
