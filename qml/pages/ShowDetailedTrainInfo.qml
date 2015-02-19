import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property variant trainData

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
                    text: trainData.TrainCode
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
                    text: trainData.StationFullName
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
                    text: trainData.StationCode
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
                text: trainData.QueryTime
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
                    text: trainData.TrainDate
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
                    text: trainData.OriginTime
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
                    text: trainData.DestinationTime
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
                    text: trainData.LastLocation
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
                    text: trainData.DueIn + ' mins'
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
                    text: trainData.ExpArrival
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
                    text: trainData.ExpDepart
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
                    text: trainData.SchArrival
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
                    text: trainData.SchDepart
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
                    text: trainData.TrainType
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
                    text: trainData.LocationType
            }
            SectionHeader { text: "LocationType" }
        }
    }
}
