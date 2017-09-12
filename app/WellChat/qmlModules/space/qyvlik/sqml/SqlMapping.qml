import QtQuick 2.0

// SqlMapping
QtObject {
    id: sqlMapping

    property bool debug: false

    readonly property alias sqlQueryBuilder: sqlMapping.__sqlQueryBuilder

    readonly property SqlQueryBuilder __sqlQueryBuilder: SqlQueryBuilder {
    }

    //@abstract
    function get(entity) {
        return sqlQueryBuilder.dump();
    }

    //@abstract
    function getByEntity(entity) {
        return sqlQueryBuilder.dump();
    }

    //@abstract
    function findList(entity) {
        return sqlQueryBuilder.dump();
    }

    //@abstract
    function insert(entity) {
        return sqlQueryBuilder.dump();
    }

    //@abstract
    function insertList(list) {
        return sqlQueryBuilder.dump();
    }

    //@abstract
    function update(entity) {
        return sqlQueryBuilder.dump();
    }

    //@abstract
    function deleteById(entity) {
        return sqlQueryBuilder.dump();
    }

    //@abstract
    function deleteRecord(entity) {
        return sqlQueryBuilder.dump();
    }

    function stringNotEmpty(str) {
        return typeof str !== 'undefined' && str !== '';
    }
}
