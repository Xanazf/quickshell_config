import QtQuick
import Quickshell
import "root:/component"

Text {
  color: "#273453"
  width: 129 + 30
  anchors.centerIn: parent
  horizontalAlignment: Text.AlignHCenter
  text: Time.time
}
