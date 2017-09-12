import QtQuick 2.0

QtObject {
    id: builder

    readonly property string spaceString: ' ';

    property alias sqlQuery: builder.__sqlQuery
    property alias bind: builder.__bind

    property string __sqlQuery: ''
    property var __bind: []

    function dumpSql() {
        var dumpStr = sqlQuery.trim();
        __sqlQuery = '';
        return dumpStr;
    }

    function dumpBind() {
        var bind = __bind;
        __bind = [];
        return bind;
    }

    function dump() {
        var query = {
            sql: dumpSql(),
            bind: dumpBind()
        }
        return query;
    }

    function select(fields) {
        var fieldsType = typeof fields;
        var selectPrefix = 'SELECT' + spaceString;

        switch(fieldsType) {
        case 'string':
            __sqlQuery += selectPrefix + fields + spaceString;
            break;

        case 'object':
        case 'array':
            var _sql = __fields(fields);
            __sqlQuery += selectPrefix + _sql + spaceString;
            break;

        case 'undefined':
        default:
            throw new TypeError('fields is not a string or array or object type: '
                                + fieldsType);
        }

        return builder;
    }

    function from(tableName) {
        __checkTableName(tableName);

        var fromPrefix = spaceString + 'FROM' + spaceString;


        __sqlQuery += fromPrefix + tableName + spaceString;

        return builder;
    }

    function where(callback) {
        var argLen = arguments.length;

        if (argLen == 0) {
            var wherePrefix = spaceString + 'WHERE' + spaceString;

            __sqlQuery += wherePrefix;
        } else if (argLen == 1) {
            __where2(callback);
        }

        return builder;
    }

    function __where2(callback) {
        callback = callback || function(_builder) {
        };
        var wherePrefix = spaceString + 'WHERE' + spaceString;
        var component = Qt.createComponent("./SqlQueryBuilder.qml");

        var __builder = component.createObject(builder);

        callback(__builder);

        var __dump = __builder.dump();

        try {
            __builder.destroy();
        } catch(e) {
            console.error(e);
        }

        if (__dump.sql === '') {
            return builder;
        }

        __sqlQuery += wherePrefix;
        __sqlQuery += __dump.sql;
        __bind = __bind.concat(__dump.bind);
    }


    function and() {
        var andPrefix = spaceString + 'AND' + spaceString;
        __sqlQuery += andPrefix;
        return builder;
    }

    function or() {
        var orPrefix = spaceString + 'OR' + spaceString;

        __sqlQuery += orPrefix;

        return builder;
    }

    function lt(field, value) {
        var result = __binaryOperator(field, '<', value);
        __sqlQuery += result.sql;
        __bind = __bind.concat(result.bind);
        return builder;
    }

    function gt(field, value) {
        var result = __binaryOperator(field, '>', value);
        __sqlQuery += result.sql;
        __bind = __bind.concat(result.bind);
        return builder;
    }

    function lte(field, value) {
        var result = __binaryOperator(field, '<=', value);
        __sqlQuery += result.sql;
        __bind = __bind.concat(result.bind);
        return builder;
    }

    function gte(field, value) {
        var result = __binaryOperator(field, '>=', value);
        __sqlQuery += result.sql;
        __bind = __bind.concat(result.bind);
        return builder;
    }

    function equals(field, value) {
        var result = __binaryOperator(field, '=', value);
        __sqlQuery += result.sql;
        __bind = __bind.concat(result.bind);
        return builder;
    }

    function notEquals(field, value) {
        var result = __binaryOperator(field, '!=', value);
        __sqlQuery += result.sql;
        __bind = __bind.concat(result.bind);
        return builder;
    }

    function like(field, value) {
        var result = __binaryOperator(field, 'like', value);
        __sqlQuery += result.sql;
        __bind = __bind.concat(result.bind);
        return builder;
    }

    function inValues(field, values) {
        var inPrefix = spaceString + "IN" + spaceString;
        var fieldType = typeof field;
        var valuesType = typeof values;

        if(fieldType !== 'string') {
            throw new TypeError('field ' + field + ' is not a string type: '
                                + fieldType );
        }

        if(valuesType !== 'object') {
            throw new TypeError('values ' + values + ' is not a obejct type: '
                                + valuesType );
        }

        var result = __values(values);

        __bind = __bind.concat(result.bind);
        __sqlQuery +=  spaceString + field + inPrefix + result.sql;

        return builder;
    }

    function orderBy(fields) {
        var fieldsType = typeof fields;
        var orderByPrefix = spaceString + "ORDER BY" + spaceString;

        if(fieldsType != 'object') {
            throw new TypeError('fields ' + fields + ' is not a obejct type: '
                                + fieldsType );
        }

        var fieldStr = __fields(fields);

        __sqlQuery += orderByPrefix + fieldStr;
        return builder;
    }

    function groupBy(fields) {
        var fieldsType = typeof fields;
        var groupByPrefix = spaceString + "GROUP BY" + spaceString;

        if(fieldsType != 'object') {
            throw new TypeError('fields ' + fields + ' is not a obejct type: '
                                + fieldsType );
        }

        var fieldStr =  __fields(fields);

        __sqlQuery += groupByPrefix + fieldStr;
        return builder;
    }

    function __binaryOperator(field, op, value) {
        var opType = typeof op;
        var fieldType = typeof field;
        var valueType = typeof value;

        if(fieldType !== 'string') {
            throw new TypeError('field ' + field + ' is not a string type: '
                                + fieldType );
        }

        if(opType !== 'string') {
            throw new TypeError('op ' + op + ' is not a string type: '
                                + opType);
        }

        if(valueType === 'undefined') {
            throw new TypeError('value is undefined type!');
        }

        var opStr = spaceString + op + spaceString;
        var sql = spaceString + field + opStr + "?";
        var bind_ = [];

        bind_.push(value);

        return {
            sql: sql,
            bind: bind_
        }
    }

    function insertInto(tableName, fields, values) {
        var insertPrefix = 'INSERT INTO' + spaceString;
        var valuesPrefix = spaceString + "VALUES" + spaceString;

        var argLength = arguments.length;               // arguemnts length

        var fieldsType = typeof fields;
        var valuesType = typeof values;

        __checkTableName(tableName);

        var sqlStr =  '';
        var valuesResult;

        if(argLength == 2) {
            // insert into table values();
            sqlStr = insertPrefix + tableName + spaceString + valuesPrefix;

            valuesResult = __values(fields);

            __sqlQuery += sqlStr + valuesResult.sql;
            __bind = __bind.concat(valuesResult.bind);


        } else  if(argLength == 3) {
            var fieldsStr = __fields(fields);

            sqlStr = insertPrefix + tableName +
                    "("+fieldsStr +")";

            valuesResult = __values(values);

            __sqlQuery += sqlStr + valuesPrefix +valuesResult.sql;
            __bind = __bind.concat(valuesResult.bind);

        } else {
            throw new TypeError('insert need 2 or 3 argument!');
        }
    }


    function insertMutilValues(tableName, fields, mutilValues) {
        var insertPrefix = 'INSERT INTO' + spaceString;
        var valuesPrefix = spaceString + "VALUES" + spaceString;

        var argLength = arguments.length;               // arguemnts length

        var fieldsType = typeof fields;
        var mutilValuesType = typeof mutilValues;

        __checkTableName(tableName);

        var fieldsStr = __fields(fields);

        var sqlStrInsertInto = insertPrefix + tableName  +
                "("+fieldsStr +")";

        var bind = [];
        var sqlQuery = '';

        var sqlStr = '';

        for(var iter in mutilValues) {

            var valuesResult = __values(mutilValues[iter]);

            sqlStr += valuesResult.sql + ", ";

            bind = bind.concat(valuesResult.bind);
        }

        sqlStr = sqlStr.substring(0, sqlStr.length - 2);

        __sqlQuery += sqlStrInsertInto + valuesPrefix + sqlStr
        __bind = __bind.concat(bind);
    }



    function update(tableName, map) {
        __checkTableName(tableName);

        var updatePrefix = "UPDATE" + spaceString
                + tableName + spaceString
                + "SET" + spaceString;

        var sqlStr = '';
        var bind_ = [];
        for(var iter in map) {
            var result = __binaryOperator(iter, '>', map[iter]);
            sqlStr += result.sql + ",";
            bind_ = bind_.concat(result.bind);
        }

        sqlStr = sqlStr.substring(0, sqlStr.length-1).trim();

        __sqlQuery += updatePrefix + sqlStr;
        __bind = __bind.concat(bind_);

        return builder;
    }

    function deleteFrom(tableName) {
        __checkTableName(tableName);

        var deleteFromPrefix = "DELETE FROM " + tableName + spaceString;
        __sqlQuery += deleteFromPrefix;

        return builder;
    }

    function __fields(fields) {
        var _sql = '';
        for(var fieldIter in fields) {
            _sql += fields[fieldIter] + ", " ;
        }
        if(_sql.length != 0) {
            _sql = _sql.substring(0, _sql.length - 2);
        }
        return _sql;
    }

    function __values(values) {
        var bind_ = [];
        var valuesBind = '(';
        for(var valueIter in values) {
            bind_.push(values[valueIter]);
            valuesBind += " ?,"
        }
        valuesBind = valuesBind.substring(0, valuesBind.length - 1).trim() +  ')';

        return {
            sql: valuesBind,
            bind: bind_
        }
    }

    function __checkTableName(tableName) {
        var tableNameType = typeof tableName;
        if(tableNameType !== 'string') {
            throw new TypeError('tableName is string type: '
                                + tableNameType);
        }
    }
}
