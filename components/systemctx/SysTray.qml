import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

import "root:/"

WrapperRectangle {
  RowLayout {
    id: root
    spacing: 6
    implicitWidth: 28 * repeater.count
    implicitHeight: Config.sizes.barHeight - 10
    anchors.centerIn: parent
    Repeater {
      id: repeater
      model: SystemTray.items
      property int count: SystemTray.items.values.length
      Layout.preferredHeight: root.implicitHeight
      Layout.preferredWidth: root.implicitWidth
      Rectangle {
        id: toprect
        //radius: 30
        required property SystemTrayItem modelData
        color: "transparent"
        Layout.preferredWidth: 36
        Layout.maximumWidth: 36
        Layout.preferredHeight: 36
        Layout.maximumHeight: 36
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        MouseArea {
          cursorShape: Qt.PointingHandCursor
          propagateComposedEvents: true
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          anchors.fill: parent
          IconImage {
            id: trayIcon
            source: toprect.modelData.icon
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
}
