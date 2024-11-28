import QtQuick
import Quickshell
import Quickshell.Widgets

import "root:/"
import "../../systemctx/"

WrapperRectangle {
  id: root
  color: Qt.alpha(Config.colors.mainColor3, 0.1)
  radius: {
    return Config.sizes.mainRadius;
  }
  SysTray {}
}
