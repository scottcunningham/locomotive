import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    function updateModel() {
        irishRailAPI.refreshAllStopsList();
        var stopsData = irishRailAPI.getAllStopsList();
        listModel.clear();
        for (var i = 0; i < stopsData.length && i < 20; i++) {
            var stopData = stopsData[i];
            listModel.append({"stopData": stopData});
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
            title: qsTr("All stops")
        }

        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: stopData['StationDesc']
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl("ShowStop.qml"), {"stopData": stopData});
            }
        }
        VerticalScrollDecorator {}
    }
}
