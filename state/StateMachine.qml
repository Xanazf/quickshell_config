// State Machine
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

import "../"
import "../helpers/io/"
import "../helpers/theme/"

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
  property string distro
  property string lang: Quickshell.env("LANG") ?? "en_GB.UTF-8"
  // --

  // GLOBAL SETTINGS

  property bool powerSaving: Config.powerSaving ?? true
  property bool drawerOpen: false
  property font font: Config.font ?? Qt.font({
    family: "Rubik"
  })

  // TODO:
  //  property string theme: "dark"
  //  property string mainBarAnchor: "top"
  // --

  // for animations
  property int frameRate: 60

  // --

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

    // generated
    // default:
    // emphasis3: #0937c0
    // tint: #7c0e74
    property color emphasis3: {
      let result = ColorManipulator.findTriadicColor(emphasis1, emphasis2);
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
      property color background: Qt.darker(colors_root.emphasis3, 2.1)
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

  // Pipewire binding
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
  }
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
  Component.onCompleted: () => {
    Logger.log("Hello, " + root.username + "!");
  }
}
