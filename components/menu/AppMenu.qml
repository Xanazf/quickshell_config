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
  property bool hovering: false
  property bool targetVisible: false
  property real animX: {
    if (root.QsWindow.window) {
      return root.QsWindow.window.contentItem.mapFromItem(root, 0, 0).x;
    }
    return 0;
  }

  MouseArea {
    id: mouseArea1
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onEntered: {
      rootIcon.currentColor = Config.colors.red700;
      root.hovering = true;
    }
    onExited: {
      rootIcon.currentColor = Config.colors.mainColor4;
      root.hovering = false;
    }
    onClicked: {
      root.showPopup = !root.showPopup;
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
}
