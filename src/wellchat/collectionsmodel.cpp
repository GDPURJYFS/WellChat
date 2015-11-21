#include "collectionsmodel.h"
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>
#include <QStandardPaths>
#include <QCoreApplication>
#include <QDir>
#include <QQmlEngine>

CollectionsModel::CollectionsModel(QObject *parent):
    QAbstractListModel(parent)
{
    database = QSqlDatabase::addDatabase("QSQLITE");



    if( QDir().mkpath(QStandardPaths::writableLocation(
                          QStandardPaths::AppDataLocation)))
    {
        QString dbPath = QStandardPaths::writableLocation(
                    QStandardPaths::AppDataLocation)
                + QDir::separator()
                + QCoreApplication::applicationName() + ".db";

#ifdef QT_DEBUG
        qDebug() << "dbPath" << QDir::toNativeSeparators(dbPath) ;
#endif

        database.setDatabaseName(dbPath);

        if(!database.open()) {
            qDebug()<<database.lastError();
            qFatal("failed to connect.") ;

        } else {
            //! init database
            QString create_table_sql = " create table if not exists collections( "
                                       "    id integer primary key autoincrement, "
                                       "    Author text,"
                                       "    Title text,"
                                       "    Source text, "
                                       "    SourceName text,"
                                       "    Summary text,"
                                       "    CollectionType text,"
                                       "    CreateTime default (datetime('now', 'localtime')) "
                                       " )";

            QSqlQuery query(create_table_sql, database);
            if(query.exec()) {
                qDebug() << "create_table_sql exec success";

                QSqlQuery insert(database);

                QString insert_one_recode = " insert into collections"
                                            " ( Author,"
                                            "   Title,"
                                            "   Source,"
                                            "   SourceName,"
                                            "   Summary, "
                                            "   CollectionType"
                                            " ) "
                                            " VALUES(?, ?, ?, ?, ?, ?)";

                insert.prepare(insert_one_recode);
                insert.bindValue(0, "qyvlik");
                insert.bindValue(1, "CVEapUQ");
                insert.bindValue(2, "http://m2.music.126.net/cYlUtEbEvgypSh-CVEapUQ==/5742749231919930.mp3");
                insert.bindValue(3, "NetEasy");
                insert.bindValue(4, "Muji");
                insert.bindValue(5, "Music");
                if(insert.exec()) {
                    qDebug() << "insert recode: " << insert.lastError();
                }
            } else {
                qDebug() << "error:" << query.lastError() ;
            }
        }
    } else {
        qFatal("path create failed");
    }

}


QString CollectionsModel::roleName(int role) {
    QHash<int, QByteArray> roleNamesHash = this->roleNames();
    if(roleNamesHash.contains(role))
        return QString(roleNamesHash[role]);
    else {
        return QString("");
    }
}


QHash<int, QByteArray> CollectionsModel::roleNames() const
{
    QHash<int, QByteArray> roleNamesHash;

    roleNamesHash.insert(Author, "Author");
    roleNamesHash.insert(CreateTime, "CreateTime");
    roleNamesHash.insert(Title, "Title");
    roleNamesHash.insert(Source, "Source");
    roleNamesHash.insert(SourceName, "SourceName");
    roleNamesHash.insert(Summary, "Summary");
    roleNamesHash.insert(CollectionType, "CollectionType");

    return roleNamesHash;
}


int CollectionsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);

    QString table_recode_count_sql = "select count(*) as TotalNum from collections";

    int table_recode_count = 0;

    if(database.isOpen()) {
        QSqlQuery query(table_recode_count_sql, database);
        if(query.exec() && query.next()) {
            bool ok = false;
            int totalNum  = query.value("TotalNum").toInt(&ok);
            if(ok) {
                table_recode_count = totalNum;
#ifdef QT_DEBUG
                qDebug() << "table_recode_count: " << table_recode_count ;
#endif
            }
        } else {
            qDebug() << "CollectionsModel::rowCount " << query.lastError() ;
        }
    }
    return table_recode_count;
}


QVariant CollectionsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0)
        return QVariant();

    if (index.row() >= this->rowCount(index)) {
        qWarning() << "CollectionsModels: Index out of bound";
        return QVariant();
    }

    // %1 is index %2  is index+1
    QString select_recode_limit_2_sql = "select * from collections limit  ";

    if(database.isOpen()) {
        QString::number(index.row());

        select_recode_limit_2_sql =
                select_recode_limit_2_sql
                + QString::number(index.row())
                + " ,"
                +QString::number(index.row()+1);

        qDebug() << "select_recode_limit_2_sql : "
                 << select_recode_limit_2_sql << endl;

        QSqlQuery query(select_recode_limit_2_sql, database);


        if(query.exec() && query.next()) {
            switch (role)
            {
            case Author:
                return  query.value("Author").toString();
            case CreateTime:
                return  query.value("CreateTime").toString();
            case Title:
                return  query.value("Title").toString();
            case Source:
                return  query.value("Source").toString();
            case SourceName:
                return  query.value("SourceName").toString();
            case Summary:
                return  query.value("Summary").toString();
            case CollectionType:
                return  query.value("CollectionType").toString();
            default:
                break;
            }
        } else {
            qDebug() << "CollectionsModel::data " << query.lastError();
        }
    }


    return QVariant(QString(""));
}


QObject *CollectionsModel::singleton(QQmlEngine *qmlEngine, QJSEngine *jsEngine)
{
    Q_UNUSED(jsEngine)

    static CollectionsModel* collectionsModel = new CollectionsModel(qmlEngine);

    return collectionsModel;
}
