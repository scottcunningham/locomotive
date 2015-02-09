#include "IrishRailDataProvider.h"

#include <QtQuick>
#include <QStringList>
#include <QList>

/*
 * All stops
 */

QList<QString> IrishRailDataProvider::getAllStopsList() const {
    QString response = sendRequest("http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML_WithStationType?StationType=D");
    auto stopsData = parseXML(response);
    QList<QString> stops;
    for (int i = stopsData.size()-1; i >= 0; --i) {
        stops.append(stopsData[i]["StationDesc"]);
    }
    return stops;
}

QString IrishRailDataProvider::getStopsListAt(int index) const {
    return getAllStopsList()[index];
}

QString IrishRailDataProvider::getStopsListLength() const {
    return QString::number(getAllStopsList().size());
}

/*
 * Favourites
 */

QStringList IrishRailDataProvider::getFavouritesList() const {
    QStringList list;
    list.append(QString("Fav 1"));
    list.append(QString("Fav 2"));
    list.append(QString("Fav 3"));
    return list;
}

QString IrishRailDataProvider::getFavouritesListAt(int index) const {
    return getFavouritesList()[index];
}

QString IrishRailDataProvider::getFavouritesLength() const {
    return QString::number(getFavouritesList().size());
}

/*
 * Stop data
 */
QStringList IrishRailDataProvider::getTrainListForStop(QString stop_name) const {
    qDebug() << stop_name;
    QString url = QString("http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML?StationDesc=%1").arg(stop_name);
    qDebug() << url;
    QString response = sendRequest(url); //.toUtf8().constData());
    qDebug() << response;
    auto trainsData = parseXML(response);
    QList<QString> trains;
    for (int i = 0; i < trainsData.size(); ++i) {
        if (trainsData[i]["Destination"] != stop_name) {
            QString s = trainsData[i]["Destination"] + " (" + trainsData[i]["Direction"] + ") " + trainsData[i]["Schdepart"];
            trains.append(s); // stopsData[i]["StationDesc"]);
            qDebug() << trainsData[i]["Destination"] + " (" + trainsData[i]["Direction"] + ") " + trainsData[i]["Schdepart"];
        }
     }
    return trains;
}

QString IrishRailDataProvider::getTrainListForStopAt(QString stop_id, int index) const {
    return getTrainListForStop(stop_id)[index];
}

QString IrishRailDataProvider::getTrainListForStopLength(QString stop_id) const {
    return QString::number(getTrainListForStop(stop_id).size());
}


#include <QCoreApplication>
#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QUrlQuery>

QString IrishRailDataProvider::sendRequest(QString url_string) const {
    // create custom temporary event loop on stack
    QEventLoop eventLoop;

    // "quit()" the event-loop, when the network request "finished()"
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    // the HTTP request
    QUrl url;
    url.setUrl(QString(url_string));
    QNetworkRequest req(url);
    QNetworkReply *reply = mgr.get(req);
    eventLoop.exec(); // blocks stack until "finished()" has been called

    if (reply->error() == QNetworkReply::NoError) {
        QString reply_body = reply->readAll();
        delete reply;
        return reply_body;
    }
    else {
        //failure
        qDebug() << "Failure" <<reply->errorString();
        QString reply_body = reply->readAll();
        delete reply;
        return reply_body;
    }
}

#include <QDomDocument>

QList<QMap<QString, QString> > IrishRailDataProvider::parseXML(QString input_str) const {
    QDomDocument doc("mydocument");

    QList<QMap<QString, QString> > stations;

    doc.setContent(input_str);
    QDomElement docElem = doc.documentElement();
    QDomNode n = docElem.firstChild();
    while(!n.isNull()) {
        QDomElement e = n.toElement(); // try to convert the node to an element.
        if(!e.isNull()) {
            QMap<QString, QString> station;
            for (int i = 0; i < e.childNodes().size(); ++i) {
                auto x = e.childNodes().at(i);
                QDomElement ex = x.toElement();
                station[ex.tagName()] = ex.text();
            }
            stations.append(station);
        }
        n = n.nextSibling();
    }
    return stations;
}
