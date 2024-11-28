import QtQuick
import QtQuick.VectorImage
import Quickshell.Widgets

import "root:/"

Rectangle {
  id: root
  color: Qt.alpha(Config.colors.mainColor5, 0.1)
  radius: Config.sizes.mainRadius
  Grid {
    id: widgetGrid
    anchors.centerIn: parent
    columns: 2
    rows: 2
    columnSpacing: 25
    rowSpacing: 25
    padding: 15

    ClippingRectangle {
      width: 54
      height: 54
      color: Qt.alpha(Config.colors.fontcolor, 0.1)
      radius: Config.sizes.mainRadius
      border.width: 1
      border.color: Qt.alpha(Config.colors.fontcolor, 0.2)
      VectorImage {
        anchors.centerIn: parent
        width: 36
        height: 36
        preferredRendererType: VectorImage.CurveRenderer
        source: "root:/svg/radioactive-circle-outline.svg"
      }
    }
    ClippingRectangle {
      width: 54
      height: 54
      color: Qt.alpha(Config.colors.fontcolor, 0.1)
      radius: Config.sizes.mainRadius
      border.width: 1
      border.color: Qt.alpha(Config.colors.fontcolor, 0.2)
      VectorImage {
        anchors.centerIn: parent
        width: 36
        height: 36
        preferredRendererType: VectorImage.CurveRenderer
        source: "root:/svg/ui/lock-outline.svg"
      }
    }
    ClippingRectangle {
      width: 54
      height: 54
      color: Qt.alpha(Config.colors.fontcolor, 0.1)
      radius: Config.sizes.mainRadius
      border.width: 1
      border.color: Qt.alpha(Config.colors.fontcolor, 0.2)
      VectorImage {
        anchors.centerIn: parent
        width: 36
        height: 36
        preferredRendererType: VectorImage.CurveRenderer
        source: "root:/svg/ui/wrench-outline.svg"
      }
    }
    ClippingRectangle {
      width: 54
      height: 54
      color: Qt.alpha(Config.colors.fontcolor, 0.1)
      radius: Config.sizes.mainRadius
      border.width: 1
      border.color: Qt.alpha(Config.colors.fontcolor, 0.2)
      VectorImage {
        anchors.centerIn: parent
        width: 36
        height: 36
        preferredRendererType: VectorImage.CurveRenderer
        source: "root:/svg/media/theater.svg"
      }
    }
  }
}
