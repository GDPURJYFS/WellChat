import QtQuick 2.0

// CrudDao
QtObject {
    id: dao

    readonly property var get: dao.__getImpl
    readonly property var getByEntity: dao.__getByEntityImpl
    readonly property var findList: dao.__findListImpl
    readonly property var insert: dao.__insertImpl
    readonly property var update: dao.__updateImpl
    readonly property var deleteById: dao.__deleteByIdImpl
    readonly property var deleteRecord: dao.__deleteRecordImpl

    property bool debug: true

    //protected:
    property DatabaseConnection __connection: null
    property SqlMapping __sqlMapping: null

    //@abstract
    function __getImpl(entity, callback, error) {
        __executeSqlImpl(entity, __sqlMapping.get, false, function(results){
            if(results.rows.length > 1) {
                throw "getById should be only one result, result size: "
                        + results.rows.length;
            }
            callback(results.rows.item(0));
        }, error);
    }

    //@abstract
    function __getByEntityImpl(entity, callback, error) {
        __executeSqlImpl(entity, __sqlMapping.getByEntity, true, function(results){
            if(results.rows.length > 1) {
                throw "getById should be only one result, result size: "
                        + results.rows.length;
            }
            callback(results.rows.item(0));
        }, error);
    }

    //@abstract
    function __findListImpl(entity, callback, error) {
        __executeSqlImpl(entity, __sqlMapping.findList, true, function(results){
            var resultList = [];
            for(var i = 0; i < results.rows.length; i++) {
                resultList.push(results.rows.item(i));
            }
            callback(resultList);
        }, error);
    }

    //@abstract
    function __insertImpl(entity, callback, error) {
        __executeSqlImpl(entity, __sqlMapping.insert, false, function(results){
            callback(results.rowsAffected);
        }, error);
    }

    //@abstract
    function __updateImpl(entity, callback, error) {
        __executeSqlImpl(entity, __sqlMapping.update, false, function(results){
            callback(results.rowsAffected);
        }, error);
    }

    //@abstract
    function __deleteByIdImpl(entity, callback, error) {
        __executeSqlImpl(entity, __sqlMapping.deleteById, false, function(results){
            callback(results.rowsAffected);
        }, error);
    }

    //@abstract
    function __deleteRecordImpl(entity, callback, error) {
        __executeSqlImpl(entity, __sqlMapping.deleteRecord, false, function(results){
            callback(results.rowsAffected);
        }, error);
    }

    function __checkImpl(entity) {
        return connection != null
                && __sqlMapping != null
                && typeof entity !== 'undefined';
    }


    function __executeSqlImpl(entity, mapping, readOnly, callback, error) {
        if(!__checkImpl(entity)) {
            console.error(JSON.stringify(entity), connection, __sqlMapping);
            error(new Error("check error"));
            return;
        }

        var ret = mapping(entity);
        //! [0] avoid have a blank char before SELECT
        var sql = ret.sql.trim();
        //! [0]
        var sqlArgs = ret.sqlArgs;

        if(debug) {
            console.debug("__executeSqlImpl : ", sql, " sqlArgs:", sqlArgs);
        }

        if(typeof sql === '' || sql === "") {
            error(new Error("sql is empty"));
            return;
        }

        var transaction = readOnly ? connection.readTransaction
                                   : connection.transaction;
        transaction(function(tx){
            try {
                var resultList = tx.executeSql(sql, sqlArgs);
                if(debug) {
                    console.debug("resultList lenght : ", resultList.rows.length
                                  , " rowsAffected : ", resultList.rowsAffected
                                  , " insertId : ", resultList.insertId);
                }
                callback(resultList);
            } catch(e) {
                console.error("sql: ", sql);
                error(e);
            }
        });
    }

}
