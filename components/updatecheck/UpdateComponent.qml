import QtQuick
import Quickshell

import qs.config
import qs.helpers.io
import qs.assets.svg.qml

Rectangle {
  id: root
  property bool canRead: CheckUpdate.finished && CheckUpdate.readAllowed
  property list<string> updates: canRead ? CheckUpdate.updates : []
  property int numOfUpdates: canRead ? updates.length : 0
  property bool canUpdate: numOfUpdates > 0
  width: 24
  implicitHeight: 30
  anchors.centerIn: parent
  color: "transparent"

  MouseArea {
    id: mouseArea1
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onPressed: {
      CheckUpdate.runningcheck = true;
    }
    onEntered: {
      if (root.hasUpdate) {
        rootIcon.currentColor = Config.colors.yellow800;
      } else {
        rootIcon.currentColor = Config.colors.red700;
      }
    }
    onExited: {
      if (root.hasUpdate) {
        rootIcon.currentColor = Config.colors.yellow600;
      } else {
        rootIcon.currentColor = Qt.alpha(Config.colors.red600, 0.3);
      }
    }
  }

  DownloadOutline {
    id: rootIcon
    anchors.centerIn: parent
    currentColor: root.canUpdate ? Config.colors.yellow600 : Qt.alpha(Config.colors.red600, 0.3)
    Behavior on currentColor {
      ColorAnimation {
        duration: 300
      }
    }
    Rectangle {
      id: updateCallout
      x: 15
      y: 15
      width: numUpdates.width + 3
      height: 13
      radius: 30
      color: root.canUpdate ? Config.colors.yellow600 : "transparent"
      Text {
        id: numUpdates
        anchors.centerIn: parent
        font.pixelSize: 9
        color: root.canUpdate ? Config.colors.neutral : "transparent"
        text: `${root.numOfUpdates}`
      }
    }
  }
  Component.onCompleted: {
    CheckUpdate.runningcheck = true;
  }
}
