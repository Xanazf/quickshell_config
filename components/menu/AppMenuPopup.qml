import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/"
import "root:/io"
import "../shared"
import "./appmenugrid"

Popup {
  id: root
  required property QsWindow window
  required property Item parentRect
  required property bool show
  property var childRect: rootrect
  setWindow: window
  setParentRect: parentRect
  setShow: show
  onShowChanged: {
    setShow = show;
  }
  setWidth: appmenugrid.implicitWidth + 24
  setHeight: appmenugrid.implicitHeight + 24
  BorderSubtle {
    gradientColor1: Config.colors.mainColor4
    gradientColor2: Config.colors.mainColor3
  }
  BorderSubtle {
    orientRight: true
    gradientColor1: Config.colors.mainColor4
    gradientColor2: Config.colors.mainColor3
  }
  WrapperRectangle {
    id: rootrect
    // props
    property bool targetVisible: false
    property Item owner: root.parentRect
    property real targetRelativeX: root.QsWindow.window.contentItem.mapFromItem(root, 0, 0).x

    // sizing
    anchors.fill: parent

    // styling
    clip: true
    opacity: root.show ? 1 : 0
    color: Qt.alpha(Config.colors.mainColor2, 0.1)
    //border.width: 1
    //border.color: Config.colors.mainColor3
    radius: Config.sizes.mainRadius
    scale: root.show ? 1 : 0.8
    Behavior on opacity {
      NumberAnimation {
        duration: 200
        easing.type: Easing.InOutQuad
      }
    }
    Behavior on scale {
      NumberAnimation {
        duration: 200
        easing.type: Easing.InOutQuad
      }
    }
    child: AppMenuGrid {
      id: appmenugrid
    }
  }
}
