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
    width: 800
    height: 1000
    title: qsTr("COSLAB")

    Settings {
        id: service_settings
        property var azure_subscription_key
        property var azure_endpoint
        property var aws_api_id
        property var aws_api_key
        property var aws_api_region
        property var google_service_account_info

    }

    BusyIndicator {
        id: busyindicator
        anchors.fill: parent
        running: false
    }
    ListModel {
        id: images // the list for all images
    }
    
    ListModel {
        id: wordcloudModel // List for generated wordclouds
    }

    TableModel {
        id: score_table // Table model for the scores
        
        TableModelColumn { display: "header" }
        TableModelColumn { display: "aws" }
        TableModelColumn { display: "azure" }
        // TableModelColumn { display: "watson" }
        TableModelColumn { display: "googlecloud" }

        rows: [
            { "header": "", "aws": "aws", "azure": "azure", "watson": "watson", "googlecloud": "googlecloud" },
            { "header": "aws", "aws": "Item 1,1", "azure": "Item 1,2", "watson": "Item 1,3", "googlecloud": "Item 1,4" },
            { "header": "azure", "aws": "Item 2,1", "azure": "Item 2,2", "watson": "Item 2,3", "googlecloud": "Item 2,4" },
            // { "header": "watson", "aws": "Item 3,1", "azure": "Item 3,2", "watson": "Item 3,3", "googlecloud": "Item 3,4" },
            { "header": "googlecloud", "aws": "Item 4,1", "azure": "Item 4,2", "watson": "Item 4,3", "googlecloud": "Item 4,4" }
        ]
    }

    header: Header {
        id: top
        height: 60
        width: parent.width
    }

    footer: Footer {
        id: bottom
        height: 60
        width: parent.width
    }

    Column {
        anchors.fill: parent
        
        Loader {
            id: content
            anchors.fill: parent
            source: "Step1.qml"
        }

    }

    
}
