import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia

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
                onTriggered: appWindow.close()
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
        ColumnLayout{
            anchors.fill: parent
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            spacing: 30
            PlaySlider{
                Layout.fillWidth: true
                mediaPlayer: mediaPlayer
            }

            RowLayout {
                anchors.centerIn: parent
//                RowLayout {
//                    anchors.bottom: parent.bottom
//                    anchors.left: parent.left
//                    Text {
//                        text: "Rate " + slider.value + "x"
//                    }
//                    Slider {
//                        id: slider
//                        Layout.fillWidth: true
//                        snapMode: Slider.SnapOnRelease
//                        enabled: true
//                        from: 0.5
//                        to: 2.5
//                        stepSize: 0.5
//                        value: 1.0

//                        onMoved: { mediaPlayer.setPlaybackRate(value) }
//                    }

//                }
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


    }
    Actions {
        id: actions
        openAction.onTriggered: fileo.openFileDialog()
        folderAction.onTriggered: fileo.openFolderDialog()
        stopAction.onTriggered:{
            playerv.stop()
            content.visible = true
        }
        playAction.onTriggered:{
            playerv.play()
            content.visible=false
        }
        pauseAction.onTriggered:
        {
            playerv.pause()
            content.visible=true
        }

        aboutAction.onTriggered: fileo.openAboutDialog()
        cataAction.onTriggered: {
            content.visible = !content.visible //make a hidden directory
        }


    }
    Open {
        id: fileo
        fileOpenDialog.onAccepted: {
            content.setFilesModel(fileOpenDialog.selectedFiles)
            content.visible = true
        }

        folderOpenDialog.onAccepted: {
            content.setFolderModel(folderOpenDialog.selectedFolder)
            content.visible = true
        }
    }
    Content {
        id: content
        anchors.fill: parent
        visible: true
        z: playerv.z + 1

    }

    Playerv {
        id: playerv
        anchors.fill: parent
        sour: content.fpath
    }


}
