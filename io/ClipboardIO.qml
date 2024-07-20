pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root;
  property bool runninglist: false;
  property bool runningwipe: false;
  property bool runningcount: false;
  signal cliphistcount(count: int);

  Process {
    id: cliphistlist;
    running: root.runninglist;
    command: ["sh", "-c", "cliphist list | wofi --dmenu | cliphist decode | wl-copy"];
    onExited: root.runninglist = false;
  }
  Process {
    id: cliphistwipe;
    running: root.runningwipe;
    command: ["cliphist", "wipe"];
    onExited: root.runningwipe = false;
  }
  Process {
    id: cliphistcount;
    running: root.runningcount;
    command: ["sh", "-c", "cliphist list | wc -l"]
    stdout: SplitParser {
      onRead: data => root.cliphistcount(data);
    }
    onExited: root.runningcount = false;
  }
}
