import QtQuick
import Quickshell
import QtQuick.Layouts
import "root:/component"
import "root:/io"

Rectangle {
  id: root;
  anchors.centerIn: parent
  color: "transparent"
  implicitWidth: 75 + 38
  RowLayout {
    anchors {
      centerIn: parent
    }
    implicitWidth: parent.width
    spacing: 1


    BarItem {
      color: "#404b7c"
      Layout.preferredWidth: textfield.width * 1.8
      topLeftRadius: 30
      bottomLeftRadius: 30
      topRightRadius: 6
      bottomRightRadius: 6
      Text {
        id: textfield
        color: "#95d3af"
        anchors.centerIn: parent
        width: PipewireIO.volume < 100 ? 32 : 39
        property string volumeLow: "󰕿 "
        property string volumeMid: "󰖀 "
        property string volumeHigh: "󰕾 "
        property string volumeIcon: PipewireIO.volume < 30 ? volumeLow : PipewireIO.volume < 70 ? volumeMid : volumeHigh
        text: volumeIcon+PipewireIO.volume 
      }
    }
    BarItem {
      color: "#f9f9fa"
      implicitWidth: textfield2.width
      Layout.preferredWidth: textfield2.width * 1.8
      topLeftRadius: 6
      bottomLeftRadius: 6
      topRightRadius: 30
      bottomRightRadius: 30
      Text {
        id: textfield2
        width: PipewireIO.micVolume < 100 ? 28 : 35
        color: "#404b7c"
        anchors.centerIn: parent
        text: " " + PipewireIO.micVolume 
      }
    }
  }
}
