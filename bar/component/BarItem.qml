import QtQuick
import Quickshell
import "root:/"

Rectangle {
  id: root;
  required default property Item item;
  color: Config.colors.bar

  implicitWidth: item.width
  //implicitHeight: item.implicitHeight
  height: 30
  children: [item]
}
