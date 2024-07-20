//@ pragma UseQApplication
import QtQuick
import Quickshell
import "root:/shared/widget"
import "root:/bar"
import "root:/"

ShellRoot {
  id: root
  Top {}
	// Popup on Quickshell reload
	ReloadPopup {}

  // post-render
  Component.onCompleted: Config
}
