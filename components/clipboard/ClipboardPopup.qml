import Quickshell
import QtQuick
import Qt.labs.qmlmodels
import QtQml

import "root:/"
import "root:/io"
import "../shared"

Popup {
  id: root
  required property QsWindow window
  required property Item parentRect
  required property bool show
  setWindow: window
  setParentRect: parentRect
  setShow: show
  setWidth: 500
  setHeight: 500
  property list<var> items
  Rectangle {
    id: rootrect
    opacity: root.show ? 1 : 0
    clip: true
    anchors.fill: parent
    color: Qt.alpha("#000000", 0.3)
    radius: Config.sizes.mainRadius
    scale: root.show ? 1 : 0.8
    BorderSubtle {
      gradientColor1: Config.colors.mainColor4
      gradientColor2: Config.colors.yellow700
    }
    BorderSubtle {
      orientRight: true
      gradientColor1: Config.colors.mainColor4
      gradientColor2: Config.colors.yellow700
    }
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
    TableView {
      id: table
      clip: true
      anchors.centerIn: parent
      width: parent.width - 15
      height: parent.height - 15
      columnSpacing: 0
      resizableColumns: true
      columnWidthProvider: column => {
        if (column === 0) {
          return 60;
        }
        return width - 60;
      }
      rowSpacing: 1
      property list<var> clipboardEntries: {
        let map = root.items.map(item => item.split("	"));
        let obj = map.map(item => {
          //console.log(item[0]);
          //console.log(item[1]);
          return {
            entryId: item[0],
            entryData: item[1]
          };
        });
        return obj;
      }
      model: TableModel {
        TableModelColumn {
          display: "entryId"
        }
        TableModelColumn {
          display: "entryData"
        }
        rows: [...table.clipboardEntries]
      }
      delegate: Rectangle {
        clip: true
        required property string display
        required property bool current
        required property bool selected
        border.width: current ? 1 : 0
        implicitHeight: 30
        implicitWidth: table.width
        color: "transparent"
        Text {
          color: Config.colors.fontcolor
          text: parent.display
        }
        MouseArea {
          id: dataEntryMouseArea
          anchors.fill: parent
          hoverEnabled: true
          property var hoveredItem
          onEntered: {
            if (!isNaN(parent.display)) {
              console.log(parent.display);
              ClipboardIO.decodeId = parent.display;
              ClipboardIO.runningdecode = true;
            }
          }
          onExited: {
            ClipboardIO.decodeId = "";
            ClipboardIO.runningdecode = false;
          }
          Connections {
            enabled: true
            target: ClipboardIO
            function onDecoded(decoded) {
              dataEntryMouseArea.hoveredItem = decoded;
            }
          }
        }
      }
    }
  }
}
