pragma Singleton

import QtQml
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property real total
  property real free
  property real used: total - free

  Timer {
    interval: 10000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      meminfo.path = "/proc/meminfo";
      meminfo.reload();
    }
  }
  FileView {
    id: meminfo
    path: "/proc/meminfo"
    onTextChanged: {
      const text = meminfo.text();
      if (meminfo.loaded && text) {
        const totalgb = Number(text.match(/MemTotal:\s+(\d+)/)[1]) / 1000000;
        const freegb = Number(text.match(/MemAvailable:\s+(\d+)/)[1]) / 1000000;
        root.total = totalgb.toFixed(1);
        root.free = freegb.toFixed(1);
        meminfo.path = "";
      } else {
        meminfo.reload();
      }
    }
  }
}
