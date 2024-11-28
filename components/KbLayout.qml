import QtQuick
import Quickshell

import "root:/"
import "root:/io"

Rectangle {
  color: "transparent"
  anchors.centerIn: parent
  height: 28
  width: 28
  radius: 15
  Text {
    color: Qt.lighter(Config.colors.navy700, 1.05)
    anchors.centerIn: parent
    font {
      bold: true
      weight: 600
      letterSpacing: 0
      pixelSize: 15
    }
    text: HyprlandIO.currKeyboardLayout
  }
}
