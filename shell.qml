//@ pragma UseQApplication
import QtQuick
import Quickshell

import "root:/"
import "root:/bars"
import "root:/components/shared"

ShellRoot {
  id: root

  // post-render
  Component.onCompleted: Config

  Top {}
  // Popup on Quickshell reload
  ReloadPopup {}
}
