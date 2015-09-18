#ifndef QTNATIVEFORANDROID_H
#define QTNATIVEFORANDROID_H

#include "sparrow_global.h"

class QtNativeForAndroid
{
public:
#ifdef Q_OS_ANDROID
    static void notifiedKeyboardRectangle(JNIEnv * env, jobject thiz,
                         jint x, jint y, jint width, jint height);
    static bool registerNativeMethodForJava();
#endif
};

#endif // QTNATIVEFORANDROID_H
