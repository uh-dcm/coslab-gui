import QtQuick
import QtCore
import QtQuick.Window

// Libraries
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Dialogs
import Qt.labs.qmlmodels

// Templates
import "."

Item{

    width: parent.width
    height: parent.height

    // List of wordclouds
    Flow {
        id: wordcloudView
        
        height: parent.height - resultTable.height - buttonRow.height
        width: parent.width
        
        spacing: 10

        Repeater {
            model: wordcloudModel

            delegate: Item {
                width: parent.width / 2 - 5
                height: parent.height / 2 - 5
                Image {
                    width: parent.width
                    height: parent.height
                    source: model.url
                    fillMode: Image.PreserveAspectFit
                }
            }

        }
    }

    Text {
        text: "Mean COSLAB score for each service pair (1 is best, 0 is worse)"
        font.pointSize: 20
        padding: 10
        anchors.bottom: resultTable.top
    }

    // Table of service scores
    TableView {
        id: resultTable

        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.bottom: buttonRow.top ; anchors.bottomMargin: 20

        width: 200
        height: 150

        columnSpacing: 1
        rowSpacing: 1

        model: score_table

        delegate: Rectangle {
            implicitWidth: resultTable.width / score_table.rowCount
            implicitHeight: resultTable.height / score_table.rowCount
            
            border.width: 1

            Text {
                text: display
                anchors.centerIn: parent
            }
        }
    }

    // Buttons for exporting or returning
    RowLayout{
        id: buttonRow
        spacing: 20
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.bottom: parent.bottom ; anchors.bottomMargin: 40

        Button{
            id: btExpportResults
            text: qsTr("Export Results")

            Layout.fillWidth: true
            Layout.preferredWidth: 60

            onClicked: exportDialog.open()
            }

        Button{
            id: cancel
            text: qsTr("Back")

            Layout.fillWidth: true
            Layout.preferredWidth: 25

            onClicked: {
                content.source = "Step2.qml"
            }
        }
    }

    // Dialog box with checkboxes for which exports should be done
    Dialog{
        id: exportDialog
        title: "Export Results"
        standardButtons: Dialog.Close | Dialog.Save
        anchors.centerIn: parent

        GridLayout{
            id: exportOptions
            anchors.centerIn: parent
            columns: 2
            rowSpacing: 10
            columnSpacing: 10

            CheckBox {
                id: wc
                checked: false
                text: "Wordclouds"
            }
            //CheckBox {
            //    id: comp
            //    checked: false
            //    text: "Comparison Table"
            //}
            CheckBox {
                id: csv
                checked: false
                text: "CSV"
            }
            CheckBox {
                id: pickle
                checked: false
                text: "Pickle"
            }
            //CheckBox {
            //    id: json
            //    checked: false
            //    text: "JSON"
            //}
            CheckBox {
                id: excel
                checked: false
                text: "Excel"
            }
        }

        onAccepted: {
            exportFolder.open()
        }
    }

    // Opens folder dialog to select where images will be saved
    FolderDialog{
        id: exportFolder
        title: "Select a Folder"
        options: FolderDialog.ShowDirsOnly
        onAccepted: {
            backend.export(wc.checked, false, csv.checked, pickle.checked, false, excel.checked, currentFolder)
        }
    }
}

