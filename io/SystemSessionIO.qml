pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// fastfetch -c /home/xnzf/.config/fastfetch/rawdata.jsonc

Singleton {
  id: root

  // host info
  property string uptime
  property string host
  property string kernel

  // RAM info
  property real totalRAM
  property real freeRAM
  property real usedRAM: totalRAM - freeRAM

  // CPU info
  property real usedCPU

  // GPU info
  property string gpuName
  property string gpuTemp
  property string gpuUtilization
  property string gpuPower
  property string gpuMemory
  property list<string> currGpuProcesses

  // universal minute timer
  Timer {
    interval: 60 * 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      getUptime.running = true;
      getMeminfo.path = "/proc/meminfo";
      getMeminfo.reload();
      getCPUinfo.running = true;
      getGPUinfo.running = true;
    }
  }
  // 1s timer
  Timer {
    interval: 1000
    running: false
    repeat: false
    triggeredOnStart: false
    onTriggered: {}
  }

  // once
  Process {
    id: getHost
    command: ["sh", "-c", "uname -n"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        root.host = data;
      }
    }
    onExited: {
      running = false;
    }
  }
  Process {
    id: getKernel
    command: ["sh", "-c", "uname -r"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        root.kernel = data;
      }
    }
    onExited: {
      running = false;
    }
  }

  // on a timer
  Process {
    id: getUptime
    command: ["sh", "-c", "uptime -p"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        root.uptime = data;
      }
    }
    onExited: {
      running = false;
    }
  }
  FileView {
    id: getMeminfo
    path: "/proc/meminfo"
    onTextChanged: {
      const text = getMeminfo.text();
      if (getMeminfo.loaded && text) {
        const totalgb = Number(text.match(/MemTotal:\s+(\d+)/)[1]) / 1000000;
        const freegb = Number(text.match(/MemAvailable:\s+(\d+)/)[1]) / 1000000;
        root.totalRAM = totalgb.toFixed(1);
        root.freeRAM = freegb.toFixed(1);
        getMeminfo.path = "";
      } else {
        getMeminfo.reload();
      }
    }
  }
  Process {
    id: getCPUinfo
    command: ["sh", "-c", "./cpuinfo.sh"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        root.usedCPU = data;
      }
    }
    onExited: {
      running = false;
    }
  }
  Process {
    id: getGPUinfo
    command: ["sh", "-c", "gpustat -P --no-color -c --no-header"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        const dataSplit = data.split("|");
        const name = dataSplit[0].slice(4);
        const t_u_p = dataSplit[1].split(",").map(item => item.trim());
        const temp = t_u_p[0];
        const util = t_u_p[1].replace(" ", "");
        const power = t_u_p[2].split("/").map(item => item.trim()).join("/").replace(" ", "");
        const memory = dataSplit[2].split("/").map(item => item.trim()).join("/").replace(" ", "");
        const processes = dataSplit[3]?.trim().split(" ");

        root.gpuName = name;
        root.gpuTemp = temp;
        root.gpuUtilization = util;
        root.gpuPower = power;
        root.gpuMemory = memory;
        root.currGpuProcesses = processes;
      }
    }
    onExited: {
      running = false;
    }
  }
}
