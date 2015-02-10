#ifndef IRISHRAILDATAPROVIDER_H
#define IRISHRAILDATAPROVIDER_H

#include <QtQuick>
#include <QStringList>
#include <QSqlDatabase>

class IrishRailDataProvider : public QObject
{
    Q_OBJECT
public:
    QStringList allStops;
    void refreshAllStopsList();
    Q_INVOKABLE QList<QString> getAllStopsList();
    Q_INVOKABLE QString getStopsListAt(int index);
    Q_INVOKABLE QString getStopsListLength();

    QMap<QString, QStringList> favourites;
    Q_INVOKABLE void addToFavourites(QString stop_name);
    Q_INVOKABLE QStringList getFavouritesList();
    Q_INVOKABLE QString getFavouritesListAt(int index);
    Q_INVOKABLE QString getFavouritesLength();

    QMap<QString, QStringList> trainsForStop;
    void refreshTrainListForStop(QString stop_name);
    Q_INVOKABLE QStringList getTrainListForStop(QString stop_id);
    Q_INVOKABLE QString getTrainListForStopAt(QString stop_id, int index);
    Q_INVOKABLE QString getTrainListForStopLength(QString stop_id);

    QString sendRequest(QString);
    QList<QMap<QString, QString> > parseXML(QString input_str);

    QSqlDatabase db;
    void setDatabase(QSqlDatabase db);
    void printFavourites();

    IrishRailDataProvider();
};

#endif // IRISHRAILDATAPROVIDER_H
