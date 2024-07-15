pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  property string currKeyboardLayout: "US";
  property string sortedWorkspaces: sortWorkspaces(Hyprland.workspaces.values);
  property QtObject activeWorkspace: QtObject {
    property int id: 1
    property string name: "1"
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
    return [...arr].sort()
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
      }
    }
  }
}
