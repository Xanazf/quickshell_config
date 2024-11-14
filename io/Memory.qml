pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property real total
  property real free
  property real used: total - free

  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: meminfo.running = true
  }
  Process {
    id: meminfo
    running: true
    command: ["cat", "/proc/meminfo"]
    stdout: SplitParser {
      splitMarker: ""
      onRead: data => {
        //print(data);
        let totalgb = Number(data.match(/MemTotal:\s+(\d+)/)[1]) / 1000000;
        let freegb = Number(data.match(/MemAvailable:\s+(\d+)/)[1]) / 1000000;
        root.total = totalgb.toFixed(1);
        root.free = freegb.toFixed(1);
        meminfo.running = false;
      }
    }
  }
}
