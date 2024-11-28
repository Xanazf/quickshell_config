pragma Singleton

import QtQml
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property bool runningcheck: false
  property bool finished
  signal success(bool status)
  property bool readAllowed: false
  property string errorMsg
  property list<string> updates: []
  onSuccess: {
    root.readAllowed = true;
  }

  Process {
    id: checkupdate
    running: root.runningcheck
    command: ["sh", "-c", "checkupdates & pacman -Qm | aur vercmp & wait"]
    stdout: SplitParser {
      onRead: data => {
        const datasplit = data.split(" ");
        const name = datasplit.shift();
        const versions = datasplit.join("").split("->");
        const oldVer = versions[0];
        const newVer = versions[1];
        const pacstr = `${name}|${oldVer}|${newVer}`;
        root.updates.push(pacstr);
      }
    }
    onStarted: {
      root.updates = [];
      root.finished = false;
    }
    onExited: (code, status) => {
      if (code === 0) {
        root.success(true);
      }
      root.runningcheck = false;
      root.finished = true;
    }
  }
  Timer {
    interval: 6 * 60 * 60 * 1000 // hours * minutes * seconds * ms
    running: true
    repeat: true
    onTriggered: root.runningcheck = true
  }
}
