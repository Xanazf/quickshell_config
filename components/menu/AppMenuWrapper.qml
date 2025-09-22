import Quickshell
import Quickshell.Widgets
import QtQuick

import qs.state
import qs.helpers.io
import "../shared/containers/"
import "../shared/decorations/"
import "./appmenugrid"

Widget {
  id: wrap
  isMenu: false
  target: root

  BorderSubtle {
    gradientColor1: StateMachine.colors.emphasis1
    gradientColor2: StateMachine.colors.emphasis3
  }
  BorderSubtle {
    orientRight: true
    gradientColor1: StateMachine.colors.emphasis1
    gradientColor2: StateMachine.colors.emphasis3
  }
  WrapperRectangle {
    id: root
    // props
    //property bool targetVisible: false
    //property Item owner: root.parentRect
    //property real targetRelativeX: root.window.contentItem.mapFromItem(root, 0, 0).x

    // sizing
    anchors.fill: parent

    // styling
    clip: true
    opacity: root.targetVisible ? 1 : 0
    color: Qt.alpha(StateMachine.colors.emphasis2, 0.1)
    //border.width: 1
    //border.color: Config.colors.mainColor3
    radius: StateMachine.sizes.radius
    scale: root.targetVisible ? 1 : 0.8

    child: AppMenuGrid {
      id: appmenugrid
    }
  }
}
