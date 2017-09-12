import QtQuick 2.0

// Image2Base64
Canvas {
    id: canvas
    width: image.sourceSize.width
    height: image.sourceSize.height
    visible: false
    signal dumpBase64(string url, string dataUrl);

    Image {
        id: image
        visible: false
    }

    onPaint: {
        var ctx = getContext("2d");
        ctx.drawImage(image, 0, 0, width, height);
        dumpBase64(image.source, canvas.toDataURL("image/png"));
    }

    function toBase64(source, callback) {
        callback = callback || function(source, dataUrl) {
            console.log("source:", source,
                        "dataUrl size:", dataUrl.length);
        }
        image.source = source;

        dumpBase64.connect(function(source, dataUrl){
            dumpBase64.disconnect(arguments.callee);
            callback(source, dataUrl);
        })

        canvas.requestPaint();
    }
}
