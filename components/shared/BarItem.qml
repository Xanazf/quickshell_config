import QtQuick
import Quickshell

import "root:/"

Rectangle {
  id: root
  default required property Item item
  color: "transparent"

  implicitWidth: item.width
  implicitHeight: 39
  children: [item]
}
