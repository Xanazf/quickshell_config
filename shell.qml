//@ pragma UseQApplication
import QtQuick
import Quickshell
import "root:/widget"
// import "root:/component"
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
