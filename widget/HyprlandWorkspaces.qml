import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "root:/io"

Item {
  id: root
  required property QSWindow window;
  implicitWidth: layout.implicitWidth + 2
  implicitHeight: 30;

  RowLayout {
    id: layout
    anchors.centerIn: parent;
    spacing: 15
    Repeater {
      id: repeater;
      model: HyprlandIO.sortedWorkspaces
      property int count: HyprlandIO.sortedWorkspaces.length
      Rectangle {
        id: toprect;
        required property HyprlandWorkspace modelData;
        property string workspaceColor: HyprlandIO.activeWorkspace.id == modelData.id ? "#9a9ada" : "#7692d6"
        implicitWidth: 32
        implicitHeight: 28
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
            color: "#273453"
            anchors.centerIn: parent;
            font.pixelSize: 12
            width: text.width
            text: modelData.id
          }
        }
      }
    }
  }
}
