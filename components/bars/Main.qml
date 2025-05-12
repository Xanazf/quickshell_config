import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "root:/"
import "root:/helpers/io/"
import "root:/state"
import "root:/components/backgrounds"
import "root:/components/shared/containers/"
import "root:/components/shared/decorations/"
import "root:/components"
import "root:/components/datetime"
import "root:/components/hyprland"
import "root:/components/media"
import "root:/components/systemctx"
import "root:/components/menu/"
import "root:/components/menu/appmenugrid/"
import "root:/components/updatecheck"
import "root:/components/clipboard"

// Screen Factory
Scope {
  Variants {
    model: Quickshell.screens

    // Base
    PanelWindow {
      id: root
      // props
      //focusable: appMenuPopup.visible
      WlrLayershell.keyboardFocus: StateMachine.drawerOpen ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

      // Needed for screens
      property var modelData
      screen: modelData

      // Orientation
      anchors {
        top: true
        left: true
        right: true
      }

      // Sizing
      height: StateMachine.sizes.bars.main.height
      width: screen.width
      margins {
        top: StateMachine.sizes.bars.main.margin
        right: StateMachine.sizes.bars.main.margin
        left: StateMachine.sizes.bars.main.margin
      }

      property real drawerYOffset: height

      // Styling
      color: "transparent"
      BackgroundItem {}

      // Popups
      Drawer {
        id: drawer
        bar: root
      }

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
            onHoveringChanged: {
              Logger.log(hovering ? "yes" : "no");
              if (hovering) {
                drawer.widgetOwner = appmenuRoot;
                appmenuRoot.target.owner = appmenuRoot;
                drawer.setItem(appmenuRoot.target);
              }
            }
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
