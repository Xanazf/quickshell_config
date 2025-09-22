import QtQuick
import Quickshell.Widgets

import qs.config

ClippingRectangle {
  id: root
  required property Item parentContainer
  required property real totalValue
  property bool usedIsPercent: totalValue === 100
  required property real usedValue
  property bool useSolidColor: false
  property color solidColor
  property color sub30Color
  property color sub60Color
  property color past61Color
  property Item icon
  property bool showText: true
  property bool alignTextRight
  property bool alignTextLeft
  property string customText
  implicitHeight: parentContainer.implicitHeight
  implicitWidth: parentContainer.implicitWidth * 0.20
  color: "transparent"
  antialiasing: true
  Canvas {
    id: rootCanvas
    anchors.centerIn: parent
    width: parent.implicitWidth > 10 ? parent.implicitWidth : 30
    height: parent.implicitWidth > 10 ? parent.implicitHeight : 30
    antialiasing: true

    property real usedValuePercent: {
      if (root.usedValue === 0) {
        return 0;
      }
      if (!root.usedIsPercent) {
        return (root.usedValue / root.totalValue) * 100;
      }
      return root.usedValue;
    }

    property color sub30: root.sub30Color || Config.colors.navy600
    property color sub60: root.sub60Color || Config.colors.yellow700
    property color past61: root.past61Color || Config.colors.red800

    property color changingColor: usedValuePercent <= 30 ? sub30 : usedValuePercent <= 60 ? sub60 : past61

    property color currColor: root.useSolidColor ? root.solidColor : changingColor

    property real centerWidth: width / 2
    property real centerHeight: height / 2
    property real radius: Math.min(rootCanvas.width - (rootCanvas.width * 0.10), rootCanvas.height - (rootCanvas.height * 0.10)) / 2

    property real minimumValue: 0
    property real maximumValue: 100
    property real currentValue: usedValuePercent

    property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI
    property real angleOffset: -Math.PI / 2

    property string text: root.usedValue

    onSub30Changed: requestPaint()
    onSub60Changed: requestPaint()
    onPast61Changed: requestPaint()
    onMinimumValueChanged: requestPaint()
    onMaximumValueChanged: requestPaint()
    onCurrentValueChanged: requestPaint()

    onPaint: {
      let ctx = getContext("2d");
      ctx.reset();

      ctx.clearRect(0, 0, rootCanvas.width - (rootCanvas.width * 0.10), rootCanvas.height - (rootCanvas.height * 0.10));

      // angle to 2*PI
      ctx.beginPath();
      ctx.lineWidth = 1;
      ctx.strokeStyle = Config.colors.neutral;
      ctx.arc(rootCanvas.centerWidth, rootCanvas.centerHeight, rootCanvas.radius, angleOffset + rootCanvas.angle, angleOffset + 2 * Math.PI);
      ctx.stroke();

      // 0 to angle
      ctx.beginPath();
      ctx.lineWidth = 3;
      ctx.strokeStyle = currColor;
      ctx.arc(rootCanvas.centerWidth, rootCanvas.centerHeight, rootCanvas.radius, rootCanvas.angleOffset, rootCanvas.angleOffset + rootCanvas.angle);
      ctx.stroke();
    }
    WrapperItem {
      id: diskSdaIcon
      visible: root.icon !== undefined
      child: root.icon
      implicitWidth: parent.width / 3
      implicitHeight: parent.width / 3
      anchors.centerIn: parent
    }
    Text {
      visible: root.showText
      font.pixelSize: parent.width / 3
      antialiasing: true
      anchors.centerIn: root.icon === null ? parent : undefined
      anchors.right: !root.alignTextRight && root.alignTextLeft ? parent.left : undefined
      anchors.left: root.alignTextRight && !root.alignTextLeft ? parent.right : undefined
      anchors.verticalCenter: root.alignTextRight || root.alignTextLeft ? parent.verticalCenter : undefined
      color: Qt.lighter(parent.currColor, 1.25)
      text: root.customText || rootCanvas.text
    }
  }
}
