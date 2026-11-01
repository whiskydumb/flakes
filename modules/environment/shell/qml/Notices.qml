pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root
    readonly property var items: server.trackedNotifications.values.filter(notification => !notification.transient)
    property bool doNotDisturb: false
    property var latest: null
    onDoNotDisturbChanged: { if (doNotDisturb) hideToast(); }
    function hideToast() {
        const previous = latest;
        latest = null;
        toastTimer.stop();
        if (previous?.transient) previous.expire();
    }
    function dismissAll() {
        hideToast();
        for (const notification of items.slice()) notification.dismiss();
    }
    Connections {
        target: root.latest
        function onClosed() { root.latest = null; toastTimer.stop(); }
    }
    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        bodyMarkupSupported: false
        persistenceSupported: true
        onNotification: notification => {
            if (root.doNotDisturb && notification.transient) return;
            notification.tracked = true;
            if (root.doNotDisturb || notification.lastGeneration) return;
            if (root.latest !== notification) root.hideToast();
            root.latest = notification;
            toastTimer.interval = notification.expireTimeout > 0 ? notification.expireTimeout : 6000;
            toastTimer.restart();
        }
    }
    Timer {
        id: toastTimer
        interval: 6000
        onTriggered: root.hideToast()
    }
}
