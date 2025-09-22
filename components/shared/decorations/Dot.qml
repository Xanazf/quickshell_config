import QtQuick

import qs.config

Rectangle {
  id: root
  default property bool transparent
  property int spacing
  implicitWidth: spacing ? spacing : 12
  anchors.fill: parent
  color: "transparent"
  Rectangle {
    id: dot
    implicitWidth: 6
    implicitHeight: 6
    anchors.centerIn: parent
    radius: 30
    color: root.transparent ? "transparent" : Qt.alpha(Config.colors.navy500, 0.5)
  }
}
