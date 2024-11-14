import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import "root:/"
import "root:/io"
import "./"

Item {
  id: root
  required property QsWindow window
  implicitWidth: layout.implicitWidth + 30
  implicitHeight: layout.implicitHeight + 2
  property int iHeight: 13
  property int iWidth: 13

  RowLayout {
    id: layout
    anchors.centerIn: parent
    spacing: 15
    implicitHeight: root.iHeight
    implicitWidth: repeater.count * root.iWidth + 15
    Repeater {
      id: repeater
      model: HyprlandIO.sortedWorkspaces
      property int count: HyprlandIO.sortedWorkspaces.length
      InnerCircle {
        id: toprect
        implicitWidth: root.iWidth
        implicitHeight: root.iHeight
      }
    }
  }

  MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    hoverEnabled: true
    onEntered: {
      root.iHeight = 28;
      root.iWidth = 28;
    }
    onExited: {
      root.iHeight = 13;
      root.iWidth = 13;
    }
    onClicked: mouse => {
      console.log(Hyprland.workspaces);
    }
  }
  Behavior on iWidth {
    SmoothedAnimation {
      velocity: 300
    }
  }
  Behavior on iHeight {
    SmoothedAnimation {
      velocity: 300
    }
  }
}
