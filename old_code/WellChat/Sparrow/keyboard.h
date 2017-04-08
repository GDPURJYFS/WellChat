#ifndef VIRTUALKEYBOARD_H
#define VIRTUALKEYBOARD_H

#include <QObject>
#include <QRectF>

class QtBridgingAndroid;
class QtNativeForAndroid;
class QInputMethod;

class Keyboard : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool visible READ visible WRITE setVisible NOTIFY visibleChanged)
    Q_PROPERTY(QRectF keyboardRectangle READ keyboardRectangle NOTIFY keyboardRectangleChanged)

public:
    explicit Keyboard(QObject *parent = 0);

    bool visible()const;
    void setVisible(bool v);

    QRectF keyboardRectangle()const;

    static Keyboard *singleton();

signals:
    void visibleChanged();
    void keyboardRectangleChanged(const QRectF& keyboardRectangle);

protected slots:
    void setKeyboardRectangle(const QRectF& keyboardRectangle);

private slots:
    void onVisibleChangedChanged();

private:
    QInputMethod* m_inputMethod;
    QRectF m_keyboardRectangle;
    friend class QtNativeForAndroid;
    friend class QtBridgingAndroid;
};

#endif // VIRTUALKEYBOARD_H
