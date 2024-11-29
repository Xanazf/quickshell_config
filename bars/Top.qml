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
import "root:/components/menu"
import "root:/components/updatecheck"
import "root:/components/clipboard"

// Screen Factory
Scope {
  Variants {
    model: Quickshell.screens

    // Base
    PanelWindow {
      id: root
      property real tooltipYOffset: height + 3
      // Needed for screens
      property var modelData
      screen: modelData
      // function boundedX() {
      // }

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
      width: screen.width

      // Styling
      color: "transparent"
      BackgroundItem {}

      // Popups
      ClipboardPopup {
        window: root
        parentRect: clipboardItem
        show: clipboardRoot.showPopup
        items: clipboardRoot.cliphistdata
      }

      AppMenuPopup {
        id: appMenuPopup
        window: root
        parentRect: appmenuItem
        show: appmenuRoot.showPopup
        onSetShowChanged: {
          if (appMenuPopup.setShow !== appmenuRoot.showPopup) {
            appmenuRoot.showPopup = appMenuPopup.setShow;
          }
        }
      }
      // AnimatedPopup {
      //   id: animatedPopup
      //   bar: root
      // }
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
          DotDecoration {
            transparent: true
          }
        }
        // -- Menu
        BarItem {
          id: appmenuItem
          AppMenu {
            id: appmenuRoot
          }
        }
        BarItem {
          DotDecoration {}
        }

        // -- Update
        BarItem {
          UpdateComponent {}
        }
        BarItem {
          DotDecoration {}
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
          DotDecoration {}
        }
        // -- Audio
        BarItem {
          id: audio
          Audio {}
        }
        BarItem {
          DotDecoration {}
        }
        // -- Keyboard
        BarItem {
          KbLayout {}
        }
        BarItem {
          DotDecoration {}
        }
        // -- Clock
        BarItem {
          Clock {}
        }
        BarItem {
          DotDecoration {}
        }
        // -- System Menu
        BarItem {
          SysMenu {}
        }
        BarItem {
          DotDecoration {
            transparent: true
          }
        }
      }
    }
  }
}
