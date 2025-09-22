// State Machine
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

import qs.config
import qs.helpers.io
import qs.helpers.theme

Singleton {
  id: root

  // ENVIRONMENT
  property bool dev: Config.dev ?? false
  property string home: Quickshell.env("HOME") ?? "/home/"
  property string shell: Quickshell.env("SHELL") ?? "/bin/bash"
  property string displaymanager: Config.displaymanager || Quickshell.env("XDG_SESSION_DESKTOP") || Quickshell.env("DESKTOP_SESSION") || "hyprland"
  property string terminal: Config.terminal || Quickshell.env("TERM") || "gnome-terminal"
  property string username: Config.username || Quickshell.env("USER") || "broski"
  property string hostname: Config.hostname
  property string distro: ""
  property string lang: Quickshell.env("LANG") ?? "en_GB.UTF-8"
  property bool zen: false
  // --

  // GLOBAL SETTINGS

  property bool powerSaving: Config.powerSaving ?? true
  property bool drawerOpen: false
  property font font: Config.font ?? Qt.font({
    family: "Rubik"
  })
  property real mainBarOrientation: 2

  // TODO:
  //  property string theme: "dark"
  //  property string mainBarAnchor: "top"
  // --

  // for animations
  property int frameRate: 60

  // --

  // modes
  property QtObject modes: QtObject {
    id: modes_root
    property bool powerSaving: Config.powerSaving ?? true
    property bool zen: Config.zen ?? false
  }

  // COLORS
  // 60/30/10
  // 60 - emphasis2
  // 30 - emphasis1, text
  // 10 - emphasis3, visualizer
  property QtObject colors: QtObject {
    id: colors_root

    // Config integration
    property color emphasis1: Config.colors.main1 ?? "#C80E65"
    property color emphasis2: Config.colors.main2 ?? "#5F0AC7"
    property color visualizer: Config.colors.visualizerEffects ?? "#02F734" // "##04E02F"
    property color text: Config.colors.fontcolor ?? "#E2ECFE"
    property color neutral: Config.colors.neutral ?? "#010C1D"

    // ui colors
    // -- danger
    property color red900: "#DD0039"
    property color red800: "#FF0042"
    property color red700: "#FF225B"
    property color red600: "#FF4575"
    property color red500: "#FF668D"

    // -- warning
    property color yellow900: "#FFA500"
    property color yellow800: "#EBC600"
    property color yellow700: "#FFD700"
    property color yellow600: "#FFEB3B"
    property color yellow500: "#FFEC88"

    // -- info
    property color navy900: "#0C00DD"
    property color navy800: "#2E22FF"
    property color navy700: "#4E44FF"
    property color navy600: "#6E66FF"
    property color navy500: "#8E88FF"

    // --success
    property color green900: "#007742"
    property color green800: "#00BB67"
    property color green700: "#00FF8D"
    property color green600: "#44FFAB"

    // generated
    // default:
    // emphasis3: #0937c0
    // tint: #7c0e74
    property color emphasis3: {
      let result = ColorManipulator.findTriadicColor(colors_root.emphasis1, colors_root.emphasis2);
      return ColorManipulator.rgbToColor(result);
    }
    property color tint: Qt.tint(emphasis1, Qt.alpha(emphasis2, 0.5))

    property QtObject button: QtObject {
      id: colors_button

      // 60
      property color background: colors_root.emphasis2
      // 30
      property color content: Qt.darker(colors_root.emphasis3, 2.1)
      property color border: Qt.lighter(colors_root.emphasis1, 2.1)

      property QtObject inverted: QtObject {
        property color background: Qt.darker(colors_root.emphasis3, 3.3)
        property color content: colors_root.emphasis2
        property color border: Qt.darker(colors_root.emphasis1, 2.1)
      }
    }
    property QtObject container: QtObject {
      id: colors_container

      // 60
      property color background: Qt.alpha(Qt.darker(colors_root.emphasis3, 2.1), 0.3)
      // 30
      property color content: colors_root.emphasis2
      property color border: Qt.lighter(colors_root.emphasis1, 2.1)
    }
  }
  // --

  // NUMERIC VALUES (sizes, etc.)
  property QtObject sizes: QtObject {
    property int radius: 15
    property QtObject bars: QtObject {
      property QtObject main: QtObject {
        property int height: 39
        property int margin: 6
      }
    }
    property QtObject popups: QtObject {
      property int height: 240
      property int width: 300
      property QtObject drawer: QtObject {
        property QtObject margins: QtObject {
          property int all: root.sizes.bars.main.margin
          property int top: root.sizes.bars.main.height
        }
      }
    }
    property QtObject icons: QtObject {
      property int height: 24
      property int width: 24
    }
    property QtObject decorators: QtObject {
      property QtObject dots: QtObject {
        property int height: 6
        property int width: 6
      }
    }
  }
  // --

  // TODO:
  // property QtObject pinned: QtObject {}

  // distro getter
  Process {
    id: distrocheck
    running: true
    command: ["sh", "-c", "lsb_release -d"]
    stdout: SplitParser {
      onRead: data => {
        let distro = data.split(":")[1].trim();
        Logger.log(distro);
        if (distro === "Arch Linux") {
          root.distro = distro + " (btw)";
        } else {
          root.distro = distro;
        }
      }
    }
    onExited: status => {
      Logger.i_w(status, "DISTRO CHECK SUCCESS", "HOST CHECK FAILED");
      distrocheck.running = false;
    }
  }
  // Pipewire binding
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
  }
  // hostname getter
  Process {
    id: hostcheck
    running: true
    command: ["sh", "-c", "uname -n"]
    stdout: SplitParser {
      onRead: data => {
        root.hostname = data;
      }
    }
    onExited: status => {
      Logger.i_w(status, "HOST CHECK SUCCESS", "HOST CHECK FAILED");
      hostcheck.running = false;
    }
  }

  // saved state object
  property var stateobject

  // save current state to file
  onStateobjectChanged: {
    if (stateobject.username && statefile.text() !== JSON.stringify(stateobject)) {
      statefile.setText(JSON.stringify(stateobject, null, 2));
      statefile.reload();
      Logger.log("json");
    }
  }

  // state file io
  FileView {
    id: statefile
    path: Qt.resolvedUrl("./state.json")
    blockLoading: true
    onLoaded: {
      root.stateobject = JSON.parse(statefile.text());
    }
  }

  // on init
  Component.onCompleted: () => {
    Logger.log("Hello, " + root.username + "!");
  }
}
