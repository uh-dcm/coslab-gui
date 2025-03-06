import QtQuick
import QtQuick.Controls

Item {

    width: parent.width
    height: parent.height

    Image {
        source: "./graphics/logo.png"
        width: 5.5 *  parent.height
        height: parent.height
        fillMode: Image.PreserveAspectFit
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}