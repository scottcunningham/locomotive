import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    SilicaListView {
        id: listView
        model: applicationData.getStopsListLength();
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("All stops")
        }

        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: applicationData.getStopsListAt(index);
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                console.log("Clicked stop " + index)
                pageStack.push(Qt.resolvedUrl("ShowStop.qml"), {"stopName": applicationData.getStopsListAt(index)})
            }
        }
        VerticalScrollDecorator {}
    }
}
