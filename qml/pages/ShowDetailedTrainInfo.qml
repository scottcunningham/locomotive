import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property string stopName
    property string trainIndex

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        Text {
            text: "Test"
        }
    }
}
