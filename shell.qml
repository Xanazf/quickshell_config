//@ pragma UseQApplication
//@ pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

import "root:/"
import "root:/components/bars/"
import "root:/components/shared/templates/"
import "root:/components/"

ShellRoot {
  id: root

  // post-render
  Component.onCompleted: Config

  Main {}
  Wallpaper {}
  // Popup on Quickshell reload
  ReloadPopup {}
  // --
}
