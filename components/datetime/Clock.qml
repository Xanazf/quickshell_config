import QtQuick
import Quickshell
import "./"
import "root:/"

Rectangle {
  color: "transparent"
  radius: 30
  width: 129 + 30
  height: Config.sizes.barHeight
  anchors.centerIn: parent
  Text {
    anchors.centerIn: parent
    horizontalAlignment: Text.AlignHCenter
    font.bold: true
    color: Config.colors.fontcolor
    text: Time.time
  }
}
