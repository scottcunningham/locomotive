import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property variant trainData

    Component.onCompleted: {
        console.log(trainData);
        console.log(trainData.Destination);
    }

    SilicaListView {
        anchors.fill: parent

        Component.onCompleted: {
            console.log(trainData);
            console.log(trainData.Destination);
        }

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader { title: trainData.StationDesc }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Traincode
            }
            SectionHeader { text: "Train code" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Stationfullname
            }
            SectionHeader { text: "Full station name" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Stationcode
            }
            SectionHeader { text: "Station code" }

            Label {
                width: parent.width
                anchors.topMargin: Theme.paddingLarge
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.RichText
                text: trainData.Querytime
            }

            SectionHeader { text: "Query time" }
            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Traindate
            }
            SectionHeader { text: "Date" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Origin
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
                    text: trainData.Destination
            }
            SectionHeader { text: "Destination" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Origintime
            }
            SectionHeader { text: "Origin time" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Destinationtime
            }
            SectionHeader { text: "Destination time" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Status
            }
            SectionHeader { text: "Status" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Lastlocation
            }
            SectionHeader { text: "Last location" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Duein + ' mins'
            }
            SectionHeader { text: "Due in" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Late + ' mins'
            }
            SectionHeader { text: "Late" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Exparrival
            }
            SectionHeader { text: "Expected arrival time" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Expdepart
            }
            SectionHeader { text: "Expected departure time" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Scharrival
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
                    text: trainData.Schdepart
            }
            SectionHeader { text: "Scheduled departure time" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Direction
            }
            SectionHeader { text: "Direction" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Traintype
            }
            SectionHeader { text: "Train Type" }

            Label {
                    width: parent.width
                    anchors.topMargin: Theme.paddingLarge
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.RichText
                    text: trainData.Locationtype
            }
            SectionHeader { text: "LocationType" }
        }
        VerticalScrollDecorator {}
    }
}
