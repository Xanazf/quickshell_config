pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
  id: root
  property MprisPlayer trackedPlayer: null

  // fallback for missing MprisPlayer on startup
  property QtObject fallbackPlayer: QtObject {
    // -- compliance to MPRIS
    property bool canRaise: false
    property bool canQuit: false
    property bool canPause: false
    property bool canSeek: false
    property bool canPlay: false
    property bool canTogglePlaying: false
    property bool canGoNext: false
    property bool canGoPrevious: false
    property bool canSetFullscreen: false
    property bool lengthSupported: false
    property bool shuffleSupported: false
    property bool positionSupported: false
    property bool volumeSupported: false
    property bool loopSupported: false
    property list<string> supportedUriSchemes: []
    property list<string> supportedMimeTypes: []

    // -- props
    property int uniqueId: 0
    property string identity: "null"
    property string trackArtUrl: ""
    property string trackAlbum: ""
    property string trackLink: ""
    property list<string> playerArr: []
    property string playerName: ""
    property string playerAttribute: ""
    property string trackAlbumArtist: "null"
    property string trackArtist: "null"
    property string trackTitle: ""
    property real position: 0
    property real length: 0

    // -- states
    property int playbackState: MprisPlaybackState.Paused
    property int loopState: MprisLoopState.None
    property bool fullscreen: false
  }

  Instantiator {
    model: Mpris.players
    Connections {
      required property MprisPlayer modelData
      target: modelData

      Component.onCompleted: {
        if (root.trackedPlayer === null || modelData.playbackState === MprisPlaybackState.Playing) {
          root.trackedPlayer = modelData;
        }
      }

      Component.onDestruction: {
        if (root.trackedPlayer === null || root.trackedPlayer.playbackState !== MprisPlaybackState.Playing) {
          for (const player of Mpris.players.values) {
            if (player.playbackState === MprisPlaybackState.Playing) {
              root.trackedPlayer = player;
              break;
            }
          }

          if (trackedPlayer === null && Mpris.players.values.length > 0) {
            trackedPlayer = Mpris.players.values[0];
          }
        }
        function onPlaybackStateChanged() {
          if (root.trackedPlayer !== modelData)
            root.trackedPlayer = modelData;
        }
      }
    }
  }
}
