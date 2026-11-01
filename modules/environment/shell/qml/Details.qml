import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Networking
import Quickshell.Bluetooth

PanelWindow {
    id: popup
    property string section: ""
    property var sink
    property var source
    property var battery
    signal closeRequested()
    onSectionChanged: sessionControls.reset()
    onVisibleChanged: sessionControls.reset()
    anchors { right: true; bottom: true }
    margins { right: 70; bottom: 6 }
    implicitWidth: Math.min(360, screen.width - 90)
    implicitHeight: Math.min(screen.height - 12, body.implicitHeight + Theme.inset * 2)
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        radius: Theme.rounding
        border.color: Theme.border
        border.width: 1
        focus: true
        Keys.onEscapePressed: popup.closeRequested()
        ScrollView {
            id: scroll
            anchors { fill: parent; margins: Theme.inset }
            contentWidth: availableWidth
            clip: true
            ColumnLayout {
                id: body
                width: scroll.availableWidth
                spacing: 20
                RowLayout {
                    Layout.fillWidth: true
                    Text { font.family: Theme.fontFamily;
                        Layout.fillWidth: true
                        text: popup.section.charAt(0).toUpperCase() + popup.section.slice(1)
                        color: Theme.foreground
                        font.pixelSize: 17
                        font.weight: Font.DemiBold
                    }
                    PanelButton { iconName: "window-close-symbolic"; hint: "Close"; onClicked: popup.closeRequested() }
                }
                SessionControls {
                    id: sessionControls
                    visible: popup.section === "session"
                    Layout.fillWidth: true
                    onCompleted: popup.closeRequested()
                }
                ColumnLayout {
                    visible: popup.section === "audio"
                    Layout.fillWidth: true
                    spacing: 20
                    AudioControl { Layout.fillWidth: true; title: "Output"; node: popup.sink }
                    Rectangle { Layout.fillWidth: true; height: 1; color: Theme.border }
                    AudioControl { Layout.fillWidth: true; title: "Microphone"; node: popup.source }
                    ActionButton {
                        Layout.fillWidth: true
                        text: "More sound settings"
                        onClicked: Quickshell.execDetached(["uwsm", "app", "--", "pwvucontrol"])
                    }
                }
                ColumnLayout {
                    visible: popup.section === "connections"
                    Layout.fillWidth: true
                    spacing: Theme.gap
                    Text { font.family: Theme.fontFamily; text: "Network"; color: Theme.foreground; font.pixelSize: 14; font.weight: Font.Medium }
                    Repeater {
                        model: Networking.devices
                        delegate: RowLayout {
                            required property var modelData
                            Layout.fillWidth: true
                            Text { font.family: Theme.fontFamily; Layout.fillWidth: true; text: modelData.name; color: Theme.foreground; font.pixelSize: 14; textFormat: Text.PlainText; elide: Text.ElideRight }
                            Text { font.family: Theme.fontFamily; text: modelData.connected ? "Connected" : "Disconnected"; color: modelData.connected ? Theme.success : Theme.muted; font.pixelSize: 12 }
                        }
                    }
                    ActionButton {
                        Layout.fillWidth: true
                        text: "Network settings"
                        onClicked: Quickshell.execDetached(["uwsm", "app", "--", "ghostty", "-e", "nmtui"])
                    }
                    Rectangle { Layout.fillWidth: true; height: 1; color: Theme.border }
                    Text { font.family: Theme.fontFamily; text: "Bluetooth"; color: Theme.foreground; font.pixelSize: 14; font.weight: Font.Medium }
                    Text { font.family: Theme.fontFamily;
                        visible: Bluetooth.adapters.values.length === 0
                        text: "No Bluetooth adapter"
                        color: Theme.muted
                        font.pixelSize: 12
                    }
                    Repeater {
                        model: Bluetooth.adapters
                        delegate: RowLayout {
                            required property var modelData
                            Layout.fillWidth: true
                            Text { font.family: Theme.fontFamily; Layout.fillWidth: true; text: modelData.name; textFormat: Text.PlainText; elide: Text.ElideRight; color: Theme.foreground; font.pixelSize: 13 }
                            Toggle {
                                checked: modelData.enabled
                                Accessible.name: "Bluetooth " + modelData.name
                                onToggled: modelData.enabled = checked
                            }
                        }
                    }
                    Repeater {
                        model: Bluetooth.devices
                        delegate: Text { font.family: Theme.fontFamily;
                            required property var modelData
                            visible: modelData.connected
                            Layout.fillWidth: true
                            text: modelData.name + " · Connected"
                            textFormat: Text.PlainText
                            elide: Text.ElideRight
                            color: Theme.muted
                            font.pixelSize: 12
                        }
                    }
                    ActionButton {
                        Layout.fillWidth: true
                        text: "Bluetooth settings"
                        enabled: Bluetooth.adapters.values.length > 0
                        onClicked: Quickshell.execDetached(["uwsm", "app", "--", "blueman-manager"])
                    }
                }
                Text { font.family: Theme.fontFamily;
                    visible: popup.section === "battery"
                    text: Math.round((popup.battery?.percentage ?? 0) * 100) + "% remaining"
                    color: Theme.foreground
                    font.pixelSize: 24
                }
                ColumnLayout {
                    visible: popup.section === "notifications"
                    Layout.fillWidth: true
                    spacing: 12
                    RowLayout {
                        Layout.fillWidth: true
                        Text { font.family: Theme.fontFamily; Layout.fillWidth: true; text: "Do not disturb"; color: Theme.foreground; font.pixelSize: 14 }
                        Toggle {
                            checked: Notices.doNotDisturb
                            Accessible.name: "Do not disturb"
                            onToggled: Notices.doNotDisturb = checked
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Text { font.family: Theme.fontFamily; Layout.fillWidth: true; text: Notices.items.length + " notifications"; color: Theme.muted; font.pixelSize: 12 }
                        ActionButton { text: "Clear all"; enabled: Notices.items.length > 0; onClicked: Notices.dismissAll() }
                    }
                    Text { font.family: Theme.fontFamily; visible: Notices.items.length === 0; text: "You're all caught up"; color: Theme.muted; font.pixelSize: 14; Layout.topMargin: 12; Layout.bottomMargin: 12 }
                    Repeater {
                        model: Notices.items
                        delegate: Rectangle {
                            id: notice
                            required property var modelData
                            Layout.fillWidth: true
                            implicitHeight: noticeBody.implicitHeight + 28
                            color: Theme.surface
                            radius: Theme.controlRadius
                            ColumnLayout {
                                id: noticeBody
                                anchors { left: parent.left; right: parent.right; top: parent.top; margins: 14 }
                                spacing: 8
                                RowLayout {
                                    Layout.fillWidth: true
                                    Text { font.family: Theme.fontFamily; Layout.fillWidth: true; text: notice.modelData.appName; color: Theme.muted; font.pixelSize: 12; textFormat: Text.PlainText; elide: Text.ElideRight }
                                    PanelButton { iconName: "window-close-symbolic"; hint: "Dismiss notification"; implicitWidth: 24; implicitHeight: 24; onClicked: notice.modelData.dismiss() }
                                }
                                Text { font.family: Theme.fontFamily; Layout.fillWidth: true; text: notice.modelData.summary; color: Theme.foreground; font.pixelSize: 14; textFormat: Text.PlainText; wrapMode: Text.Wrap; font.weight: Font.Medium }
                                Text { font.family: Theme.fontFamily; Layout.fillWidth: true; visible: text !== ""; text: notice.modelData.body; color: Theme.muted; font.pixelSize: 13; textFormat: Text.PlainText; wrapMode: Text.Wrap }
                                Repeater {
                                    model: notice.modelData.actions
                                    delegate: ActionButton {
                                        required property var modelData
                                        Layout.fillWidth: true
                                        text: modelData.text
                                        onClicked: modelData.invoke()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
