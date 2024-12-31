pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  property var locale: Qt.locale()
  property var datevar: new Date()
  property string date: datevar.toLocaleString(locale, "ddd, dd MMM")
  property string dateNum: datevar.toLocaleString(locale, "d/M/yy")
  property string syshours: clock.hours
  property string sysminutes: clock.minutes
  property string sysseconds: clock.seconds
  SystemClock {
    id: clock
    precision: SystemClock.Minutes
    onHoursChanged: {
      root.syshours = hours.toString().padStart(2, "0");
    }
    onMinutesChanged: {
      root.sysminutes = minutes.toString().padStart(2, "0");
    }
    onSecondsChanged: {
      root.sysseconds = seconds.toString().padStart(2, "0");
    }
  }

  Timer {
    interval: 5 * 60 * 60 * 1000 // hours * minutes * seconds * ms
    running: true
    repeat: true
    onTriggered: datevar = new Date()
  }
}
