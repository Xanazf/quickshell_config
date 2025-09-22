import QtQuick
import Quickshell.Widgets

import qs.config
import qs.state
import qs.helpers.io
import qs.assets.svg.qml
import "../../shared/decorations/"
import "../../shared/templates/"

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

  property real totalSwap: SystemSessionIO.totalSwap ?? 83.1
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
  color: Qt.alpha(StateMachine.colors.emphasis1, 0.1)
  radius: StateMachine.sizes.radius

  BorderSubtle {
    gradientColor1: StateMachine.colors.emphasis1
    gradientColor2: StateMachine.colors.green600
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
      color: StateMachine.colors.emphasis3
      text: `${StateMachine.username}@${root.host}`
    }
    Text {
      id: uptime
      antialiasing: true
      font.pixelSize: 18
      font.letterSpacing: 1
      color: StateMachine.colors.yellow600
      leftPadding: 5
      text: root.uptime.slice(0, root.uptime.lastIndexOf(","))
    }
    Text {
      id: distroText
      width: text.length
      antialiasing: true
      font.pixelSize: 18
      font.letterSpacing: 1
      color: StateMachine.colors.emphasis2
      text: StateMachine.distro
      Text {
        id: kernelText
        width: text.length
        anchors.top: distroText.bottom
        anchors.right: distroText.right
        antialiasing: true
        font.pixelSize: 16
        font.letterSpacing: 1
        color: Qt.alpha(StateMachine.colors.text, 0.3)
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
          CircularProgress {
            id: cpuCanvas
            parentContainer: puRect
            usedValue: root.usedCPU
            totalValue: 100

            sub30Color: Config.colors.green600
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
                  width: parent.width * (parent.utilNum * 0.01) ?? 22
                  x: 0
                  color: parent.currColor
                }
                Text {
                  antialiasing: true
                  font.pixelSize: 12
                  color: gpuUtilCanvas.currColor
                  anchors.verticalCenter: parent.verticalCenter
                  x: {
                    let result = gpuUtilFilled.width >= (parent.width / 2) ? gpuUtilFilled.width + 3 : parent.width / 2;
                    return result;
                  }
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
        WrapperRectangle {
          radius: memRect.radius
          color: "#20000000"
          margin: 3
          Column {
            spacing: 3
            Text {
              font.pixelSize: ramCanvas.implicitWidth / 4
              antialiasing: true
              color: Qt.lighter(ramCanvas.solidColor, 1.25)
              text: ramCanvas.customText
            }
            Text {
              font.pixelSize: swapCanvas.implicitWidth / 4
              antialiasing: true
              color: Qt.lighter(swapCanvas.solidColor, 1.25)
              text: swapCanvas.customText
            }
          }
        }
        Row {
          id: memRow
          spacing: 15
          anchors.horizontalCenter: parent.horizontalCenter
          CircularProgress {
            id: ramCanvas
            parentContainer: memRect
            usedValue: root.usedRAM
            totalValue: root.totalRAM

            useSolidColor: true
            solidColor: Config.colors.mainColor4

            alignTextLeft: true
            customText: `${root.usedRAM}/${root.totalRAM.toFixed(0) - 1}G`
            showText: false

            icon: RAMFilled {
              implicitWidth: 18
              implicitHeight: 18
              anchors.centerIn: parent
              currentColor: ramCanvas.solidColor
            }
          }
          CircularProgress {
            id: swapCanvas
            parentContainer: memRect
            usedValue: root.usedSwap
            totalValue: root.totalSwap

            useSolidColor: true
            solidColor: Config.colors.navy600

            alignTextRight: true
            customText: `${root.usedSwap}/${root.totalSwap.toFixed(0)}G`
            showText: false

            icon: RAMOutline {
              implicitWidth: 18
              implicitHeight: 18
              anchors.centerIn: parent
              currentColor: swapCanvas.solidColor
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
          CircularProgress {
            id: diskSdaCanvas
            parentContainer: diskRect
            usedValue: root.sdaUsed
            totalValue: root.sdaTotal

            useSolidColor: true
            solidColor: Config.colors.navy600

            customText: "/"
          }
          CircularProgress {
            id: diskSdbCanvas
            parentContainer: diskRect
            usedValue: root.sdbUsed
            totalValue: root.sdbTotal

            useSolidColor: true
            solidColor: Config.colors.mainColor3

            customText: "/sdb"
            showText: false
            icon: SSDOutline {
              id: diskSdbIcon
              implicitWidth: 18
              implicitHeight: 18
              anchors.centerIn: parent
              currentColor: Qt.lighter(diskSdbCanvas.solidColor, 1.25)
            }
          }
          CircularProgress {
            id: diskSdcCanvas
            parentContainer: diskRect
            usedValue: root.sdcUsed
            totalValue: root.sdcTotal

            useSolidColor: true
            solidColor: Config.colors.mainColor4

            customText: "/sdc"
            showText: false
            icon: SSDFilled {
              id: diskSdcIcon
              implicitWidth: 18
              implicitHeight: 18
              anchors.centerIn: parent
              currentColor: Qt.lighter(diskSdcCanvas.solidColor, 1.25)
            }
          }
        }
      }
    }
  }
}
