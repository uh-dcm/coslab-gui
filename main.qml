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
    width: 640
    height: 480
    visible: true
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
            text: qsTr("Analyse Images")
            backgroundDefaultColor: "#78ec95"

            onClicked: {
                console.log("button clicked")
            }

        }

        RectButton{
            id: btRemoveAll
            text: qsTr("Remove All Images")
            backgroundDefaultColor: "#ec7878"

        }
    }

    ListView {
        id: listview
        height: 100
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        orientation: Qt.Horizontal
        delegate:
            Image {
            width: 160
            height: 90
            source: modelData
            }
    }

    FileDialog {
        FileDialog.OpenFiles
        id: fileDialog
        property url defaultz: "E:\IMG"
        nameFilters: [ "Image files (*.jpg *.png *.bmp)", "All files (*)" ]
        onAccepted: {
            var images = [];
            for(var i in fileDialog.fileUrls){
                images[i] = fileDialog.fileUrls[i]
            }
            listview.model = images
        }
        onRejected: fileDialog.visible = false
    }

}
