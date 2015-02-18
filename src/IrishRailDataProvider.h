#ifndef IRISHRAILDATAPROVIDER_H
#define IRISHRAILDATAPROVIDER_H

#include <QtQuick>
#include <QStringList>
#include <QSqlDatabase>
#include <QMap>

class IrishRailDataProvider : public QObject
{
    Q_OBJECT
private:
    QString sendRequest(QString);
    QList<QMap<QString, QString> > parseXML(QString input_str);

    QStringList allStops;
    QMap<QString, QStringList> favourites;
    QMap<QString, QStringList> trainsForStop;

    QSqlDatabase db;
    void initDatabase();

public:
    IrishRailDataProvider();
    ~IrishRailDataProvider();

    Q_INVOKABLE void refreshAllStopsList();
    Q_INVOKABLE QStringList getAllStopsList();

    Q_INVOKABLE void addToFavourites(QString stop_name);
    Q_INVOKABLE void removeFromFavourites(QString stopName);
    Q_INVOKABLE bool isStopInFavourites(QString stop_name);
    Q_INVOKABLE QStringList getFavouritesList();

    Q_INVOKABLE void refreshTrainListForStop(QString stop_name);
    Q_INVOKABLE QStringList getTrainListForStop(QString stop_id);
};

#endif // IRISHRAILDATAPROVIDER_H
