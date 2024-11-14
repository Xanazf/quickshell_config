import QtQuick
import QtQuick.Layouts
import Quickshell

import "root:/"
import "root:/backgrounds"
import "root:/components/shared"
import "root:/components"
import "root:/components/datetime"
import "root:/components/hyprland"
import "root:/components/media"
import "root:/components/systemctx"

// Screen Factory
Scope {
  Variants {
    model: Quickshell.screens

    // Base
    PanelWindow {
      id: root
      // Needed for screens
      property var modelData
      screen: modelData

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
      height: Config.sizes.barHeight

      // Styling
      color: "transparent"
      BackgroundItem {}

      // Left Side
      RowLayout {
        // Anchor to the left side
        anchors {
          left: parent.left
        }

        // Items
        // -- Menu
        // -- Update
        // -- Window
        BarItem {
          radius: 30
          HyprlandWindow {}
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
          id: mpris
          MprisComponent {}
        }
      }

      // Right Side
      RowLayout {
        // Anchor to the right side
        anchors {
          right: parent.right
        }
        spacing: 9

        // Items
        // -- Clipboard
        BarItem {
          Clipboard {}
        }
        // -- Language
        BarItem {
          id: lang
          KbLayout {
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              propagateComposedEvents: true
              onEntered: {
                root.hoveredItem = lang;
                root.isHovered = true;
                //console.log(root.hoveredItem)
              }
              onExited: {
                root.isHovered = false;
                //root.hoveredItem = null;
                //console.log(root.hoveredItem)
              }
            }
          }
        }
        // -- System Tray
        BarItem {
          id: sysTray
          radius: 30
          SysTray {
            window: root
          }
        }
        // -- Audio
        BarItem {
          id: audio
          Audio {
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              propagateComposedEvents: true
              onEntered: {
                root.hoveredItem = audio;
                root.isHovered = true;
                //console.log(root.hoveredItem.x)
              }
              onExited: {
                root.isHovered = false;
                //root.hoveredItem = null;
                //console.log(root.hoveredItem)
              }
            }
          }
        }
        // -- Memory
        BarItem {
          id: memory
          MemStat {
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              propagateComposedEvents: true
              onEntered: {
                root.hoveredItem = memory;
                root.isHovered = true;
                //console.log(root.hoveredItem)
              }
              onExited: {
                root.isHovered = false;
                //root.hoveredItem = null;
                //console.log(root.hoveredItem)
              }
            }
          }
        }
        // -- Clock
        BarItem {
          Clock {}
        }
      }
    }
  }
}
