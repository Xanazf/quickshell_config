import QtQuick

import "root:/"
import "root:/io"
import "../../shared"

Rectangle {
  id: root
  color: Qt.alpha(Config.colors.mainColor5, 0.1)
  radius: Config.sizes.mainRadius
  property string uptime: SystemSessionIO.uptime
  BorderSubtle {
    gradientColor1: Config.colors.mainColor6
    gradientColor2: Config.colors.yellow600
    numOfBorders: 1
  }

  Column {
    anchors.verticalCenter: parent.verticalCenter
    spacing: 15
    Text {
      id: username
      antialiasing: true
      font.bold: true
      font.pixelSize: 21
      font.letterSpacing: 1
      color: Config.colors.mainColor4
      leftPadding: 10
      text: Config.username
    }
    Text {
      id: uptime
      antialiasing: true
      font.pixelSize: 18
      font.letterSpacing: 1
      color: Config.colors.yellow600
      leftPadding: 15
      text: root.uptime
    }
    Text {
      id: distroText
      antialiasing: true
      font.pixelSize: 18
      font.letterSpacing: 1
      color: "darkturquoise"
      leftPadding: 10
      text: Config.distro
    }
  }
}
