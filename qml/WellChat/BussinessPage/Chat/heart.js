// .pragma library

// 心跳包

// to include static singleton mess_id
Qt.include("./storage.js")

WorkerScript.onMessage = function(message) {
    var model = message.listModel;

    var doc = new XMLHttpRequest;
    doc.open("POST", "http://cnzxzc.tunnel.mobi/qyvlik/sendMess");
    doc.onreadystatechange = function () {
        if (doc.readyState === XMLHttpRequest.DONE) {
            console.log("on message, model:", model);
            console.log("XMLHttpRequest DONE");
            console.log("====轮询结果=======,mess_id:", mess_id);
            console.log(doc.responseText);
            console.log("====轮询结果=======");
            try {
                var content = JSON.parse(doc.responseText);
                if(content.hasOwnProperty("mess_id")) {
                    mess_id = content.mess_id;
                    timestamp = content.timestamp;
                    var item = {
                        "chatContext": content.content
                    }
                    model.append(item);
                    model.sync();
                }
            } catch(e) {
                console.log(e);
            }
        }
    }
    var lunxun = {
        "timestamp": timestamp,
        "room_id":"1",
        "mess_id":mess_id
    }
    doc.send(JSON.stringify(lunxun));


}
