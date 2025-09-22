import QtQuick
import Quickshell
import Quickshell.Widgets

import qs.config
import qs.state
import qs.helpers.io

ClippingWrapperRectangle {
  id: root
  color: Qt.alpha(StateMachine.colors.emphasis3, 0.1)
  radius: StateMachine.sizes.radius
  property ObjectModel appItems: DesktopIO.apps
  property list<QtObject> filteredItems
  resizeChild: true
  margin: 10
  implicitWidth: parent.implicitWidth
  function filterApps(filterValue, filterArray) {
    Logger.log("HELLO?????");
    return filterArray.values.filter(item => item.name.toLowerCase().indexOf(filterValue) !== -1);
  }
  Keys.onPressed: event => {
    if (event.key === Qt.Key_Escape && StateMachine.drawerOpen) {
      StateMachine.drawerOpen = !StateMachine.drawerOpen;
    }
  }
  child: Rectangle {
    id: flickWrapper
    //resizeChild: true
    color: "transparent"
    radius: root.radius
    implicitWidth: root.implicitWidth
    implicitHeight: 130
    WrapperRectangle {
      id: inputWrapper
      anchors.top: parent.top
      radius: root.radius
      width: parent.implicitWidth - 20
      height: 40
      color: Qt.alpha(StateMachine.colors.neutral, 0.1)
      margin: 6
      MouseArea {
        cursorShape: Qt.IBeamCursor
        anchors.fill: parent
        TextInput {
          id: searchInput
          focus: StateMachine.drawerOpen
          onDisplayTextChanged: {
            root.filteredItems = root.filterApps(displayText, root.appItems);
          }
          onAccepted: {
            root.filteredItems[0].execute();
            if (StateMachine.drawerOpen === true)
              StateMachine.drawerOpen = !StateMachine.drawerOpen;
          }
          Keys.onPressed: event => {
            switch (event.key) {
            case Qt.Key_Tab:
              {
                searchInput.focus = false;
                desktopEntriesGrid.focus = true;
                desktopEntriesGrid.interactive = true;
                break;
              }
            }
          }
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          anchors.leftMargin: 6
          width: parent.width
          color: StateMachine.colors.text
          font.pixelSize: 21
          font.letterSpacing: 1
        }
      }
    }
    Rectangle {
      anchors.top: inputWrapper.bottom
      anchors.topMargin: 8
      color: "transparent"
      implicitHeight: flickWrapper.implicitHeight
      implicitWidth: flickWrapper.implicitWidth
      GridView {
        id: desktopEntriesGrid
        clip: true
        implicitHeight: flickWrapper.implicitHeight - 46
        implicitWidth: flickWrapper.implicitWidth
        model: {
          if (root.filteredItems.length > 0 || searchInput.displayText.length > 0) {
            return root.filteredItems;
          }
          return root.appItems;
        }
        cellHeight: 43
        cellWidth: implicitWidth / 4
        Keys.onPressed: event => {
          switch (event.key) {
          case Qt.Key_H:
            {
              desktopEntriesGrid.moveCurrentIndexLeft();
              break;
            }
          case Qt.Key_L:
            {
              desktopEntriesGrid.moveCurrentIndexRight();
              break;
            }
          case Qt.Key_J:
            {
              desktopEntriesGrid.moveCurrentIndexDown();
              break;
            }
          case Qt.Key_K:
            {
              desktopEntriesGrid.moveCurrentIndexUp();
              break;
            }
          case Qt.Key_Return:
            {
              if (focus & interactive) {
                model[currentIndex].execute();
                StateMachine.drawerOpen = !StateMachine.drawerOpen;
              }
              break;
            }
          case Qt.Key_B:
            {
              desktopEntriesGrid.interactive = false;
              desktopEntriesGrid.focus = false;
              searchInput.focus = true;
              break;
            }
          case Qt.Key_Tab:
            {
              desktopEntriesGrid.interactive = false;
              desktopEntriesGrid.focus = false;
              searchInput.focus = true;
              break;
            }
          }
        }
        add: Transition {
          NumberAnimation {
            properties: "x,y"
            duration: 100
          }
          NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 100
          }
        }
        populate: Transition {
          NumberAnimation {
            properties: "x,y"
            duration: 100
          }
          NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 100
          }
        }
        displaced: Transition {
          NumberAnimation {
            properties: "x,y"
            duration: 300
          }
          NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 300
          }
        }
        move: Transition {
          NumberAnimation {
            properties: "x,y"
            duration: 300
          }
        }
        highlight: Rectangle {
          color: Qt.alpha("white", 0.1)
          radius: Config.sizes.mainRadius
          Behavior on x {
            SpringAnimation {
              spring: 3
              damping: 0.2
            }
          }
          Behavior on y {
            SpringAnimation {
              spring: 3
              damping: 0.2
            }
          }
        }

        Keys.onEnterPressed: {}
        delegate: Rectangle {
          id: modelRect
          required property QtObject modelData
          required property int index
          implicitHeight: 40
          implicitWidth: root.implicitWidth / 4 - 25
          radius: StateMachine.sizes.radius
          color: Qt.alpha("white", 0.1)

          ClippingRectangle {
            id: icon
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: 40
            width: 40
            color: "transparent"
            IconImage {
              width: 26
              height: 26
              anchors.centerIn: parent

              source: Quickshell.iconPath(modelRect.modelData.icon, true) || "root:/assets/svg/skull-outline.svg"
            }
          }
          Text {
            anchors.left: icon.right
            height: parent.height
            width: modelRect.width - 40
            elide: Text.ElideRight
            color: Config.colors.fontcolor
            verticalAlignment: Text.AlignVCenter
            text: modelRect.modelData.name
          }
          MouseArea {
            id: itemMouseArea
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onEntered: {
              desktopEntriesGrid.currentIndex = modelRect.index;
            }
            onExited: {
              modelRect.color = Qt.alpha("white", 0.1);
            }
            onClicked: mouse => {
              if (mouse.button === Qt.LeftButton) {
                modelRect.QsWindow.window.setShow = false;
                modelRect.modelData.execute();
              }
            }
          }
          Behavior on color {
            ColorAnimation {
              duration: 200
            }
          }
        }
      }
    }
  }
}
