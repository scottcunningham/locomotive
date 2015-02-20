#ifndef IRISH_RAIL_API_H
#define IRISH_RAIL_API_H

#include <QtQuick>
#include <QStringList>
#include <QSqlDatabase>
#include <QVariantMap>

class IrishRailAPI : public QObject
{
    Q_OBJECT
private:
    QString sendRequest(QString);
    QVariantList parseXML(QString input_str);

    QVariantList allStops;
    QVariantMap favourites;
    QVariantMap trainsForStop;

    QSqlDatabase db;
    void initDatabase();

public:
    IrishRailAPI();
    ~IrishRailAPI();

    Q_INVOKABLE void refreshAllStopsList();
    Q_INVOKABLE QVariantList getAllStopsList();
    Q_INVOKABLE QVariantMap getStopByName(QString stop_name);

    Q_INVOKABLE void addToFavourites(QString stop_name);
    Q_INVOKABLE void removeFromFavourites(QString stopName);
    Q_INVOKABLE bool isStopInFavourites(QString stop_name);
    Q_INVOKABLE QStringList getFavouritesList();

    Q_INVOKABLE void refreshTrainListForStop(QString stop_name);
    Q_INVOKABLE QVariantList getTrainListForStop(QString stop_id);
};

#endif // IRISH_RAIL_API_H
