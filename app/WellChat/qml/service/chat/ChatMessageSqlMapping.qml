import QtQuick 2.0

import space.qyvlik.sqml 1.0

/*
CREATE TABLE `message` (
`id`  bigint(20) NOT NULL ,
`content`  varchar(2000) NOT NULL ,
`sender_id`  varchar(64) NOT NULL ,
`receiver_id`  varchar(64) NOT NULL ,
`group_id`  varchar(64) NOT NULL ,
`read`  varchar(5) NOT NULL DEFAULT '0' ,
`create_time`  bigint(20) NOT NULL ,
PRIMARY KEY (`id`)
)
;
*/

SqlMapping {
    id: chatMessageSqlMapping

    function __getReturn() {
        return "\n";
    }

    function __getColumn() {
        return "a.id AS 'id', " + "\n"
                + "a.content AS 'content', " + "\n"
                + "a.sender_id AS 'senderId', " + "\n"
                + "a.receiver_id AS 'receiverId', " + "\n"
                + "a.group_id AS 'groupId', " + "\n"
                + "a.read AS 'read', " + "\n"
                + "a.create_time AS 'createTime' " + "\n";
    }

    function __getSingleCondition(entity, field, sqlField, callback) {
        callback = callback || function(condition) {
            if(debug) {
                console.debug(condition);
            }
        }

        if(stringNotEmpty(entity[field])) {
            callback(" " + sqlField + " = ? ");
        }
    }

    //@override
    function get(entity) {
        var sqlArgs = [];
        var sql = " SELECT \n"
                + __getColumn()
                + " FROM message a \n"

        var whereSqlStatement = "";

        if(entity !== null && typeof entity != 'undefined') {
            __getSingleCondition(entity, "id", "id", function(sql){
                sqlArgs.push(entity["id"]);
                whereSqlStatement += sql;
            });
        }

        if(sqlArgs.length != 0) {
            sql += " WHERE " + whereSqlStatement;
        }

        return {
            "sql": sql,
            "bind": sqlArgs
        };
    }

    //@override
    function getByEntity(entity) {
        var sqlArgs = [];
        var sql = " SELECT \n"
                + __getColumn()
                + " FROM message a \n"

        var whereSqlStatement = "";

        if(entity !== null && typeof entity != 'undefined') {
            __getSingleCondition(entity, "id", "id", function(sql){
                sqlArgs.push(entity["id"]);
                whereSqlStatement += sql;
            });

            __getSingleCondition(entity, "senderId", "sender_id", function(sql){
                sqlArgs.push(entity["id"]);
                whereSqlStatement += sql;
            });

            __getSingleCondition(entity, "receiverId", "receiver_id", function(sql){
                sqlArgs.push(entity["id"]);
                whereSqlStatement += sql;
            });

            __getSingleCondition(entity, "groupId", "group_id", function(sql){
                sqlArgs.push(entity["id"]);
                whereSqlStatement += sql;
            });

            __getSingleCondition(entity, "read", "read", function(sql){
                sqlArgs.push(entity["id"]);
                whereSqlStatement += sql;
            });
        }

        if(sqlArgs.length != 0) {
            sql += " WHERE " + whereSqlStatement;
        }

        return {
            "sql": sql,
            "bind": sqlArgs
        };
    }



    //@override
    function findList(entity) {
        var sqlArgs = [];
        var sql = "SELECT \n"
                + __getColumn()
                + " FROM message a \n"

        var whereSqlStatement = "";

        if(entity !== null && typeof entity != 'undefined') {
            __getSingleCondition(entity, "id", "id", function(sql){
                sqlArgs.push(entity["id"]);
                whereSqlStatement += sql;
            });

            __getSingleCondition(entity, "senderId", "sender_id", function(sql){
                sqlArgs.push(entity["senderId"]);
                whereSqlStatement += sql;
            });

            __getSingleCondition(entity, "receiverId", "receiver_id", function(sql){
                sqlArgs.push(entity["receiverId"]);
                whereSqlStatement += sql;
            });

            __getSingleCondition(entity, "groupId", "group_id", function(sql){
                sqlArgs.push(entity["groupId"]);
                whereSqlStatement += sql;
            });

            __getSingleCondition(entity, "read", "read", function(sql){
                sqlArgs.push(entity["read"]);
                whereSqlStatement += sql;
            });
        }

        var orderBySql = " ORDER BY create_time ";
        if(sqlArgs.length != 0) {
            sql += " WHERE " + whereSqlStatement + orderBySql;
        }

        return {
            "sql": sql,
            "bind": sqlArgs
        };
    }

    //@override
    function insert(entity) {
        var sql = "INSERT INTO message \n"
                + " ";

        var sqlFieldColumn = "(
                 id,
                 content,
                 sender_id,
                 receiver_id,
                 group_id,
                 read,
                 create_time
                )\n";

        var sqlValues = " VALUES (
            ?, ?, ?, ?, ?, ?, ?
        );";

        sql += sqlFieldColumn + sqlValues;

        var sqlArgs = [entity.id,
                       entity.content,
                       entity.senderId,
                       entity.receiverId,
                       entity.groupId,
                       entity.read,
                       entity.createTime];

        return {
            "sql": sql,
            "bind": sqlArgs
        };
    }

    //@override
    function update(entity) {
        throw new Error('Not support Update');
    }

    //@override
    function deleteById(entity) {
        throw new Error('Not support Update');
    }

    //@override
    function deleteRecord(entity) {
        throw new Error('Not support Update');
    }
}
