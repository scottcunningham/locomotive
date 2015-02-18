import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    function updateModel() {
        irishRailAPI.refreshAllStopsList();
        var stopsData = irishRailAPI.getFavouritesList();
        listModel.clear();
        for (var i = 0; i < stopsData.length && i < 20; i++) {
            var stopData = stopsData[i];
            listModel.append({"stopName": stopData});
        }
    }

    Component.onCompleted: {
        updateModel();
    }

    ListModel {
        id: listModel
    }

    SilicaListView {
        id: listView
        model: listModel
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Favourites")
        }

        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: stopName
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl("ShowStop.qml"), {"stopName": stopName})
            }
        }
        VerticalScrollDecorator {}
    }
}
