import QtQuick
import QtQuick.Shapes

Item {
  id: root
  anchors.fill: parent

  Shape {
    id: tint
    anchors.fill: parent
    width: parent.width
    height: parent.height
    ShapePath {
      fillGradient: RadialGradient {
        centerY: tint.y / 2
        centerX: tint.x / 2
        centerRadius: 100
        focalY: centerY
        focalX: centerX
        GradientStop {
          position: 0
          color: "transparent"
        }
        GradientStop {
          position: 1
          color: "#000000"
        }
      }
    }
  }
}
