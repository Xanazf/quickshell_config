//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import QtQuick
import Quickshell

import "config/"
import "components/"
import "components/bars/"

ShellRoot {
  id: root

  // post-render
  Component.onCompleted: Config

  Wallpaper {}

  //Main {}
  Mainv2 {}
}
