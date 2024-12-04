//@ pragma UseQApplication
import QtQuick
import Quickshell

import "../svg/qml/"

ShellRoot {
  id: root

  ReloadPopup {}

  Scope {
    Variants {
      model: Quickshell.screens

      // Base
      PanelWindow {
        id: crasherParent
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
        height: 36
        width: screen.width
        margins {
          top: 6
          right: 6
          left: 6
        }

        // Styling
        color: "transparent"
        Rectangle {
          id: crasher
          width: 24
          implicitHeight: 30
          anchors.centerIn: parent
          color: "transparent"
          property bool showPopup: false
          property bool hovering: false
          property bool targetVisible: false
          property real relX: {
            if (root.QsWindow.window) {
              const huehue = root.QsWindow.window.contentItem.mapFromItem(root, 0, 0).x;
              console.log(huehue);
              return huehue;
            }
            return 0;
          }

          MouseArea {
            id: mouseArea1
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
              rootIcon.currentColor = "#FF0044";
              crasher.hovering = true;
            }
            onExited: {
              rootIcon.currentColor = "#C80E65";
              crasher.hovering = false;
            }
            onClicked: {
              crasher.showPopup = !crasher.showPopup;
            }
            ArchIcon {
              id: rootIcon
              anchors.centerIn: parent
              currentColor: "#C80E65"
              Behavior on currentColor {
                ColorAnimation {
                  duration: 300
                }
              }
            }
          }
        }
      }
    }
  }
}
