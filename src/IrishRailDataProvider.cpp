#include "IrishRailDataProvider.h"

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

IrishRailDataProvider::IrishRailDataProvider() {
    this->initDatabase();
}

IrishRailDataProvider::~IrishRailDataProvider() {
    this->db.close();
}

void IrishRailDataProvider::initDatabase() {
    QSqlDatabase db = QSqlDatabase::addDatabase(DATABASE_DRIVER);
    db.setDatabaseName(QString(DATABASE_PATH));
    this->db = db;
    this->db.open();
    QSqlQuery query(this->db);
    QString query_string = QString(INIT_FAVOURITES_SQL);
    query.exec(query_string);
}

void IrishRailDataProvider::refreshAllStopsList() {
    QString response = sendRequest(ALL_STOPS_LIST_API_URL);
    auto stopsData = parseXML(response);
    QList<QString> stops;
    for (int i = stopsData.size()-1; i >= 0; --i) {
        stops.append(stopsData[i]["StationDesc"]);
    }
    this->allStops = stops;
}

QStringList IrishRailDataProvider::getAllStopsList() {
    // TODO: Nicer refresh logic here.
    if (this->allStops.size() == 0) {
        this->refreshAllStopsList();
    }
    return this->allStops;
}

QString IrishRailDataProvider::getStopsListAt(int index) {
    return this->getAllStopsList()[index];
}

QString IrishRailDataProvider::getStopsListLength() {
    return QString::number(this->getAllStopsList().size());
}

void IrishRailDataProvider::refreshTrainListForStop(QString stop_name) {
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

QStringList IrishRailDataProvider::getTrainListForStop(QString stop_name) {
    if (this->trainsForStop[stop_name].size() == 0) {
        this->refreshTrainListForStop(stop_name);
    }
    return this->trainsForStop[stop_name];
}

QString IrishRailDataProvider::getTrainListForStopAt(QString stop_name, int index) {
    return this->getTrainListForStop(stop_name)[index];
}

QString IrishRailDataProvider::getTrainListForStopLength(QString stop_name) {
    return QString::number(this->getTrainListForStop(stop_name).size());
}

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

QList<QMap<QString, QString> > IrishRailDataProvider::parseXML(QString input_xml) {
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

void IrishRailDataProvider::addToFavourites(QString stop_name) {
    QSqlQuery query(this->db);
    // TODO: Use proper QT SQL API
    QString query_string = QString(ADD_FAVOURITE_SQL).arg(stop_name);
    bool result = query.exec(query_string);
    if (!result) {
        qDebug() << query.lastError().text();
    }
}

void IrishRailDataProvider::removeFromFavourites(QString stop_name) {
    QSqlQuery query(this->db);
    // TODO: Use proper QT SQL API
    QString query_string = QString(REMOVE_FAVOURITE_SQL).arg(stop_name);
    bool result = query.exec(query_string);
    if (!result) {
        qDebug() << query.lastError().text();
    }
}

QStringList IrishRailDataProvider::getFavouritesList() {
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

QString IrishRailDataProvider::getFavouritesListAt(int index) {
    return getFavouritesList()[index];
}

QString IrishRailDataProvider::getFavouritesLength() {
    return QString::number(getFavouritesList().size());
}

bool IrishRailDataProvider::isStopInFavourites(QString stop_name) {
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
