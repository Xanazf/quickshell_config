pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

import "./"

// fastfetch -c /home/xnzf/.config/fastfetch/rawdata.jsonc

Singleton {
  id: root

  property string workingDirectory: "/home/xnzf/.config/quickshell/"

  // host info
  property string uptime
  property string host
  property string kernel

  // RAM info
  property real totalRAM
  property real freeRAM
  property real usedRAM: totalRAM - freeRAM

  property real totalSwap
  property real freeSwap
  property real usedSwap: totalSwap - freeSwap

  // CPU info
  property real usedCPU

  // GPU info
  property string gpuName
  property string gpuTemp
  property string gpuUtilization
  property string gpuPower
  property string gpuMemory
  property list<string> currGpuProcesses

  // disk info
  property list<string> sdaChildren
  property list<string> sdbChildren
  property list<string> sdcChildren
  property list<string> nvme0n1Children
  //property list<string> nvmeXnYChildren

  property real sdaUsed
  property real sdbUsed
  property real sdcUsed
  property real nvme0n1Used
  property real sdaTotal
  property real sdbTotal
  property real sdcTotal
  property real nvme0n1Total

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
      getGPUinfo.running = true;
    }
  }
  // 1s timer
  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      getCPUinfo.running = true;
    }
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
        const totalgbSwap = Number(text.match(/SwapTotal:\s+(\d+)/)[1]) / 1000000;
        const freegbSwap = Number(text.match(/SwapFree:\s+(\d+)/)[1]) / 1000000;
        if (root.totalRAM !== totalgb.toFixed(1)) {
          root.totalRAM = totalgb.toFixed(1);
        }
        if (root.freeRAM !== freegb.toFixed(1)) {
          root.freeRAM = freegb.toFixed(1);
        }
        if (root.totalSwap !== totalgbSwap.toFixed(1)) {
          root.totalSwap = totalgbSwap.toFixed(1);
        }
        if (root.freeSwap !== freegbSwap.toFixed(1)) {
          root.freeSwap = freegbSwap.toFixed(1);
        }
        getMeminfo.path = "";
      } else {
        getMeminfo.reload();
      }
    }
  }
  Process {
    id: getCPUinfo
    command: ["sh", "-c", "./cpuinfo.sh"]
    workingDirectory: `${root.workingDirectory}/helpers/io/`
    running: true
    stdout: SplitParser {
      onRead: data => {
        root.usedCPU = Number(data);
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
  Process {
    id: getDiskInfo
    command: ["sh", "-c", "lsblk -fnJA"]
    running: true
    stdout: SplitParser {
      splitMarker: ""
      onRead: data => {
        const parsed = JSON.parse(data);
        //console.log(data);
        const blockdevices = parsed.blockdevices;
        let swap;
        for (const device of blockdevices) {
          if (device.name === "sda") {
            swap = device.children.find(item => item.name === "sda3");
          }
          const childrenNames = device.children.map(item => item.name);
          root[`${device.name}Children`] = childrenNames;

          let freePercent;
          let freeValue;
          let usedPercent;
          let usedValue;
          let totalSize;
          for (const child of device.children) {
            if (!child.fsavail) {
              continue;
            }
            usedPercent = Number(child["fsuse%"].slice(0, -1));
            freePercent = 100 - usedPercent;

            freeValue = Number(child["fsavail"].slice(0, -3));
            totalSize = (freeValue / (freePercent * 0.01)).toFixed(0);
            usedValue = totalSize - freeValue;
          }
          root[`${device.name}Used`] = usedValue;
          root[`${device.name}Total`] = totalSize;
        }
      }
    }
    onExited: {
      running = false;
    }
  }
}
