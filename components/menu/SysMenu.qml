import QtQuick
import QtQuick.Controls
import Quickshell.Io
import Quickshell.Widgets

import qs.config
import qs.helpers.io
import qs.assets.svg.qml

Rectangle {
  id: root
  width: 24
  height: 30
  anchors.centerIn: parent

  color: "transparent"
  MouseArea {
    id: mouseArea1
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      wlogout.running = true;
    }
    onEntered: {
      rootIcon.currentColor = Config.colors.red700;
    }
    onExited: {
      rootIcon.currentColor = Config.colors.mainColor4;
    }
  }
  PowerIcon {
    id: rootIcon
    anchors.centerIn: parent
    currentColor: Config.colors.mainColor4
    Behavior on currentColor {
      ColorAnimation {
        duration: 300
      }
    }
  }
  Process {
    id: wlogout
    command: ["wlogout"]
    running: false
    onExited: running = false
  }
}
