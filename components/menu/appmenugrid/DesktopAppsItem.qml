import QtQuick
import Quickshell
import Quickshell.Widgets

import "root:/"
import "../../shared"
import "root:/io"

ClippingWrapperRectangle {
  id: root
  color: Qt.alpha(Config.colors.mainColor3, 0.1)
  radius: Config.sizes.mainRadius
  property ObjectModel appItems: DesktopIO.apps
  resizeChild: true
  margin: 10
  BorderSubtle {
    numOfBorders: 1
    orientVertical: true
    gradientColor1: Config.colors.mainColor2
    gradientColor2: Config.colors.mainColor2
  }
  child: GridView {
    id: desktopEntriesGrid
    width: parent.width
    height: parent.height
    model: root.appItems
    cellHeight: height / 3 + 3.33
    cellWidth: width / 4
    populate: Transition {
      NumberAnimation {
        properties: "x,y"
        duration: 300
      }
      NumberAnimation {
        property: "opacity"
        from: 0
        to: 1
        duration: 300
      }
    }
    displaced: Transition {
      NumberAnimation {
        properties: "x,y"
        duration: 300
      }
      NumberAnimation {
        property: "opacity"
        from: 1
        to: 0
        duration: 300
      }
    }
    move: Transition {
      NumberAnimation {
        properties: "x,y"
        duration: 1000
      }
    }
    delegate: Rectangle {
      id: modelRect
      required property QtObject modelData
      height: 40
      width: root.width / 4 - 10
      radius: Config.sizes.mainRadius
      color: Qt.alpha("white", 0.1)
      ClippingRectangle {
        id: icon
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: 40
        width: 40
        color: "transparent"
        IconImage {
          width: 30
          height: 30
          anchors.centerIn: parent

          source: Quickshell.iconPath(modelRect.modelData.icon, true) || "root:/svg/skull-outline.svg"
        }
      }
      Text {
        anchors.left: icon.right
        height: parent.height
        width: modelRect.width - 40
        elide: Text.ElideRight
        color: Config.colors.fontcolor
        verticalAlignment: Text.AlignVCenter
        text: modelRect.modelData.name
      }
      MouseArea {
        id: itemMouseArea
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onEntered: {
          modelRect.color = Qt.alpha("white", 0.2);
        }
        onExited: {
          modelRect.color = Qt.alpha("white", 0.1);
        }
        onClicked: mouse => {
          if (mouse.button === Qt.LeftButton) {
            modelRect.QsWindow.window.setShow = false;
            modelRect.modelData.execute();
          }
        }
      }
      Behavior on color {
        ColorAnimation {
          duration: 200
        }
      }
    }
  }
}
