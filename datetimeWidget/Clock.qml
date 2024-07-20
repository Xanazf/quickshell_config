import QtQuick
import Quickshell
import "./component/"
import "root:/"

Rectangle {
  color: "#f9f9fa"
  radius: 30
  width: 129 + 30
  height: Config.sizes.barHeight
  anchors.centerIn: parent
  Text { 
    anchors.centerIn: parent
    horizontalAlignment: Text.AlignHCenter
    font.bold: true
    color: "#273453"
    text: Time.time 
  }
}
