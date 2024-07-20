import QtQuick
import QtQuick.Layouts
import Quickshell
import "./component/"
import "root:/shared/component/"
import "root:/"
import "root:/datetimeWidget"
import "root:/systemtrayWidget"
import "root:/audioWidget"
import "root:/systemstatsWidget"
import "root:/mprisWidget"
import "root:/hyprWidget"
import "root:/keyboardWidget"
import "root:/clipboardWidget"


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

      // hover border
      property Item hoveredItem;
      property bool isHovered: false;

      HoverItem {
        id: hoverItem;
        hovered: isHovered;
        wX: root.contentItem.mapFromItem(hoveredItem, 0, 0).x;
        wWidth: hoveredItem?.width ?? 0;
      }


      // Right Side
      RowLayout {
        // Anchor to the right side
        anchors {
          right: parent.right
        }
        spacing: 9;

        // Items
        // -- Clipboard
        BarItem {
          Clipboard {}
        }
        // -- Language
        BarItem {
          id: lang;
          KeyboardLayout {
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true;
              propagateComposedEvents: true;
              onEntered: {
                root.hoveredItem = lang;
                root.isHovered = true
                //console.log(root.hoveredItem)
              }
              onExited: {
                root.isHovered = false
                //root.hoveredItem = null;
                //console.log(root.hoveredItem)
              }
            }
          }
        }
        // -- System Tray
        BarItem {
          id: sysTray;
          color: "#90" + Config.colors.modularBG
          radius: 30
          SystemTray {
            window: root
          }
        }
        // -- Audio
        BarItem {
          id: audio;
          AudioWidget {
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true;
              propagateComposedEvents: true;
              onEntered: {
                root.hoveredItem = audio;
                root.isHovered = true
                //console.log(root.hoveredItem.x)
              }
              onExited: {
                root.isHovered = false
                //root.hoveredItem = null;
                //console.log(root.hoveredItem)
              }
            }
          }
        }
        // -- Memory
        BarItem {
          id: memory;
          MemoryWidget {
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true;
              propagateComposedEvents: true;
              onEntered: {
                root.hoveredItem = memory;
                root.isHovered = true
                //console.log(root.hoveredItem)
              }
              onExited: {
                root.isHovered = false
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

      // Center
      RowLayout {
        // Anchor to the center
        anchors {
          centerIn: parent
        }

        // Items
        // -- Mpris
        BarItem {
          id: mpris;
          MprisWidget {
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true;
              propagateComposedEvents: true;
              onEntered: {
                root.hoveredItem = mpris;
                root.isHovered = true
                //console.log(root.hoveredItem)
              }
              onExited: {
                root.isHovered = false
                //root.hoveredItem = null;
                //console.log(root.hoveredItem)
              }
            }
          }
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
