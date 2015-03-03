import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property variant stopData

    function updateModel() {
        irishRailAPI.refreshTrainListForStop(stopData.StationDesc);
        var trainsData = irishRailAPI.getTrainListForStop(stopData.StationDesc);
        listModel.clear();
        for (var i = 0; i < trainsData.Northbound.length && i < 20; i++) {
            var trainData = trainsData.Northbound[i];
            listModel.append({"trainData": trainData, "section": "Northbound"});
        }
        for (var i = 0; i < trainsData.Southbound.length && i < 20; i++) {
            var trainData = trainsData.Southbound[i];
            listModel.append({"trainData": trainData, "section": "Southbound"});
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
                text: irishRailAPI.isStopInFavourites(page.stopData.StationDesc) ? qsTr("Remove from favourites") : qsTr("Add to favourites");
                onClicked: {
                    if (irishRailAPI.isStopInFavourites(page.stopData.StationDesc)) {
                        irishRailAPI.removeFromFavourites(page.stopData.StationDesc);
                    } else {
                        irishRailAPI.addToFavourites(page.stopData.StationDesc);
                    }
                    // Refresh page
                    pageStack.replace(Qt.resolvedUrl("ShowStop.qml"), {"stopData": page.stopData});
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

            section {
                property: 'section'

                delegate: SectionHeader {
                    text: section
                    height: Theme.itemSizeExtraSmall
                }
            }

            delegate: BackgroundItem {
                id: delegate

                Label {
                    id: dest
                    x: Theme.paddingLarge
                    text: trainData.Destination
                    anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    font.pixelSize: Theme.fontSizeMedium
                    truncationMode: TruncationMode.Fade
                    anchors {
                        left: parent.left
                        right: date.left
                        rightMargin: Theme.paddingSmall
                    }
                }
                Label {
                    id: date
                    text: trainData.Schdepart
                    font.pixelSize: Theme.fontSizeMedium
                    horizontalAlignment: Text.AlignRight
                    anchors {
                        right: parent.right
                        baseline: dest.baseline
                    }
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
