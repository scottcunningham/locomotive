import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property string stopName
    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Add to favourites")
                onClicked: console.log("Added.")
            }
            MenuItem {
                text: qsTr("Refresh")
                onClicked: console.log("Refreshing...")
            }
        }

        SilicaListView {
            id: listView
            model: applicationData.getTrainListForStopLength(page.stopName)
            anchors.fill: parent
            header: PageHeader {
                title: page.stopName // qsTr("Stop Name (Northbound)")
            }
            delegate: BackgroundItem {
                id: delegate

                Label {
                    x: Theme.paddingLarge
                    text: applicationData.getTrainListForStopAt(page.stopName, index)
                    anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                onClicked: {
                    console.log("Clicked " + index)
                }
            }
            VerticalScrollDecorator {}
        }
    }
}
