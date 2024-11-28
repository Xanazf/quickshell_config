// Generated from SVG file svg/ui/clipboard-text-outline.svg
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
    preferredRendererType: Shape.GeometryRenderer
    ShapePath {
      strokeColor: "transparent"
      fillColor: root.currentColor
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 19 3 L 14.82 3 C 14.25 1.44 12.53 0.64 11 1.2 C 10.14 1.5 9.5 2.16 9.18 3 L 5 3 C 3.89543 3 3 3.89543 3 5 L 3 19 C 3 20.1046 3.89543 21 5 21 L 19 21 C 20.1046 21 21 20.1046 21 19 L 21 5 C 21 3.89543 20.1046 3 19 3 M 12 3 C 12.5523 3 13 3.44772 13 4 C 13 4.55228 12.5523 5 12 5 C 11.4477 5 11 4.55228 11 4 C 11 3.44772 11.4477 3 12 3 M 7 7 L 17 7 L 17 5 L 19 5 L 19 19 L 5 19 L 5 5 L 7 5 L 7 7 M 17 11 L 7 11 L 7 9 L 17 9 L 17 11 M 15 15 L 7 15 L 7 13 L 15 13 L 15 15 "
      }
    }
  }
}
