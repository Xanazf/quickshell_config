import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

import "root:/"

Row {
  id: root
  spacing: 6
  padding: 6
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
  move: Transition {
    NumberAnimation {
      properties: "x,y"
      duration: 300
    }
  }
  // onImplicitWidthChanged: {
  //   console.log("Row", implicitWidth);
  // }
  Repeater {
    id: repeater
    model: SystemTray.items
    onItemAdded: {
      root.forceLayout();
    }
    onItemRemoved: {
      root.forceLayout();
    }
    Rectangle {
      id: toprect
      //radius: 30
      required property SystemTrayItem modelData
      color: "transparent"
      implicitWidth: 36
      implicitHeight: 36
      anchors.verticalCenter: parent.verticalCenter
      MouseArea {
        cursorShape: Qt.PointingHandCursor
        propagateComposedEvents: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        IconImage {
          id: trayIcon
          source: {
            if (toprect.modelData.title === "Steam") {
              return "root:/svg/apps/steam.svg";
            }
            return toprect.modelData.icon;
          }
          height: 28
          width: 28
          anchors.centerIn: parent
        }
        onClicked: mouse => {
          if (mouse.button == Qt.LeftButton) {
            toprect.modelData.activate();
          } else if (mouse.button == Qt.RightButton) {
            if (!menuOpener.anchor.window) {
              menuOpener.anchor.window = toprect.QsWindow.window;
            }
            if (menuOpener.visible) {
              menuOpener.close();
            } else {
              menuOpener.open();
            }
          }
        }
      }
      QsMenuAnchor {
        id: menuOpener
        menu: toprect.modelData.menu
        anchor {
          rect.x: 0
          rect.y: 0
          onAnchoring: {
            if (anchor.window) {
              let coords = anchor.window.contentItem.mapFromItem(toprect, 0, 0);
              anchor.rect.x = coords.x;
              anchor.rect.y = coords.y + 6;
            }
          }
          rect.width: trayIcon.width
          rect.height: trayIcon.height
          gravity: Edges.Bottom
          edges: Edges.Bottom
          adjustment: PopupAdjustment.SlideY
        }
      }
    }
  }
}
