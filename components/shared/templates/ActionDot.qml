import QtQuick
import QtQuick.Layouts

import "root:/"

Rectangle {
  id: root
  property int spacing
  property color ccolor
  required property int dotSize
  property bool hovered: false
  implicitWidth: hovered ? dotSize * 1.8 : dotSize
  implicitHeight: hovered ? dotSize * 1.8 : dotSize
  Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
  color: hovered ? Qt.alpha(Config.colors.fontcolor, 0.2) : "transparent"
  border.width: 1
  border.color: hovered ? Qt.alpha(Config.colors.fontcolor, 0.6) : "transparent"
  radius: 30
  Rectangle {
    id: dot
    implicitWidth: root.dotSize
    implicitHeight: root.dotSize
    anchors.centerIn: parent
    radius: 30
    color: root.ccolor ? root.ccolor : Qt.alpha(Config.colors.red500, 0.5)
    Behavior on implicitWidth {
      NumberAnimation {
        duration: 200
      }
    }
    Behavior on implicitHeight {
      NumberAnimation {
        duration: 200
      }
    }
  }
  Behavior on implicitWidth {
    NumberAnimation {
      duration: 200
    }
  }
  Behavior on implicitHeight {
    NumberAnimation {
      duration: 200
    }
  }
}
