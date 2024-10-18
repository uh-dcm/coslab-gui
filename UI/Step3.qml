import QtQuick
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

// Placeholder

Item{
    
    Title{
        id: title
    }


    // Placeholder until the code is linked with coslab-core
    Image{
        id: wordCloud
        
        anchors.top: title.bottom ; anchors.topMargin: 20
        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.bottom: resultTable.top ; anchors.bottomMargin: 40

        width: 200; height: 200
        fillMode: Image.PreserveAspectFit
        source: "https://upload.wikimedia.org/wikipedia/commons/b/b6/Logo_University_of_Helsinki_fi.svg"
    }


    TableView {
        id: resultTable

        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.bottom: buttonRow.top ; anchors.bottomMargin: 20

        width: 200
        height: 150

        columnSpacing: 1
        rowSpacing: 1

        model: TableModel {
            TableModelColumn { display: "header" }
            TableModelColumn { display: "aws" }
            TableModelColumn { display: "azure" }
            TableModelColumn { display: "watson" }
            TableModelColumn { display: "googlecloud" }

            rows: [
                { "header": "", "aws": "aws", "azure": "azure", "watson": "watson", "googlecloud": "googlecloud" },
                { "header": "aws", "aws": "Item 1,1", "azure": "Item 1,2", "watson": "Item 1,3", "googlecloud": "Item 1,4" },
                { "header": "azure", "aws": "Item 2,1", "azure": "Item 2,2", "watson": "Item 2,3", "googlecloud": "Item 2,4" },
                { "header": "watson", "aws": "Item 3,1", "azure": "Item 3,2", "watson": "Item 3,3", "googlecloud": "Item 3,4" },
                { "header": "googlecloud", "aws": "Item 4,1", "azure": "Item 4,2", "watson": "Item 4,3", "googlecloud": "Item 4,4" }
            ]
        }

        delegate: Rectangle {
            implicitWidth: resultTable.width / 5
            implicitHeight: resultTable.height / 5
            
            border.width: 1

            Text {
                text: display
                anchors.centerIn: parent
            }
        }
    }


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
            }

        Button{
            id: cancel
            text: qsTr("Back")

            Layout.fillWidth: true
            Layout.preferredWidth: 25

            onClicked: {
                console.log("Switching to step 2")
                step3.visible = false
                step2.visible = true
            }
        }
    }

}