// Generated from SVG file svg/ui/check.svg
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
        path: "M 21 7 L 9 19 L 3.5 13.5 L 4.91 12.09 L 9 16.17 L 19.59 5.59 L 21 7 "
      }
    }
  }
}
