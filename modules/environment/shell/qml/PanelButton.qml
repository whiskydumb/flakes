import QtQuick
import QtQuick.Controls.Basic
import Quickshell

Button {
    id: root
    property string iconName: ""
    property string hint: ""
    implicitWidth: 32
    implicitHeight: 32
    display: AbstractButton.IconOnly
    icon.source: iconName ? Quickshell.iconPath(iconName) : ""
    icon.width: 20
    icon.height: 20
    icon.color: highlighted ? Theme.accent : Theme.foreground
    Accessible.name: hint
    hoverEnabled: true
    background: Rectangle {
        radius: Theme.controlRadius
        color: root.hovered || root.down ? Theme.surface : "transparent"
        border.width: root.visualFocus ? 1 : 0
        border.color: Theme.accent
    }
    HoverHint { target: root; text: root.hint; active: root.hovered && !root.down }
}
