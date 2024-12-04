import QtQuick
import Quickshell.Widgets

import "root:/"
import "../../systemctx/"

WrapperRectangle {
  id: root
  color: Qt.alpha(Config.colors.mainColor3, 0.1)
  radius: Config.sizes.mainRadius
  // onImplicitWidthChanged: {
  //   console.log("Wrapper", implicitWidth);
  // }
  SysTray {}
}
