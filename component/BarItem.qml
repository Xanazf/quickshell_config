import QtQuick
import Quickshell

Rectangle {
  required default property Item item;

  implicitWidth: item.width
  //implicitHeight: item.implicitHeight
  height: 30
  children: [item]
}
