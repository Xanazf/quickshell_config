import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import qs.config
import qs.helpers.io
import qs.components.shared.templates

Item {
  id: root
  required property QsWindow window
  width: layout.implicitWidth
  height: Config.sizes.barHeight

  RowLayout {
    id: layout
    anchors.centerIn: parent
    spacing: 21
    implicitHeight: root.height
    implicitWidth: repeater.totalCount * 15
    Repeater {
      id: repeater
      model: 5
      property list<HyprlandWorkspace> workspaces: HyprlandIO.sortedWorkspaces
      property int totalCount: 5
      property QtObject activeWorkspace: HyprlandIO.activeWorkspace
      property color activeColor: Config.colors.red600
      property color existingColor: Config.colors.red700
      property color nonExistingColor: Config.colors.navy700
      ActionDot {
        id: workdot
        required property int index
        property HyprlandWorkspace currWorkspace: repeater.workspaces[index] || null
        property bool nonExisting: currWorkspace === null
        ccolor: {
          if (nonExisting) {
            return Qt.alpha(repeater.nonExistingColor, 0.6);
          }
          if (currWorkspace.id === repeater.activeWorkspace.id) {
            return repeater.activeColor;
          }
          if (currWorkspace.name === "special:scratchpad" && HyprlandIO.activeSpecial.active) {
            return Qt.lighter(Config.colors.mainColor3, 1.8);
          }
          return repeater.existingColor;
        }
        dotSize: 7
        MouseArea {
          id: workdotMouseArea
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          cursorShape: Qt.PointingHandCursor
          anchors.fill: parent
          hoverEnabled: true
          onEntered: {
            workdot.dotSize = 9;
            workdot.hovered = true;
          }
          onExited: {
            workdot.dotSize = 7;
            workdot.hovered = false;
          }
          onClicked: mouse => {
            console.log(HyprlandIO.sortedWorkspaces[workdot.index]);
          }
        }
      }
    }
  }
}
