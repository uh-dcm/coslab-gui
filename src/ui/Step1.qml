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
                text: qsTr("Add images")
                onClicked: fileDialog.open()
                Layout.fillWidth: true
            }

            //Button{
            //    id: btAddInternet
            //    text: qsTr("Add Images from the Internet")
            //    onClicked: textDialog.open()
            //}
        }

        RowLayout{
            spacing: 20

            Button{
                id: btAnalyseAll
                text: qsTr("Analyse %1 images").arg( images.count )
                enabled: images.count > 0
        

                Layout.fillWidth: true
                Layout.preferredWidth: 60

                onClicked: {
                    content.source = "Step2.qml"
                }

            }

            Button {
                id: btRemoveAll
                text: qsTr("Remove all images")
                enabled: images.count > 0

                Layout.fillWidth: true
                Layout.preferredWidth: 25

                onClicked: {
                    images.clear()
                }
            }
        }
    }

    DropArea {
        id: dropArea
        anchors.fill: parent

        // Qt Complains about injecting parameters into signal handlers
        // but it works anyway.
        onDropped: {
            for (var i = 0; i < drop.urls.length; i++) {
                if (drop.urls[i].toString().endsWith(".jpg") ||
                    drop.urls[i].toString().endsWith(".jpeg") ||
                    drop.urls[i].toString().endsWith(".png") ||
                    drop.urls[i].toString().endsWith(".bmp") ||
                    drop.urls[i].toString().endsWith(".gif")) {
                    images.append({"imageSource": drop.urls[i]})
                }
            }
        }

        Rectangle {
            width: parent.width - 20
            height: parent.height - 20
            anchors.centerIn: parent
            color: dropArea.containsDrag ? "lightgreen" : "transparent"
            border.color: "transparent"
            radius: 10

            Text {
                anchors.centerIn: parent
                text: dropArea.containsDrag ? "Drop Images Here" : ""
                font.bold: true
            }
        }
    }
    
    Flow {
        id: imageListView
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 20
        anchors.bottomMargin: 40 + buttonGrid.height
        spacing: 10
        
        Repeater {
            model: images
            delegate: Item {
                width: 200
                height: 200

                Button {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: 40
                    height: 40
                    background: Image {
                        source: "graphics/trashcan.png"
                    }
                    onClicked: {
                        images.remove(index)
                    }
                }

                Image {
                    width: parent.width
                    height: parent.height
                    source: model.imageSource
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }

    FilePrompt {
        id: fileDialog
    }

    FileDialogCustom{
        id: textDialog
    }
}
