pragma Singleton
import QtQuick 2.0
import Qt.labs.settings 1.0
import "UI.js" as UI

QObject {
    id: generalSettings
    objectName: "GeneralSettings"

    // read

    readonly property alias generalFontPointSize: internal.generalFontPointSize
    readonly property alias generalfontFamily: internal.generalfontFamily

    // write

    function setGeneralFontPointSize(size) {
        internal.generalFontPointSize = size;
    }

    function setFontFamily(family) {
        var families  = Qt.fontFamilies();
        for(var iter in families) {
            if(iter === family) {
                internal.fontFamily = family;
            }
        }
    }

    // reset

    function resetGeneralFontPointSiz() {
        internal.generalFontPointSize = UI.StandardFontPointSize;
    }

    function resetFontFamily() {
        internal.fontFamily = UI.defaultFontFamily;
    }

    //////////////////////////////////////////////////////////////////////////

    /*! internal */
    QObject {
        id: internal
        property int generalFontPointSize: UI.StandardFontPointSize
        property string generalfontFamily: UI.defaultFontFamily
    }

    /*! internal settings */
    Settings {
        id: settings
        category: generalSettings.objectName
        property alias generalFontPointSize: internal.generalFontPointSize
        property alias generalfontFamily: internal.generalfontFamily
    }
}

