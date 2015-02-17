import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property string stopName
    property string trainIndex

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader { title: stopName }

            Label {
                width: parent.width
                anchors.topMargin: Theme.paddingLarge
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.RichText
                text: applicationData.getTrainListForStopAt(stopName, trainIndex)
            }
            SectionHeader { text: "Train name" }

            Label {
                width: parent.width
                anchors.topMargin: Theme.paddingLarge
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.RichText
                text: 'Test'
            }
            SectionHeader { text: "Scheduled arrival time" }

            Label {
                width: parent.width
                anchors.topMargin: Theme.paddingLarge
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.RichText
                text: 'Test'
            }
            SectionHeader { text: "Origin" }

            Label {
                width: parent.width
                anchors.topMargin: Theme.paddingLarge
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.RichText
                text: 'Test'
            }
            SectionHeader { text: "Train type" }

            VerticalScrollDecorator {}
        }
    }
}
