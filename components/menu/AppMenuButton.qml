import QtQuick
import Quickshell.Widgets

import "./appmenugrid/"
import "root:/state"
import "root:/helpers/io"
import "root:/components/shared/containers/"
import "root:/assets/svg/qml"

ClippingRectangle {
  id: root
  width: 24
  implicitHeight: 30
  anchors.centerIn: parent
  color: "transparent"
  property bool hovering: false
  property Widget target: AppMenuWrapper {}
  property bool targetVisible: false

  MouseArea {
    id: mouseArea1
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onEntered: {
      rootIcon.currentColor = StateMachine.colors.emphasis2;
      root.hovering = true;
    }
    onExited: {
      rootIcon.currentColor = StateMachine.colors.emphasis3;
      root.hovering = false;
    }
    onClicked: {
      StateMachine.drawerOpen = !StateMachine.drawerOpen;
    }
    ArchIcon {
      id: rootIcon
      anchors.centerIn: parent
      currentColor: StateMachine.colors.emphasis3
      Behavior on currentColor {
        ColorAnimation {
          duration: 300
        }
      }
    }
  }
}
