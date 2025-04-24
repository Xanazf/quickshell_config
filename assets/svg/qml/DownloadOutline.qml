// Generated from SVG file svg/ui/download-outline.svg
import QtQuick
import QtQuick.Shapes

Item {
  id: root
  required property string currentColor
  implicitWidth: 24
  implicitHeight: 24
  transform: [
    Scale {
      xScale: width / 24
      yScale: height / 24
    }
  ]
  Shape {
    preferredRendererType: Shape.CurveRenderer
    ShapePath {
      strokeColor: "transparent"
      fillColor: root.currentColor
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 13 5 L 13 11 L 14.17 11 L 12 13.17 L 9.83 11 L 11 11 L 11 5 L 13 5 M 15 3 L 9 3 L 9 9 L 5 9 L 12 16 L 19 9 L 15 9 L 15 3 M 19 18 L 5 18 L 5 20 L 19 20 L 19 18 "
      }
    }
  }
}
