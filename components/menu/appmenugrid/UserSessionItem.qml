import QtQuick
import Quickshell.Widgets

import "root:/"
import "root:/io"
import "root:/svg/qml"
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
  property real usedRAM: SystemSessionIO.usedRAM.toFixed(1)

  property real totalSwap: SystemSessionIO.totalSwap
  property real usedSwap: SystemSessionIO.usedSwap.toFixed(1)

  // -- CPU
  property real usedCPU: SystemSessionIO.usedCPU

  // -- GPU
  property string gpuTemp: SystemSessionIO.gpuTemp
  property string gpuUtil: SystemSessionIO.gpuUtilization
  property string gpuPower: SystemSessionIO.gpuPower
  property string gpuMemory: SystemSessionIO.gpuMemory

  // -- Disk
  property real sdaUsed: SystemSessionIO.sdaUsed
  property real sdbUsed: SystemSessionIO.sdbUsed
  property real sdcUsed: SystemSessionIO.sdcUsed
  property real sdaTotal: SystemSessionIO.sdaTotal
  property real sdbTotal: SystemSessionIO.sdbTotal
  property real sdcTotal: SystemSessionIO.sdcTotal

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
              width: parent.implicitWidth
              height: parent.implicitHeight
              antialiasing: true

              property color sub30: Config.colors.green600
              property color sub60: Config.colors.yellow700
              property color past61: Config.colors.red800

              property color currColor: root.usedCPU <= 30 ? sub30 : root.usedCPU <= 60 ? sub60 : past61

              property real centerWidth: width / 2
              property real centerHeight: height / 2
              property real radius: Math.min(cpuCanvas.width - 10, cpuCanvas.height - 10) / 2

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

                ctx.clearRect(0, 0, cpuCanvas.width - 10, cpuCanvas.height - 10);

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
              Rectangle {
                id: gpuUtilCanvas
                width: parent.width
                height: 6
                antialiasing: true
                color: Config.colors.neutral

                property real utilNum: root.gpuUtil.slice(0, -1)

                property color sub30: Config.colors.green600
                property color sub60: Config.colors.yellow700
                property color past61: Config.colors.red800

                property color currColor: utilNum <= 30 ? sub30 : utilNum <= 60 ? sub60 : past61

                property real minimumValue: 0
                property real maximumValue: 100
                property real currentValue: utilNum

                ClippingRectangle {
                  id: gpuUtilFilled
                  anchors.verticalCenter: parent.verticalCenter
                  height: parent.height
                  width: parent.width * (parent.utilNum * 0.01)
                  x: 0
                  color: parent.currColor
                }
                Text {
                  antialiasing: true
                  font.pixelSize: 12
                  color: gpuUtilCanvas.currColor
                  anchors.verticalCenter: parent.verticalCenter
                  x: gpuUtilFilled.width >= (parent.width / 2) ? gpuUtilFilled.width + 3 : parent.width / 2
                  text: `${gpuUtilCanvas.utilNum}%`
                }
              }
              Rectangle {
                id: gpuPowerCanvas
                width: parent.width - (gpuPowerTotalText.implicitWidth + 3)
                height: 6
                antialiasing: true
                color: Config.colors.neutral

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

                ClippingRectangle {
                  id: gpuPowerFilled
                  anchors.verticalCenter: parent.verticalCenter
                  height: parent.height
                  width: parent.width * (parent.powerUsedPercent * 0.01)
                  x: 0
                  color: parent.currColor
                }

                Text {
                  id: gpuPowerUsedText
                  antialiasing: true
                  font.pixelSize: 12
                  color: gpuPowerCanvas.currColor
                  anchors.verticalCenter: parent.verticalCenter
                  x: gpuPowerFilled.width > (parent.width * 0.8) ? 0 : gpuPowerFilled.width + 3
                  text: `${gpuPowerCanvas.powerUsed}W`
                }
                Text {
                  id: gpuPowerTotalText
                  antialiasing: true
                  font.pixelSize: 12
                  color: gpuPowerCanvas.currColor
                  anchors.left: parent.right
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.leftMargin: 3
                  text: `${gpuPowerCanvas.powerTotal}W`
                }
              }
              Rectangle {
                id: gpuMemoryCanvas
                width: parent.width - (gpuMemoryTotalText.implicitWidth + 3)
                height: 6
                antialiasing: true
                color: Config.colors.neutral

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

                ClippingRectangle {
                  id: gpuMemoryFilled
                  anchors.verticalCenter: parent.verticalCenter
                  height: parent.height
                  width: parent.width * (parent.memoryUsedPercent * 0.01)
                  x: 0
                  color: parent.currColor
                }

                Text {
                  id: gpuMemoryCurrentText
                  antialiasing: true
                  font.pixelSize: 12
                  color: gpuMemoryCanvas.currColor
                  anchors.verticalCenter: parent.verticalCenter
                  x: gpuMemoryFilled.width > (parent.width * 0.8) ? 0 : gpuMemoryFilled.width + 3
                  text: `${(gpuMemoryCanvas.memoryUsed / 1000).toFixed(1)}G`
                }
                Text {
                  id: gpuMemoryTotalText
                  antialiasing: true
                  font.pixelSize: 12
                  color: gpuMemoryCanvas.currColor
                  anchors.left: parent.right
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.leftMargin: 3
                  text: `${(gpuMemoryCanvas.memoryTotal / 1000).toFixed(0)}G`
                }
              }
            }
          }
        }
      }
      Rectangle {
        id: memRect
        //anchors.left: parent.left
        //anchors.leftMargin: (parent.implicitWidth - memRow.implicitWidth) / 2
        implicitHeight: 40
        implicitWidth: parent.implicitWidth
        color: Qt.alpha(Config.colors.neutral, 0.3)
        radius: Config.sizes.mainRadius
        Row {
          id: memRow
          spacing: 36
          anchors.horizontalCenter: parent.horizontalCenter
          Rectangle {
            id: ramWrap
            //anchors.left: memRect.left
            //anchors.leftMargin: ramText.width - 12
            implicitWidth: memRect.implicitWidth * 0.20
            implicitHeight: memRect.implicitHeight
            color: "transparent"
            Canvas {
              id: ramCanvas
              anchors.centerIn: parent
              width: parent.implicitWidth > 10 ? parent.implicitWidth : 30
              height: parent.implicitWidth > 10 ? parent.implicitHeight : 30
              antialiasing: true

              property real usedRAMPercent: (root.usedRAM / root.totalRAM) * 100

              property color sub30: Config.colors.navy600
              property color sub60: Config.colors.yellow700
              property color past61: Config.colors.red800

              property color currColor: Config.colors.mainColor4

              //usedRAMPercent <= 30 ? sub30 : usedRAMPercent <= 60 ? sub60 : past61

              property real centerWidth: width / 2
              property real centerHeight: height / 2
              property real radius: Math.min(ramCanvas.width - 10, ramCanvas.height - 10) / 2

              property real minimumValue: 0
              property real maximumValue: 100
              property real currentValue: usedRAMPercent

              property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI
              property real angleOffset: -Math.PI / 2

              property string text: root.usedRAM

              onSub30Changed: requestPaint()
              onSub60Changed: requestPaint()
              onPast61Changed: requestPaint()
              onMinimumValueChanged: requestPaint()
              onMaximumValueChanged: requestPaint()
              onCurrentValueChanged: requestPaint()

              onPaint: {
                let ctx = getContext("2d");
                ctx.save();

                ctx.clearRect(0, 0, ramCanvas.width - 10, ramCanvas.height - 10);

                // angle to 2*PI
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.strokeStyle = Config.colors.neutral;
                ctx.arc(ramCanvas.centerWidth, ramCanvas.centerHeight, ramCanvas.radius, angleOffset + ramCanvas.angle, angleOffset + 2 * Math.PI);
                ctx.stroke();

                // 0 to angle
                ctx.beginPath();
                ctx.lineWidth = 3;
                ctx.strokeStyle = currColor;
                ctx.arc(ramCanvas.centerWidth, ramCanvas.centerHeight, ramCanvas.radius, ramCanvas.angleOffset, ramCanvas.angleOffset + ramCanvas.angle);
                ctx.stroke();

                ctx.restore();
              }
              Text {
                id: ramText
                antialiasing: true
                anchors.left: parent.right
                font.pixelSize: 9
                font.letterSpacing: 1
                color: parent.currColor
                text: `${root.usedRAM}/${root.totalRAM.toFixed(0) - 1}G`
              }
              RAMFilled {
                implicitWidth: 18
                implicitHeight: 18
                anchors.centerIn: parent
                currentColor: parent.currColor
              }
            }
          }
          Rectangle {
            id: swapWrap
            //anchors.left: ramWrap.right
            //anchors.leftMargin: ramText.width + 3
            implicitWidth: memRect.implicitWidth * 0.20
            implicitHeight: memRect.implicitHeight
            color: "transparent"
            Canvas {
              id: swapCanvas
              anchors.centerIn: parent
              width: parent.implicitWidth
              height: parent.implicitHeight
              antialiasing: true

              property real usedSwapPercent: root.usedSwap !== 0 ? (root.usedSwap / root.totalSwap) * 100 : 0

              property color sub30: Config.colors.navy600
              property color sub60: Config.colors.yellow700
              property color past61: Config.colors.red800

              property color currColor: sub30

              //usedRAMPercent <= 30 ? sub30 : usedRAMPercent <= 60 ? sub60 : past61

              property real centerWidth: width / 2
              property real centerHeight: height / 2
              property real radius: Math.min(swapCanvas.width - 10, swapCanvas.height - 10) / 2

              property real minimumValue: 0
              property real maximumValue: 100
              property real currentValue: usedSwapPercent

              property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI
              property real angleOffset: -Math.PI / 2

              property string text: root.usedSwap

              onSub30Changed: requestPaint()
              onSub60Changed: requestPaint()
              onPast61Changed: requestPaint()
              onMinimumValueChanged: requestPaint()
              onMaximumValueChanged: requestPaint()
              onCurrentValueChanged: requestPaint()

              onPaint: {
                let ctx = getContext("2d");
                ctx.save();

                ctx.clearRect(0, 0, swapCanvas.width - 10, swapCanvas.height - 10);

                // angle to 2*PI
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.strokeStyle = Config.colors.neutral;
                ctx.arc(swapCanvas.centerWidth, swapCanvas.centerHeight, swapCanvas.radius, angleOffset + swapCanvas.angle, angleOffset + 2 * Math.PI);
                ctx.stroke();

                // 0 to angle
                ctx.beginPath();
                ctx.lineWidth = 3;
                ctx.strokeStyle = currColor;
                ctx.arc(swapCanvas.centerWidth, swapCanvas.centerHeight, swapCanvas.radius, swapCanvas.angleOffset, swapCanvas.angleOffset + swapCanvas.angle);
                ctx.stroke();

                ctx.restore();
              }
              Text {
                id: swapText
                antialiasing: true
                anchors.left: parent.right
                font.pixelSize: 9
                font.letterSpacing: 1
                color: parent.currColor
                text: `${root.usedSwap}/${root.totalSwap.toFixed(0)}G`
              }
              RAMOutline {
                implicitWidth: 18
                implicitHeight: 18
                anchors.centerIn: parent
                currentColor: parent.currColor
              }
            }
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
          anchors.horizontalCenter: parent.horizontalCenter
          Rectangle {
            id: diskSdaWrap
            implicitHeight: diskRect.implicitHeight
            implicitWidth: diskRect.implicitWidth * 0.20
            color: "transparent"
            Canvas {
              id: diskSdaCanvas
              anchors.centerIn: parent
              width: parent.implicitWidth > 10 ? parent.implicitWidth : 30
              height: parent.implicitWidth > 10 ? parent.implicitHeight : 30
              antialiasing: true

              property real usedDiskPercent: root.sdaUsed !== 0 ? (root.sdaUsed / root.sdaTotal) * 100 : 0

              property color sub30: Config.colors.navy600
              property color sub60: Config.colors.yellow700
              property color past61: Config.colors.red800

              property color currColor: sub60

              //usedRAMPercent <= 30 ? sub30 : usedRAMPercent <= 60 ? sub60 : past61

              property real centerWidth: width / 2
              property real centerHeight: height / 2
              property real radius: Math.min(diskSdaCanvas.width - 10, diskSdaCanvas.height - 10) / 2

              property real minimumValue: 0
              property real maximumValue: 100
              property real currentValue: usedDiskPercent

              property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI
              property real angleOffset: -Math.PI / 2

              property string text: root.sdaUsed

              onSub30Changed: requestPaint()
              onSub60Changed: requestPaint()
              onPast61Changed: requestPaint()
              onMinimumValueChanged: requestPaint()
              onMaximumValueChanged: requestPaint()
              onCurrentValueChanged: requestPaint()

              onPaint: {
                let ctx = getContext("2d");
                ctx.save();

                ctx.clearRect(0, 0, diskSdaCanvas.width - 10, diskSdaCanvas.height - 10);

                // angle to 2*PI
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.strokeStyle = Config.colors.neutral;
                ctx.arc(diskSdaCanvas.centerWidth, diskSdaCanvas.centerHeight, diskSdaCanvas.radius, angleOffset + diskSdaCanvas.angle, angleOffset + 2 * Math.PI);
                ctx.stroke();

                // 0 to angle
                ctx.beginPath();
                ctx.lineWidth = 3;
                ctx.strokeStyle = currColor;
                ctx.arc(diskSdaCanvas.centerWidth, diskSdaCanvas.centerHeight, diskSdaCanvas.radius, diskSdaCanvas.angleOffset, diskSdaCanvas.angleOffset + diskSdaCanvas.angle);
                ctx.stroke();

                ctx.restore();
              }
              SSDFilled {
                id: diskSdaIcon
                visible: false
                implicitWidth: 12
                implicitHeight: 12
                //anchors.horizontalCenter: parent.horizontalCenter
                //anchors.top: parent.top
                //anchors.topMargin: 5
                anchors.centerIn: parent
                currentColor: Qt.lighter(parent.currColor, 1.25)
              }
              Text {
                font.pixelSize: 12
                antialiasing: true
                anchors.centerIn: parent
                //anchors.top: diskSdaIcon.bottom
                //anchors.horizontalCenter: parent.horizontalCenter
                color: Qt.lighter(parent.currColor, 1.25)
                text: "/"
              }
            }
          }
          Rectangle {
            id: diskSdbWrap
            implicitHeight: diskRect.implicitHeight
            implicitWidth: diskRect.implicitWidth * 0.20
            color: "transparent"
            Canvas {
              id: diskSdbCanvas
              anchors.centerIn: parent
              width: parent.implicitWidth
              height: parent.implicitHeight
              antialiasing: true

              property real usedDiskPercent: root.sdbUsed !== 0 ? (root.sdbUsed / root.sdbTotal) * 100 : 0

              property color sub30: Config.colors.navy600
              property color sub60: Config.colors.yellow700
              property color past61: Config.colors.red800

              property color currColor: Config.colors.mainColor3

              //usedRAMPercent <= 30 ? sub30 : usedRAMPercent <= 60 ? sub60 : past61

              property real centerWidth: width / 2
              property real centerHeight: height / 2
              property real radius: Math.min(diskSdbCanvas.width - 10, diskSdbCanvas.height - 10) / 2

              property real minimumValue: 0
              property real maximumValue: 100
              property real currentValue: usedDiskPercent

              property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI
              property real angleOffset: -Math.PI / 2

              property string text: root.sdbUsed

              onSub30Changed: requestPaint()
              onSub60Changed: requestPaint()
              onPast61Changed: requestPaint()
              onMinimumValueChanged: requestPaint()
              onMaximumValueChanged: requestPaint()
              onCurrentValueChanged: requestPaint()

              onPaint: {
                let ctx = getContext("2d");
                ctx.save();

                ctx.clearRect(0, 0, diskSdbCanvas.width - 10, diskSdbCanvas.height - 10);

                // angle to 2*PI
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.strokeStyle = Config.colors.neutral;
                ctx.arc(diskSdbCanvas.centerWidth, diskSdbCanvas.centerHeight, diskSdbCanvas.radius, angleOffset + diskSdbCanvas.angle, angleOffset + 2 * Math.PI);
                ctx.stroke();

                // 0 to angle
                ctx.beginPath();
                ctx.lineWidth = 3;
                ctx.strokeStyle = currColor;
                ctx.arc(diskSdbCanvas.centerWidth, diskSdbCanvas.centerHeight, diskSdbCanvas.radius, diskSdbCanvas.angleOffset, diskSdbCanvas.angleOffset + diskSdbCanvas.angle);
                ctx.stroke();

                ctx.restore();
              }
              SSDOutline {
                id: diskSdbIcon
                implicitWidth: 18
                implicitHeight: 18
                anchors.centerIn: parent
                currentColor: Qt.lighter(parent.currColor, 1.25)
              }
              Text {
                visible: false
                font.pixelSize: 9
                antialiasing: true
                anchors.top: diskSdbIcon.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: Qt.lighter(parent.currColor, 1.25)
                text: "/sdb"
              }
            }
          }
          Rectangle {
            id: diskSdcWrap
            implicitHeight: diskRect.implicitHeight
            implicitWidth: diskRect.implicitWidth * 0.20
            color: "transparent"
            Canvas {
              id: diskSdcCanvas
              anchors.centerIn: parent
              width: parent.implicitWidth > 10 ? parent.implicitWidth : 30
              height: parent.implicitWidth > 10 ? parent.implicitHeight : 30
              antialiasing: true

              property real usedDiskPercent: root.sdcUsed !== 0 ? (root.sdcUsed / root.sdcTotal) * 100 : 0

              property color sub30: Config.colors.navy600
              property color sub60: Config.colors.yellow700
              property color past61: Config.colors.red800

              property color currColor: Config.colors.mainColor4

              //usedRAMPercent <= 30 ? sub30 : usedRAMPercent <= 60 ? sub60 : past61

              property real centerWidth: width / 2
              property real centerHeight: height / 2
              property real radius: Math.min(diskSdcCanvas.width - 10, diskSdcCanvas.height - 10) / 2

              property real minimumValue: 0
              property real maximumValue: 100
              property real currentValue: usedDiskPercent

              property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI
              property real angleOffset: -Math.PI / 2

              property string text: root.sdcUsed

              onSub30Changed: requestPaint()
              onSub60Changed: requestPaint()
              onPast61Changed: requestPaint()
              onMinimumValueChanged: requestPaint()
              onMaximumValueChanged: requestPaint()
              onCurrentValueChanged: requestPaint()

              onPaint: {
                let ctx = getContext("2d");
                ctx.save();

                ctx.clearRect(0, 0, diskSdcCanvas.width - 10, diskSdcCanvas.height - 10);

                // angle to 2*PI
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.strokeStyle = Config.colors.neutral;
                ctx.arc(diskSdcCanvas.centerWidth, diskSdcCanvas.centerHeight, diskSdcCanvas.radius, angleOffset + diskSdcCanvas.angle, angleOffset + 2 * Math.PI);
                ctx.stroke();

                // 0 to angle
                ctx.beginPath();
                ctx.lineWidth = 3;
                ctx.strokeStyle = currColor;
                ctx.arc(diskSdcCanvas.centerWidth, diskSdcCanvas.centerHeight, diskSdcCanvas.radius, diskSdcCanvas.angleOffset, diskSdcCanvas.angleOffset + diskSdcCanvas.angle);
                ctx.stroke();

                ctx.restore();
              }
              SSDOutline {
                id: diskSdcIcon
                implicitWidth: 18
                implicitHeight: 18
                anchors.centerIn: parent
                currentColor: Qt.lighter(parent.currColor, 1.25)
              }
              Text {
                visible: false
                font.pixelSize: 9
                antialiasing: true
                anchors.top: diskSdcIcon.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: Qt.lighter(parent.currColor, 1.25)
                text: "/sdc"
              }
            }
          }
        }
      }
    }
  }
}
