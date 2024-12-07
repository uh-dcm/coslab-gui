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

Item{

    Title{
        id: title
    }

    Text{
        id: instructions
        anchors.top: title.bottom ; anchors.topMargin: 20
        anchors.left: parent.left ; anchors.leftMargin: 30
        anchors.right: parent.right ; anchors.rightMargin: 30
        font.pixelSize: 20
        // ToDo: make the image counter work
        text: qsTr("Ready to analyse %1 images.\nChoose services which are used for image labelling.").arg( images.count )
    }

    ColumnLayout{
        anchors.left: parent.left ; anchors.leftMargin: 50
        anchors.top: instructions.bottom ; anchors.topMargin: 40

        CheckBox{
            id: googleBox
            checked: true
            text: qsTr("Google Vision AI")
        }
        CheckBox{
            id: ibmBox
            checked: true
            text: qsTr("IBM Watson Visual Recognition")
        }
        CheckBox{
            id: microsoftBox
            checked: true
            text: qsTr("Microsoft Azure Computer Vision")
        }
        CheckBox{
            id: amazonBox
            checked: true
            text: qsTr("Amazon Rekognition")
        }

        Text{
            id: estimative
            text: qsTr("Estimated total cost: [total cost] euros")

        }
    }

    RowLayout{
        spacing: 20
        anchors.left: parent.left ; anchors.leftMargin: 20
        anchors.right: parent.right ; anchors.rightMargin: 20
        anchors.bottom: parent.bottom ; anchors.bottomMargin: 40

        Button{
            id: btAnayliseServices
            // ToDo: Make the image count work
            text: qsTr("Analyse All %1 Images").arg( images.count )

            Layout.fillWidth: true
            Layout.preferredWidth: 60

            onClicked: {

                // Converting ListModel so it can be sent to python
                loadingStatus.visible = true
                var itemList = []
                for (var i = 0; i < images.count; i++) {
                    var item = images.get(i)
                    itemList.push(item.imageSource.toString().replace("file:///", ""))
                }

                var checkboxes = [googleBox.checked,
                                  ibmBox.checked,
                                  microsoftBox.checked,
                                  amazonBox.checked]

                // Send signal to python
                analyseImages.analyse_images(itemList, checkboxes)
                generateWordcloud.generate_wordcloud()
                generateScores.generate_scores()
                
                loadingStatus.visible = false
                console.log("Switching to step 3")
                step2.visible = false
                step3.visible = true
            }

        }

        // Processing wordcloud URLs received from python
        Connections {
            target: generateWordcloud
            function onWordcloudGenerated(urls) {
                wordcloudModel.clear();
                for(var i = 0; i < urls.length; i++){
                    wordcloudModel.append({url : urls[i]});
                }
            }
        }

        Connections {
            target: generateScores
            function onScoresGenerated(scores) {
                var services = ["aws", "azure", "watson", "google"]
                for(var r = 1; r < score_table.rowCount; r++){
                    score_table.setRow(r, {
                        "header": services[r-1],
                        "aws": scores[r-1][0],
                        "azure": scores[r-1][1],
                        "watson": scores[r-1][2],
                        "googlecloud": scores[r-1][3],
                    })
                }
            }
        }

        Button{
            id: btBack
            text: qsTr("Back")

            Layout.fillWidth: true
            Layout.preferredWidth: 25

            onClicked: {

                console.log("Switching to step 1")
                step2.visible = false
                step1.visible = true
            }

        }

    }

    // This rectangle doesn't actually appear because QML waits for
    // python to finish all its code before repainting. This would need
    // to be rethreaded to allow for updates in the GUI
    Rectangle {
        id: loadingStatus
        anchors.centerIn: parent
        width: 300
        height: 100
        color: "gray"
        border.color: "black"
        border.width: 2
        visible: false 
        
        Text {
            id: loadingText
            anchors.centerIn: parent
            text: "Loading..."
            font.pixelSize: 25
        }

        Connections{
            target: generateScores 
            function onStatusUpdated(status){
                loadingText.text = status
            }
        }
    }
}