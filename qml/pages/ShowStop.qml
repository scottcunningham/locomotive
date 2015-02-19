import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property variant stopData

    function updateModel() {
        irishRailAPI.refreshTrainListForStop(stopData);
        irishRailAPI.refreshTrainListForStop(stopData.StationDesc);
        var trainsData = irishRailAPI.getTrainListForStop(stopData.StationDesc);
        listModel.clear();
        for (var i = 0; i < trainsData.length && i < 20; i++) {
            var trainData = trainsData[i];
            listModel.append({"trainData": trainData});
        }
    }

    Component.onCompleted: {
        updateModel();
    }

    ListModel {
        id: listModel
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: irishRailAPI.isStopInFavourites(page.stopName) ? qsTr("Remove from favourites") : qsTr("Add to favourites");
                onClicked: {
                    if (irishRailAPI.isStopInFavourites(page.stopName)) {
                        irishRailAPI.removeFromFavourites(page.stopName);
                    } else {
                        irishRailAPI.addToFavourites(page.stopName);
                    }
                    // Refresh page
                    pageStack.replace(Qt.resolvedUrl("ShowStop.qml"), {"stopName": page.stopName});
                }
            }
            MenuItem {
                text: qsTr("Refresh")
                onClicked: {
                    console.log("Refreshing...")
                    updateModel();
                }
            }

            MenuItem {
                text: qsTr("Show detailed stop information")
                onClicked: {
                    pageStack.replace(Qt.resolvedUrl("ShowDetailedStopInfo.qml"), {"stopData": page.stopData});
                }
            }
        }

        SilicaListView {
            id: listView
            model: listModel
            anchors.fill: parent
            header: PageHeader {
                title: stopData.StationDesc
            }
            delegate: BackgroundItem {
                id: delegate

                Label {
                    x: Theme.paddingLarge
                    text: trainData.Destination + ' (' + trainData.Direction + ') ' + trainData.Schdepart;
                    anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                onClicked: {
                    console.log("Clicked " + index)
                    pageStack.push(Qt.resolvedUrl("ShowDetailedTrainInfo.qml"), {"trainData": trainData})
                }
            }
            VerticalScrollDecorator {}
        }
    }
}
