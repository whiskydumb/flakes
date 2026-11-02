//@ pragma IconTheme Adwaita
import QtQuick
import Quickshell

Scope {
    Background {}

    Variants {
        model: Quickshell.screens
        SideBar {
            required property var modelData
            screen: modelData
        }
    }
}
