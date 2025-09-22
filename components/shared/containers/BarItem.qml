import QtQuick
import Quickshell.Widgets

import qs.config

Rectangle {
  id: root
  default required property Item item
  color: "transparent"

  implicitWidth: item.width
  implicitHeight: 39
  children: [item]
}
