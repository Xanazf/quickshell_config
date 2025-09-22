import QtQuick
import Quickshell
import Quickshell.Widgets

import "./appmenugrid/"
import qs.state
import qs.helpers.io
import qs.components.shared.containers
import qs.assets.svg.qml

ClippingRectangle {
  id: root
  width: 24
  implicitHeight: 30
  anchors.centerIn: parent
  color: "transparent"
  required property QsWindow qsWindow
  property bool targetVisible: false
  property bool hovering: false
  property Widget target: AppMenuWrapper {
    owner: root
    bar: root.window
    scaleMul: 1
    targetVisible: root.targetVisible
    popupLayer: root.parent.drawer
  }

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
