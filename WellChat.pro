TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    src/wellchat/collectionsmodel.cpp

RESOURCES += \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
include(Sparrow/Sparrow.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += android/src/org/gdpurjyfs/wellchat/WellChatActivity.java
# android/src/org/gdpurjyfs/wellchat/QtBridgingAndroid.java \

HEADERS += \
    src/wellchat/collectionsmodel.h

