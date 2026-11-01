pragma Singleton
import QtQuick

QtObject {
    readonly property string fontFamily: "Geologica"
    readonly property color background: "#@background@"
    readonly property color surface: "#@surface@"
    readonly property color foreground: "#@foreground@"
    readonly property color muted: "#@muted@"
    readonly property color accent: "#@accent@"
    readonly property color blood: "#@blood@"
    readonly property color bloodText: "#@onBlood@"
    readonly property color success: "#@success@"
    readonly property color warning: "#@warning@"
    readonly property color error: "#@error@"
    readonly property color info: "#@info@"
    readonly property color border: Qt.rgba(0.62, 0.62, 0.62, 0.18)
    readonly property int rounding: 12
    readonly property int controlRadius: 8
    readonly property int inset: 20
    readonly property int gap: 12
}
