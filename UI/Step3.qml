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

    ListView {
        id: wordcloudView
        
        anchors.top: title.bottom ; anchors.topMargin: 20
        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.bottom: resultTable.top ; anchors.bottomMargin: 40

        spacing: 10
        flickableDirection: Flickable.AutoFlickDirection
        orientation: Qt.Horizontal

        model: wordcloudModel

        delegate: Item {
            width: 200
            height: wordcloudView.height
            Image {
                width: 200
                height: wordcloudView.height
                source: model.url
                fillMode: Image.PreserveAspectFit
            }
        }
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

        model: score_table

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