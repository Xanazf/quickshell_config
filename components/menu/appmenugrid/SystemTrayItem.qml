import QtQuick
import Quickshell.Widgets

import qs.state
import qs.components.systemctx

WrapperRectangle {
  id: root
  color: Qt.alpha(StateMachine.colors.emphasis2, 0.1)
  radius: StateMachine.sizes.radius
  // onImplicitWidthChanged: {
  //   console.log("Wrapper", implicitWidth);
  // }
  SysTray {}
}
