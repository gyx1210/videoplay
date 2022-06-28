import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia

ApplicationWindow {
    id: appWindow
    property bool fullScreen: false
    visible: true
    width: 600
    height: 400

    background: Rectangle {
        color: "black"
    }

    menuBar: MenuBar {
        id: appMenuBar
        visible: !fullScreen
        background: Rectangle {
            color: "#e0ffff"
        }
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
        Menu {
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
        visible: !fullScreen
        background: Rectangle {
            color: "#87cefa"
        }
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
        visible: !fullScreen
        ColumnLayout {
            anchors.fill: parent
            anchors.topMargin: 6
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            spacing: 25
            PlaySlider {
                Layout.fillWidth: true
                mediaPlayer: playerv.mediaplayer
            }


            RowLayout {

//                anchors.centerIn: parent
                ToolButton {
                    action: actions.pauseAction
                }
                ToolButton {
                    action: actions.playAction
                }
                ToolButton {
                    action: actions.stopAction
                }
                ToolButton {
                    action: actions.rateAction
                }
                SoundSlider{
                    id:soundSlider
                    width: 1
                }
            }
        }
    }
    Actions {
        id: actions
        openAction.onTriggered: fileo.openFileDialog()
        folderAction.onTriggered: fileo.openFolderDialog()

        stopAction.onTriggered: {
            playerv.stop()
            content.visible = true
        }
        playAction.onTriggered: {
            playerv.play()
            content.visible = false
        }
        pauseAction.onTriggered: {
            playerv.pause()
            content.visible = true
        }
//        rateAction.onTriggered: {
//            if (playerv.rate == 2) {
//                playerv.rate = 1
//                rateAction.text = qsTr("x1")
//            } else {
//                playerv.rate = 2
//                rateAction.text = qsTr("x2")
//            }
//        }
        rateAction.onTriggered: {
            popup.open()
        }
        Popup{
            id:popup
            padding:0
    //            parent: /*Overlay.overlay*/actions.rateAction
    //            //anchors.left: parent.right
            background: Rectangle{
                implicitWidth: 20
                implicitHeight: 20

                color: "white"
            }
            contentItem: ColumnLayout{
                Button{
                    text: qsTr("x1")
                    onClicked: {
                        playerv.rate = 1
                        popup.close()
                        actions.rateAction.text = qsTr("rate_x1")
                    }
                }
                Button{
                    text: qsTr("x2")
                    onClicked: {
                        playerv.rate = 2
                        popup.close()
                        actions.rateAction.text = qsTr("rate_x2")
                    }
                }
            }
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
            content.addFile = true
        }

        folderOpenDialog.onAccepted: {
            content.setFolderModel(folderOpenDialog.selectedFolder)
            content.visible = true
            content.addFile = false
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
        volume: soundSlider.volume
        muted: soundSlider.muted
    }
    TapHandler {
        onDoubleTapped: {
            if (fullScreen = !fullScreen) {
                showFullScreen()
            } else {
                showNormal()
            }
        }
    }
}
