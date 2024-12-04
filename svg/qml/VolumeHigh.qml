// Generated from SVG file svg/media/volume-high.svg
import QtQuick
import QtQuick.Shapes

Item {
  id: root
  required property color currentColor
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
        path: "M 14 3.23 L 14 5.29 C 16.89 6.15 19 8.83 19 12 C 19 15.17 16.89 17.84 14 18.7 L 14 20.77 C 18 19.86 21 16.28 21 12 C 21 7.72 18 4.14 14 3.23 M 16.5 12 C 16.5 10.23 15.5 8.71 14 7.97 L 14 16 C 15.5 15.29 16.5 13.76 16.5 12 M 3 9 L 3 15 L 7 15 L 12 20 L 12 4 L 7 9 L 3 9 "
      }
    }
  }
}
