import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import "root:/"
import "root:/io"

Rectangle {
  id: root
  required property HyprlandWorkspace modelData
  property string workspaceColor: HyprlandIO.activeWorkspace.id == modelData.id ? "#82aaff" : "#273463"
  implicitWidth: 13
  implicitHeight: 13
  color: workspaceColor
  radius: 30
  MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    width: parent.width
    height: parent.height
    anchors.bottom: parent.bottom
    onClicked: mouse => {
      console.log(Hyprland.workspaces);
    }
    Text {
      color: "#95d3af"
      anchors.centerIn: parent
      font.pixelSize: 12
      font.family: "Hack Nerd Font Mono"
      width: text.width
      text: root.height <= 15 ? "" : modelData.id
    }
  }
}
