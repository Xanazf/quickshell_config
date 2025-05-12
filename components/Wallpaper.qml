import QtQuick
import QtQuick.Effects
import QtMultimedia
import Quickshell
import Quickshell.Wayland

import "root:/state/"

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
        visible: !StateMachine.powerSaving
        anchors.fill: parent
        autoPlay: true
        loops: MediaPlayer.Infinite
        fillMode: VideoOutput.Stretch
        source: StateMachine.powerSaving ? "" : "root:/assets/wallpapers/pinksunwave.mp4"
      }

      Image {
        id: imgBg
        visible: StateMachine.powerSaving
        fillMode: Image.PreserveAspectFit
        mipmap: true
        autoTransform: false
        width: 2560
        height: 1440
        source: "root:/assets/wallpapers/forest.jpg"
      }
    }
  }
}
