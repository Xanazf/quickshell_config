import QtQuick
import "root:/"

Rectangle {
  id: root;
  property int wWidth;
  required property int wX;
  property bool hovered: false;

	//color: "#9094e2d5"
  height: 3
  opacity: hovered ? 1 : 0
  width: wWidth ?? 250
  x: wX
  y: 29
  gradient: Gradient {
    orientation: Gradient.Horizontal
    GradientStop { position: 0.0; color: "#0094e2d5" }
    GradientStop { position: 0.5; color: "#af94e2d5" }
    GradientStop { position: 1.0; color: "#0094e2d5" }
  }

  Behavior on x {
    SmoothedAnimation {
      velocity: 900
    }
  }
  Behavior on opacity {
    SmoothedAnimation {
      velocity: 1
    }
  }
  Behavior on width {
    SmoothedAnimation {
      velocity: 300
    }
  }
}
