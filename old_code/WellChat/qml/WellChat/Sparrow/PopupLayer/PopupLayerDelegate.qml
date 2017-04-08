//~ PopupLayerDelegate
import QtQuick 2.0

QtObject {
    id: popupLayerDelegate

    property PopupLayerTransition showTransition: null

    property PopupLayerTransition hideTransition: null

    property Item popupItem: null

    property Item maskItem: null

    property list<QtObject> showChanges

    property list<QtObject> hideChanges

}

