//@ pragma IconTheme breeze
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import Quickshell

//import "./theme.qml" as Theme



PanelWindow {
  id: powerWindow

  implicitWidth: 400
  implicitHeight: 80

  visible: true

  color: Theme.crust

  ColumnLayout {
    RowLayout {
      id: buttonRow
      anchors.fill: parent
      Layout.fillWidth: true

      palette.base: Theme.base

      PowerButton { 
        id: powerButton
        iconName: 'system-shutdown'
        //cmd: ["shutdown", "now"]
        cmd: ["notify-send", "shutting down"]
        onActivated: confirmOverlay.startCountdown(cmd)
      }
      PowerButton {
        id: restartButton
        iconColor: Theme.green
        iconName: 'system-reboot'
        cmd: ["notify-send", "rebooting!"]
        onActivated: confirmOverlay.startCountdown(cmd)
      }
      PowerButton {
        id: hibernateButton
        iconColor: Theme.green
        iconName: 'system-hibernate'
        cmd: ["notify-send", "hibernating!"]
        onActivated: confirmOverlay.startCountdown(cmd)
      }
    }
  }

  //Rectangle {
  //  id: confirmOverlay
  //  anchors.fill: parent
  //  visible: false

  //  property var proc: null

  //  Timer {
  //    id: countdownTimer
  //    interval: 6000
  //    repeat: false
  //    running: false

  //    onTriggered: {
  //      proc.running = true
  //    }
  //  }
  //  Process {
  //    id: proc
  //    running: false
  //    command: ["notify-send", "no command given to confirmOverlay!"]
  //  }

  //  function startCountdown(cmd) {
  //    proc.command = cmd
  //    //proc.running = true
  //    confirmOverlay.visible = true
  //    countdownTimer.start()
  //  }


  //  color: Theme.base

  //  ColumnLayout {
  //    anchors.centerIn: parent

  //    Label {
  //      text: "Are You Sure?"
  //      color: Theme.text
  //      Layout.fillWidth: true
  //    }
  //    RowLayout {
  //      Layout.fillWidth: true
  //      Button {
  //        icon.name: "face-angel"
  //        icon.height: 48
  //        icon.width: 48
  //        icon.color: Theme.green
  //        palette.button: Theme.mantle
  //        onClicked: {
  //          proc.running = true
  //        }
  //      }
  //      Button {
  //        icon.name: "face-devilish"
  //        icon.height: 48
  //        icon.width: 48
  //        icon.color: Theme.red
  //        palette.button: Theme.mantle
  //        onClicked: {
  //          countdownTimer.stop()
  //          confirmOverlay.visible = false
  //        }
  //      }
  //    }
  //  }
  //}
}
