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

                onClicked: textDialog.open()
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
                    backend.send_credentials()

                    console.log("Switching to step 2")
                    step1.visible = false
                    step2.visible = true
                }

            }

            Connections{
                target: backend
                function onSendCredentials(cred){
                    credentials.set(0, {"attribute1" : cred[0]});
                    credentials.set(0, {"attribute2" : cred[1]});
                    credentials.set(1, {"attribute1" : cred[2]});
                    credentials.set(1, {"attribute2" : cred[3]});
                    credentials.set(1, {"attribute3" : cred[4]});
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
                    console.log(drop.urls[i])
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
                    images.remove(index)
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

    FileDialogCustom{
        id: textDialog
    }
}
