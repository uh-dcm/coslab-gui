import QtQuick 2.15
import QtQuick.Window 2.15

// Libraries
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 2.15

// Templates
import "."

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("coslab-gui")

    GridLayout{
        anchors.centerIn: parent
        columnSpacing: 30
        rowSpacing: 30
        rows: 2
        columns: 2

        RectButton{
            text: qsTr("Add Images from Local Machine")

        }

        RectButton{
            text: qsTr("Add Images from the Internet")
        }

        RectButton{
            text: qsTr("Analyse Images")
            onClicked: {
                console.log("button clicked")
            }

        }

        RectButton{
            text: qsTr("Remove All Images")
        }
    }
}