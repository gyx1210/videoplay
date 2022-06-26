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
        Menu{
            title: qsTr("&View")
            //using Action object as menu item directly
            MenuItem {
                action: actions.fullAction
            }
            MenuItem {
                action: actions.cataAction
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
        stopAction.onTriggered:{
            video.stop()
            mulu.visible = true
        }
        playAction.onTriggered:{
            video.play()
            mulu.visible=false
        }
        pauseAction.onTriggered:
        {
            video.pause()
            mulu.visible=true
        }

        aboutAction.onTriggered: fileo.openAboutDialog()
        cataAction.onTriggered: {
            mulu.visible = !mulu.visible //make a hidden directory
        }
    }
    Fileo {
        id: fileo
        fileOpenDialog.onAccepted: {
            mulu.setFilesModel(fileOpenDialog.selectedFiles)
            mulu.visible = true
        }

        folderOpenDialog.onAccepted: {
            mulu.setFolderModel(folderOpenDialog.selectedFolder)
            mulu.visible = true
        }
    }
    Mulu {
        id: mulu
        anchors.fill: parent
        visible: true
        z: video.z + 1
    }

    Vid {
        id: video
        anchors.fill: parent
        sour: mulu.fpath
    }
}
