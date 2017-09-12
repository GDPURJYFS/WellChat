import QtQuick 2.0

QtObject {
    id: service

    property DatabaseConnection connection
    readonly property alias dao: service.__dao
    property bool debug: connection != null ? connection.debug : false

    //protected:
    property CrudDao __dao

    function get(entity, callback, error) {
        error = error || __errorImpl;
        dao.get(entity, callback, error);
    }

    function getByEntity(entity, callback, error) {
        error = error || __errorImpl;
        dao.getByEntity(entity, callback, error);
    }

    function findList(entity, callback, error) {
        error = error || __errorImpl;
        dao.findList(entity, callback, error);
    }

    function insert(entity, callback, error) {
        error = error || __errorImpl;
        dao.insert(entity, callback, error);
    }

    function insertList(list, callback, error) {
        error = error || __errorImpl;
        dao.insertList(list, callback, error);
    }

    function update(entity, callback, error) {
        error = error || __errorImpl;
        dao.update(entity, callback, error);
    }

    function deleteById(entity, callback, error) {
        error = error || __errorImpl;
        dao.deleteById(entity, callback, error);
    }

    function deleteRecord(entity, callback, error) {
        error = error || __errorImpl;
        dao.deleteById(entity, callback, error);
    }

    function __errorImpl(error) {
        console.trace();
        console.log(error);
        if(error instanceof Error) {
            throw error;
        } else {
            throw new Error(error);
        }
    }
}
