pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  property var locale: Qt.locale()
  property var date: new Date()
  property string time: date.toLocaleString(locale, "ddd, dd MMM | hh:mm")

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: date = new Date()
  }
}
