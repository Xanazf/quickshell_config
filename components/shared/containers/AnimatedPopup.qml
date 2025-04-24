import QtQuick
import Quickshell
import Quickshell.Hyprland

Scope {
  id: root
  required property var bar

  property Item activeTooltip: null
  property Item activeMenu: null

  readonly property Item activeItem: activeMenu ?? activeTooltip
  property Item lastActiveItem: null
  readonly property Item shownItem: activeItem ?? lastActiveItem
  property real hangTime: lastActiveItem?.hangTime ?? 0

  property Item tooltipItem: null

  onActiveItemChanged: {
    if (activeItem !== null) {
      hangTimer.stop();
      activeItem.targetVisible = true;

      if (tooltipItem) {
        activeItem.parent = tooltipItem;
      }
    }

    if (lastActiveItem !== null && lastActiveItem !== activeItem) {
      if (activeItem !== null)
        lastActiveItem.targetVisible = false;
      else if (root.hangTime == 0)
        doLastHide();
      else
        hangTimer.start();
    }

    if (activeItem != null)
      lastActiveItem = activeItem;
  }

  function setItem(item: Item) {
    if (item.isMenu) {
      activeMenu = item;
    } else {
      activeTooltip = item;
    }
  }

  function removeItem(item: Item) {
    if (item.isMenu && activeMenu === item) {
      activeMenu = null;
    } else if (!item.isMenu && activeTooltip === item) {
      activeTooltip = null;
    }
  }

  function doLastHide() {
    lastActiveItem.targetVisible = false;
  }

  function onHidden(item: Item) {
    if (item === lastActiveItem) {
      lastActiveItem = null;
    }
  }

  Timer {
    id: hangTimer
    interval: root.hangTime
    onTriggered: doLastHide()
  }

  property real scaleMul: lastActiveItem && lastActiveItem.targetVisible ? 1000 : 0
  Behavior on scaleMul {
    SmoothedAnimation {
      velocity: 5000
    }
  }

  LazyLoader {
    id: popupLoader
    activeAsync: shownItem !== null

    PopupWindow {
      id: popup

      anchor {
        window: bar

        rect.x: tooltipItem.lowestAnimX
        rect.y: bar.tooltipYOffset

        adjustment: PopupAdjustment.None
      }

      height: Math.max(700, tooltipItem.height) // max due to qtwayland glitches
      width: {
        const w = tooltipItem.width;
        //console.log(`seth ${h} ${tooltipItem.highestAnimY} ${tooltipItem.lowestAnimY}; ${tooltipItem.y1} ${tooltipItem.y2}`)
        console.log(w);
        return w;
      }

      visible: true
      //color: "transparent"
      color: "#20000000"

      mask: Region {
        item: (shownItem?.hoverable ?? false) ? tooltipItem : null
      }

      HyprlandFocusGrab {
        active: activeItem?.isMenu ?? false
        windows: [popup, bar, ...(activeItem?.grabWindows ?? [])]
        onActiveChanged: {
          if (!active && activeItem?.isMenu) {
            activeMenu.close();
          }
        }
      }

      Item {
        id: tooltipItem
        Component.onCompleted: {
          root.tooltipItem = this;
          if (root.shownItem) {
            root.shownItem.parent = this;
          }
        }

        transform: Scale {
          origin.x: 0
          origin.y: tooltipItem.height / 2
          xScale: 0.9 + (scaleMul / 10000)
          yScale: xScale
        }

        clip: width != targetWidth || height != targetHeight

        readonly property var targetWidth: shownItem?.implicitWidth ?? 0
        readonly property var targetHeight: shownItem?.implicitHeight ?? 0

        property var largestAnimWidth: 0
        property var highestAnimX: 0 // unused due to reposition timing issues
        property var lowestAnimX: bar.height

        onTargetWidthChanged: {
          if (targetWidth > largestAnimWidth) {
            largestAnimWidth = targetWidth;
          }
        }

        readonly property real targetX: {
          if (shownItem == null)
            return 0;
          const target = bar.contentItem.mapFromItem(shownItem.owner, 0, shownItem.targetRelativeX).x;
          return bar.boundedX(target, shownItem.implicitWidth / 2);
        }

        property var h: -1
        height: Math.max(1, h)

        property var x1: -1
        property var x2: -1

        x: x1 - popup.anchor.rect.x
        width: x2 - x1

        readonly property bool anyAnimsRunning: x1Anim.running || x2Anim.running || heightAnim.running

        onAnyAnimsRunningChanged: {
          if (!anyAnimsRunning) {
            largestAnimWidth = targetWidth;
          }
        }

        SmoothedAnimation {
          id: x1Anim
          target: tooltipItem
          property: "x1"
          to: tooltipItem.targetX - tooltipItem.targetHeight / 2
          onToChanged: {
            if (tooltipItem.y1 == -1 || !(shownItem?.animateSize ?? true)) {
              stop();
              tooltipItem.y1 = to;
            } else {
              velocity = (Math.max(tooltipItem.y1, to) - Math.min(tooltipItem.y1, to)) * 5;
              restart();
            }
          }
        }

        SmoothedAnimation {
          id: x2Anim
          target: tooltipItem
          property: "x2"
          to: tooltipItem.targetX + tooltipItem.targetHeight / 2
          onToChanged: {
            if (tooltipItem.x2 == -1 || !(shownItem?.animateSize ?? true)) {
              stop();
              tooltipItem.x2 = to;
            } else {
              velocity = (Math.max(tooltipItem.x2, to) - Math.min(tooltipItem.x2, to)) * 5;
              restart();
            }
          }
        }

        SmoothedAnimation {
          id: heightAnim
          target: tooltipItem
          property: "h"
          to: tooltipItem.targetHeight
          onToChanged: {
            if (tooltipItem.h == -1) {
              stop();
              tooltipItem.h = to;
            } else {
              velocity = (Math.max(tooltipItem.height, to) - Math.min(tooltipItem.height, to)) * 5;
              restart();
            }
          }
        }
      }
    }
  }
}
