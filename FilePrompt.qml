import QtQuick
import QtQuick.Window

// Libraries
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Dialogs


FileDialog {
    fileMode: FileDialog.OpenFiles
    nameFilters: [ "Image files (*.jpg *.jpeg *.png *.bmp *.gif)", "All files (*)" ]
    onAccepted: {
        for (var i = 0; i < selectedFiles.length; i++) {
            imageModel.append({"imageSource": selectedFiles[i]})
        }
    }
    onRejected: fileDialog.visible = false
}