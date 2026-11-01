import QtQuick
import QtQuick.Controls.Basic

Slider {
    id: root
    from: 0
    to: 1
    stepSize: 0.01
    implicitHeight: 28
    leftPadding: 8
    rightPadding: 8
    opacity: enabled ? 1 : 0.4
    background: Rectangle {
        x: root.leftPadding
        y: (root.height - height) / 2
        width: root.availableWidth
        height: 4
        radius: 2
        color: Theme.surface
        Rectangle {
            width: root.position * parent.width
            height: parent.height
            radius: 2
            color: Theme.accent
        }
    }
    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * root.availableWidth - width / 2
        y: (root.height - height) / 2
        width: 14
        height: 14
        radius: 7
        color: root.pressed ? Theme.accent : Theme.foreground
        border.width: root.visualFocus ? 2 : 0
        border.color: Theme.accent
    }
}
