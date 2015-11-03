QT += core network sql qml

android {
    QT += androidextras

}

HEADERS += \
    $$PWD/qmlnetworkaccessmanagerfactory.h \
    $$PWD/notificationclient.h \
    $$PWD/keyboard.h \
    $$PWD/sparrow_global.h \
    $$PWD/qtnativeforandroid.h

SOURCES += \
    $$PWD/qmlnetworkaccessmanagerfactory.cpp \
    $$PWD/notificationclient.cpp \
    $$PWD/keyboard.cpp \
    $$PWD/qtnativeforandroid.cpp
# OTHER_FILES += $$PWD/../android/src/org/gdpurjyfs/sparrow/QtNativeForAndroid.java
OTHER_FILES += $$PWD/../android/src/org/gdpurjyfs/sparrow/QtNativeForAndroid.java

