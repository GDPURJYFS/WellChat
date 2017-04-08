.pragma library

// callback(responseText)
// err(errorCode)
function sendTextToTuling123(text, chatUserId, callback, err) {
    // http://www.tuling123.com/openapi/api?key=b77b735b2797bc613e7623f4406fe342&info=你好
    var host = "http://www.tuling123.com/openapi/api?";

    // 这里填写你在图灵机器人网站申请的apiKey
    // 现在图灵机器人网站是免费申请的哦。
    var apiKey = "b77b735b2797bc613e7623f4406fe342";
    var info = text;

    var dataTemplate = {
        "code": 10000,              // 返回的错误码
        "text": "回复的内容",
        "url": "",                  // 返回单条链接
        "list": []                  // 返回多条信息
    }

    var xhr = new XMLHttpRequest;
    xhr.onreadystatechange = function() {
        if(xhr.readyState == xhr.DONE) {
            console.log("xhr.responseText: ", xhr.responseText);
            try {
                var dataObject = JSON.parse(xhr.responseText);
                if(!isErrorCode(dataObject.code)) {
                    callback(dataObject.text);
                } } catch(e) {
                console.log(e);
            }

        }
    }
    xhr.open("GET", host+ "key=" + apiKey +"&userid=" + chatUserId +"&info="+info );
    xhr.send()
}


function isErrorCode(code) {
    var errorCodes = [
                {
                    "code":40001,
                    "description":"参数key长度错误（应该是32位）"
                },
                {
                    "code":40002,
                    "description":"请求内容info为空"
                },
                {
                    "code":40003,
                    "description":"key错误或帐号未激活"
                },
                {
                    "code":40004,
                    "description":"当天请求次数已使用完"
                },
                {
                    "code":40005,
                    "description":"暂不支持所请求的功能"
                },
                {
                    "code":40006,
                    "description":"图灵机器人服务器正在升级"
                },
                {
                    "code":40007,
                    "description":"数据格式异常"
                },
            ];
    for(var iter in errorCodes) {
        if(errorCodes[iter].code === code) {
            return true;
        }
    }
    return false;
}

function errorCodeHandle(code) {

    var errorCodes = [
                {
                    "code":40001,
                    "description":"参数key长度错误（应该是32位）"
                },
                {
                    "code":40002,
                    "description":"请求内容info为空"
                },
                {
                    "code":40003,
                    "description":"key错误或帐号未激活"
                },
                {
                    "code":40004,
                    "description":"当天请求次数已使用完"
                },
                {
                    "code":40005,
                    "description":"暂不支持所请求的功能"
                },
                {
                    "code":40006,
                    "description":"图灵机器人服务器正在升级"
                },
                {
                    "code":40007,
                    "description":"数据格式异常"
                },
            ];
    for(var iter in errorCodes) {
        if(errorCodes[iter].code === code) {
            console.log(errorCodes[iter].description);
        }
    }
}
