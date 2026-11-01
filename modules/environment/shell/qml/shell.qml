//@ pragma IconTheme Adwaita
import QtQuick
import Quickshell

Scope {
    Variants {
        model: Quickshell.screens
        SideBar {
            required property var modelData
            screen: modelData
        }
    }
}
