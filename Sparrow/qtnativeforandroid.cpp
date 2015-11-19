#include "qtnativeforandroid.h"
#include "keyboard.h"
#include <QRect>
#include <QRectF>
#include <QGuiApplication>

#ifdef Q_OS_ANDROID
void QtNativeForAndroid::notifiedKeyboardRectangle(JNIEnv *env, jobject thiz,
                                                   jint x, jint y, jint width, jint height)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)

    if(QGuiApplication::applicationState() != Qt::ApplicationHidden) {

#ifdef QT_DEBUG
        qDebug() << "notifiedKeyboardRectangle: "
                 <<
#endif
            QMetaObject::invokeMethod(Keyboard::singleton(),
                                      "setKeyboardRectangle",
                                       Qt::AutoConnection,
                                      Q_ARG(QRectF, QRect(x, y, width, height))) ;

    }
}

bool QtNativeForAndroid::registerNativeMethodForJava()
{
    JNINativeMethod methods[] = {
        {
            "notifiedKeyboardRectangle",
            "(IIII)V",
            (void*)&(QtNativeForAndroid::notifiedKeyboardRectangle)
        }
    };

    // org/gdpurjyfs/wellchat/QtBridgingAndroid

    // "org/gdpurjyfs/sparrow/qtnativeforandroid" // 包名
    // const char * classname = "org/gdpurjyfs/sparrow/QtNativeForAndroid";
    const char * classname = "org/gdpurjyfs/wellchat/QtBridgingAndroid";
    jclass clazz;
    QAndroidJniEnvironment env;

    QAndroidJniObject javaClass(classname);
    clazz = env->GetObjectClass(javaClass.object<jobject>());

    Q_SAFE_CALL_JAVA

    bool result = false;
    if(clazz) {
        jint ret = env->RegisterNatives(clazz,
                                        methods,
                                        sizeof(methods) / sizeof(methods[0]));
        //! [bug] env->DeleteGlobalRef(clazz);
        result = (ret >= 0);
    } else {
#ifdef QT_DEBUG
        qDebug() << "can't find java class" << classname;
#endif
    }

    Q_SAFE_CALL_JAVA

    return result;
}

#endif
