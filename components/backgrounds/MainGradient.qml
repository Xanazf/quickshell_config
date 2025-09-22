import QtQuick
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

import qs.config

Rectangle {
  id: root
  width: parent.width
  height: parent.height

  layer {
    enabled: true
    effect: MultiEffect {
      anchors.fill: root
      source: root
      blurEnabled: true
      blur: 1.0
      blurMax: 32
      blurMultiplier: 1.0
      saturation: 1
    }
  }
  opacity: 1 - Config.opacityOffset

  gradient: Gradient {
    id: gradient1
    orientation: Gradient.Horizontal
    property real positionOffset

    GradientStop {
      position: 0.0 + gradient1.positionOffset
      color: Config.colors.mainColor1
    }
    GradientStop {
      position: 0.2 + gradient1.positionOffset
      color: Config.colors.mainColor2
    }
    GradientStop {
      position: 0.4 + gradient1.positionOffset
      color: Config.colors.mainColor3
    }
    GradientStop {
      position: 0.6 + gradient1.positionOffset
      color: Config.colors.mainColor4
    }
    GradientStop {
      position: 0.8 + gradient1.positionOffset
      color: Config.colors.mainColor6
    }
    GradientStop {
      position: 1.0 + gradient1.positionOffset
      color: Config.colors.mainColor4
    }
    GradientStop {
      position: 1.2 + gradient1.positionOffset
      color: Config.colors.mainColor3
    }
    GradientStop {
      position: 1.4 + gradient1.positionOffset
      color: Config.colors.mainColor2
    }
    GradientStop {
      position: 1.6 + gradient1.positionOffset
      color: Config.colors.mainColor1
    }
    NumberAnimation on positionOffset {
      id: numanim
      running: !Config.powerSaving
      loops: Animation.Infinite
      duration: 30000
      from: -2.0
      to: 1.0
    }
  }
}
