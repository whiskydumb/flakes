import QtQuick
import QtQuick.Layouts
import Quickshell.Io

ColumnLayout {
    id: root
    property string pendingAction: ""
    property string failure: ""
    readonly property bool busy: actionProcess.running
    signal completed()
    spacing: Theme.gap

    readonly property var actions: [
        { label: "Sleep", command: ["systemctl", "suspend"], confirm: false },
        { label: "Restart", command: ["systemctl", "reboot"], confirm: true },
        { label: "Shut down", command: ["systemctl", "poweroff"], confirm: true }
    ]

    function reset() { pendingAction = ""; failure = ""; }
    function execute(action) {
        if (busy) return;
        failure = "";
        pendingAction = "";
        actionProcess.command = action.command;
        actionProcess.running = true;
    }

    Process {
        id: actionProcess
        stderr: StdioCollector {
            onStreamFinished: if (text.trim()) console.warn("Session action:", text.trim())
        }
        onExited: (exitCode, exitStatus) => {
            if (exitCode === 0 && exitStatus === 0) root.completed();
            else root.failure = "Action failed (" + exitCode + "). See the Quickshell journal for details.";
        }
    }
    Repeater {
        model: root.actions
        delegate: ActionButton {
            required property var modelData
            Layout.fillWidth: true
            visible: root.pendingAction === ""
            text: modelData.label
            enabled: !root.busy
            onClicked: {
                if (modelData.confirm) root.pendingAction = modelData.label;
                else root.execute(modelData);
            }
        }
    }
    Text { font.family: Theme.fontFamily;
        visible: root.pendingAction !== ""
        Layout.fillWidth: true
        text: root.pendingAction + "? Unsaved work may be lost."
        color: Theme.foreground
        font.pixelSize: 14
        wrapMode: Text.Wrap
    }
    RowLayout {
        visible: root.pendingAction !== ""
        Layout.fillWidth: true
        spacing: Theme.gap
        ActionButton { Layout.fillWidth: true; text: "Cancel"; onClicked: root.pendingAction = "" }
        ActionButton {
            Layout.fillWidth: true
            text: root.pendingAction
            primary: true
            onClicked: root.execute(root.actions.find(action => action.label === root.pendingAction))
        }
    }
    Text { font.family: Theme.fontFamily;
        Layout.fillWidth: true
        visible: root.failure !== ""
        text: root.failure
        color: Theme.accent
        font.pixelSize: 12
        wrapMode: Text.Wrap
    }
}
