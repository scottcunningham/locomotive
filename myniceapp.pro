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

CONFIG += sailfishapp

SOURCES += src/myniceapp.cpp

OTHER_FILES += qml/myniceapp.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/myniceapp.changes.in \
    rpm/myniceapp.spec \
    rpm/myniceapp.yaml \
    translations/*.ts \
    myniceapp.desktop \
    qml/pages/AllStops.qml \
    qml/pages/FavouriteStops.qml \
    qml/pages/SearchStops.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/myniceapp-de.ts

