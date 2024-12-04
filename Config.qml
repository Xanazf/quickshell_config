// Central config file
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
  id: root
  property string username: "xnzf"
  property string distro: "Arch Linux (btw)"

  property bool powerSaving: false

  property QtObject colors: QtObject {
    // surface colors
    property string neutral: "#010C1D"
    property string fontcolor: "#E2ECFE"

    // main colors
    property string mainColor0: "#111160"
    property string mainColor1: "#0F0679"
    property string mainColor2: "#1911A6"
    property string mainColor3: "#8D1B82"
    property string mainColor4: "#C80E65"
    property string mainColor5: "#FF0044"
    property string mainColor6: "#DB0037"

    // ui colors
    // -- danger
    property string red900: "#DD0039"
    property string red800: "#FF0042"
    property string red700: "#FF225B"
    property string red600: "#FF4575"
    property string red500: "#FF668D"

    // -- warning
    property string yellow900: "#FFA500"
    property string yellow800: "#EBC600"
    property string yellow700: "#FFD700"
    property string yellow600: "#FFEB3B"
    property string yellow500: "#FFEC88"

    // -- info
    property string navy900: "#0C00DD"
    property string navy800: "#2E22FF"
    property string navy700: "#4E44FF"
    property string navy600: "#6E66FF"
    property string navy500: "#8E88FF"

    // --success
    property string green900: "#007742"
    property string green800: "#00BB67"
    property string green700: "#00FF8D"
    property string green600: "#44FFAB"
    property string green500: "#88FFCA"
  }

  property real opacityOffset: 0.84

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
