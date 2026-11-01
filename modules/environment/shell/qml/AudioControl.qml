import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    property string title: ""
    property var node
    spacing: 8
    RowLayout {
        Layout.fillWidth: true
        Text { font.family: Theme.fontFamily; Layout.fillWidth: true; text: root.title; color: Theme.foreground; font.pixelSize: 14; font.weight: Font.Medium }
        Text { font.family: Theme.fontFamily; text: root.node?.audio ? Math.round(root.node.audio.volume * 100) + "%" : "—"; color: Theme.muted; font.pixelSize: 13 }
        Toggle {
            enabled: !!root.node?.audio
            checked: root.node?.audio ? !root.node.audio.muted : false
            Accessible.name: root.title + " enabled"
            onToggled: root.node.audio.muted = !checked
        }
    }
    Text { font.family: Theme.fontFamily;
        Layout.fillWidth: true
        text: !root.node?.audio ? "No device connected" : root.node.audio.muted ? "Muted · " + root.node.description : root.node.description
        textFormat: Text.PlainText
        color: Theme.muted
        font.pixelSize: 12
        elide: Text.ElideRight
    }
    LevelSlider {
        Layout.fillWidth: true
        enabled: !!root.node?.audio
        value: root.node?.audio?.volume ?? 0
        Accessible.name: root.title + " volume"
        onMoved: root.node.audio.volume = value
    }
}
