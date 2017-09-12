import QtQuick 2.0
import './qrcode.js' as Lib

//! [KochergaClub/kocherga-mobile](https://github.com/KochergaClub/kocherga-mobile/blob/master/components/QrCode.qml)

Image {
    property string value: ''
    property int type: 4                    //  1 to 40
    property int level: 2 // 1 - 4
    property int qrCodeCellSize: 4

    function refresh() {
        var levels = ['L','M','Q','H'];
        var qr = Lib.qrcode(type, levels[level - 1]);
        qr.addData(value);
        qr.make();
        source = qr.createImgTag(qrCodeCellSize, 1).replace(/.*"data:/, "data:").replace(/".*/, '');
    }

    onValueChanged: refresh()
    onTypeChanged: refresh()
    onLevelChanged: refresh()
    onQrCodeCellSizeChanged: refresh()

    antialiasing: false
    smooth: false
    fillMode: Image.PreserveAspectFit

    Component.onCompleted: refresh()
}
