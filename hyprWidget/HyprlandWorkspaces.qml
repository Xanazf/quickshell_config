import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "root:/io"
import "root:/"

Item {
  id: root
  required property QSWindow window;
  implicitWidth: layout.implicitWidth + 2
  implicitHeight: Config.sizes.barHeight + 2;

  RowLayout {
    id: layout
    anchors.centerIn: parent;
    spacing: 15
    implicitHeight: parent.height
    Repeater {
      id: repeater;
      model: HyprlandIO.sortedWorkspaces
      property int count: HyprlandIO.sortedWorkspaces.length
      Rectangle {
        id: toprect;
        required property HyprlandWorkspace modelData;
        property string workspaceColor: HyprlandIO.activeWorkspace.id == modelData.id ? "#273495" : "#273463"
        implicitWidth: 32
        implicitHeight: Config.sizes.barHeight
        color: workspaceColor
        radius: 30
        MouseArea {
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          width: parent.width
          height: parent.height
          anchors.centerIn: parent;
          onClicked: (mouse) => {
            console.log(Hyprland.workspaces)
          }
          Text {
            color: "#95d3af"
            anchors.centerIn: parent;
            font.pixelSize: 12
            font.family: "Hack Nerd Font Mono"
            width: text.width
            text: modelData.id
          }
        }
      }
    }
  }
}
