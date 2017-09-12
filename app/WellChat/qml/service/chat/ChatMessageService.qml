import QtQuick 2.0

import space.qyvlik.sqml 1.0

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
        console.log("message: ", JSON.stringify(message));
        insert(message, callback);
    }
}
