#ifndef COLLECTIONSMODEL_H
#define COLLECTIONSMODEL_H

#include <QAbstractListModel>
#include <QSqlDatabase>

class QQmlEngine;
class QJSEngine;

class CollectionsModel : public QAbstractListModel
{
    Q_OBJECT

    enum CollectionRole {
        Author = Qt::UserRole + 1,              // 作者
        CreateTime,                             // 创建时间
        Title,                                  // 标题
        Source,                                 // 来源地址：http://baidu.com
        SourceName,                             // 来源名字：baidu
        Summary,                                // 摘要
        CollectionType                          // 收藏的类型，例如链接，音乐，图片等
    };

public:
    CollectionsModel(QObject* parent=0);

    QString roleName(int role);

    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;

    static QObject* singleton(QQmlEngine* qmlEngine, QJSEngine* jsEngine);
private:
    QSqlDatabase database;
};

#endif // COLLECTIONSMODEL_H
