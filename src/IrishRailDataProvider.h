#ifndef IRISHRAILDATAPROVIDER_H
#define IRISHRAILDATAPROVIDER_H

#include <QtQuick>
#include <QStringList>

class IrishRailDataProvider : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QList<QString> getAllStopsList() const;
    Q_INVOKABLE QString getStopsListAt(int index) const;
    Q_INVOKABLE QString getStopsListLength() const;

    Q_INVOKABLE QStringList getFavouritesList() const;
    Q_INVOKABLE QString getFavouritesListAt(int index) const;
    Q_INVOKABLE QString getFavouritesLength() const;

    Q_INVOKABLE QStringList getTrainListForStop(QString stop_id) const;
    Q_INVOKABLE QString getTrainListForStopAt(QString stop_id, int index) const;
    Q_INVOKABLE QString getTrainListForStopLength(QString stop_id) const;

    QString sendRequest(QString) const;
    QList<QMap<QString, QString> > parseXML(QString input_str) const;
};

#endif // IRISHRAILDATAPROVIDER_H
