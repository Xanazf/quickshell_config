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
        source: Config.powerSaving ? "" : "root:/assets/wallpapers/pinksunwave.mp4"
      }

      Image {
        id: imgBg
        visible: Config.powerSaving
        fillMode: Image.PreserveAspectFit
        mipmap: true
        autoTransform: false
        width: 1920
        height: 1080
        source: "root:/assets/wallpapers/forest.jpg"
      }
    }
  }
}
