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
TARGET = myniceapp

QT += xml
QT += sql

CONFIG += sailfishapp
CONFIG += c++11

SOURCES += \
    src/IrishRailDataProvider.cpp \
    src/myniceapp.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/myniceapp.changes.in \
    rpm/myniceapp.spec \
    rpm/myniceapp.yaml \
    translations/*.ts \
    qml/pages/AllStops.qml \
    qml/pages/FavouriteStops.qml \
    qml/pages/SearchStops.qml \
    qml/pages/ShowStop.qml \
    myniceapp.desktop \
    qml/myniceapp.qml \
    qml/pages/ShowDetailedTrainInfo.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/myniceapp-de.ts

HEADERS += \
    src/IrishRailDataProvider.h
