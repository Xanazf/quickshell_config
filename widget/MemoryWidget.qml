import QtQuick
import Quickshell
import "root:/io"
import "root:/component"


Rectangle {
  id: root;
  anchors.centerIn: parent
  color: "transparent"
  width: (memtext.memory < 20 ? 66 : 72) + 30
  height: 30

  BarItem {
    id: item;
    property string memcolor: memtext.memUsed > (memtext.memTotal / 2) ? "#E29F42":"#4ba9b1"
    width: parent.width
    color: memcolor
    radius: 30
    Text {
      id: memtext;
      property real memTotal: Memory.total
      property real memUsed: Memory.used
      property string memory: memUsed.toFixed(1);
      anchors.centerIn: parent
      color: "#181c22"
      text: " " + memory + " GB"
    }
  }
}
