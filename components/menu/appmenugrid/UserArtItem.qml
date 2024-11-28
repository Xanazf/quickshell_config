import QtQuick
import Quickshell.Widgets

import "root:/"

ClippingRectangle {
  id: root
  color: Qt.alpha("black", 1)
  radius: Config.sizes.mainRadius
  Image {
    id: userAvatar
    cache: true
    sourceSize.width: 210
    sourceSize.height: 210
    width: parent.width
    height: parent.height
    anchors.centerIn: parent
    horizontalAlignment: Image.AlignHCenter
    verticalAlignment: Image.AlignVCenter
    fillMode: Image.PreserveAspectCrop
    source: "/home/xnzf/picture.png"
  }
}
