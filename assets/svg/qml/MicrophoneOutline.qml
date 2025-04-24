// Generated from SVG file svg/media/microphone-outline.svg
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
        path: "M 17.3 11 C 17.3 14 14.76 16.1 12 16.1 C 9.24 16.1 6.7 14 6.7 11 L 5 11 C 5 14.41 7.72 17.23 11 17.72 L 11 21 L 13 21 L 13 17.72 C 16.28 17.23 19 14.41 19 11 M 10.8 4.9 C 10.8 4.24 11.34 3.7 12 3.7 C 12.66 3.7 13.2 4.24 13.2 4.9 L 13.19 11.1 C 13.19 11.76 12.66 12.3 12 12.3 C 11.34 12.3 10.8 11.76 10.8 11.1 M 12 14 C 13.6569 14 15 12.6569 15 11 L 15 5 C 15 3.34315 13.6569 2 12 2 C 10.3431 2 9 3.34315 9 5 L 9 11 C 9 12.6569 10.3431 14 12 14 "
      }
    }
  }
}
