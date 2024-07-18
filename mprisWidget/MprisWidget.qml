import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "root:/io"

Rectangle {
  id: root;
  anchors.centerIn: parent;

  // fallback for missing MprisPlayer on startup
  property QtObject fallbackPlayer: QtObject {
    property string trackAlbumArtist: ""
    property string trackArtists: ""
    property string trackTitle: ""
    property int playbackState: MprisPlaybackState.Stopped
  }
  property QtObject player: MprisIO.trackedPlayer ?? fallbackPlayer;

  // destructuring of the Player object
  property string artist: player.trackAlbumArtist || player.trackArtists
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
