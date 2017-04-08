#ifndef QTBRIDGINGANDROID_H
#define QTBRIDGINGANDROID_H

#include <QObject>
#include <QColor>
#include "sparrow_global.h"

class QtBridgingAndroid : public QObject
{
    Q_OBJECT
public:
    explicit QtBridgingAndroid(QObject *parent = 0);

    // Java Method
    Q_INVOKABLE void sendNotification(const QString& notifyString);
    // Java Method
    Q_INVOKABLE void setStatusBarColor(const QColor& color);

public:
#ifdef Q_OS_ANDROID
    static void notifiedKeyboardRectangle(JNIEnv * env, jobject thiz,
                         jint x, jint y, jint width, jint height);
    static bool registerNativeMethodForJava();

    static void installListener();

#endif

};

#endif // QTBRIDGINGANDROID_H
