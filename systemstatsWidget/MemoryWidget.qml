import QtQuick
import Quickshell
import "root:/io"
import "root:/"


Rectangle {
  id: root;
  anchors.centerIn: parent
  implicitWidth: (memtext.memory < 20 ? 66 : 72) + 30
  implicitHeight: Config.sizes.barHeight

  property string memcolor: memtext.memUsed > (memtext.memTotal / 2) ? "#E29F42":"#404b7c"
  color: memcolor
  radius: 30
  Text {
    id: memtext;
    property string textcolor: memtext.memUsed > (memtext.memTotal / 2) ? "#273453" : "#95d3af"
    property real memTotal: Memory.total
    property real memUsed: Memory.used
    property string memory: memUsed.toFixed(1);
    anchors.centerIn: parent
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    height: parent.height
    color: textcolor
    text: " " + memory + " GB"
  }
}
