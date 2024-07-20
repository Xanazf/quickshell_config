import QtQuick
import Quickshell
import "root:/io"
import "root:/"

Rectangle {
  color: "#9a273453"
  anchors.centerIn: parent
  property string windowTitle: HyprlandIO.activeWindow.title
  property string windowClass: HyprlandIO.activeWindow.hclass

  height: Config.sizes.barHeight
  implicitWidth: text.width + 30
  radius: 15
  Text {
    id: text
    color: "#adbcbc"
    elide: Text.ElideRight
    maximumLineCount: 20
    anchors.centerIn: parent
    width: 250
    height: parent.height
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font {
      bold: true
      letterSpacing: 0
    }
    text: windowTitle
  }
}
