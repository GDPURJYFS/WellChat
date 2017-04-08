import QtQuick 2.0

import "../../component/sqml"

CrudService {
    id: chatMessageService
    debug: connection != null ?connection.debug : false
    __dao: ChatMessageDao {
        __connection: chatMessageService.connection
        debug: chatMessageService.debug
    }

    /**
     * message(id, content, senderId, receiverId, groupId, read, createTime)
     */
    function saveMessage(message, callback) {
        insert(message, callback);
    }
}
