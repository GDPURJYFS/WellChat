#include "qmlnetworkaccessmanagerfactory.h"

#include <QDir>
#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkDiskCache>
#include <QStandardPaths>

QmlNetworkAccessManagerFactory::QmlNetworkAccessManagerFactory()
{
#ifdef QT_DEBUG
    qDebug() << QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
#endif
}

QmlNetworkAccessManagerFactory::~QmlNetworkAccessManagerFactory()
{
#ifdef QT_DEBUG
    qDebug() << "~QmlNetworkAccessManagerFactory";
#endif
}

QNetworkAccessManager *QmlNetworkAccessManagerFactory::create(QObject *parent)
{
    QNetworkAccessManager* manager = new QNetworkAccessManager(parent);
    QString cachePath = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);

    if(QDir().mkpath(cachePath)) {
        QNetworkDiskCache* diskCache = new QNetworkDiskCache(manager);
        diskCache->setCacheDirectory(cachePath);
        diskCache->setMaximumCacheSize(10*1024*1024);
        manager->setCache(diskCache);
    }

    return manager;
}

