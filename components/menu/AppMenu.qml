import QtQuick
import Quickshell

import "root:/"
import "root:/io"
import "root:/svg/qml"

Rectangle {
  id: root
  width: 24
  implicitHeight: 30
  anchors.centerIn: parent
  color: "transparent"
  property bool showPopup: false

  MouseArea {
    id: mouseArea1
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onEntered: {
      rootIcon.currentColor = Config.colors.red700;
    }
    onExited: {
      rootIcon.currentColor = Config.colors.mainColor4;
    }
    onClicked: {
      root.showPopup = !root.showPopup;
    }
  }

  ArchIcon {
    id: rootIcon
    anchors.centerIn: parent
    currentColor: Config.colors.mainColor4
    Behavior on currentColor {
      ColorAnimation {
        duration: 300
      }
    }
  }
}
