import QtQuick 2.0

QtObject {
    id: popupLayerTransition
    default property alias animaitons: popupLayerTransition.__animaions

    // Animation is an abstract class
    // property list<Animation> __animaions
     property list<QtObject> __animaions
}

