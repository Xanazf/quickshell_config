// Generated from SVG file svg/hw/ram-line.svg
import QtQuick
import QtQuick.Shapes

Item {
  id: root
  required property string currentColor
  implicitWidth: 36
  implicitHeight: 36
  transform: [
    Scale {
      xScale: width / 36
      yScale: height / 36
    }
  ]
  Shape {
    preferredRendererType: Shape.CurveRenderer
    ShapePath {
      strokeColor: "transparent"
      fillColor: root.currentColor
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 8 12 L 12 12 L 12 20 L 8 20 L 8 12 "
      }
    }
    ShapePath {
      strokeColor: "transparent"
      fillColor: Qt.lighter(root.currentColor, 1.25)
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 16 12 L 20 12 L 20 20 L 16 20 L 16 12 "
      }
    }
    ShapePath {
      strokeColor: "transparent"
      fillColor: Qt.lighter(root.currentColor, 1.25)
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 24 12 L 28 12 L 28 20 L 24 20 L 24 12 "
      }
    }
    ShapePath {
      strokeColor: "transparent"
      fillColor: Qt.lighter(root.currentColor, 1.25)
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 15 27 L 4 27 L 4 17 L 2 17 L 2 27 C 2 28.1046 2.89543 29 4 29 L 16.61 29 L 16.61 25.55 L 18.87 25.55 L 18.87 24 L 15 24 L 15 27 "
      }
    }
    ShapePath {
      strokeColor: "transparent"
      fillColor: Qt.lighter(root.currentColor, 1.25)
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 32 7 L 4 7 C 2.89543 7 2 7.89543 2 9 L 2 13 L 4 13 L 4 9 L 32 9 L 32 13 L 34 13 L 34 9 C 34 7.89543 33.1046 7 32 7 "
      }
    }
    ShapePath {
      strokeColor: "transparent"
      fillColor: Qt.lighter(root.currentColor, 1.25)
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 32 27 L 19 27 L 19 29 L 32 29 C 33.1046 29 34 28.1046 34 27 L 34 17 L 32 17 L 32 27 "
      }
    }
    ShapePath {
      strokeColor: "transparent"
      fillColor: "#00000000"
      fillRule: ShapePath.WindingFill
      PathSvg {
        path: "M 0 0 L 36 0 L 36 36 L 0 36 L 0 0 "
      }
    }
  }
}
