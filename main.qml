import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("coslab-gui")

    Grid {
        id: buttonGrid
        y: 371
        height: 59

        anchors.left: parent.left ; anchors.margins: 50
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        horizontalItemAlignment: Grid.AlignHCenter
        verticalItemAlignment: Grid.AlignVCenter


        rows: 2
        columns: 2

        Button {
            id: button
            text: qsTr("Add images from local machine")
        }

        Button {
            id: button1
            text: qsTr("Add images from online source")

        }

        Button {
            id: button2
            text: qsTr("Analyse all images")

        }

        Button {
            id: button3
            text: qsTr("Remove all images")
        }
    }

    GridLayout {
        id: imageGrid

        anchors.left: parent.left ; anchors.leftMargin: 50
        anchors.right: parent.right ; anchors.rightMargin: 50
        anchors.top: parent.top ; anchors.topMargin: 50
        anchors.bottom: buttonGrid.top ; anchors.bottomMargin: 50


        rows: 4
        columns: 4

        Image {
            id: image1
            width: 100
            height: 100
            source: "qrc:/qtquickplugin/images/template_image.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image2
            width: 100
            height: 100
            source: "qrc:/qtquickplugin/images/template_image.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image3
            width: 100
            height: 100
            source: "qrc:/qtquickplugin/images/template_image.png"
            fillMode: Image.PreserveAspectFit
        }


    }

}
