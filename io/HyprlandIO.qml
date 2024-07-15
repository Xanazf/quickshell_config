pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  property string currKeyboardLayout: "US";
  property list<HyprlandWorkspace> sortedWorkspaces: sortWorkspaces(Hyprland.workspaces.values);
  property QtObject activeWorkspace: QtObject {
    property int id: 1
    property string name: "1"
  }
  property QtObject activeWindow: QtObject {
    property string hclass: " "
    property string title: " "
  }

  function textTransform(layout){
    let transform;
    switch (layout){
      case "English (US)": {
        transform = "US";
        break;
      }
      case "English (Dvorak)": {
        transform = "DV"
        break;
      }
      case "Ukrainian": {
        transform = "UA"
        break;
      }
      default: {
        transform = "US"
        break
      }
    }
    return transform;

  }

  function sortWorkspaces(arr){
    return [...arr].sort((a, b) => a.id - b.id)
  }

  Connections {
    target: Hyprland;
    function onRawEvent(event) {
      //console.log("EVENT NAME", event.name);
      //console.log("EVENT DATA", event.data);
      let eventName = event.name;

      switch (eventName) {
        case "activelayout": {
          let layout = event.parse(2)[1]
          currKeyboardLayout = textTransform(layout)
          break;
        }
        case "workspacev2": {
          let workspace = event.parse(2)
          activeWorkspace.id = workspace[0];
          activeWorkspace.name = workspace[1];
          break;
        }
        case "activewindow": {
          let window = event.parse(2)
          activeWindow.hclass = window[0];
          activeWindow.title = window[1];
          break;
        }
      }
    }
  }
}
