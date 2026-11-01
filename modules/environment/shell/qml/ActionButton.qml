import QtQuick
import QtQuick.Controls.Basic

Button {
    id: root
    property bool primary: false
    implicitHeight: 36
    implicitWidth: Math.max(80, contentItem.implicitWidth + 28)
    leftPadding: 14
    rightPadding: 14
    hoverEnabled: true
    opacity: enabled ? 1 : 0.4
    contentItem: Text { font.family: Theme.fontFamily;
        text: root.text
        color: root.primary ? Theme.bloodText : Theme.foreground
        font.pixelSize: 13
        font.weight: Font.Medium
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        textFormat: Text.PlainText
    }
    background: Rectangle {
        radius: Theme.controlRadius
        color: root.primary ? Theme.blood : Theme.surface
        border.width: root.visualFocus || root.hovered ? 1 : 0
        border.color: root.visualFocus ? Theme.accent : Theme.border
        opacity: root.down ? 0.75 : 1
    }
}
