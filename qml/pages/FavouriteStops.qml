import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    SilicaListView {
        id: listView
        model: applicationData.getFavouritesLength();
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Favourites")
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: applicationData.getFavouritesListAt(index);
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl("ShowStop.qml"), {"stopName": applicationData.getFavouritesListAt(index)})
            }
        }
        VerticalScrollDecorator {}
    }
}
