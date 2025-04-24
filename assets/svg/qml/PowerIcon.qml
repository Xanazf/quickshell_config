// Generated from SVG file svg/ui/power.svg
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
        path: "M 16.56 5.44 L 15.11 6.89 C 16.84 7.94 18 9.83 18 12 C 18 15.3137 15.3137 18 12 18 C 8.68629 18 6 15.3137 6 12 C 6 9.83 7.16 7.94 8.88 6.88 L 7.44 5.44 C 5.36 6.88 4 9.28 4 12 C 4 16.4183 7.58172 20 12 20 C 16.4183 20 20 16.4183 20 12 C 20 9.28 18.64 6.88 16.56 5.44 M 13 3 L 11 3 L 11 13 L 13 13 "
      }
    }
  }
}
