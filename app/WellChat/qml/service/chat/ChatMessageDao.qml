import QtQuick 2.0

import "../../component/sqml"

CrudDao {
    id: chatMessageDao
    __sqlMapping: ChatMessageSqlMapping { }
}
