#include "keyboard.h"
#include <QGuiApplication>
#include <QInputMethod>

#include "sparrow_global.h"

Keyboard::Keyboard(QObject *parent) :
    QObject(parent),
    m_inputMethod (QGuiApplication::inputMethod())
{
    connect(m_inputMethod, SIGNAL(visibleChanged()), this, SIGNAL(visibleChanged()));

#ifndef Q_OS_ANDROID
    connect(this, SIGNAL(visibleChanged()), this, SLOT(onVisibleChangedChanged()));
#endif

#ifdef Q_OS_ANDROID
    QAndroidJniObject::callStaticMethod<void>("org/GDPURJYFS/WellChat/NotificationClient",
                                              "listenKeyboardHeight");
    Q_SAFE_CALL_JAVA
#endif
}

bool Keyboard::visible() const
{
    return m_inputMethod->isVisible();
}

void Keyboard::setVisible(bool v)
{
    if(v) {
        m_inputMethod->show();
    } else {
        m_inputMethod->hide();
    }
}

QRectF Keyboard::keyboardRectangle() const
{
    return this->m_keyboardRectangle;
}

Keyboard *Keyboard::singleton()
{
    static Keyboard* keyboard = new Keyboard(QCoreApplication::instance());
    return keyboard;
}

void Keyboard::onVisibleChangedChanged()
{
#ifndef Q_OS_ANDROID
    m_keyboardRectangle = m_inputMethod->keyboardRectangle();
    emit keyboardRectangleChanged(m_keyboardRectangle);
#endif
}


