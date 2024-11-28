//@ pragma UseQApplication
import QtQuick
import Quickshell

import "root:/"
import "root:/bars"
import "root:/components/shared"
import "root:/components"

ShellRoot {
  id: root

  // post-render
  Component.onCompleted: Config

  Top {}
  // Popup on Quickshell reload
  ReloadPopup {}
  // --
  Wallpaper {}
}
