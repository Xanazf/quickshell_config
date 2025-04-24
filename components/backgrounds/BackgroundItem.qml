import QtQuick
import Qt5Compat.GraphicalEffects

import "root:/"

Item {
  id: root
  anchors.fill: parent
  width: parent.width
  height: parent.height

  layer {
    enabled: true
    effect: OpacityMask {
      maskSource: Rectangle {
        width: root.width
        height: root.height
        radius: Config.sizes.mainRadius
      }
    }
  }
  Rectangle {
    id: mask
    anchors.fill: parent
    color: Config.colors.neutral
  }
  MainGradient {}
}
