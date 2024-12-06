import QtQuick
import Quickshell.Widgets

import "root:/"
import "root:/io"
import "../../shared"

Rectangle {
  id: root
  // props
  // -- host
  property string uptime: SystemSessionIO.uptime
  property string host: SystemSessionIO.host
  property string kernel: SystemSessionIO.kernel

  // -- RAM
  property real totalRAM: SystemSessionIO.totalRAM
  property real usedRAM: SystemSessionIO.usedRAM.toFixed(3)

  // -- CPU
  property real usedCPU: SystemSessionIO.usedCPU

  // -- GPU
  property string gpuTemp: SystemSessionIO.gpuTemp
  property string gpuUtil: SystemSessionIO.gpuUtilization
  property string gpuPower: SystemSessionIO.gpuPower
  property string gpuMemory: SystemSessionIO.gpuMemory

  // styling
  color: Qt.alpha(Config.colors.mainColor5, 0.1)
  radius: Config.sizes.mainRadius

  BorderSubtle {
    gradientColor1: Config.colors.mainColor6
    gradientColor2: Config.colors.yellow600
    numOfBorders: 1
  }

  // items
  Column {
    id: userSessionColumn
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.leftMargin: 10
    spacing: 15
    Text {
      id: username
      antialiasing: true
      font.bold: true
      font.pixelSize: 21
      font.letterSpacing: 1.2
      color: Config.colors.mainColor4
      text: `${Config.username}@${root.host}`
    }
    Text {
      id: uptime
      antialiasing: true
      font.pixelSize: 18
      font.letterSpacing: 1
      color: Config.colors.yellow600
      leftPadding: 5
      text: root.uptime.slice(0, root.uptime.lastIndexOf(","))
    }
    Text {
      id: distroText
      antialiasing: true
      font.pixelSize: 18
      font.letterSpacing: 1
      color: "darkturquoise"
      text: Config.distro
      Text {
        id: kernelText
        anchors.top: distroText.bottom
        anchors.right: distroText.right
        antialiasing: true
        font.pixelSize: 16
        font.letterSpacing: 1
        color: Qt.alpha(Config.colors.fontcolor, 0.3)
        text: root.kernel
      }
    }
  }

  WrapperRectangle {
    visible: root.usedCPU !== undefined && root.gpuPower !== undefined && root.gpuMemory !== undefined
    color: "#20000000"
    anchors.verticalCenter: root.verticalCenter
    anchors.right: root.right
    topRightRadius: Config.sizes.mainRadius
    bottomRightRadius: Config.sizes.mainRadius
    margin: 9
    Column {
      id: sysStatColumn
      spacing: 6
      Rectangle {
        id: puRect
        implicitHeight: 40
        implicitWidth: root.width / 2 - 25
        color: Qt.alpha(Config.colors.neutral, 0.3)
        radius: Config.sizes.mainRadius
        Row {
          id: puRow
          spacing: 6
          Rectangle {
            id: cpuRect
            implicitHeight: puRect.implicitHeight
            implicitWidth: puRect.implicitWidth * 0.20
            color: "transparent"
            anchors.verticalCenter: parent.verticalCenter
            Canvas {
              id: cpuCanvas
              anchors.centerIn: parent
              width: parent.implicitWidth - 10
              height: parent.implicitHeight - 10
              antialiasing: true

              property color sub30: Config.colors.green600
              property color sub60: Config.colors.yellow700
              property color past61: Config.colors.red800

              property color currColor: root.usedCPU <= 30 ? sub30 : root.usedCPU <= 60 ? sub60 : past61

              property real centerWidth: width / 2
              property real centerHeight: height / 2
              property real radius: Math.min(cpuCanvas.width, cpuCanvas.height) / 2

              property real minimumValue: 0
              property real maximumValue: 100
              property real currentValue: root.usedCPU

              property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI
              property real angleOffset: -Math.PI / 2

              property string text: root.usedCPU

              onSub30Changed: requestPaint()
              onSub60Changed: requestPaint()
              onPast61Changed: requestPaint()
              onMinimumValueChanged: requestPaint()
              onMaximumValueChanged: requestPaint()
              onCurrentValueChanged: requestPaint()

              onPaint: {
                let ctx = getContext("2d");
                ctx.save();

                ctx.clearRect(0, 0, cpuCanvas.width, cpuCanvas.height);

                // angle to 2*PI
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.strokeStyle = Config.colors.neutral;
                ctx.arc(cpuCanvas.centerWidth, cpuCanvas.centerHeight, cpuCanvas.radius, angleOffset + cpuCanvas.angle, angleOffset + 2 * Math.PI);
                ctx.stroke();

                // 0 to angle
                ctx.beginPath();
                ctx.lineWidth = 3;
                ctx.strokeStyle = currColor;
                ctx.arc(cpuCanvas.centerWidth, cpuCanvas.centerHeight, cpuCanvas.radius, cpuCanvas.angleOffset, cpuCanvas.angleOffset + cpuCanvas.angle);
                ctx.stroke();

                ctx.restore();
              }
              Text {
                color: cpuCanvas.currColor
                anchors.centerIn: parent
                text: cpuCanvas.text
              }
            }
          }
          Rectangle {
            id: gpuRect
            color: "transparent"
            implicitHeight: puRect.implicitHeight
            implicitWidth: puRect.implicitWidth * 0.80 - 6
            Text {
              id: gpuTempText
              anchors.verticalCenter: parent.verticalCenter
              anchors.left: parent.left
              property real tempNum: root.gpuTemp.slice(0, -2)
              property color currColor: {
                if (tempNum < 70 & tempNum > 50) {
                  return Config.colors.yellow700;
                }
                if (tempNum >= 70) {
                  return Config.colors.red800;
                }
                return Config.colors.green600;
              }
              color: currColor
              text: tempNum + root.gpuTemp.slice(-2)
            }
            Column {
              id: gpuDataColumn
              width: gpuRect.implicitWidth - gpuTempText.implicitWidth - 15
              height: children.length * 10
              anchors.verticalCenter: parent.verticalCenter
              anchors.left: gpuTempText.right
              anchors.leftMargin: 6
              anchors.rightMargin: 3
              spacing: 6
              Canvas {
                id: gpuUtilCanvas
                width: parent.width
                height: 6
                antialiasing: true

                property real utilNum: root.gpuUtil.slice(0, -1)

                property color sub30: Config.colors.green600
                property color sub60: Config.colors.yellow700
                property color past61: Config.colors.red800

                property color currColor: utilNum <= 30 ? sub30 : utilNum <= 60 ? sub60 : past61

                property real minimumValue: 0
                property real maximumValue: 100
                property real currentValue: utilNum

                onSub30Changed: requestPaint()
                onSub60Changed: requestPaint()
                onPast61Changed: requestPaint()
                onMinimumValueChanged: requestPaint()
                onMaximumValueChanged: requestPaint()
                onCurrentValueChanged: requestPaint()
                onPaint: {
                  let ctx = getContext("2d");
                  ctx.save();
                  ctx.clearRect(0, 0, gpuUtilCanvas.width, gpuUtilCanvas.height);

                  // currentValue to 100
                  ctx.beginPath();
                  ctx.fillStyle = Config.colors.neutral;
                  ctx.fillRect(gpuUtilCanvas.width * (utilNum * 0.01), 0, gpuUtilCanvas.width - gpuUtilCanvas.width * (utilNum * 0.01), gpuUtilCanvas.height);
                  ctx.fill();

                  // 0 to currentValue
                  ctx.beginPath();
                  ctx.fillStyle = currColor;
                  ctx.fillRect(0, 0, gpuUtilCanvas.width * (utilNum * 0.01), gpuUtilCanvas.height);
                  ctx.fill();

                  ctx.restore();
                }
                Text {
                  font.pixelSize: 12
                  color: gpuUtilCanvas.currColor
                  anchors.centerIn: parent
                  text: `${gpuUtilCanvas.utilNum}%`
                }
              }
              Canvas {
                id: gpuPowerCanvas
                width: parent.width
                height: 6
                antialiasing: true
                property real powerUsed: root.gpuPower.split("/")[0]
                property real powerTotal: root.gpuPower.split("/")[1]?.slice(0, -1) || 0
                property real powerUsedPercent: powerTotal !== 0 ? ((powerUsed / powerTotal) * 100).toFixed(1) : 0

                property color sub30: Config.colors.green600
                property color sub60: Config.colors.yellow700
                property color past61: Config.colors.red800

                property color currColor: powerUsedPercent <= 30 ? sub30 : powerUsedPercent <= 60 ? sub60 : past61

                property real minimumValue: 0
                property real maximumValue: 100
                property real currentValue: powerUsedPercent

                onSub30Changed: requestPaint()
                onSub60Changed: requestPaint()
                onPast61Changed: requestPaint()
                onMinimumValueChanged: requestPaint()
                onMaximumValueChanged: requestPaint()
                onCurrentValueChanged: requestPaint()
                onPaint: {
                  let ctx = getContext("2d");
                  ctx.save();
                  ctx.clearRect(0, 0, gpuPowerCanvas.width, gpuPowerCanvas.height);

                  // currentValue to 100
                  ctx.beginPath();
                  ctx.fillStyle = Config.colors.neutral;
                  ctx.fillRect(gpuPowerCanvas.width * (powerUsedPercent * 0.01), 0, gpuPowerCanvas.width - gpuPowerCanvas.width * (powerUsedPercent * 0.01), gpuPowerCanvas.height);
                  ctx.fill();

                  // 0 to currentValue
                  ctx.beginPath();
                  ctx.fillStyle = currColor;
                  ctx.fillRect(0, 0, gpuPowerCanvas.width * (powerUsedPercent * 0.01), gpuPowerCanvas.height);
                  ctx.fill();

                  ctx.restore();
                }
                Text {
                  font.pixelSize: 12
                  color: gpuPowerCanvas.currColor
                  anchors.centerIn: parent
                  text: `${gpuPowerCanvas.powerUsed}W`
                }
              }
              Canvas {
                id: gpuMemoryCanvas
                width: parent.width
                height: 6
                antialiasing: true

                property color sub30: Config.colors.green600
                property color sub60: Config.colors.yellow700
                property color past61: Config.colors.red800

                property real memoryUsed: root.gpuMemory.split("/")[0]
                property real memoryTotal: root.gpuMemory.split("/")[1]?.slice(0, -2) || 0
                property real memoryUsedPercent: memoryTotal !== 0 ? ((memoryUsed / memoryTotal) * 100).toFixed(1) : 0

                property color currColor: memoryUsedPercent <= 30 ? sub30 : memoryUsedPercent <= 60 ? sub60 : past61

                property real minimumValue: 0
                property real maximumValue: 100
                property real currentValue: memoryUsedPercent

                onSub30Changed: requestPaint()
                onSub60Changed: requestPaint()
                onPast61Changed: requestPaint()
                onMinimumValueChanged: requestPaint()
                onMaximumValueChanged: requestPaint()
                onCurrentValueChanged: requestPaint()

                onPaint: {
                  let ctx = getContext("2d");
                  ctx.save();
                  ctx.clearRect(0, 0, gpuMemoryCanvas.width, gpuMemoryCanvas.height);

                  // currentValue to 100
                  ctx.beginPath();
                  ctx.fillStyle = Config.colors.neutral;
                  ctx.fillRect(gpuMemoryCanvas.width * (memoryUsedPercent * 0.01), 0, gpuMemoryCanvas.width - gpuMemoryCanvas.width * (memoryUsedPercent * 0.01), gpuMemoryCanvas.height);
                  ctx.fill();

                  // 0 to currentValue
                  ctx.beginPath();
                  ctx.fillStyle = currColor;
                  ctx.fillRect(0, 0, gpuMemoryCanvas.width * (memoryUsedPercent * 0.01), gpuMemoryCanvas.height);
                  ctx.fill();

                  ctx.restore();
                }
                Text {
                  font.pixelSize: 12
                  color: gpuMemoryCanvas.currColor
                  anchors.centerIn: parent
                  text: `${(gpuMemoryCanvas.memoryUsed / 1000).toFixed(2)}G`
                }
              }
            }
          }
        }
      }
      Rectangle {
        id: memRect
        implicitHeight: 40
        implicitWidth: parent.implicitWidth
        color: Qt.alpha(Config.colors.neutral, 0.3)
        radius: Config.sizes.mainRadius
        Row {
          id: memRow
          spacing: 6
          Text {
            id: ramText
            antialiasing: true
            font.pixelSize: 18
            font.letterSpacing: 1
            color: Qt.alpha(Config.colors.fontcolor, 0.3)
            text: `${root.usedRAM}/${root.totalRAM}G`
          }
          Text {
            id: swapText
            antialiasing: true
            font.pixelSize: 18
            font.letterSpacing: 1
            color: Qt.alpha(Config.colors.fontcolor, 0.3)
            text: "amogus"
          }
        }
      }
      Rectangle {
        id: diskRect
        implicitHeight: 40
        implicitWidth: parent.implicitWidth
        color: Qt.alpha(Config.colors.neutral, 0.3)
        radius: Config.sizes.mainRadius
        Row {
          id: diskRow
          spacing: 6
          Text {
            id: diskText
            antialiasing: true
            font.pixelSize: 18
            font.letterSpacing: 1
            color: Qt.alpha(Config.colors.fontcolor, 0.3)
            text: "amogus"
          }
        }
      }
    }
  }
}
