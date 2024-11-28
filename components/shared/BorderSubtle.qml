import QtQuick

Rectangle {
  id: root
  property color gradientColor1
  property color gradientColor2
  property bool orientVertical: false
  property bool orientRight: orientVertical === true || false
  property int numOfBorders: 2
  anchors.left: orientRight ? undefined : parent.left
  anchors.right: orientRight ? parent.right : undefined
  anchors.verticalCenter: orientRight ? undefined : parent.verticalCenter
  anchors.horizontalCenter: orientVertical ? parent.horizontalCenter : undefined
  anchors.bottom: orientRight ? parent.bottom : undefined
  height: orientVertical ? 1 : parent.height - (parent.height / 4)
  width: orientVertical ? parent.width - (parent.width / 4) : 1
  radius: parent.radius ? parent.radius : 0
  gradient: Gradient {
    orientation: root.orientVertical ? Gradient.Horizontal : Gradient.Vertical
    GradientStop {
      position: 0.0
      color: "transparent"
    }
    GradientStop {
      position: 0.25
      color: root.gradientColor1
    }
    GradientStop {
      position: 0.5
      color: root.numOfBorders > 1 ? "transparent" : root.gradientColor2
    }
    GradientStop {
      position: 0.75
      color: root.numOfBorders > 1 ? root.gradientColor2 : root.gradientColor1
    }
    GradientStop {
      position: 1.0
      color: "transparent"
    }
  }
}
