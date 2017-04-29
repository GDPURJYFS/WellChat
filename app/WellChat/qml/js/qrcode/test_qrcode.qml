import QtQuick 2.0

Item {

    width: 400
    height: 400

    QRCode {
        id: qrCode
        type: 4
        qrCodeCellSize: 12
        value: "import QtQuick 2.中文"
    }
}
