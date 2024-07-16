pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
  id: root;
  property MprisPlayer trackedPlayer: null;

  Instantiator {
    model: Mpris.players
    Connections {
      required property MprisPlayer modelData;
      target: modelData

      Component.onCompleted: {
        if (
          root.trackedPlayer == null || 
          modelData.playbackState === MprisPlaybackState.Playing
        ) {
          root.trackedPlayer = modelData
        }
      }

      Component.onDestruction: {
        if (
          root.trackedPlayer == null ||
          root.trackedPlayer.playbackState !== MprisPlaybackState.Playing
        ) {
          for (const player of Mpris.players.values) {
            if (player.playbackState === MprisPlaybackState.Playing) {
              root.trackedPlayer = player;
              break;
            }
          }

          if (trackedPlayer == null && Mpris.players.values.length > 0) {
            trackedPlayer = Mpris.players.values[0];
          }
        }
        function onPlaybackStateChanged() {
          if (root.trackedPlayer !== modelData) root.trackedPlayer = modelData
        }

      }
    }
  }
}
