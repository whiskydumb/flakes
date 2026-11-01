import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

PanelWindow {
    id: popup
    property var levels: []
    visible: levels.length > 0
    function openMenu(handle, title) { levels = [{ handle: handle, title: title }]; }
    function closeMenu() { levels = []; }
    anchors { right: true; bottom: true }
    margins { right: 70; bottom: 6 }
    implicitWidth: Math.min(220, screen.width - 90)
    implicitHeight: Math.min(screen.height - 12, body.implicitHeight + 16)
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    color: "transparent"
    Rectangle {
        anchors.fill: parent
        radius: 10
        color: Theme.background
        border.color: Theme.border
        focus: true
        Keys.onEscapePressed: popup.closeMenu()
        ScrollView {
            id: scroll
            anchors { fill: parent; margins: 8 }
            contentWidth: availableWidth
            clip: true
            ColumnLayout {
                id: body
                width: scroll.availableWidth
                spacing: 2
                RowLayout {
                    Layout.fillWidth: true
                    PanelButton {
                        visible: popup.levels.length > 1
                        iconName: "go-previous-symbolic"
                        hint: "Back"
                        onClicked: popup.levels = popup.levels.slice(0, -1)
                    }
                    Text { font.family: Theme.fontFamily;
                        Layout.fillWidth: true
                        text: popup.levels.length ? popup.levels[popup.levels.length - 1].title : ""
                        textFormat: Text.PlainText
                        elide: Text.ElideRight
                        color: Theme.foreground
                        font.pixelSize: 12
                        font.weight: Font.Bold
                        opacity: 0.7
                        Layout.leftMargin: 8
                    }
                    PanelButton { iconName: "window-close-symbolic"; hint: "Close menu"; onClicked: popup.closeMenu() }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    Layout.leftMargin: 4
                    Layout.rightMargin: 4
                    Layout.bottomMargin: 4
                    color: Theme.foreground
                    opacity: 0.1
                }
                Repeater {
                    model: popup.levels
                    delegate: ColumnLayout {
                        id: level
                        required property var modelData
                        required property int index
                        Layout.fillWidth: true
                        visible: index === popup.levels.length - 1
                        spacing: 2
                        QsMenuOpener { id: opener; menu: level.modelData.handle }
                        Repeater {
                            model: opener.children
                            delegate: Item {
                                id: row
                                required property var modelData
                                Layout.fillWidth: true
                                implicitHeight: modelData.isSeparator ? 9 : 32
                                Rectangle {
                                    visible: row.modelData.isSeparator
                                    anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter; leftMargin: 8; rightMargin: 8 }
                                    height: 1
                                    color: Theme.foreground
                                    opacity: 0.1
                                }
                                ActionButton {
                                    id: menuButton
                                    anchors.fill: parent
                                    visible: !row.modelData.isSeparator
                                    enabled: row.modelData.enabled
                                    text: row.modelData.text
                                    leftPadding: 10
                                    rightPadding: 10
                                    opacity: enabled ? 1.0 : 0.5
                                    background: Rectangle {
                                        radius: 6
                                        color: menuButton.enabled && (menuButton.hovered || menuButton.visualFocus) ? Theme.surface : "transparent"
                                    }
                                    contentItem: RowLayout {
                                        spacing: 8
                                        Rectangle {
                                            visible: row.modelData.buttonType !== QsMenuButtonType.None
                                            implicitWidth: 16
                                            implicitHeight: 16
                                            radius: row.modelData.buttonType === QsMenuButtonType.RadioButton ? 8 : 3
                                            color: "transparent"
                                            border.color: row.modelData.checkState !== Qt.Unchecked ? Theme.accent : Theme.foreground
                                            border.width: 1.5
                                            opacity: row.modelData.checkState !== Qt.Unchecked ? 1.0 : 0.5
                                            Rectangle {
                                                anchors.centerIn: parent
                                                width: 8
                                                height: 8
                                                radius: row.modelData.buttonType === QsMenuButtonType.RadioButton ? 4 : 2
                                                color: Theme.accent
                                                visible: row.modelData.checkState !== Qt.Unchecked
                                            }
                                        }
                                        IconImage {
                                            visible: row.modelData.icon !== "" && row.modelData.buttonType === QsMenuButtonType.None
                                            source: row.modelData.icon
                                            implicitSize: 16
                                        }
                                        Text { font.family: Theme.fontFamily;
                                            Layout.fillWidth: true
                                            text: row.modelData.text.replace(/&(?!&)/g, "").replace(/&&/g, "&")
                                            textFormat: Text.PlainText
                                            color: Theme.foreground
                                            font.pixelSize: 13
                                            elide: Text.ElideRight
                                        }
                                        PanelButton {
                                            visible: row.modelData.hasChildren
                                            iconName: "go-next-symbolic"
                                            implicitWidth: 16
                                            implicitHeight: 16
                                            enabled: false
                                        }
                                    }
                                    onClicked: {
                                        if (row.modelData.hasChildren) {
                                            popup.levels = popup.levels.concat([{ handle: row.modelData, title: row.modelData.text }]);
                                        } else {
                                            row.modelData.triggered();
                                            popup.closeMenu();
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
}
