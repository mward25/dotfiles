import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
  id: root
  property string iconName: 'system-shutdown'
  property color iconColor: Theme.red
  property var cmd: ["notify-send", "\"please fill out cmd!\""]

  signal activated(var command)
  
  icon.name: root.iconName
  icon.color: iconColor
  icon.width: 48
  icon.height: 48

  palette.button: Theme.mantle

  Layout.fillWidth: true
  Layout.fillHeight: true
  //// Process runner
  Process {
    id: proc
    running: false
    command: root.cmd
  }
  onClicked: {
    //proc.startDetached()
    root.activated(root.cmd)
  }
}
