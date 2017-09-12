import QtQuick 2.0

QtObject {
    property Auth auth: null                    // header
    property string uri: ""
    property string method: "POST"              // default post method
    property string contentType: "application/json"
    readonly property var callback: callbackImpl
    readonly property var errorHandle: errorHandleImpl

    property string sign

    //@abstract
    function getHeaders() {
        if (auth == null) {
            console.warn("auth is null")
        }

        var userName = auth ? auth.userName : "";
        var token = auth ? auth.token : "";
        var headers = {
            "Content-Type": contentType,
            "userName": userName,
            "token": token
        };
        return headers;
    }

    //@abstract
    function getPayloadString() {
    }

    //@abstract
    function callbackImpl(jsonObject) {
    }

    //@abstract
    function errorHandleImpl(reponseText, error) {
        console.error("uri:", uri, "error:", error, "reponseText:", reponseText);
    }

    function filterUndefinedParam(data) {
        for(var iter in data) {
            if(typeof data[iter] === 'undefined') {
                delete data[iter];
            }
        }
        return data;
    }

    function toInteger(param) {
        var i = parseInt(param);
        if(isNaN(i)) {
            return undefined;
        }
        return i;
    }

}
