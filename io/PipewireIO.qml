pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

Singleton {
  id: root;

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink, Pipewire.defaultAudioSource ]
  }

  property PwNode activeSink: Pipewire.defaultAudioSink;
  property PwNode activeSource: Pipewire.defaultAudioSource;

	property real volume: activeSink?.audio?.volume ?? 0;
	property real micVolume: activeSource?.audio?.volume ?? 0;

	property bool muted: activeSink?.audio?.muted ?? false;
	property bool micMuted: activeSource?.audio?.muted ?? false;
}
