import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "root:/io"

RowLayout {
  id: root;
  spacing: 15
  required property QSWindow window;
  implicitWidth: 40 * repeater.count + 30;
  implicitHeight: 30;
  Repeater {
    id: repeater;
    model: HyprlandIO.sortedWorkspaces
    property int count: HyprlandIO.sortedWorkspaces.length
    Rectangle {
      Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
      id: toprect;
      required property HyprlandWorkspace modelData;
      implicitWidth: 32
      implicitHeight: 28
      color: "#7692d6"
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
