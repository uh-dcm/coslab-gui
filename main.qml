import QtQuick
import QtQuick.Window

// Libraries
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Dialogs

// Templates
import "."

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("coslab-gui")

    GridLayout{
        id: buttonGrid
        // Positioning
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.bottom: parent.bottom ; anchors.bottomMargin: 40

        // Design
        columnSpacing: 30
        rowSpacing: 20

        // Number of elements
        rows: 2
        columns: 2

        // Elements
        RectButton{
            id: btAddLocal
            text: qsTr("Add Images from Local Machine")
            onClicked: fileDialog.open()
        }

        RectButton{
            id: btAddInternet
            text: qsTr("Add Images from the Internet")
        }

        RectButton{
            id: btAnalyseAll
            text: qsTr("Analyse All " + imageListView.count + " Images")
            backgroundDefaultColor: "#78ec95"

            onClicked: {
                console.log("button clicked")
            }

        }

        RectButton{
            id: btRemoveAll
            text: qsTr("Remove All " + imageListView.count + " Images")
            backgroundDefaultColor: "#ec7878"

        }
    }

    ListModel {
        id: imageModel
    }

   ListView {
        id: imageListView
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.top: parent.top ; anchors.topMargin: 20
        anchors.bottom: buttonGrid.top ; anchors.bottomMargin: 40

        spacing: 10
        flickableDirection: Flickable.AutoFlickDirection

        orientation: Qt.Horizontal
        delegate: Image {
            width: 200
            height: imageListView.height
            source: model.imageSource
            fillMode: Image.PreserveAspectFit
            }
        }

    FileDialog {
        id: fileDialog
        fileMode: FileDialog.OpenFiles
        nameFilters: [ "Image files (*.jpg *.jpeg *.png *.bmp *.gif)", "All files (*)" ]
        onAccepted: {
            for (var i = 0; i < selectedFiles.length; i++) {
                imageModel.append({"imageSource": selectedFiles[i]})
            }
            imageListView.model = imageModel
        }
        onRejected: fileDialog.visible = false
    }

}
