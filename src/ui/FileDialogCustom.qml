import QtQuick
import QtQuick.Window

// Libraries
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Dialogs


Dialog{
        id: textDialog
        title: "Add Image from the Internet"
        standardButtons: Dialog.Close
        anchors.centerIn: parent

        TextField {
            id: textInput
            placeholderText: "Paste your URL here. Use Enter to confirm URL."
            anchors.fill: parent
            anchors.margins: 10
            Keys.onReturnPressed: {
                if (textInput.text.endsWith(".jpg") ||
                    textInput.text.endsWith(".jpeg") ||
                    textInput.text.endsWith(".png") ||
                    textInput.text.endsWith(".bmp") ||
                    textInput.text.endsWith(".gif")) {
                    images.append({"imageSource": textInput.text})
                    placeholderText = "Image loaded successfully!"
                } else {
                    placeholderText = "Error: The URL was not identified as an image."
                }
            }
        }
    }