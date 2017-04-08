import QtQuick 2.0

// SqlMapping
QtObject {
    id: sqlMapping

    property bool debug: false

    //@abstract
    function get(entity) {
        var sql = "";
        var sqlArgs = [];
        return {
            "sql": "",
            "sqlArgs": []
        };
    }

    //@abstract
    function getByEntity(entity) {
        var sql = "";
        var sqlArgs = [];
        return {
            "sql": "",
            "sqlArgs": []
        };
    }

    //@abstract
    function findList(entity) {
        var sql = "";
        var sqlArgs = [];
        return {
            "sql": "",
            "sqlArgs": []
        };
    }

    //@abstract
    function insert(entity) {
        var sql = "";
        var sqlArgs = [];
        return {
            "sql": "",
            "sqlArgs": []
        };
    }

    //@abstract
    function update(entity) {
        var sql = "";
        var sqlArgs = [];
        return {
            "sql": "",
            "sqlArgs": []
        };
    }

    //@abstract
    function deleteById(entity) {
        var sql = "";
        var sqlArgs = [];
        return {
            "sql": "",
            "sqlArgs": []
        };
    }

    //@abstract
    function deleteRecord(entity) {
        var sql = "";
        var sqlArgs = [];
        return {
            "sql": "",
            "sqlArgs": []
        };
    }

    function stringNotEmpty(str) {
        return typeof str !== 'undefined' && str !== '';
    }
}
