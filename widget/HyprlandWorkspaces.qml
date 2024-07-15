import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "root:/io"

RowLayout {
  id: root;
  spacing: 3
  required property QSWindow window;
  width: 28 * repeater.count + 30;
  Repeater {
    id: repeater;
    model: Hyprland.sortedWorkspaces
    Rectangle {
      Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
      id: toprect;
      required property HyprlandWorkspace modelData;
      width: 28
      height: 30
      color: "transparent"
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
          anchors.centerIn: parent;
          text: modelData.id
        }
      }
    }
  }
}
