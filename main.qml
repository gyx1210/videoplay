import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    id: appWindow
    visible: true
    width: 600
    height: 400

    menuBar: MenuBar {
        id: appMenuBar

        Menu {
            title: qsTr("&File")
            MenuItem {
                action: actions.openAction
            }
            MenuItem {
                action: actions.folderAction
            }
            MenuItem {
                action: actions.exitAction
            }
        }

        Menu {
            title: qsTr("&Help")
            contentData: [actions.contentsAction, actions.aboutAction]
        }
    }

    header: ToolBar {
        id: appToolBar
        RowLayout {
            ToolButton {
                action: actions.openAction
            }
            ToolButton {
                action: actions.folderAction
            }
            ToolButton {
                action: actions.cataAction
            }
        }
    }

    footer: ToolBar {
        RowLayout {
            anchors.centerIn: parent
            ToolButton {
                action: actions.pauseAction
            }
            ToolButton {
                action: actions.playAction
            }
            ToolButton {
                action: actions.stopAction
            }
        }
    }
    Actions {
        id: actions
        openAction.onTriggered: fileo.openFileDialog()
        folderAction.onTriggered: fileo.openFolderDialog()
        stopAction.onTriggered: video.stop
        playAction.onTriggered: video.play
        pauseAction.onToggled: video.pause
        aboutAction.onTriggered: fileo.openAboutDialog()
        cataAction.onTriggered: {
            mulu.visible = !mulu.visible //make a hidden directory
        }
    }
    Fileo {
        id: fileo
        fileOpenDialog.onAccepted: mulu.setFilesModel(
                                       fileOpenDialog.selectedFiles)

        folderOpenDialog.onAccepted: mulu.setFolderModel(
                                         folderOpenDialog.selectedFolder)
    }

    Mulu {
        id: mulu
        //        width: 100
        //        height: parent.height
        //        anchors.right: parent.right
        anchors.fill: parent
        visible: true
        z: video.z + 1 //make the mulu layer above the video
    }

    Vid {
        id: video
        //        anchors.right: mulu.left
        //        anchors.left: parent.left
        //        anchors.top: parent.top
        //        anchors.bottom: parent.bottom
        anchors.fill: parent
        sour: mulu.fpath
        onSourChanged: console.log(sour)
    }
}
