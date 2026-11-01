import QtQuick
import QtQuick.Controls.Basic

Switch {
    id: root
    implicitWidth: 44
    implicitHeight: 32
    padding: 0
    opacity: enabled ? 1 : 0.4
    indicator: Rectangle {
        x: 2
        y: 5
        width: 40
        height: 22
        radius: 11
        color: root.checked ? Theme.blood : Theme.surface
        border.width: 1
        border.color: root.visualFocus ? Theme.accent : root.checked ? Theme.accent : Theme.border
        Rectangle {
            x: root.checked ? 21 : 3
            y: 3
            width: 16
            height: 16
            radius: 8
            color: root.checked ? Theme.bloodText : Theme.muted
            Behavior on x { NumberAnimation { duration: 100 } }
        }
    }
    contentItem: Item {}
}
