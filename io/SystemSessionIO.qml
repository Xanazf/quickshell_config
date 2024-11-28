pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// fastfetch -c /home/xnzf/.config/fastfetch/rawdata.jsonc

Singleton {
  id: root
  property string uptime
  onUptime: update => uptime = update
  Process {
    id: getUptime
    command: ["sh", "-c", "uptime -p"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        root.uptime = data;
      }
    }
    onExited: running = false
  }
  Timer {
    interval: 60 * 1000
    running: true
    repeat: true
    onTriggered: getUptime.running = true
  }
}
