import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Pane {

    Image {
        id: logo
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 30
        height: 50
        width: 50
        source: "graphics/coslabicon.png"
        fillMode: Image.PreserveAspectFit
    }

    Text{
        text: "coslab"
        font.pixelSize: logo.height
        anchors.top: logo.top
        anchors.left: logo.right
        anchors.leftMargin: 10
    }
    
    Button {
        text: "HELP"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.topMargin: 5
        onClicked: Qt.openUrlExternally("https://github.com/uh-dcm/coslab-gui")
    }

}
