import QtQuick

Rectangle {
  id: root

  default required property Item item

  property int size: 24

  required property color setActiveColor
  required property color setInactiveColor

  property bool coloredIcon

  property bool canInteract
  signal pressEvent
  property bool releaseEventNeeded
  signal releaseEvent

  property color currentColor: canInteract ? setActiveColor : setInactiveColor

  implicitWidth: size
  implicitHeight: size
  color: {
    if (coloredIcon) {
      return "transparent";
    }
    return currentColor;
  }

  MouseArea {
    id: buttonMouseArea
    hoverEnabled: true
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: root.canInteract ? Qt.PointingHandCursor : Qt.ForbiddenCursor
    onPressed: mouse => {
      if (root.canInteract) {
        root.pressEvent();
      }
    }
    onReleased: mouse => {
      if (root.releaseEventNeeded) {
        root.releaseEvent();
      }
    }
    onEntered: {
      if (root.canInteract) {
        root.currentColor = Qt.alpha(root.setActiveColor, 1);
      }
    }
    onExited: {
      if (root.canInteract) {
        root.currentColor = Qt.alpha(root.setActiveColor, 0.8);
      }
    }
  }
  children: [buttonMouseArea, item]
  Behavior on currentColor {
    ColorAnimation {
      duration: 200
    }
  }
}
