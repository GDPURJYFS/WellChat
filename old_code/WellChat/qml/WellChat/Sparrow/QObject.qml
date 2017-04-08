import QtQuick 2.0

QtObject {
    id: qObject
    default property alias data: qObject.__data
    property list<QtObject> __data
}
