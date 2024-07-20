import QtQuick
import QtQuick.Controls
import Quickshell
import "root:/io"
import "root:/"

Rectangle {
  id: root;
  anchors.centerIn: parent;
  color: Config.colors.mainBG
  implicitHeight: 28
  implicitWidth: 42
  radius: 30
  MouseArea {
    id: mouseArea
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    property bool isHovered: false;
    property string tooltipText: "0";
    Text {
      id: text
      color: Config.colors.mainFG
      anchors.fill: parent
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      font {
        pixelSize: 24
        family: "Hack Nerd Font Mono"
      }
      text: "󰨸"
    }
    onClicked: (mouse) => {
      if (mouse.button === Qt.LeftButton) {
        ClipboardIO.runninglist = true;
      } else if (mouse.button === Qt.RightButton) {
        ClipboardIO.runningwipe = true;
      }
    }
    onEntered: {
      ClipboardIO.runningcount = true;
      isHovered = true
    }
    onExited: {
      isHovered = false
    }
    ToolTip {
      id: tooltip;
      delay: 300
      width: 200;
      height: 30;
      visible: false //mouseArea.isHovered;
      //topMargin: 30
      y: 100;
      x: -60;
      text: mouseArea.tooltipText
    }
  }

  Connections {
    target: ClipboardIO
    function cliphistcount(count){
      console.log(count)
      mouseArea.tooltipText = count
    }
  }

}
