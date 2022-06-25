
/*
  this is button
  */
import QtQuick
import QtQuick.Controls

Item {
    property alias openAction: open
    property alias folderAction: folder
    property alias exitAction: exit

    property alias aboutAction: about
    property alias contentsAction: contents

    property alias playAction: playv
    property alias pauseAction: pausev
    property alias stopAction: stopv
    property alias cataAction: catalogue
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
    }
    Action {
        id: contents
        text: qsTr("&contents")
        icon.name: "help-contents"
    }

    Action {
        id: about
        text: qsTr("&About")
        icon.name: "help-about"
    }
    Action {
        id: playv
        text: qsTr("&play")
        icon.name: "media-playback-start"
    }
    Action {
        id: stopv
        text: qsTr("&stop")
        icon.name: "media-playback-stop"
    }
    Action {
        id: pausev
        text: qsTr("p&ause")
        icon.name: "media-playback-pause"
    }
    Action {
        id: catalogue
        text: qsTr("catalogue")
    }
}
