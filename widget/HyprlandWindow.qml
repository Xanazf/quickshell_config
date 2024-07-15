import QtQuick
import Quickshell
import "root:/io"

Rectangle {
  color: "#9a273453"
  anchors.centerIn: parent
  property string windowTitle: HyprlandIO.activeWindow.title
  property string windowClass: HyprlandIO.activeWindow.hclass

  height: 30
  width: text.width + 30
  radius: 15
  Text {
    id: text
    color: "#adbcbc"
    anchors.centerIn: parent
    font {
      bold: true
      letterSpacing: 0
    }
    text: windowTitle
  }
}
