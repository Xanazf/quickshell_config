import QtQuick
import Quickshell
import QtQuick.Layouts
import "root:/component"
import "root:/io"

Rectangle {
  id: root;
  anchors.centerIn: parent
  color: "transparent"
  width: 75 + 38
  RowLayout {
    anchors {
      centerIn: parent
    }
    width: parent.width

    BarItem {
      color: "#404b7c"
      Layout.preferredWidth: textfield.width * 1.8
      radius: 30
      Text {
        id: textfield
        color: "#95d3af"
        anchors.centerIn: parent
        width: Audio.volume < 100 ? 32 : 39
        property string volumeLow: "󰕿 "
        property string volumeMid: "󰖀 "
        property string volumeHigh: "󰕾 "
        property string volumeIcon: Audio.volume < 30 ? volumeLow : Audio.volume < 70 ? volumeMid : volumeHigh
        text: volumeIcon+Audio.volume 
      }
    }
    BarItem {
      color: "#f9f9fa"
      radius: 30
      width: textfield2.width
      Layout.preferredWidth: textfield2.width * 1.8
      Text {
        id: textfield2
        width: Audio.micVolume < 100 ? 28 : 35
        color: "#404b7c"
        anchors.centerIn: parent
        text: " " + Audio.micVolume 
      }
    }
  }
}
