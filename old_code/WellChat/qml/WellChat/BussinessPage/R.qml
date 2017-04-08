// ~R

pragma Singleton
import QtQuick 2.0

// WellChat BussinessPage Resource
QtObject {
    id: resource

    objectName: "WellChatBussinessPageResource"

    readonly property
    url chatChatPage:
    Qt.resolvedUrl("./Chat/ChatPage.qml")

    readonly property
    url discoverMomentsPage:
    Qt.resolvedUrl("./Discover/MomentsPage/MomentsPage.qml")

    readonly property
    url personalSettingsAboutPage:
    Qt.resolvedUrl("./Personal/Settings/AboutPage.qml")

    readonly property
    url personalSettingsChatSettingsPage:
    Qt.resolvedUrl("./Personal/Settings/ChatSettingsPage.qml")

    readonly property
    url personalSettingsDoNotDisturbSettingsPage:
    Qt.resolvedUrl("./Personal/Settings/DoNotDisturbSettingsPage.qml")

    readonly property
    url personalSettingsGeneralSettingsPage:
    Qt.resolvedUrl("./Personal/Settings/GeneralSettingsPage.qml")

    readonly property
    url personalSettingsMyAccountSettingsPage:
    Qt.resolvedUrl("./Personal/Settings/MyAccountSettingsPage.qml")

    readonly property
    url personalSettingsNotificationsSettingsPage:
    Qt.resolvedUrl("./Personal/Settings/NotificationsSettingsPage.qml")

    readonly property
    url personalSettingsPrivacySettingsPage:
    Qt.resolvedUrl("./Personal/Settings/PrivacySettingsPage.qml")

    readonly property
    url personalFavoritesPage:
    Qt.resolvedUrl("./Personal/FavoritesPage.qml")

    readonly property
    url personalMyPostsPage:
    Qt.resolvedUrl("./Personal/MyPostsPage.qml")

    readonly property
    url personalSettingsPage:
    Qt.resolvedUrl("./Personal/SettingsPage.qml")

    readonly property
    url chatsView:
    Qt.resolvedUrl("./ChatsView.qml")

    readonly property
    url constactsView:
    Qt.resolvedUrl("./ContactsView.qml")

    readonly property
    url discoverPage:
    Qt.resolvedUrl("./DiscoverPage.qml")

    readonly property
    url profilePage:
    Qt.resolvedUrl("./ProfilePage.qml")

}

