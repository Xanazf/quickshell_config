import QtQuick
import Quickshell
import Quickshell.Hyprland

import "root:/helpers/io/"
import "root:/state"

// TODO:
// - start the bar from scratch, make sure to integrate the drawer properly
// - hyprland blur to visualise drawer:open
// - per screen pinned widgets

Scope {
  id: root
  required property QsWindow bar

  property Widget activeWidget: null // inside the drawer, pinnable
  property Widget activeMenu: null // dropdown menu of any items
  property Widget activeTooltip: null // tooltips of any items

  readonly property Widget activeItem: activeWidget ?? activeMenu
  property Widget lastActiveItem: null
  readonly property Widget shownItem: activeItem ?? lastActiveItem
  property real hangTime: lastActiveItem?.hangTime ?? 0

  property Widget widget: null
  property Item widgetOwner: null

  onActiveItemChanged: {
    if (activeItem !== null) {
      hangTimer.stop();
      activeItem.targetVisible = true;
      StateMachine.drawerOpen = true;

      if (activeTooltip !== null || activeMenu !== null) {
        activeItem.parent = widget;
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

  function setItem(item: Widget) {
    StateMachine.drawerOpen = true;
    if (item.isMenu) {
      activeMenu = item;
    } else {
      activeWidget = item;
    }
  }

  function removeItem(item: var) {
    StateMachine.drawerOpen = false;
    if (item.isMenu && activeMenu == item) {
      activeMenu = null;
    } else if (!item.isMenu && activeWidget == item) {
      activeWidget = null;
    }
  }

  function doLastHide() {
    lastActiveItem.targetVisible = false;
    StateMachine.drawerOpen = false;
  }

  function onHidden(item: var) {
    if (item == lastActiveItem) {
      lastActiveItem = null;
      StateMachine.drawerOpen = false;
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
    activeAsync: root.shownItem !== null

    PopupWindow {
      id: popup
      anchor {
        window: bar
        rect.y: bar.drawerOffset
        rect.x: StateMachine.sizes.bars.main.margin //widget.highestAnimX
        adjustment: PopupAdjustment.None
      }

      //height: bar.height
      //width: Math.max(1, widthAnim.running ? Math.max(tooltipItem.targetWidth, tooltipItem.lastTargetWidth) : tooltipItem.targetWidth)
      //width: Math.max(1, widthAnim.running ? Math.max(tooltipItem.targetWidth, tooltipItem.lastTargetWidth) : tooltipItem.targetWidth)
      height: Math.max(700, widget.largestAnimHeight) // max due to qtwayland glitches
      width: {
        const w = widget.highestAnimX - widget.lowestAnimX;
        //console.log(`seth ${h} ${tooltipItem.highestAnimY} ${tooltipItem.lowestAnimY}; ${tooltipItem.y1} ${tooltipItem.y2}`)
        return w;
      }

      //width: tooltipItem.targetWidth
      visible: true
      //color: "transparent"
      color: "#20000000"

      mask: Region {
        item: (shownItem?.hoverable ?? false) ? widget : null
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

      Widget {
        id: widget
        bar: root.bar
        popupLayer: popup
        scaleMul: root.scaleMul
        targetVisible: popupLayer.visible
      }
    }
  }
}
