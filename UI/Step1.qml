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

    Title{
        id: title
    }

    ColumnLayout{
        id: buttonGrid
        // Positioning
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.bottom: parent.bottom ; anchors.bottomMargin: 40

        // Design
        spacing: 20

        // Elements
        RowLayout{
            spacing: 20

            Button{
                id: btAddLocal
                text: qsTr("Add Images from Local Machine")
                onClicked: fileDialog.open()
                Layout.fillWidth: true

            }

            Button{
                id: btAddInternet
                text: qsTr("Add Images from the Internet")

                onClicked: console.log(  c )
            }
        }

        RowLayout{
            spacing: 20

            Button{
                id: btAnalyseAll
                text: qsTr("Analyse All %1 Images").arg( images.count )

                 Layout.fillWidth: true
                 Layout.preferredWidth: 60

                onClicked: {
                    console.log("Switching to step 2")
                    step1.visible = false
                    step2.visible = true
                }

            }

            Button {
                id: btRemoveAll
                text: qsTr("Remove All " + imageListView.count + " Images")

                Layout.fillWidth: true
                Layout.preferredWidth: 25

                onClicked: {
                    imageModel.clear()
                }
            }
        }
    }



   ListView {
        id: imageListView
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.top: title.bottom ; anchors.topMargin: 20
        anchors.bottom: buttonGrid.top ; anchors.bottomMargin: 40

        spacing: 10
        flickableDirection: Flickable.AutoFlickDirection
        orientation: Qt.Horizontal

        model: images

        delegate: Item {
            width: 200
            height: imageListView.height

            Button {
                anchors.top: parent.top
                anchors.left: parent.left
                width: 40
                height: 40
                background: Image {
                    source: "Graphics/trashcan icon.png"
                }
                onClicked: {
                    model.remove(index)
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
