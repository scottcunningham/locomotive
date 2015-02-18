# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = locomotive

QT += xml
QT += sql

CONFIG += sailfishapp
CONFIG += c++11

SOURCES += \
    src/locomotive.cpp \
    src/IrishRailAPI.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    translations/*.ts \
    qml/pages/AllStops.qml \
    qml/pages/FavouriteStops.qml \
    qml/pages/SearchStops.qml \
    qml/pages/ShowStop.qml \
    qml/pages/ShowDetailedTrainInfo.qml \
    qml/locomotive.qml \
    locomotive.desktop \
    rpm/locomotive.changes.in \
    rpm/locomotive.spec \
    rpm/locomotive.yaml

HEADERS += \
    src/IrishRailAPI.h
