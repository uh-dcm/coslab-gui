import QtCore
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

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("coslab-gui")

     Settings {
        id: service_settings
        property var azure_subscription_key
        property var azure_endpoint
        property var aws_api_id
        property var aws_api_key
        property var aws_region
        property var google_service_account_info

    }

    // the list for all images
    ListModel {
        id: images
    }
    // List for generated wordclouds
    ListModel {
        id: wordcloudModel
    }

    // Table model for the scores
    TableModel {
        id: score_table
        
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
