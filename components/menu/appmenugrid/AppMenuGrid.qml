import QtQuick
import QtQuick.Layouts

import "root:/"

GridLayout {
  id: root
  anchors.centerIn: parent
  columns: 5
  rows: 4
  columnSpacing: 12
  rowSpacing: 12
  implicitHeight: ((children.length - 1) * 150) + (children.length * 12) + 40
  implicitWidth: 100 * children.length + children.length * 12

  UserArtItem {
    Layout.horizontalStretchFactor: 0
    Layout.fillWidth: true
    Layout.preferredHeight: 150
    Layout.maximumWidth: root.implicitWidth / 4
    Layout.columnSpan: 1
    Layout.column: 1
    Layout.row: 1
  }
  UserSessionItem {
    Layout.horizontalStretchFactor: 2
    Layout.fillWidth: true
    Layout.preferredHeight: 150
    Layout.preferredWidth: 200
    Layout.maximumWidth: root.implicitWidth - root.implicitWidth / 4
    Layout.columnSpan: 3
    Layout.column: 2
    Layout.row: 1
  }
  DesktopAppsItem {
    Layout.preferredHeight: 150
    Layout.preferredWidth: root.implicitWidth
    Layout.columnSpan: 4
    Layout.column: 1
    Layout.row: 2
  }
  WeatherItem {
    Layout.horizontalStretchFactor: 2
    Layout.fillWidth: true
    Layout.preferredHeight: 150
    Layout.preferredWidth: 200
    Layout.maximumWidth: root.implicitWidth - root.implicitWidth / 4
    Layout.columnSpan: 3
    Layout.column: 1
    Layout.row: 3
  }
  CommonWidgets {
    Layout.horizontalStretchFactor: 0
    Layout.fillWidth: true
    Layout.preferredWidth: root.implicitWidth / 4
    Layout.preferredHeight: 150
    Layout.columnSpan: 1
    Layout.column: 4
    Layout.row: 3
  }
  SystemTrayItem {
    Layout.alignment: Qt.AlignHCenter
    Layout.preferredHeight: 40
    Layout.preferredWidth: root.implicitWidth - root.implicitWidth / 4
    Layout.columnSpan: 4
    Layout.column: 1
    Layout.row: 4
  }
}
