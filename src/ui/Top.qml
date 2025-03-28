import QtQuick
import QtQuick.Controls

Item {

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
        font.pixelSize: 30
        anchors.top: logo.top
        anchors.left: logo.right
        anchors.leftMargin: 10
    }


    Button {
        text: "Support"
        anchors.top: parent.top
        anchors.right: parent.right
        leftPadding: 20
        topPadding: 10
        onClicked: Qt.openUrlExternally("https://github.com/uh-dcm/coslab-gui")
    }

}
