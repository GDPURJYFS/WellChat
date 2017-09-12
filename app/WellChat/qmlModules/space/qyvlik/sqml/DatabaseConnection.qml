import QtQuick 2.0
import QtQuick.LocalStorage 2.0

// DatabaseConnection
QtObject {
    id: databaseConnection

    property string identifier: ""
    property string version: ""
    property string description: ""
    property int estimatedSize: 0
    readonly property alias isOpen: databaseConnection.__isOpen
    property bool debug: false

    readonly property var database: databaseConnection.__database

    property var __database
    property bool __isOpen: false

    //    onIdentifierChanged: {
    //        __reOpen();
    //    }

    //@abstract
    function initDatabase(db) {
    }

    function __reOpen() {
        __isOpen = false;
        __tryOpen();
    }

    function __tryOpen() {
        if(!__isOpen) {
            __openDatabase();
        }
    }

    function __openDatabase() {
        if(__isOpen) {
            return;
        }

        __isOpen = true;

        console.debug("identifier", identifier,
                      "version:", version,
                      "description:", description,
                      "estimatedSize:", estimatedSize);

        if(identifier !== '' && version !== '' && description !== '' && estimatedSize != 0) {
            try {
                __database = LocalStorage.openDatabaseSync(identifier,
                                                           version,
                                                           description,
                                                           estimatedSize,
                                                           initDatabase);

                if (__database.version === '') {
                    // FIX:  Error: SQL: database version mismatch
                    __database.changeVersion('', version);
                }

            } catch(e) {
                __isOpen = false;
                console.trace()

                throw e;
            }
        } else {
            __isOpen = false;
            console.debug("identifier", identifier,
                          "version:", version,
                          "description:", description,
                          "estimatedSize:", estimatedSize);
            throw "arguments lost!";
        }
    }

    function changeVersion(from, to, callback) {
        __tryOpen();

        if(typeof from === 'undefined' || from === '') {
            return;
        }

        if(typeof to === 'undefined' || to === '') {
            return;
        }

        if(from === to) {
            return;
        }

        database.changeVersion(from, to, callback);
        version = to;
    }

    function transaction(callback) {
        __tryOpen();

        database.transaction(callback);
    }

    function readTransaction(callback) {
        __tryOpen();

        database.readTransaction(callback);
    }
}
