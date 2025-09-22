pragma ComponentBehavior: Bound
import QtQuick
import QtMultimedia
import Quickshell
import Quickshell.Wayland

import qs.state

// Screen Factory
Scope {
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: root
      required property var modelData
      screen: modelData
      implicitWidth: screen.width
      implicitHeight: screen.height
      property bool isPortrait: screen.orientation === Qt.PortraitOrientation

      // When PanelWindow is backed with WlrLayershell this will work
      WlrLayershell.layer: WlrLayer.Background
      exclusionMode: ExclusionMode.Ignore
      anchors {
        top: true
        left: true
        right: true
        bottom: true
      }

      color: "black"

      Video {
        id: videoBg
        visible: !StateMachine.powerSaving && !root.isPortrait
        anchors.fill: parent
        autoPlay: true
        loops: MediaPlayer.Infinite
        fillMode: VideoOutput.Stretch
        source: StateMachine.powerSaving ? "" : "root:/assets/wallpapers/pinksunwave.mp4"
      }

      Image {
        id: imgBg
        visible: StateMachine.powerSaving || root.isPortrait
        fillMode: {
          if (root.isPortrait) {
            return Image.PreserveAspectCrop;
          }
          return Image.PreserveAspectFit;
        }
        mipmap: true
        autoTransform: false
        width: root.width
        height: root.height
        source: "root:/assets/wallpapers/forest.jpg"
      }
    }
  }
}
