import QtQuick
import QtQuick.Layouts
import Quickshell
import "./component/"
import "root:/"
import "root:/datetimeWidget"
import "root:/systemtrayWidget"
import "root:/audioWidget"
import "root:/systemstatsWidget"
import "root:/mprisWidget"
import "root:/hyprWidget"
import "root:/keyboardWidget"


// Screen Factory
Scope {
  Variants {
    model: Quickshell.screens

    // Base
    PanelWindow {
      // Needed for screens
      property var modelData
      screen: modelData
      id: root

      // Positioning
      anchors {
        top: true
        left: true
        right: true
      }

      // Sizing
      margins {
        top: 6
        right: 6
        left: 6
      }
      height: 30

      // Styling
      color: Config.colors.bar

      // Right Side
      RowLayout {
        // Anchor to the right side
        anchors {
          right: parent.right
        }
        spacing: 9;

        // Items
        // -- Clipboard
        // -- Language
        BarItem {
          KeyboardLayout {}
        }
        // -- System Tray
        BarItem {
          color: "#ee404b7c"
          radius: 30
          SystemTray {
            window: root
          }
        }
        // -- Audio
        BarItem {
          AudioWidget {}
        }
        // -- Memory
        BarItem {
          MemoryWidget {}
        }
        // -- Clock
        BarItem {
          Clock {}
        }
      }

      // Center
      RowLayout {
        // Anchor to the center
        anchors {
          centerIn: parent
        }

        // Items
        // -- Mpris
        BarItem {
          MprisWidget {}
        }
      }

      // Left Side
      RowLayout {
        // Anchor to the left side
        anchors { left: parent.left }

        // Items
        // -- Workspaces
        BarItem {
          color: "#91404b7c"
          radius: 30
          HyprlandWorkspaces {
            window: root
          }
        }

        // -- Current Window
        BarItem {
          radius: 30
          HyprlandWindow {}
        }
      }
    }
  }
}
