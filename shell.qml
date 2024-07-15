//@ pragma UseQApplication
import QtQuick
import Quickshell
import "root:/widget"
import "root:/component"
import "root:/bar"

ShellRoot {
  id: root
  Top {}
	// Popup on Quickshell reload
	ReloadPopup {}
}
