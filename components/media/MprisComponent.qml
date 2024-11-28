import QtQuick
import QtQuick.Layouts
import QtQuick.VectorImage
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Mpris

import "root:/io"
import "root:/"
import "../shared"

Rectangle {
  id: root

  // actual player
  property MprisPlayer player: MprisIO.trackedPlayer ?? fallbackPlayer

  // fallback for missing MprisPlayer on startup
  property QtObject fallbackPlayer: QtObject {
    property string trackAlbumArtist: ""
    property string trackArtists: ""
    property string trackTitle: ""
    property int playbackState: MprisPlaybackState.Stopped
  }

  // destructuring of the Player object
  // -- compliance to MPRIS
  property bool canRaise: player.canRaise
  property bool canQuit: player.canQuit
  property bool canPause: player.canPause
  property bool canSeek: player.canSeek
  property bool canPlay: player.canPlay
  property bool canTogglePlaying: player.canTogglePlaying
  property bool canGoNext: player.canGoNext
  property bool canGoPrevious: player.canGoPrevious
  property bool canSetFullscreen: player.canSetFullscreen
  property bool canLength: player.lengthSupported
  property bool canShuffle: player.shuffleSupported
  property bool canPosition: player.positionSupported
  property bool canVolume: player.volumeSupported
  property bool canLoop: player.loopSupported
  property list<string> supportedUri: player.supportedUriSchemes
  property list<string> supportedMime: player.supportedMimeTypes

  // -- props
  property int uniqueId: player.uniqueId
  property string playerIdentity: player.identity
  property string trackArt: player.trackArtUrl
  property string trackAlbum: player.trackAlbum
  property string trackLink: player.metadata["xesam:url"]
  property list<string> playerArr: trackLink.split("\/")
  property string playerName: playerArr[2].startsWith("www.") ? playerArr[2].slice(4, playerArr[2].lastIndexOf(".")) : playerArr[2].slice(0, playerArr[2].lastIndexOf("."))
  property string playerAttribute: playerArr[3]
  property string artist: player.trackAlbumArtist || player.trackArtists
  property string title: player.trackTitle
  property real position: player.position
  property real length: player.length

  // -- states
  property bool playing: player.playbackState === MprisPlaybackState.Playing
  property bool loopedTrack: player.loopState === MprisLoopState.Track
  property bool loopedPlaylist: player.loopState === MprisLoopState.Playlist
  property bool fullscreen: canSetFullscreen ? player.fullscreen : false

  // base colors
  property string playbackBG: playing ? Qt.alpha(Config.colors.mainColor4, 0.3) : Qt.alpha(Config.colors.mainColor1, 0.3)
  property string playbackFG: playing ? Config.colors.mainColor4 : Qt.alpha(Config.colors.fontcolor, 0.3)

  // settings
  implicitHeight: Config.sizes.barHeight
  implicitWidth: artistData.width
  color: playbackBG

  Behavior on width {
    NumberAnimation {
      duration: 200
      easing.type: Easing.InOutQuad
    }
  }

  // elements
  Rectangle {
    id: artistData
    width: artistDataLayout.width
    height: parent.height
    color: "transparent"
    RowLayout {
      id: artistDataLayout
      spacing: 6
      height: Config.sizes.barHeight
      implicitWidth: albumArtRect.calculatedWidth + controlsRect.calculatedWidth + artistTrackRect.calculatedWidth + 6 * 3

      Rectangle {
        id: albumArtRect
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        Layout.preferredHeight: Config.sizes.barHeight
        Layout.maximumWidth: Config.sizes.barHeight * 2
        Layout.minimumWidth: Config.sizes.barHeight
        Layout.preferredWidth: albumArt.paintedWidth
        property int calculatedWidth: albumArt.paintedWidth
        color: "transparent"

        Image {
          id: albumArt
          visible: root.trackArt.length > 0
          fillMode: Image.PreserveAspectFit
          height: Config.sizes.barHeight
          width: {
            let width = Config.sizes.barHeight;
            if (root.playerName === "youtube") {
              width *= 2;
            }
            return width;
          }
          mipmap: true
          horizontalAlignment: Image.AlignLeft
          verticalAlignment: Image.AlignTop
          cache: root.playerName === "music.youtube"
          source: root.trackArt
        }
        Behavior on Layout.preferredWidth {
          NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
          }
        }
      }
      Rectangle {
        id: artistTrackRect
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.preferredHeight: Config.sizes.barHeight
        property int calculatedWidth
        Layout.preferredWidth: {
          if (artistText.implicitWidth > trackText.implicitWidth) {
            calculatedWidth = artistText.implicitWidth + 42;
            return artistText.implicitWidth + 42;
          }
          calculatedWidth = trackText.width + 42;
          return trackText.width + 42;
        }
        color: "transparent"
        Text {
          id: artistText
          color: Qt.lighter(Config.colors.mainColor2, 1.8)
          anchors.top: parent.top
          anchors.topMargin: 4
          font {
            bold: true
            letterSpacing: 1
            pixelSize: 12
          }
          text: root.artist
        }
        Text {
          id: trackText
          color: root.playbackFG
          elide: Text.ElideRight
          width: 200
          maximumLineCount: 10
          anchors.top: artistText.bottom
          font {
            bold: true
            letterSpacing: 0
          }
          text: root.title
        }
        MouseArea {
          id: artistDataMouseArea
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          cursorShape: Qt.PointingHandCursor
          onClicked: mouse => {
            root.player.togglePlaying();
          }
        }
      }
      Rectangle {
        id: controlsRect
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        Layout.preferredHeight: Config.sizes.barHeight
        Layout.preferredWidth: controlsLayout.width
        color: "transparent"
        property color controlColor: Config.colors.mainColor4
        property color noControlColor: Config.colors.neutral
        property int calculatedWidth: controlsLayout.width
        RowLayout {
          id: controlsLayout
          width: Config.sizes.barHeight * children.length
          height: parent.height
          ButtonComponent {
            id: prevButton
            size: 30
            setInactiveColor: Qt.alpha(controlsRect.noControlColor, 0.3)
            setActiveColor: Qt.alpha(controlsRect.controlColor, 0.8)
            canInteract: root.canGoPrevious
            radius: Config.sizes.mainRadius
            VectorImage {
              preferredRendererType: VectorImage.GeometryRenderer
              anchors.centerIn: parent
              source: "root:/svg/media/skip-previous-outline.svg"
            }
            onPressEvent: root.player.previous()
          }
          ButtonComponent {
            id: playPauseButton
            size: 30
            setInactiveColor: Qt.alpha(controlsRect.noControlColor, 0.3)
            setActiveColor: Qt.alpha(controlsRect.controlColor, 0.8)
            canInteract: root.canTogglePlaying || (root.canPlay && root.canPause)
            radius: Config.sizes.mainRadius
            VectorImage {
              preferredRendererType: VectorImage.GeometryRenderer
              anchors.centerIn: parent
              source: !root.playing ? "root:/svg/media/play-outline.svg" : "root:/svg/media/pause.svg"
            }
            onPressEvent: {
              if (root.canTogglePlaying) {
                return root.player.togglePlaying();
              }
              return root.playing ? root.player.pause() : root.player.play();
            }
          }
          ButtonComponent {
            id: nextButton
            size: 30
            setInactiveColor: Qt.alpha(controlsRect.noControlColor, 0.3)
            setActiveColor: Qt.alpha(controlsRect.controlColor, 0.8)
            canInteract: root.canTogglePlaying || (root.canPlay && root.canPause)
            radius: Config.sizes.mainRadius
            VectorImage {
              preferredRendererType: VectorImage.GeometryRenderer
              anchors.centerIn: parent
              source: "root:/svg/media/skip-next-outline.svg"
            }
            onPressEvent: root.player.next()
          }
        }
      }
    }
  }
}
