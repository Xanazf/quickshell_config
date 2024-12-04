import QtQuick
import QtQuick.VectorImage
import Quickshell.Widgets

import "root:/"
import "root:/svg/qml"

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
      id: powerSaveButton
      width: 54
      height: 54
      color: Qt.alpha(Config.colors.fontcolor, 0.1)
      radius: Config.sizes.mainRadius
      border.width: 1
      border.color: Qt.alpha(Config.colors.fontcolor, 0.2)
      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
          powerSaveButton.color = Qt.alpha(Config.colors.fontcolor, 0.2);
        }
        onExited: {
          powerSaveButton.color = Qt.alpha(Config.colors.fontcolor, 0.1);
        }
        onClicked: {
          Config.powerSaving = !Config.powerSaving;
        }
        RadioactiveCircleOutline {
          implicitWidth: 36
          implicitHeight: 36
          anchors.centerIn: parent
          currentColor: {
            if (Config.powerSaving) {
              return Config.colors.red800;
            }
            return Config.colors.green800;
          }
        }
      }
      Behavior on color {
        ColorAnimation {
          duration: 200
        }
      }
    }
    ClippingRectangle {
      id: lockButton
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
      id: settingsButton
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
      id: multimediaModeButton
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
