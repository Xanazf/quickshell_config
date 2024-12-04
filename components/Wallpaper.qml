import QtQuick
import QtQuick.Effects
import QtMultimedia
import Quickshell
import Quickshell.Wayland

import "root:/"

// Screen Factory
Scope {
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: root
      property var modelData
      screen: modelData
      width: screen.width
      height: screen.height

      // When PanelWindow is backed with WlrLayershell this will work
      WlrLayershell.layer: WlrLayer.Background
      anchors {
        top: true
        left: true
        right: true
        bottom: true
      }
      exclusionMode: ExclusionMode.Ignore

      color: "black"

      Video {
        id: videoBg
        visible: !Config.powerSaving
        anchors.fill: parent
        autoPlay: true
        loops: MediaPlayer.Infinite
        fillMode: VideoOutput.Stretch
        source: Config.powerSaving ? "" : "root:/wallpapers/pinksunwave.mp4"
      }

      Rectangle {
        id: imageBg
        visible: Config.powerSaving
        anchors.fill: parent
        color: Config.colors.yellow900
        layer {
          enabled: Config.powerSaving
          effect: MultiEffect {
            maskSpreadAtMin: 1.0
            maskThresholdMax: 0.5
            maskEnabled: Config.powerSaving
            maskInverted: true
            maskSource: Image {
              fillMode: Image.PreserveAspectFit
              mipmap: true
              autoTransform: false
              sourceSize.height: 200
              sourceSize.width: 200
              height: 200
              width: 200
              source: "root:/wallpapers/nuclear-hexagon-1.png"
            }
          }
        }
      }
    }
  }
}
