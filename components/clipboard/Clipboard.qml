import QtQuick
import QtQuick.Controls
import Quickshell

import "root:/"
import "root:/helpers/io"
import "root:/assets/svg/qml"

Rectangle {
  id: root
  property int tooltipText: ClipboardIO.cliphistcount
  property list<string> cliphistdata: ClipboardIO.cliphistlist
  property bool showPopup: false
  anchors.centerIn: parent
  color: "transparent"
  border.width: 2
  property color mainColor: mouseArea.isHovered ? Qt.lighter(Config.colors.mainColor2, 1.6) : Qt.lighter(Config.colors.mainColor2, 1.3)
  border.color: mainColor
  implicitHeight: Config.sizes.barHeight / 1.32
  implicitWidth: 42
  radius: 30
  ClipboardTextOutline {
    id: clipboardTextIcon
    visible: root.tooltipText !== 0
    anchors.centerIn: parent
    currentColor: root.mainColor
    Behavior on currentColor {
      ColorAnimation {
        duration: 300
      }
    }
  }
  ClipboardOutline {
    id: clipboardEmptyIcon
    visible: root.tooltipText === 0
    anchors.centerIn: parent
    currentColor: root.mainColor
    Behavior on currentColor {
      ColorAnimation {
        duration: 300
      }
    }
  }
  MouseArea {
    id: mouseArea
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    property bool isHovered: false
    onClicked: mouse => {
      if (mouse.button === Qt.LeftButton) {
        if (root.cliphistdata.length === 0 || (!ClipboardIO.runninglist && ClipboardIO.cliphistcount !== root.tooltipText)) {
          ClipboardIO.runninglist = true;
        }
        root.showPopup = !root.showPopup;
      } else if (mouse.button === Qt.RightButton) {
        ClipboardIO.runningwipe = true;
      }
    }
    onEntered: {
      ClipboardIO.runningcount = true;
      isHovered = true;
    }
    onExited: {
      isHovered = false;
    }
  }
  Behavior on border.color {
    ColorAnimation {
      duration: 300
    }
  }
}
