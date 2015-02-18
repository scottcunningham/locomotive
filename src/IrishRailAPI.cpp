#include "IrishRailAPI.h"

#include <sailfishapp.h>
#include <QCoreApplication>
#include <QDebug>
#include <QDomDocument>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QStringList>
#include <QSqlQuery>
#include <QSqlError>
#include <QtQuick>
#include <QUrl>
#include <QUrlQuery>

#include <sailfishapp.h>


const static QString ALL_STOPS_LIST_API_URL = "http://api.irishrail.ie/realtime/realtime.asmx/"
                                              "getAllStationsXML_WithStationType?StationType=D";
const static QString TRAIN_LIST_FOR_STOP_API_URL = "http://api.irishrail.ie/realtime/realtime.asmx/"
                                                   "getStationDataByNameXML?StationDesc=%1";

const static QString DATABASE_PATH = "database.sqlite";
const static QString DATABASE_DRIVER = "QSQLITE";
const static QString INIT_FAVOURITES_SQL = "CREATE TABLE IF NOT EXISTS favourites"
                                           "(`stop_name` string, `direction` string);";
const static QString GET_FAVOURITES_SQL_QUERY = "SELECT * FROM favourites;";
const static QString ADD_FAVOURITE_SQL = "insert into favourites (`stop_name`, `direction`)"
                                         "VALUES (\"%1\", \"Northbound\")";
const static QString REMOVE_FAVOURITE_SQL = "delete from favourites where `stop_name`=\"%1\"";
const static QString IS_STOP_FAVOURITE_SQL = "select count(*) from favourites where stop_name=\"%1\"";

IrishRailAPI::IrishRailAPI() {
    this->initDatabase();
}

IrishRailAPI::~IrishRailAPI() {
    this->db.close();
}

void IrishRailAPI::initDatabase() {
    QSqlDatabase db = QSqlDatabase::addDatabase(DATABASE_DRIVER);
    db.setDatabaseName(QString(DATABASE_PATH));
    this->db = db;
    this->db.open();
    QSqlQuery query(this->db);
    QString query_string = QString(INIT_FAVOURITES_SQL);
    query.exec(query_string);
}

void IrishRailAPI::refreshAllStopsList() {
    QString response = sendRequest(ALL_STOPS_LIST_API_URL);
    auto stopsData = parseXML(response);
    QList<QString> stops;
    for (int i = stopsData.size()-1; i >= 0; --i) {
        stops.append(stopsData[i]["StationDesc"]);
    }
    this->allStops = stops;
}

QStringList IrishRailAPI::getAllStopsList() {
    return this->allStops;
}

void IrishRailAPI::refreshTrainListForStop(QString stop_name) {
    QString url = QString(TRAIN_LIST_FOR_STOP_API_URL).arg(stop_name);
    QString response = sendRequest(url);
    auto trains_data = parseXML(response);
    QList<QString> trains;
    for (int i = 0; i < trains_data.size(); ++i) {
        if (trains_data[i]["Destination"] != stop_name) {
            // TODO: Align destination to left, time to right
            // TODO: Change text colour based on whether train late etc.
            QString s = QString("%1 (%2) %3").arg(trains_data[i]["Destination"])
                                             .arg(trains_data[i]["Direction"])
                                             .arg(trains_data[i]["Schdepart"]);
            trains.append(s);
        }
    }
    this->trainsForStop[stop_name] = trains;
}

QStringList IrishRailAPI::getTrainListForStop(QString stop_name) {
    if (this->trainsForStop[stop_name].size() == 0) {
        this->refreshTrainListForStop(stop_name);
    }
    return this->trainsForStop[stop_name];
}

QString IrishRailAPI::sendRequest(QString url_string) {
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

    QString reply_body;
    if (reply->error() == QNetworkReply::NoError) {
        reply_body = reply->readAll();
        delete reply;
    }
    else {
        qDebug() << "HTTP Request failure:" << reply->errorString();
        reply_body = reply->readAll();
        delete reply;
    }
    return reply_body;
}

QList<QMap<QString, QString> > IrishRailAPI::parseXML(QString input_xml) {
    QList<QMap<QString, QString> > stations;

    QDomDocument doc;
    doc.setContent(input_xml);

    QDomElement docElem = doc.documentElement();
    QDomNode node = docElem.firstChild();
    while(!node.isNull()) {
        QDomElement element = node.toElement();
        if(!element.isNull()) {
            QMap<QString, QString> station;
            for (int i = 0; i < element.childNodes().size(); ++i) {
                auto child_node = element.childNodes().at(i);
                QDomElement child_element = child_node.toElement();
                station[child_element.tagName()] = child_element.text();
            }
            stations.append(station);
        }
        node = node.nextSibling();
    }
    return stations;
}

void IrishRailAPI::addToFavourites(QString stop_name) {
    QSqlQuery query(this->db);
    // TODO: Use proper QT SQL API
    QString query_string = QString(ADD_FAVOURITE_SQL).arg(stop_name);
    bool result = query.exec(query_string);
    if (!result) {
        qDebug() << query.lastError().text();
    }
}

void IrishRailAPI::removeFromFavourites(QString stop_name) {
    QSqlQuery query(this->db);
    // TODO: Use proper QT SQL API
    QString query_string = QString(REMOVE_FAVOURITE_SQL).arg(stop_name);
    bool result = query.exec(query_string);
    if (!result) {
        qDebug() << query.lastError().text();
    }
}

QStringList IrishRailAPI::getFavouritesList() {
    QStringList favourites;
    QSqlQuery query(this->db);
    QString query_string = QString(GET_FAVOURITES_SQL_QUERY);
    bool result = query.exec(query_string);
    if (!result) {
        qDebug() << query.lastError().text();
    }
    while (query.next()) {
        QString name = query.value(0).toString();
        favourites.append(name);
    }
    return favourites;
}

bool IrishRailAPI::isStopInFavourites(QString stop_name) {
    QSqlQuery query(this->db);
    // TODO: Use proper QT SQL API
    QString query_string = QString(IS_STOP_FAVOURITE_SQL).arg(stop_name);
    bool result = query.exec(query_string);
    if (!result) {
        qDebug() << query.lastError().text();
    }
    query.next();
    long long count = query.value(0).toLongLong();
    return count != 0;
}
