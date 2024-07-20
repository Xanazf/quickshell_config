import QtQuick
import Quickshell
import "root:/io"
import "root:/"

Rectangle {
  color: Config.colors.mainBG
  anchors.centerIn: parent
  height: Config.sizes.barHeight
  width: 28
  radius: 15
  Text {
    color: Config.colors.mainFG
    anchors.centerIn: parent
    font {
      bold: true
      weight: 600
      letterSpacing: 0
      pixelSize: 13
      family: "Hack Nerd Font"
    }
    text: HyprlandIO.currKeyboardLayout
  }
}
