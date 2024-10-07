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

Item {
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

            onClicked: textDialog.open()
        }

        RectButton{
            id: btAnalyseAll
            text: qsTr("Analyse All " + imageListView.count + " Images")
            backgroundDefaultColor: "#78ec95"

            onClicked: {
                console.log("Switching to step 2")
                step1.visible = false
                step2.visible = true
            }

        }

        RectButton{
            id: btRemoveAll
            text: qsTr("Remove All " + imageListView.count + " Images")
            backgroundDefaultColor: "#ec7878"
            onClicked: {
                imageModel.clear()
            }
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

        model: imageModel

        delegate: Item {
            width: 200
            height: imageListView.height

            Button {
                anchors.top: parent.top
                anchors.left: parent.left
                width: 50
                height: 50
                background: Image {
                    source: "Graphics/trashcan icon.png"
                }
                onClicked: {
                    imageModel.remove(index)
                }
            }

            Image {
                width: 200
                height: imageListView.height
                source: model.imageSource
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    FilePrompt {
        id: fileDialog
    }

    FileDialog{
        id: textDialog
    }
}
