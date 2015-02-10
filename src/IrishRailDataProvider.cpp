#include "IrishRailDataProvider.h"

#include <QtQuick>
#include <QStringList>
#include <QList>
#include <sailfishapp.h>

/*
 * All stops
 */

void IrishRailDataProvider::refreshAllStopsList() {
    QString response = sendRequest("http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML_WithStationType?StationType=D");
    qDebug() << response;
    auto stopsData = parseXML(response);
    QList<QString> stops;
    for (int i = stopsData.size()-1; i >= 0; --i) {
        stops.append(stopsData[i]["StationDesc"]);
        qDebug() << stopsData[i]["StationDesc"];
    }
    this->allStops = stops;
}

QList<QString> IrishRailDataProvider::getAllStopsList() {
    if (this->allStops.size() == 0) {
        qDebug() << "Refreshing, size=" << this->allStops.size();
        this->refreshAllStopsList();
    }
    qDebug() << "Size=" << this->allStops.size();
    return this->allStops;
}

QString IrishRailDataProvider::getStopsListAt(int index) {
    return this->getAllStopsList()[index];
}

QString IrishRailDataProvider::getStopsListLength() {
    return QString::number(this->getAllStopsList().size());
}

/*
 * Favourites
 */

QStringList IrishRailDataProvider::getFavouritesList() {
    QStringList list;
    list.append(QString("Fav 1"));
    list.append(QString("Fav 2"));
    list.append(QString("Fav 3"));
    return list;
}

QString IrishRailDataProvider::getFavouritesListAt(int index) {
    return getFavouritesList()[index];
}

QString IrishRailDataProvider::getFavouritesLength() {
    return QString::number(getFavouritesList().size());
}

/*
 * Stop data
 */
void IrishRailDataProvider::refreshTrainListForStop(QString stop_name) {
    QString url = QString("http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML?StationDesc=%1").arg(stop_name);
    QString response = sendRequest(url); //.toUtf8().constData());
    auto trainsData = parseXML(response);
    QList<QString> trains;
    for (int i = 0; i < trainsData.size(); ++i) {
        if (trainsData[i]["Destination"] != stop_name) {
            QString s = trainsData[i]["Destination"] + " (" + trainsData[i]["Direction"] + ") " + trainsData[i]["Schdepart"];
            trains.append(s); // stopsData[i]["StationDesc"]);
        }
    }
    this->trainsForStop[stop_name] = trains;
}

QStringList IrishRailDataProvider::getTrainListForStop(QString stop_name) {
    if (this->trainsForStop[stop_name].size() == 0) {
        qDebug() << "Refreshing, size=" << this->trainsForStop.size();
        this->refreshTrainListForStop(stop_name);
    }
    qDebug() << "Size=" << this->trainsForStop[stop_name].size();
    return this->trainsForStop[stop_name];
}

QString IrishRailDataProvider::getTrainListForStopAt(QString stop_name, int index) {
    return this->getTrainListForStop(stop_name)[index];
}

QString IrishRailDataProvider::getTrainListForStopLength(QString stop_name) {
    return QString::number(this->getTrainListForStop(stop_name).size());
}


#include <QCoreApplication>
#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QUrlQuery>

QString IrishRailDataProvider::sendRequest(QString url_string) {
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

QList<QMap<QString, QString> > IrishRailDataProvider::parseXML(QString input_str) {
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

IrishRailDataProvider::IrishRailDataProvider() {
    qDebug() << "Data provider initialising";
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(QString("database.sqlite3"));
    this->db = db;
}


#include <QSqlQuery>

void IrishRailDataProvider::addToFavourites(QString stop_name) {
    QSqlQuery query(this->db);
    QString query_string = QString("insert into favourites values (%1, \"Northbound\"").arg(stop_name);
    query.exec(query_string);
}
