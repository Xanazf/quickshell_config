// Central config file
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
  id: root

  property QtObject colors: QtObject {
    property string neutral: "#151515"
    property string fontcolor: "#f9f9fa"
    property string mainBG: "#404b7c"
    property string mainFG: "#95d3af"
    property string modularBG: "404b7c"
    property string modularFG: "95d3af"
    property string modularFG2: "f9f9fa"
    property string secondaryFG: "#404b7c"
    property string mainColor1: "#0F0679"
    property string mainColor2: "#1911A6"
    property string mainColor3: "#8D1B82"
    property string mainColor4: "#C80E65"
    property string mainColor5: "#FF0044"
    property string mainColor6: "#DB0037"
  }

  property real opacityOffset: 0.75

  // default font
  property font font: Qt.font({
    family: "Rubik"
  })

  // for animations
  property int frameRate: 60

  // username
  property string name: "xnzf"
  property string shell: Quickshell.env("SHELL") ?? "bash"

  // universal sizes
  property QtObject sizes: QtObject {
    property int barHeight: 39
    property int barMargin: 6
    property int mainRadius: 15
  }

  // user terminal (kitty), user shell (fish)
  property string terminal: Quickshell.env("TERM") ?? "gnome-terminal"

  Component.onCompleted: () => {
    console.log("Hello, " + root.name + "!");
  }

  // Pipewire binding
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
  }
}
