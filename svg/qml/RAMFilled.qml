// Generated from SVG file svg/hw/ram-solid.svg
import QtQuick
import QtQuick.Shapes

Item {
  id: root
  required property string currentColor
  implicitWidth: 36
  implicitHeight: 36
  transform: [
    Scale {
      xScale: width / 36
      yScale: height / 36
    }
  ]
  Shape {
    preferredRendererType: Shape.CurveRenderer
    ShapePath {
      strokeColor: "transparent"
      fillColor: root.currentColor
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 34 13 L 34 9 C 34 7.89543 33.1046 7 32 7 L 4 7 C 2.89543 7 2 7.89543 2 9 L 2 13 L 4 13 L 4 17 L 2 17 L 2 27 C 2 28.1046 2.89543 29 4 29 L 16.61 29 L 16.61 25.55 L 19 25.55 L 19 29 L 32 29 C 33.1046 29 34 28.1046 34 27 L 34 17 L 32 17 L 32 13 L 34 13 M 12 20 L 8 20 L 8 12 L 12 12 L 12 20 M 20 20 L 16 20 L 16 12 L 20 12 L 20 20 M 28 20 L 24 20 L 24 12 L 28 12 L 28 20 "
      }
    }
    ShapePath {
      strokeColor: "transparent"
      fillColor: "#00000000"
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 0 0 L 36 0 L 36 36 L 0 36 L 0 0 "
      }
    }
  }
}
