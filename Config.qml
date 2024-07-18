// Central config file
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire


Singleton {
  id: root;

  // username
  property string name: "xnzf";

  // user terminal (kitty), user shell (fish)
	property string terminal: Quickshell.env("TERM") ?? "gnome-terminal"
	property string shell: Quickshell.env("SHELL") ?? "bash"

  // for animations
	property int frameRate: 60

  // Pipewire binding
	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
	}

  // default font
	property font font: Qt.font({
		family: "Rubik"
	})

  // universal sizes
  property QtObject sizes: QtObject {
    property int barHeight: 30;
    property int barMargin: 6;
  }

  property QtObject colors: QtObject {
    property string bar: "transparent";
  }





  Component.onCompleted: () => {
    console.log("Hello, " + root.name + "!");
  }
}
