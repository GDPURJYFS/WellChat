#include "qtnativeforandroid.h"
#include "keyboard.h"
#include <QMutex>
#include <QRect>
#include <QRectF>

#ifdef Q_OS_ANDROID
void QtNativeForAndroid::notifiedKeyboardRectangle(JNIEnv *env, jobject thiz,
                                         jint x, jint y, jint width, jint height)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)

    static QMutex mutex;
    mutex.lock();

    QRect rect(x, y, width, height);
#ifdef QT_DEBUG
    qDebug() << "notifiedKeyboardRectangle: " << rect ;
#endif
    Keyboard * keyboardSingleton = Keyboard::singleton();
    keyboardSingleton->m_keyboardRectangle = QRectF(rect);
    keyboardSingleton->keyboardRectangleChanged(keyboardSingleton->m_keyboardRectangle);

    mutex.unlock();
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

    const char * classname = "org/GDPURJYFS/Sparrow/QtNativeForAndroid";
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
