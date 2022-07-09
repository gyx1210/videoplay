
/*
  this is button
  */
import QtQuick
import QtQuick.Controls

Item {
    property alias openAction: open
    property alias folderAction: folder
    property alias exitAction: exit
    property alias cataAction: catalogue
    property alias networkAction: network
    property alias aboutAction: about
    property alias playAction: playv
    property alias iconname: playv.icon.name
    property alias stopAction: stopv
    property alias rateAction: ratev
    property alias goNextAction: goNext

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
        id: network
        text: qsTr("&Network")
        shortcut: "Ctrl+n"
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
        id: goNext
        icon.name: "go-next"
    }
    Action {
        id: ratev
        text: qsTr("rate")
    }
}
