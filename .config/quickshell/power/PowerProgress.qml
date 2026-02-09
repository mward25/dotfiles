import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ProgressBar {
  id: root
  Timer {
    interval: 100
    running: true
    repeat: true
    onTriggered: time.text = Date().toString()
  }
}
