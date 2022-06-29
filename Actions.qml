
/*
  this is button
  */
import QtQuick
import QtQuick.Controls

Item {
    property alias openAction: open
    property alias folderAction: folder
    property alias exitAction: exit

    property alias fullAction: fullScreen
    property alias cataAction: catalogue

    property alias networkAction: network

    property alias aboutAction: about
    property alias contentsAction: contents

    property alias playAction: playv
    property alias pauseAction: pausev
    property alias stopAction: stopv
    property alias rateAction: ratev

    Action {
        id: open
        text: qsTr("&Addvideo...")
        icon.name: "document-open"
        shortcut: "StandardKey.Open"
    }

    Action {
        id: folder
        text: qsTr("OpenFol&der...")
        icon.name: "document-open-recent"
        shortcut: "Ctrl + d"
    }
    Action {
        id: exit
        text: qsTr("E&xit")
        icon.name: "application-exit"
        shortcut: "Ctrl + e"
    }

    Action {
        id: catalogue
        text: qsTr("Hidesho&wcata")
        shortcut: "Ctrl + w"
    }
    Action {
        id: fullScreen
        text: qsTr("&FullScreen")
        icon.name: "view-fullscreen"
        shortcut: "Ctrl + f"
        onTriggered: showFullScreen()
    }

    Action{
        id:network
        text: qsTr("&Network")
        shortcut: "Ctrl+n"
    }

    Action {
        id: contents
        text: qsTr("&Contents")
        icon.name: "help-contents"
        shortcut: "Ctrl + c"
    }

    Action {
        id: about
        text: qsTr("&About")
        icon.name: "help-about"
        shortcut: "Ctrl + a"
    }
    Action {
        id: playv
        icon.name: "media-playback-start"
    }
    Action {
        id: stopv
        icon.name: "media-playback-stop"
        shortcut: "Ctrl + s"
    }
    Action {
        id: pausev
        icon.name: "media-playback-pause"
        shortcut: "Ctrl + p"
    }
    Action {
        id: ratev
        text: qsTr("rate")
    }
}
