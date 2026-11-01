import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import Quickshell.Networking
import Quickshell.Hyprland

PanelWindow {
    id: bar
    color: "transparent"
    implicitWidth: 48
    anchors { right: true; top: true; bottom: true }
    margins { right: 10; top: 6; bottom: 6 }
    exclusiveZone: 58
    property string section: ""
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property var source: Pipewire.defaultAudioSource
    readonly property var battery: UPower.displayDevice
    readonly property var activeNetwork: Networking.devices.values.find(device => device.connected) ?? null
    function toggleSection(name) { trayPopup.closeMenu(); section = section === name ? "" : name; }

    PwObjectTracker { objects: [bar.sink, bar.source] }
    SystemClock { id: clock; precision: SystemClock.Minutes }

    Rectangle {
        anchors.fill: parent
        radius: Theme.rounding
        color: Theme.background
        border.color: Theme.border
        border.width: 1
        PanelButton {
            id: launcher
            anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
            iconName: "nix-snowflake"
            hint: "Vicinae"
            onClicked: Quickshell.execDetached(["vicinae", "toggle"])
        }
        Column {
            anchors { top: launcher.bottom; topMargin: 12; horizontalCenter: parent.horizontalCenter }
            spacing: 4
            Repeater {
                model: [1, 2, 3]
                delegate: Button {
                    id: workspaceButton
                    required property int modelData
                    readonly property bool active: Hyprland.focusedWorkspace?.id === modelData
                    implicitWidth: 24
                    implicitHeight: 24
                    padding: 0
                    background: Item {}
                    contentItem: Text {
                        text: String(workspaceButton.modelData)
                        font.family: Theme.fontFamily
                        font.pixelSize: 14
                        font.weight: Font.Medium
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: workspaceButton.active || workspaceButton.visualFocus ? Theme.accent : Theme.foreground
                        opacity: workspaceButton.active || workspaceButton.visualFocus ? 1.0 : 0.6
                        Behavior on color { ColorAnimation { duration: 150 } }
                        Behavior on opacity { NumberAnimation { duration: 150 } }
                    }
                    HoverHandler { cursorShape: Qt.PointingHandCursor }
                    Accessible.name: "Workspace " + modelData
                    onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + modelData + " })")
                }
            }
        }
        Column {
            anchors.centerIn: parent
            width: parent.width - 8
            spacing: 6
            Text {
                width: parent.width
                text: Qt.formatDateTime(clock.date, "hh mm")
                font.family: Theme.fontFamily
                font.pixelSize: 12
                font.weight: Font.Medium
                color: Theme.foreground
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                width: parent.width
                text: Qt.formatDateTime(clock.date, "dd MM")
                font.family: Theme.fontFamily
                font.pixelSize: 11
                color: Theme.muted
                horizontalAlignment: Text.AlignHCenter
            }
        }
        ColumnLayout {
            anchors { bottom: parent.bottom; bottomMargin: 10; horizontalCenter: parent.horizontalCenter }
            spacing: 8
            Repeater {
                model: SystemTray.items
                delegate: Item {
                    id: trayButton
                    required property var modelData
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                    IconImage {
                        anchors.centerIn: parent
                        implicitSize: 18
                        mipmap: true
                        source: trayButton.modelData.icon
                    }
                    MouseArea {
                        id: trayMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        onClicked: mouse => {
                            if (mouse.button === Qt.MiddleButton) trayButton.modelData.secondaryActivate();
                            else if (mouse.button === Qt.RightButton || trayButton.modelData.onlyMenu) {
                                if (trayButton.modelData.hasMenu) {
                                    bar.section = "";
                                    trayPopup.openMenu(trayButton.modelData.menu, trayButton.modelData.title || trayButton.modelData.id);
                                }
                            } else trayButton.modelData.activate();
                        }
                    }
                    HoverHint {
                        target: trayButton
                        text: trayButton.modelData.tooltipTitle || trayButton.modelData.title || trayButton.modelData.id
                        active: trayMouse.containsMouse && !trayMouse.pressed
                    }
                }
            }
            Rectangle {
                visible: SystemTray.items.values.length > 0
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: 20
                implicitHeight: 1
                color: Theme.border
            }
            PanelButton {
                iconName: "preferences-system-notifications-symbolic"
                hint: (Notices.doNotDisturb ? "Do not disturb · " : "Notifications: ") + Notices.items.length
                highlighted: Notices.items.length > 0
                onClicked: { Notices.hideToast(); bar.toggleSection("notifications"); }
            }
            PanelButton {
                iconName: !bar.sink?.audio || bar.sink.audio.muted ? "audio-volume-muted-symbolic" : "audio-volume-high-symbolic"
                hint: bar.sink?.audio ? "Volume: " + Math.round(bar.sink.audio.volume * 100) + "%" : "No audio output"
                onClicked: bar.toggleSection("audio")
            }
            PanelButton {
                iconName: !bar.activeNetwork ? "network-offline-symbolic" : bar.activeNetwork.type === DeviceType.Wifi ? "network-wireless-signal-excellent-symbolic" : "network-wired-symbolic"
                hint: "Connections · " + (bar.activeNetwork ? bar.activeNetwork.name : "Offline")
                onClicked: bar.toggleSection("connections")
            }
            PanelButton {
                visible: bar.battery?.isPresent ?? false
                iconName: bar.battery?.iconName || "battery-symbolic"
                hint: "Battery: " + Math.round((bar.battery?.percentage ?? 0) * 100) + "%"
                onClicked: bar.toggleSection("battery")
            }
            PanelButton {
                iconName: "system-shutdown-symbolic"
                hint: "Session"
                onClicked: bar.toggleSection("session")
            }
        }
    }

    TrayMenu { id: trayPopup; screen: bar.screen }

    Details {
        screen: bar.screen
        visible: bar.section !== ""
        section: bar.section
        sink: bar.sink
        source: bar.source
        battery: bar.battery
        onCloseRequested: bar.section = ""
    }

    PanelWindow {
        screen: bar.screen
        visible: Notices.latest !== null && bar.section !== "notifications"
        anchors { right: true; top: true }
        margins { right: 70; top: 6 }
        implicitWidth: 320
        implicitHeight: toastColumn.implicitHeight + 24
        exclusionMode: ExclusionMode.Ignore
        color: "transparent"
        Rectangle {
            anchors.fill: parent
            radius: Theme.rounding
            color: Theme.background
            border.color: Theme.border
            ColumnLayout {
                id: toastColumn
                anchors { left: parent.left; right: parent.right; top: parent.top; margins: 12 }
                Text { font.family: Theme.fontFamily;
                    Layout.fillWidth: true
                    text: Notices.latest?.summary ?? ""
                    textFormat: Text.PlainText
                    color: Theme.foreground
                    font.bold: true
                    wrapMode: Text.Wrap
                    maximumLineCount: 2
                    elide: Text.ElideRight
                }
                Text { font.family: Theme.fontFamily;
                    Layout.fillWidth: true
                    text: Notices.latest?.body ?? ""
                    textFormat: Text.PlainText
                    color: Theme.foreground
                    wrapMode: Text.Wrap
                    maximumLineCount: 3
                    elide: Text.ElideRight
                }
                ActionButton {
                    text: "Open notifications"
                    Layout.fillWidth: true
                    onClicked: { Notices.hideToast(); bar.section = "notifications"; }
                }
            }
        }
    }
}
