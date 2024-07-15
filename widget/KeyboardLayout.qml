import QtQuick
import Quickshell
import "root:/component"
import "root:/io"

Rectangle {
  color: "#f9f9fa"
  anchors.centerIn: parent
  height: 30
  width: 30
  radius: 15
  Text {
    property string currLayout: Hyprland.currKeyboardLayout;
    color: "#404b7c"
    anchors.centerIn: parent
    font {
      bold: true
      letterSpacing: 0
    }
    text: Hyprland.currKeyboardLayout
  }
}
