#ifndef QMLNETWORKACCESSMANAGERFACTORY_H
#define QMLNETWORKACCESSMANAGERFACTORY_H

#include <QQmlNetworkAccessManagerFactory>

class QmlNetworkAccessManagerFactory : public QQmlNetworkAccessManagerFactory
{
public:
    QmlNetworkAccessManagerFactory();
    ~QmlNetworkAccessManagerFactory();
    QNetworkAccessManager *create(QObject *parent);
};

#endif // QMLNETWORKACCESSMANAGERFACTORY_H
