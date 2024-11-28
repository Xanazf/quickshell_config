import QtQuick
import QtQuick.Shapes

Shape {
  id: tint
  anchors.fill: parent
  width: parent.width
  height: parent.height
  ShapePath {
    fillGradient: RadialGradient {
      centerY: tint.height / 2
      centerX: tint.width / 2
      centerRadius: 100
      focalY: centerY
      focalX: centerX
      focalRadius: 0
      GradientStop {
        position: 0
        color: "#0000ff"
      }
      GradientStop {
        position: 1
        color: "#ff0000"
      }
    }
  }
}
