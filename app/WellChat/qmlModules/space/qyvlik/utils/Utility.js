
// .pragma library

function urlQuery(jsonObject) {
    var query = "";
    var i = 0;
    for(var iter in jsonObject) {

        if(i > 0) {
            query += "&";
        }
        query += iter +"=" + encodeURI(jsonObject[iter]);
        i++;
    }
    // console.log("url query:", query);
    return query;
}


function setHeader(xhr, headers) {
    //"Content-Type":"application/x-www-form-urlencoded"
    for(var iter in headers) {
        xhr.setRequestHeader(iter, headers[iter]);
    }
}

function ajax(method, url, headers, data, callable) {
    headers = headers || {};
    callable = callable || function(xhr) {
        console.log(xhr.responseText);
    }
    var xhr = new XMLHttpRequest;
    xhr.onreadystatechange = function() {
        callable(xhr);
    };
    xhr.open(method, url);
    setHeader(xhr, headers);
    if("GET" === method) {
        xhr.send();
    } else {
        xhr.send(data);
    }
}

function randomString(length, special) {
    var iteration = 0;
    var password = "";
    var randomNumber;
    if(typeof special === 'undefined'){
        special = false;
    }
    while(iteration < length){
        randomNumber = (Math.floor((Math.random() * 100)) % 94) + 33;
        if(!special){
            if ((randomNumber >=33) && (randomNumber <=47)) { continue; }
            if ((randomNumber >=58) && (randomNumber <=64)) { continue; }
            if ((randomNumber >=91) && (randomNumber <=96)) { continue; }
            if ((randomNumber >=123) && (randomNumber <=126)) { continue; }
        }
        iteration++;
        password += String.fromCharCode(randomNumber);
    }
    return password;
}

// 链接信号一次
function connectOnce(target, signalName, callable) {
    singalConnectOnce(target[signalName], callable);
}

function singalConnectOnce(singalObject, callable) {
    if(typeof singalObject === 'undefined') {
        throw "singalObject is undefined!";
    }

    singalObject.connect(function(){
        callable.call({}, arguments);                   // {} mean thisArg
        singalObject.disconnect(arguments.callee);
    });
}

// use Qt.resolvedUrl warp file
function readFileAsync(file, callable, error) {
    callable = callable || function(fileContent) {
        console.log("fileContent size: ", fileContent.length);
    }
    error = error || function(e) {
        console.log("readFileAsync error : ", e);
    }

    ajax("GET", file, {}, "", function(xhr){
        if(xhr.status !== 200) {
            error("file "+file + " not exist!");
        } else {
            callable(xhr.responseText);
        }
    });
}

function writeTextFileAsync(file, content, callback) {
    callback = callback || function(xhr) {
        console.log("AllResponseHeaders:", xhr.getAllResponseHeaders());
        console.log("length:", xhr.responseText.length);
    }

    var xhr = new XMLHttpRequest;

    xhr.onreadystatechange = function() {
        if(xhr.readyState == xhr.DONE) {
            callback(xhr);
        }
    }
    console.log("file", file);
    xhr.open("PUT", file);
    xhr.send(content);
}

function stringNotEmpty(str) {
    if(typeof str === 'undefined' || str === null) {
        return false;
    }
    if(str == '' || str.length == 0) {
        return false;
    }
    return true;
}


function randomColor(a) {
    a = a || 1;
    return Qt.rgba(Math.random(), Math.random(), Math.random(), a);
}

function listGroup(list, step, callback) {
    callback = callback || function(list) {
    };

    if (typeof list === 'undefined' || list === null || list.length === 0) {
        return;
    }

    var len = list.length;
    var start = 0;
    var end = step;
    if (len <= step) {
        callback(list);
        return;
    }

    while(start < len) {
        var tList = list.slice(start, end);             // [start, end)
        callback(tList);
        start = end;
        end += step;
        if (end > len) {
            end = len;
        }
    }
}
