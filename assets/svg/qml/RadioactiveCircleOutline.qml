// Generated from SVG file svg/radioactive-circle-outline.svg
import QtQuick
import QtQuick.Shapes

Item {
  id: root
  implicitWidth: 24
  implicitHeight: 24
  required property color currentColor
  transform: [
    Scale {
      xScale: width / 24
      yScale: height / 24
    }
  ]
  objectName: "mdi-radioactive-circle-outline"
  Shape {
    preferredRendererType: Shape.CurveRenderer
    ShapePath {
      strokeColor: "transparent"
      fillColor: root.currentColor
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 12 4 C 16.4 4 20 7.6 20 12 C 20 16.4 16.4 20 12 20 C 7.6 20 4 16.4 4 12 C 4 7.6 7.6 4 12 4 M 12 2 C 6.5 2 2 6.5 2 12 C 2 17.5 6.5 22 12 22 C 17.5 22 22 17.5 22 12 C 22 6.5 17.5 2 12 2 M 15 17.2 L 13.2 14.2 C 12.8 14.4 12.4 14.5 12 14.5 C 11.6 14.5 11.1 14.4 10.8 14.2 C 10.3 15.1 9.6 16.2 9 17.2 C 9.9 17.7 10.9 18 12 18 C 13.1 18 14.1 17.7 15 17.2 M 15 6.8 L 13.2 9.8 C 13.9 10.2 14.5 11 14.5 12 L 18 12 C 18 9.8 16.8 7.8 15 6.8 M 12 13 C 12.6 13 13 12.6 13 12 C 13 11.4 12.6 11 12 11 C 11.4 11 11 11.4 11 12 C 11 12.6 11.4 13 12 13 M 6 12 L 9.5 12 C 9.5 11.1 10 10.3 10.8 9.8 C 10.3 8.9 9.6 7.8 9 6.8 C 7.2 7.8 6 9.8 6 12 "
      }
    }
  }
}
