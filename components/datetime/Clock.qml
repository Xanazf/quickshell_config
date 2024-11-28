import QtQuick
import Quickshell
import "root:/"

Rectangle {
  id: root
  color: "transparent"
  width: 80
  height: Config.sizes.barHeight
  anchors.fill: parent
  Text {
    id: timetext
    anchors.horizontalCenter: root.horizontalCenter
    y: parent.height / 4
    font.bold: true
    horizontalAlignment: Text.AlignHCenter
    color: Qt.lighter(Config.colors.navy500, 1.1)
    text: `${Time.syshours}:${Time.sysminutes}`
    Behavior on y {
      SmoothedAnimation {
        velocity: 100
      }
    }
  }
  Text {
    id: datetext
    width: contentWidth > 80 ? contentWidth : 80
    anchors.horizontalCenter: root.horizontalCenter
    y: root.height / 1.3
    font.bold: true
    color: Qt.alpha(Config.colors.navy500, 0.3)
    text: `${Time.date}`
    Behavior on y {
      SmoothedAnimation {
        velocity: 100
      }
    }
    Behavior on color {
      ColorAnimation {
        duration: 100
      }
    }
  }
  MouseArea {
    id: hoverArea
    anchors.fill: parent
    hoverEnabled: true
    onEntered: {
      datetext.y = root.height / 2;
      datetext.color = Qt.alpha(Config.colors.navy500, 0.9);
      timetext.y = parent.y + 3;
    }
    onExited: {
      datetext.y = root.height / 1.3;
      datetext.color = Qt.alpha(Config.colors.navy500, 0.3);
      timetext.y = parent.height / 4;
    }
  }
}
