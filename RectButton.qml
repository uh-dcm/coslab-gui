import QtQuick 2.15

// Libraries
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 2.15


Button{
    id: root

    property color backgroundDefaultColor: "#2cc55a"
    property color backgroundPressedColor: Qt.darker(backgroundDefaultColor, 1.2)

    background: Rectangle{
        border.color: "#26282a"
        border.width: 0
        color: root.down ? root.backgroundPressedColor : root.backgroundDefaultColor
    }
}