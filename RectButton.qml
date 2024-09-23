import QtQuick

// Libraries
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


Button{
    id: root

    property color backgroundDefaultColor: "#b5c0b8"
    property color backgroundPressedColor: Qt.darker(backgroundDefaultColor, 1.2)

    Layout.fillWidth: true

    background: Rectangle{
        border.width: root.hovered ? 1 : 0
        color: root.down ? root.backgroundPressedColor : root.backgroundDefaultColor
    }
}