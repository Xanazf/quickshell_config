// Generated from SVG file svg/media/volume-medium.svg
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
        path: "M 5 9 L 5 15 L 9 15 L 14 20 L 14 4 L 9 9 M 18.5 12 C 18.5 10.23 17.5 8.71 16 7.97 L 16 16 C 17.5 15.29 18.5 13.76 18.5 12 "
      }
    }
  }
}
