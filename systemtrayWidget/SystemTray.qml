import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import "root:/"

RowLayout {
  id: root;
  spacing: 3
  required property QSWindow window;
  width: 28 * repeater.count + 30;
  height: Config.sizes.barHeight;
  anchors.centerIn: parent
  Repeater {
    id: repeater;
    model: SystemTray.items
    property int count: SystemTray.items.values.length;
    height: parent.height
    width: parent.width
    Rectangle {
      radius: 30
      id: toprect;
      required property SystemTrayItem modelData;
      height: Config.sizes.barHeight
      color: "transparent"
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
      Layout.fillHeight: true
      MouseArea {
        propagateComposedEvents: true;
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        width: parent.width
        height: parent.height
        anchors.centerIn: parent;
        Image {
          source: modelData.icon
          height: 21
          width: 21
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
