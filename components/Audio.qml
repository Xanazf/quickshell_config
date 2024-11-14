import QtQuick
import Quickshell
import QtQuick.Layouts

import "root:/"
import "root:/io"

Rectangle {
  id: root
  anchors.centerIn: parent
  color: "transparent"
  implicitWidth: 75 + 38
  height: 28
  RowLayout {
    anchors {
      centerIn: parent
    }
    implicitWidth: parent.width
    implicitHeight: parent.height
    spacing: 1

    Rectangle {
      color: Config.colors.mainColor4
      Layout.preferredWidth: textfield.width * 1.8
      height: parent.height
      topLeftRadius: 30
      bottomLeftRadius: 30
      topRightRadius: 6
      bottomRightRadius: 6
      Text {
        id: textfield
        color: Config.colors.fontcolor
        anchors.centerIn: parent
        property string volumeLow: "󰕿 "
        property string volumeMid: "󰖀 "
        property string volumeHigh: "󰕾 "

        property int intVolume: PipewireIO.volume * 100
        width: intVolume < 100 ? 32 : 39
        property string volumeIcon: intVolume < 30 ? volumeLow : intVolume < 70 ? volumeMid : volumeHigh

        text: volumeIcon + intVolume
      }
      MouseArea {
        anchors.fill: parent
        anchors.centerIn: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onWheel: event => {
          event.accepted = true;
          let volumeChange = event.angleDelta.y === -240 ? -0.03 : 0.03;
          let newVolume = PipewireIO.volume + volumeChange;
          let nullishVolume = Math.max(newVolume, 0);
          PipewireIO.activeSink.audio.volume = nullishVolume;
        }
      }
    }
    Rectangle {
      color: Config.colors.mainColor3
      implicitWidth: textfield2.width
      Layout.preferredWidth: textfield2.width * 1.8
      height: parent.height
      topLeftRadius: 6
      bottomLeftRadius: 6
      topRightRadius: 30
      bottomRightRadius: 30
      Text {
        id: textfield2
        width: 35
        color: Config.colors.fontcolor
        anchors.centerIn: parent
        property int intMicVolume: PipewireIO.micVolume * 100
        text: " " + intMicVolume
      }
      MouseArea {
        anchors.fill: parent
        anchors.centerIn: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onWheel: event => {
          event.accepted = true;
          let volumeChange = event.angleDelta.y === -240 ? -0.03 : 0.03;
          let newVolume = PipewireIO.micVolume + volumeChange;
          let nullishVolume = Math.max(newVolume, 0);
          PipewireIO.activeSource.audio.volume = nullishVolume;
        }
      }
    }
  }
}
