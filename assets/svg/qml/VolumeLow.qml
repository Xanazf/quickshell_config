// Generated from SVG file svg/media/volume-low.svg
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
        path: "M 7 9 L 7 15 L 11 15 L 16 20 L 16 4 L 11 9 L 7 9 "
      }
    }
  }
}
