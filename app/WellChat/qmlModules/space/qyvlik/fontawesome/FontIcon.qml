import QtQuick 2.5
import QtQuick.Controls 2.0

import "."

ItemDelegate {
    id: fontIcon

    //! [avoid]
    //! DirectWrite: CreateFontFaceFromHDC() failed ()
    //! for QFontDef(Family="", pointsize=10.5, pixelsize=14, styleHint=5, weight=57, stretch=100, hintingPreference=0)
    //! LOGFONT("MS Sans Serif", lfWidth=0, lfHeight=-14) dpi=96
    Binding {
        target: fontIcon
        when: FontAwesome.init
        property: "font.family"
        value: FontAwesome.fontFamily
    }
}
