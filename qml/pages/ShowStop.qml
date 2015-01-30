import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Add to favourites")
                onClicked: console.log("Added.")
            }
        }

        SilicaListView {
            id: listView
            model: 5
            anchors.fill: parent
            header: PageHeader {
                title: qsTr("Stop Name (Northbound)")
            }
            delegate: BackgroundItem {
                id: delegate

                Label {
                    x: Theme.paddingLarge
                    text: qsTr("Destination") + " " + index + "\t\t\t 16:45"
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
