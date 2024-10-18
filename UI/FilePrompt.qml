import QtQuick
import QtQuick.Window

// Libraries
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Dialogs

// The ID of the listModel in Step1 must be named imageModel or else this break
// maybe someone smarter than me knows how to make this modular
FileDialog {

    fileMode: FileDialog.OpenFiles
    nameFilters: [ "Image files (*.jpg *.jpeg *.png *.bmp *.gif)", "All files (*)" ]
    onAccepted: {
        for (var i = 0; i < selectedFiles.length; i++) {
            images.append({"imageSource": selectedFiles[i]})
        }
    }
    onRejected: fileDialog.visible = false
}