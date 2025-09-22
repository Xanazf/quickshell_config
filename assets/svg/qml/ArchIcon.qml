// Generated from SVG file svg/arch.svg
import QtQuick
import QtQuick.Shapes

Item {
  id: root
  required property string currentColor
  implicitWidth: 24
  implicitHeight: 24
  transform: [
    Scale {
      xScale: root.width / 24
      yScale: root.height / 24
    }
  ]
  Shape {
    preferredRendererType: Shape.CurveRenderer
    ShapePath {
      strokeColor: "transparent"
      fillColor: root.currentColor
      fillRule: ShapePath.PathSolid
      PathSvg {
        path: "M 12 2 C 11.11 4.18 10.57 5.61 9.58 7.73 C 10.19 8.37 10.93 9.12 12.14 9.97 C 10.84 9.43 9.95 8.9 9.29 8.34 C 8 11 6.03 14.75 2 22 C 5.17 20.17 7.63 19.04 9.92 18.61 C 9.82 18.19 9.76 17.73 9.77 17.25 L 9.77 17.15 C 9.82 15.12 10.88 13.56 12.13 13.67 C 13.38 13.77 14.35 15.5 14.3 17.54 C 14.29 17.92 14.25 18.29 14.18 18.63 C 16.44 19.07 18.87 20.19 22 22 C 21.38 20.86 20.83 19.84 20.31 18.87 C 19.5 18.23 18.61 17.39 16.85 16.5 C 18.06 16.8 18.93 17.16 19.61 17.57 C 14.26 7.62 13.83 6.3 12 2 "
      }
    }
  }
}
