import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "root:/io"

Rectangle {
  id: root;
  anchors.centerIn: parent
  property MprisPlayer player: MprisIO.trackedPlayer;
  property string artist: player.trackAlbumArtist || player.metadata["xesam:artist"]
  property string title: player.trackTitle
  property bool playing: player.playbackState === MprisPlaybackState.Playing
  property string playbackBG: playing ? "#00bbcc" : "#9a273453"
  property string playbackFG: playing ? "#273453" : "#adbcbc"
  color: playbackBG

  height: 30
  implicitWidth: text.width + 30
  radius: 15
  MouseArea {
    anchors.fill: parent
    anchors.centerIn: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    Text {
      id: text
      color: root.playbackFG
      elide: Text.ElideRight
      maximumLineCount: 20
      anchors.centerIn: parent
      width: 250
      horizontalAlignment: Text.AlignHCenter
      font {
        bold: true
        letterSpacing: 0
      }
      text: root.artist + " | " + root.title
    }
    onClicked: (mouse) => {
      if (root.playing) {
        root.player.pause()
      } else {
        root.player.play()
      }
    }
  }
}
