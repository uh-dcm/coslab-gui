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
                var itemList = []
                for (var i = 0; i < images.count; i++) {
                    var item = images.get(i)
                    itemList.push(item.imageSource.toString())
                }

                var checkboxes = [googleBox.checked,
                                  ibmBox.checked,
                                  microsoftBox.checked,
                                  amazonBox.checked]

                // Send signal to python
                analyseImages.analyse_images(itemList, checkboxes)
                console.log(analyseImages)

                console.log("Switching to step 3")
                step2.visible = false
                step3.visible = true
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

}