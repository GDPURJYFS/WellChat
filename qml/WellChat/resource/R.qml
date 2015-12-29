pragma Singleton

import QtQuick 2.0

// R
// Applicaton icon html ... resource

QtObject {
    id: resource

    objectName: "ApplicatonResources"

    readonly property
    url testPic:
    Qt.resolvedUrl( "./tests/tests001.jpg")


    // bar icons
    // ./icons/bar-icons/active
    readonly property
    url activeIconBack:
    //icons.activeIcon("back")
    Qt.resolvedUrl("./icons/bar-icons/active/back.png")

    readonly property
    url inactiveIconBack:
    Qt.resolvedUrl("./icons/bar-icons/inactive/back.png")

    readonly property
    url activeIconChat:
    Qt.resolvedUrl("./icons/bar-icons/active/chat.png")

    readonly property
    url inactiveIconChat:
    Qt.resolvedUrl("./icons/bar-icons/inactive/chat.png")

    readonly property
    url activeIconContacts:
    Qt.resolvedUrl("./icons/bar-icons/active/contacts.png")

    readonly property
    url inactiveIconContacts:
    Qt.resolvedUrl("./icons/bar-icons/inactive/contacts.png")

    readonly property
    url activeIconDicover:
    Qt.resolvedUrl("./icons/bar-icons/active/dicover.png")

    readonly property
    url inactiveIconDicover:
    Qt.resolvedUrl("./icons/bar-icons/inactive/dicover.png")

    readonly property
    url activeIconEmoticon:
    Qt.resolvedUrl("./icons/bar-icons/active/emoticon.png")

    readonly property
    url inactiveIconEmoticon:
    Qt.resolvedUrl("./icons/bar-icons/inactive/emoticon.png")

    readonly property
    url activeIconMagnifier:
    Qt.resolvedUrl("./icons/bar-icons/active/magnifier.png")

    readonly property
    url inactiveIconMagnifier:
    Qt.resolvedUrl("./icons/bar-icons/inactive/magnifier.png")

    readonly property
    url activeIconMe:
    Qt.resolvedUrl("./icons/bar-icons/active/me.png")

    readonly property
    url inactiveIconMe:
    Qt.resolvedUrl("./icons/bar-icons/inactive/me.png")

    readonly property
    url activeIconPlus:
    Qt.resolvedUrl("./icons/bar-icons/active/plus.png")

    readonly property
    url inactiveIconPlus:
    Qt.resolvedUrl("./icons/bar-icons/inactive/plus.png")

    readonly property
    url activeIconSound:
    Qt.resolvedUrl("./icons/bar-icons/active/sound.png")

    readonly property
    url inactiveIconSound:
    Qt.resolvedUrl("./icons/bar-icons/inactive/sound.png")


    // label icons
    // ./icons/label-icons/
    readonly property
    url labelIconDriftBottle:
    Qt.resolvedUrl("./icons/label-icons/drift-bottle.png")

    readonly property
    url labelIconFace:
    Qt.resolvedUrl("./icons/label-icons/face.png")

    readonly property
    url labelIconGames:
    Qt.resolvedUrl("./icons/label-icons/games.png")

    readonly property
    url labelIconMoments:
    Qt.resolvedUrl("./icons/label-icons/moments.png")

    readonly property
    url labelIconMyPosts:
    Qt.resolvedUrl("./icons/label-icons/my-posts.png")

    readonly property
    url labelIconPeopleNearby:
    Qt.resolvedUrl("./icons/label-icons/people-nearby.png")

    readonly property
    url labelIconScanQRCode:
    Qt.resolvedUrl("./icons/label-icons/scan-qr-code.png")

    readonly property
    url labelIconSettings:
    Qt.resolvedUrl("./icons/label-icons/settings.png")

    readonly property
    url labelIconShake:
    Qt.resolvedUrl("./icons/label-icons/shake.png")

    readonly property
    url labelIconShareExcel:
    Qt.resolvedUrl("./icons/label-icons/share-excel.png")

    readonly property
    url labelIconShareFile:
    Qt.resolvedUrl("./icons/label-icons/share-file.png")

    readonly property
    url labelIconShareMusic:
    Qt.resolvedUrl("./icons/label-icons/share-music.png")

    readonly property
    url labelIconSharePdf:
    Qt.resolvedUrl("./icons/label-icons/share-pdf.png")

    readonly property
    url labelIconShakePicture:
    Qt.resolvedUrl("./icons/label-icons/share-picture.png")

    readonly property
    url labelIconSharePosition:
    Qt.resolvedUrl("./icons/label-icons/share-position.png")

    readonly property
    url labelIconShareSound:
    Qt.resolvedUrl("./icons/label-icons/share-sound.png")

    readonly property
    url labelIconShareText:
    Qt.resolvedUrl("./icons/label-icons/share-text.png")

    readonly property
    url labelIconShareUrl:
    Qt.resolvedUrl("./icons/label-icons/share-url.png")

    ///

    readonly property
    url labelIconShareVideo:
    Qt.resolvedUrl("./icons/label-icons/share-video.png")

    readonly property
    url labelIconShareWord:
    Qt.resolvedUrl("./icons/label-icons/share-word.png")

    readonly property
    url labelIconShareZip:
    Qt.resolvedUrl("./icons/label-icons/share-zip.png")

    readonly property
    url labelIconWallet:
    Qt.resolvedUrl("./icons/label-icons/wallet.png")
}

