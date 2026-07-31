import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts // for Text

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30

  RowLayout {
    Text {
      // center the bar in its parent component (the window)
      //anchors.centerIn: parent

      text: "Hello World"
    }
    Text {
      // center the bar in its parent component (the window)
      //anchors.centerIn: parent
      color: "purple"
      text: "Potato"
    }
  }
}
