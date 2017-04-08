#ifndef GLOBAL
#define GLOBAL

#include <QDebug>

#ifdef Q_OS_ANDROID

#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#define Q_SAFE_CALL_JAVA {                  \
    QAndroidJniEnvironment env;             \
    if(env->ExceptionCheck()) {             \
    qDebug() << "have a java exception";    \
    env->ExceptionClear();                  \
    }                                       \
    }

#endif

#endif // GLOBAL

