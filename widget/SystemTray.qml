import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray

RowLayout {
  id: root;
  spacing: 3
  required property QSWindow window;
  width: 28 * repeater.count + 30;
  Repeater {
    id: repeater;
    model: SystemTray.items
    property int count: SystemTray.items.values.length;
    Rectangle {
      id: toprect;
      required property SystemTrayItem modelData;
      height: 30
      color: "transparent"
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
      MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        width: parent.width
        height: parent.height
        Image {
          source: modelData.icon
          height: 24
          width: 24
          anchors.centerIn: parent;
        }
        onClicked: (mouse) => {
          if (mouse.button == Qt.LeftButton){
            modelData.activate()
          } else if (mouse.button == Qt.RightButton){
            let relX = window.width - toprect.x + root.width
            let coord = window.contentItem.mapFromItem(toprect, 0, 0)
            modelData.display(window, coord.x, window.height + 3)
          }
        }

      }
    }
  }
}
