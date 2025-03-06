import QtQuick
import QtQuick.Controls

Item {

    Text{
        text: "coslab"
        font.pixelSize: 30
        anchors.top: parent.top
        anchors.left: parent.left
        leftPadding: 20
        topPadding: 10
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
