import QtQuick
import QtQuick.Window

// Libraries
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
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
            text: "Add Images from Local Machine"

        }

        RectButton{
            text: "Add Images from the Internet"
        }

        RectButton{
            text: "Analyse Images"
        }

        RectButton{
            text: "Remove All Images"
        }
    }
}
