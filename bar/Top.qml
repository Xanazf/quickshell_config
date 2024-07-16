import QtQuick
import QtQuick.Layouts
import Quickshell
import "root:/widget"
import "root:/component"


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
      color: "transparent"

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
          color: "transparent"
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
          color: "transparent"
          AudioWidget {}
        }
        // -- Memory
        BarItem {
          color: "transparent"
          MemoryWidget {}
        }
        // -- Clock
        BarItem {
          color: "#f9f9fa"
          radius: 30
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
          color: "transparent"
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
          color: "transparent"
          radius: 30
          HyprlandWindow {}
        }
      }
    }
  }
}
