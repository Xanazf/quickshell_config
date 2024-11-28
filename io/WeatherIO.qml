pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// fastfetch -c /home/xnzf/.config/fastfetch/rawdata.jsonc

Singleton {
  id: root
  property var weather
  Process {
    id: getWeather
    command: ["sh", "-c", "weather-Cli get Kyiv --raw"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        let jsonData = JSON.parse(data);
        if (jsonData.current_weather) {
          root.weather = jsonData;
        }
      }
    }
    onExited: running = false
  }
  Timer {
    interval: 60 * 1000
    running: true
    repeat: true
    onTriggered: getWeather.running = true
  }
}
