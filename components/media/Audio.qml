import QtQuick
import Quickshell
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.config
import qs.helpers.io
import qs.assets.svg.qml

Rectangle {
  id: root
  anchors.centerIn: parent
  color: "transparent"
  implicitWidth: 75 + 38
  height: parent.height / 1.32
  property int elementWidth: 33
  RowLayout {
    clip: false
    anchors {
      centerIn: parent
    }
    implicitWidth: parent.width
    implicitHeight: parent.height
    spacing: 1

    Rectangle {
      id: soundRoot
      //clip: true
      property color soundHighlight: Config.colors.mainColor4
      color: "transparent"
      Layout.preferredWidth: soundText.width * 1.8
      Layout.preferredHeight: parent.height
      // border.color: soundHighlight
      // border.width: 2
      // topLeftRadius: 30
      // bottomLeftRadius: 30
      // topRightRadius: 6
      // bottomRightRadius: 6

      // sound props
      property int intVolume: PipewireIO.volume * 100
      property string volumeIcon: intVolume < 30 ? "volumeLow" : intVolume < 70 ? "volumeMid" : "volumeHigh"

      Text {
        id: soundText
        anchors.centerIn: soundRoot
        color: soundRoot.soundHighlight
        width: root.elementWidth
        font.strikeout: PipewireIO.muted
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: soundRoot.intVolume
      }
      MouseArea {
        id: soundMouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        onWheel: event => {
          event.accepted = true;
          let volumeChange = event.angleDelta.y === -240 ? -0.03 : 0.03;
          let newVolume = PipewireIO.volume + volumeChange;
          let nullishVolume = Math.max(newVolume, 0);
          PipewireIO.activeSink.audio.volume = nullishVolume;
        }
      }
      VolumeHigh {
        id: soundIcon3
        clip: true
        visible: soundRoot.volumeIcon === "volumeHigh"
        currentColor: PipewireIO.muted ? Qt.alpha(Config.colors.red900, 0.6) : Qt.alpha(soundRoot.soundHighlight, 0.6)
        width: 24 * 1.5
        height: 24 * 1.5
        x: parent.width / 4
        y: -parent.height / 3
        rotation: 180
      }
      VolumeMedium {
        id: soundIcon2
        clip: true
        visible: soundRoot.volumeIcon === "volumeMid"
        currentColor: PipewireIO.muted ? Qt.alpha(Config.colors.red900, 0.6) : Qt.alpha(soundRoot.soundHighlight, 0.6)
        width: 24 * 1.5
        height: 24 * 1.5
        x: parent.width / 4
        y: -parent.height / 3
        rotation: 180
      }
      VolumeLow {
        id: soundIcon1
        clip: true
        visible: soundRoot.volumeIcon === "volumeLow"
        currentColor: PipewireIO.muted ? Qt.alpha(Config.colors.red900, 0.6) : Qt.alpha(soundRoot.soundHighlight, 0.6)
        width: 24 * 1.5
        height: 24 * 1.5
        x: parent.width / 4
        y: -parent.height / 3
        rotation: 180
      }
      layer {
        enabled: true
        effect: OpacityMask {
          maskSource: Background {
            orient: "right"
            border.color: "transparent"
            color: "white"
            width: soundBG.width
            height: soundBG.height
          }
        }
      }
      Background {
        id: soundBG
        orient: "right"
        border.color: soundRoot.soundHighlight
        color: "transparent"
        implicitWidth: soundRoot.width
        implicitHeight: soundRoot.height
      }
    }
    Rectangle {
      id: micRoot
      //clip: true
      color: "transparent"
      Layout.preferredWidth: micText.width * 1.8
      Layout.preferredHeight: parent.height
      // border.color: micHighlight
      // border.width: 2
      // topRightRadius: 30
      // bottomRightRadius: 30
      // topLeftRadius: 6
      // bottomLeftRadius: 6

      // mic props
      property int intMicVolume: PipewireIO.micVolume * 100
      property color micHighlight: Qt.lighter(Config.colors.mainColor3, 1.2)

      Text {
        id: micText
        anchors.centerIn: micRoot
        width: root.elementWidth
        color: micRoot.micHighlight
        font.strikeout: PipewireIO.micMuted
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: micRoot.intMicVolume
      }
      MouseArea {
        id: micMouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        onWheel: event => {
          event.accepted = true;
          let volumeChange = event.angleDelta.y === -240 ? -0.03 : 0.03;
          let newVolume = PipewireIO.micVolume + volumeChange;
          let nullishVolume = Math.max(newVolume, 0);
          PipewireIO.activeSource.audio.volume = nullishVolume;
        }
        onClicked: {
          PipewireIO.micMuted = !PipewireIO.micMuted;
        }
      }
      MicrophoneOutline {
        id: micIcon1
        clip: true
        currentColor: PipewireIO.micMuted ? Qt.alpha(Config.colors.red600, 0.6) : Qt.alpha(micRoot.micHighlight, 0.6)
        width: 24 * 1.5
        height: 24 * 1.5
        x: -12
        y: -11
      }
      layer {
        enabled: true
        effect: OpacityMask {
          maskSource: Background {
            border.color: "transparent"
            color: "white"
            width: micBG.width
            height: micBG.height
          }
        }
      }
      Background {
        id: micBG
        orient: "left"
        border.color: micRoot.micHighlight
        color: "transparent"
        implicitWidth: micRoot.width
        implicitHeight: micRoot.height
      }
    }
  }
  component Background: Rectangle {
    // set border width, size, radius
    property string orient
    border.width: 2
    topRightRadius: orient === "right" ? 6 : 30
    bottomRightRadius: orient === "right" ? 6 : 30
    topLeftRadius: orient === "right" ? 30 : 6
    bottomLeftRadius: orient === "right" ? 30 : 6
  }
}
