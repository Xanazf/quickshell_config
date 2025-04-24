pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property string decodeId
  property bool runningdecode: false

  property var copyItem
  property bool runningcopy

  property bool runninglist: false
  property bool runningwipe: false
  property bool runningcount: true
  property int cliphistcount: 0
  property list<string> cliphistlist: []

  signal decoded(var data)
  signal copy

  Process {
    id: cliphist
    running: root.runninglist
    command: ["sh", "-c", "cliphist list"]
    stdout: SplitParser {
      onRead: data => {
        root.cliphistlist.push(data);
      }
    }
    onExited: root.runninglist = false
  }
  Process {
    id: cliphistwipe
    running: root.runningwipe
    command: ["sh", "-c", "cliphist wipe"]
    onExited: root.runningwipe = false
  }
  Process {
    id: cliphistcount
    running: root.runningcount
    command: ["sh", "-c", "cliphist list | wc -l"]
    stdout: SplitParser {
      onRead: data => {
        root.cliphistcount = data;
        if (Number(data) >= 500) {
          root.runningwipe = true;
        }
      }
    }
    onExited: (code, status) => {
      root.runningcount = false;
    }
  }
  Process {
    id: cliphistdecode
    running: root.runningdecode
    command: ["sh", "-c", `cliphist decode ${root.decodeId}`]
    stdout: SplitParser {
      onRead: data => {
        root.decoded(data);
      }
    }
    onExited: root.runningdecode = false
  }
  Process {
    id: cliphistcopy
    running: root.runningcopy
    command: ["sh", "-c", `wl-copy ${root.copyItem}`]
    onExited: root.runningdecode = false
  }
}
