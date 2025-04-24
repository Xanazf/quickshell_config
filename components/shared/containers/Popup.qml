import Quickshell
import QtQuick

PopupWindow {
  id: root
  required property QsWindow setWindow
  required property Item setParentRect
  required property bool setShow
  property var coordinates: setShow && setWindow.contentItem.mapFromItem(setParentRect, 0, 0)
  property int setWidth: 500
  property int setHeight: 500
  anchor {
    window: root.setWindow
    rect {
      x: {
        //let coord = setWindow.contentItem.mapFromItem(setParentRect, 0, 0);
        //let coordX = setWindow.width + coord.x;
        if (root.coordinates) {
          let coordXstr = root.coordinates.x.toString();
          let coordX = coordXstr.startsWith("-") ? setWindow.width - Number(coordXstr.slice(1)) : Number(coordXstr);
          return coordX < setWidth ? coordX - 18 : coordX - width / 2;
        }
        return 0;
      }
      y: setWindow.height + 8
    }
  }
  width: setWidth
  height: setHeight
  color: "transparent"
  visible: setShow
}
