import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    SilicaListView {
        id: listView
        model: 10
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Favourites")
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: qsTr("Stop ") + " " + index + " (Northbound)"
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                console.log("Clicked favourite " + index)
                pageStack.push(Qt.resolvedUrl("ShowStop.qml"))
            }
        }
        VerticalScrollDecorator {}
    }
}
