import QtQuick
import QtQuick.Layouts
import Quickshell
//import Quickshell.Wayland

import qs.state
import qs.config
import qs.helpers.io
import qs.components
import qs.components.backgrounds
import qs.components.shared.decorations
import qs.components.shared.containers
import qs.components.datetime
import qs.components.hyprland
import qs.components.media
import qs.components.menu
import qs.components.updatecheck
import qs.components.clipboard

// Screen Factory
Scope {
  Variants {
    model: Quickshell.screens

    // Base
    PanelWindow {
      id: root
      required property var modelData
      screen: modelData
      property bool barHorizontal: StateMachine.mainBarOrientation === 2 || StateMachine.mainBarOrientation === 0
      property bool hidden: StateMachine.modes.zen

      // Orientation
      anchors {
        top: StateMachine.mainBarOrientation === 2
        left: StateMachine.mainBarOrientation === 2 || StateMachine.mainBarOrientation === 0 || StateMachine.mainBarOrientation === 1
        right: StateMachine.mainBarOrientation === 2 || StateMachine.mainBarOrientation === 0 || StateMachine.mainBarOrientation === 3
        bottom: StateMachine.mainBarOrientation === 0
      }

      // Sizing
      height: barHorizontal ? StateMachine.sizes.bars.main.height : screen.height
      width: barHorizontal ? screen.width : StateMachine.sizes.bars.main.width

      margins {
        top: StateMachine.sizes.bars.main.margin
        right: StateMachine.sizes.bars.main.margin
        left: StateMachine.sizes.bars.main.margin
      }

      property real drawerOffset: barHorizontal ? height : width

      // Styling
      color: "transparent"
      BackgroundItem {}

      // Drawer
      Drawer {
        id: drawer
        bar: root
      }

      // --- CONTENT ---

      // Left Side
      RowLayout {
        id: leftLayoutRoot
        // Anchor to the left side
        anchors {
          left: parent.left
        }

        spacing: 9

        // Items
        BarItem {
          Dot {
            transparent: true
          }
        }
        // -- Menu
        BarItem {
          id: appmenuItem
          AppMenuButton {
            id: appmenuRoot
            qsWindow: root.window
            onHoveringChanged: {
              Logger.log(hovering ? "yes" : "no");
              if (hovering) {
                drawer.widgetOwner = appmenuRoot;
                drawer.setItem(appmenuRoot.target);
                appmenuRoot.targetVisible = true;
              }
            }
          }
          Rectangle {
            anchors.fill: parent
            color: "turquoise"
          }
        }
        BarItem {
          Dot {}
        }

        // -- Update
        BarItem {
          UpdateComponent {}
        }
        BarItem {
          Dot {}
        }
        // -- Window
        BarItem {
          MprisComponent {}
        }
      }

      // Center
      RowLayout {
        id: centerLayoutRoot
        // Anchor to the center
        anchors {
          centerIn: parent
        }

        // Workspaces
        BarItem {
          HyprlandWorkspaces {
            window: root
          }
        }
      }

      // Right Side
      RowLayout {
        id: rightLayoutRoot
        // Anchor to the right side
        anchors {
          right: parent.right
        }
        spacing: 9

        // Items
        // -- Clipboard
        BarItem {
          id: clipboardItem
          Clipboard {
            id: clipboardRoot
          }
        }
        // -- System Tray
        BarItem {
          Dot {}
        }
        // -- Audio
        BarItem {
          id: audio
          Audio {}
        }
        BarItem {
          Dot {}
        }
        // -- Keyboard
        BarItem {
          KbLayout {}
        }
        BarItem {
          Dot {}
        }
        // -- Clock
        BarItem {
          Clock {}
        }
        BarItem {
          Dot {}
        }
        // -- System Menu
        BarItem {
          SysMenu {}
        }
        BarItem {
          Dot {
            transparent: true
          }
        }
      }
    }
  }
}
