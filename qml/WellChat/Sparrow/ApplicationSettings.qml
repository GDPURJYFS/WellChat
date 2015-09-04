pragma Singleton
import QtQuick 2.0
import Qt.labs.settings 1.0
import "./UI.js" as UI

QObject {
    id: applicationSettingsSingleton

    readonly property alias defaultNormalFontPointSize: internal.defaultNormalFontPointSize
    function setNormalFontPointSize(fontPointSize) {  internal.defaultNormalFontPointSize = fontPointSize; }
    function resetNormalFontPointSize(){ internal.defaultNormalFontPointSize = UI.StandardFontPointSize; }

    readonly property alias fontFamily: text.font.family
    function setFontFamily(familyName) { text.font.family = familyName; }
    function resetFontFamily() { text.font.family = UI.defaultFontFamily; }


    readonly property alias gridViewBufferBlock: internal.defaultGridViewBufferBlock
    function setGridViewBufferBlock(block) {
        internal.defaultGridViewBufferBlock = block;
    }
    function resetGridViewBufferBlock() {
        internal.defaultGridViewBufferBlock = UI.gridViewBufferBlock;
    }

    readonly property alias defaultPageEnablePush: internal.defaultPageEnablePush
    function setPageEnablePush(enable) {
        internal.defaultPageEnablePush = enable;
    }

    Settings {
        id: settings
        property alias fontPointSize: internal.defaultNormalFontPointSize
        property alias defaultPageEnablePush: internal.defaultPageEnablePush
    }

    QObject {
        id: internal
        property int defaultNormalFontPointSize: UI.StandardFontPointSize
        property int defaultGridViewBufferBlock: UI.gridViewBufferBlock
        property bool defaultPageEnablePush: true
        Text {
            id: text
            font.family: UI.defaultFontFamily
            font.pointSize: internal.defaultNormalFontPointSize
        }
    }
}
