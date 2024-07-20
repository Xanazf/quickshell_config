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
    property int barHeight: 28;
    property int barMargin: 6;
  }

  property QtObject colors: QtObject {
    property string bar: "transparent";
    property string mainBG: "#404b7c";
    property string mainFG: "#95d3af";
    property string secondaryBG: "#f9f9fa";
    property string secondaryFG: "#404b7c";
    property string modularBG: "404b7c";
    property string modularFG: "95d3af";
    property string modularFG2: "f9f9fa";
  }





  Component.onCompleted: () => {
    console.log("Hello, " + root.name + "!");
  }
}
