import QtQuick
import Quickshell

PopupWindow {
    id: root
    required property Item target
    property string text: ""
    property bool active: false
    property bool ready: false
    onActiveChanged: {
        ready = false;
        if (active) delay.restart();
        else delay.stop();
    }
    visible: active && ready && text !== ""
    anchor.item: target
    anchor.edges: Edges.Left
    anchor.gravity: Edges.Left
    anchor.rect { x: -16; y: target.height / 2; width: 1; height: 1 }
    implicitWidth: Math.min(320, Math.ceil(metrics.advanceWidth) + 26)
    implicitHeight: label.height + 16
    color: "transparent"
    mask: Region {}

    Timer { id: delay; interval: 500; onTriggered: root.ready = true }
    TextMetrics { id: metrics; font: label.font; text: root.text }
    Rectangle {
        anchors.fill: parent
        color: Theme.background
        border.color: Theme.border
        border.width: 1
        radius: Theme.controlRadius
        Text {
            id: label
            x: 12
            y: 8
            width: root.width - 24
            text: root.text
            textFormat: Text.PlainText
            font.family: Theme.fontFamily
            font.pixelSize: 13
            color: Theme.foreground
            wrapMode: Text.Wrap
        }
    }
}
