import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia
import QtQuick.Particles

ApplicationWindow {
    id: appWindow
    property bool fullScreen: false
    visible: true
    width: 1000
    height: 800

    background: Rectangle {
        id:ro
        color: "black"
        ParticleSystem{id:particleSystem}//粒子系统
        Emitter{//发射器
            id:emitter
            anchors.centerIn: parent
            width: parent.width;height: parent.height
            system: particleSystem

            emitRate: 10//发射速率（每秒发射多少个粒子，默认值为10）
            lifeSpan: 2500;//粒子生命周期，单位毫秒（默认值为1000）
            lifeSpanVariation: 500//粒子生命周期误差区间
            size: 25;//粒子初始大小
            endSize: 50//粒子生命周期结束时大小（默认值为-1）

            velocity: AngleDirection{//角度定义方向//velocity速度
                angle: 30//发射角度
                angleVariation: 15
                magnitude: 50//粒子速度
                magnitudeVariation: 20
            }
            acceleration: AngleDirection {//acceleration加速度
                angle: -90
                magnitude: 25
            }

        }
        ImageParticle{//粒子画笔
            source: "qrc:/b.png"
            system: particleSystem
            color: "yellow"
            colorVariation: 0.6
            rotation: 30//顺时针旋转
            rotationVariation: 5//旋转误差
            rotationVelocity: 45//旋转速度
            rotationVelocityVariation: 15
        }
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
        Menu{
            title: qsTr("&Model")
            Menu{
                title: "&Local"
                MenuItem {
                    action: actions.openAction
                }
                MenuItem {
                    action: actions.folderAction
                }
            }
            MenuItem{
                action: actions.networkAction
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
        height: 50
        background: Rectangle {
            color: "#e0ffff"
        }
        ColumnLayout {
            anchors.fill: parent
            PlaySlider {
                id: playslider
                width: parent.width
                mediaPlayer: playerv.mediaplayer
            }
            RowLayout {
                id: button
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
                    id: rate
                    action: actions.rateAction
                }
                ToolButton {
                    action: actions.goNextAction
                }
                ToolButton {
                    SoundSlider {
                        id: soundSlider
                    }
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
        rateAction.onTriggered: {
            popup.open()
        }
        goNextAction.onTriggered: {
            content.next()
        }

        Popup {
            id: popup
            padding: 0
            background: Rectangle {
                implicitWidth: 20
                implicitHeight: 20

                color: "white"
            }
            contentItem: ColumnLayout {
                Button {
                    text: qsTr("x1")
                    onClicked: {
                        playerv.rate = 1
                        popup.close()
                        actions.rateAction.text = qsTr("rate_x1")
                    }
                }
                Button {
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
    TapHandler{
        acceptedButtons: Qt.RightButton
        onTapped:{
            po.open()
        }
    }
//    function getX(event) {
//        var e = event || window.event;
//        return e.clientX;
//    }

//    function getY(event) {
//        var e = event || window.event;
//        return e.clientY;
//    }

    Popup{
        id:po
        opacity: 1
        x:parent.width/2
        y:parent.height/8


        background: Rectangle {
            implicitWidth: 50
            implicitHeight: 50
            color: "#e0ffff"
        }

        contentItem: ColumnLayout{
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
                MenuItem {
                    action: actions.fullAction
                }
                MenuItem {
                    action: actions.cataAction
                }
                MenuItem {
                    action: actions.contentsAction
                }
                MenuItem {
                    action:  actions.aboutAction
                }
        }

    }
}
