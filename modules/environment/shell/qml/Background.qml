import QtQuick
import Quickshell
import Quickshell.Wayland

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData
        screen: modelData
        color: Theme.background
        mask: Region {}

        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "whisky-background"

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        Image {
            anchors.fill: parent
            source: Qt.resolvedUrl("wallpaper.png")
            fillMode: Image.PreserveAspectCrop
            asynchronous: true

            onStatusChanged: {
                if (status === Image.Error)
                    console.error("Failed to load wallpaper:", source)
            }
        }
    }
}
