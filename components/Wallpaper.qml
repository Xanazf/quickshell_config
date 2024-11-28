import QtMultimedia
import Quickshell
import Quickshell.Wayland

PanelWindow {
  // When PanelWindow is backed with WlrLayershell this will work
  WlrLayershell.layer: WlrLayer.Background
  anchors {
    top: true
    left: true
    right: true
    bottom: true
  }
  exclusionMode: ExclusionMode.Ignore
  Video {
    id: name
    autoPlay: true
    loops: MediaPlayer.Infinite
    anchors.fill: parent
    fillMode: VideoOutput.Stretch
    source: "root:/wallpapers/pinksunwave.mp4"
  }
}
