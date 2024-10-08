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
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("coslab-gui")

    Step1 {
        id: step1
        anchors.fill: parent
        visible: true
    }

    Step2 {
        id: step2
        anchors.fill: parent
        visible: false
    }

    Step3{
        id: step3
        anchors.fill: parent
        visible: false
    }
}
