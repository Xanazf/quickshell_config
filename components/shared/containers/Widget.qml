import QtQuick
import Quickshell

Item {
  id: root

  required property bool isMenu
  property Item target: null
  required property Item owner
  required property QsWindow bar
  required property PopupWindow popupLayer
  required property bool targetVisible
  required property real scaleMul
  property real hangTime: 6

  readonly property var targetWidth: target?.implicitWidth ?? 0
  readonly property var targetHeight: 500 // target?.implicitHeight ?? 500

  property var largestAnimHeight: 0
  property var highestAnimX: bar.height
  property var lowestAnimX: 0 // unused due to reposition timing issues

  //onTargetHeightChanged: {
  //  if (targetHeight > largestAnimHeight) {
  //    largestAnimHeight = targetHeight;
  //  }
  //}

  transform: Scale {
    origin.x: 0
    origin.y: root.height / 2
    xScale: 0.9 + (root.scaleMul / 10000)
    yScale: xScale
  }

  clip: width != targetWidth || height != targetHeight

  onTargetXChanged: updateXBounds()
  onTargetWidthChanged: updateXBounds()
  function updateXBounds() {
    if (targetX - targetWidth / 2 < highestAnimX)
    //highestAnimY = targetY - targetHeight / 2
    {}

    if (targetX + targetWidth / 2 > lowestAnimX)
    //lowestAnimY = targetY + targetHeight / 2
    {}
  }

  readonly property real targetX: {
    if (!targetVisible)
      return 0;
    const target = bar.contentItem.mapFromItem(target.owner, 0, target.targetRelativeX).X;
    return bar.boundedX(target, target.implicitWidth / 2);
  }

  property var h: -1
  height: Math.max(1, h)

  property var x1: -1
  property var x2: -1

  x: x1 - popupLayer.anchor.rect.x
  width: x2 - x1

  readonly property bool anyAnimsRunning: x1Anim.running || x2Anim.running || heightAnim.running

  onAnyAnimsRunningChanged: {
    if (!anyAnimsRunning) {
      largestAnimHeight = targetHeight;
      //highestAnimY = y1;
      //lowestAnimY = y2;
    }
  }

  SmoothedAnimation {
    id: x1Anim
    target: widget
    property: "x1"
    to: widget.targetX - widget.targetWidth / 2
    onToChanged: {
      if (widget.x1 == -1 || !(target?.animateSize ?? true)) {
        stop();
        widget.x1 = to;
      } else {
        velocity = (Math.max(widget.x1, to) - Math.min(widget.x1, to)) * 5;
        restart();
      }
    }
  }

  SmoothedAnimation {
    id: x2Anim
    target: widget
    property: "x2"
    to: widget.targetX + widget.targetWidth / 2
    onToChanged: {
      if (widget.x2 == -1 || !(target?.animateSize ?? true)) {
        stop();
        widget.x2 = to;
      } else {
        velocity = (Math.max(widget.x2, to) - Math.min(widget.x2, to)) * 5;
        restart();
      }
    }
  }

  SmoothedAnimation {
    id: heightAnim
    target: widget
    property: "h"
    to: widget.targetWidth
    onToChanged: {
      if (widget.h == -1) {
        stop();
        widget.h = to;
      } else {
        velocity = (Math.max(widget.height, to) - Math.min(widget.height, to)) * 5;
        restart();
      }
    }
  }
}
