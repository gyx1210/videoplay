import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia
import QtQuick.Particles
import VideoInternet

ApplicationWindow {
    id: appWindow
    property bool fullScreen: false//判断是否全屏
    property bool netModel: false//判断是否为网络播放
    visible: true
    width: 1000
    height: 800

    background: Rectangle {
        id: ro
        color: "black"
        ParticleSystem {
            id: particleSystem
        } //粒子系统
        Emitter {
            //发射器
            id: emitter
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            system: particleSystem

            emitRate: 10 //发射速率（每秒发射多少个粒子，默认值为10）
            lifeSpan: 2500 //粒子生命周期，单位毫秒（默认值为1000）
            lifeSpanVariation: 500 //粒子生命周期误差区间
            size: 25 //粒子初始大小
            endSize: 50 //粒子生命周期结束时大小（默认值为-1）

            velocity: AngleDirection {
                //角度定义方向//velocity速度
                angle: 30 //发射角度
                angleVariation: 15
                magnitude: 50 //粒子速度
                magnitudeVariation: 20
            }
            acceleration: AngleDirection {
                //acceleration加速度
                angle: -90
                magnitude: 25
            }
        }
        ImageParticle {
            //粒子画笔
            source: "qrc:/image/b.png"
            system: particleSystem
            color: "yellow"
            colorVariation: 0.6
            rotation: 30 //顺时针旋转
            rotationVariation: 5 //旋转误差
            rotationVelocity: 45 //旋转速度
            rotationVelocityVariation: 15
        }
    }//做的背景

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
                action: actions.cataAction
            }
        }
        Menu {
            title: qsTr("&Model")
            Menu {
                title: "&Local"
                MenuItem {
                    action: actions.openAction
                }
                MenuItem {
                    action: actions.folderAction
                }
            }
            MenuItem {
                action: actions.networkAction
            }
        }

        Menu {
            title: qsTr("&Help")
            contentData: [ actions.aboutAction]
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
                ToolButton{
                    action: actions.backAction
                }
                ToolButton {
                    action: actions.playAction
                }
                ToolButton {
                    action: actions.stopAction
                }
                ToolButton{
                    action: actions.fastAction
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
        openAction.onTriggered: {
            fileo.openFileDialog()
            netModel = false
        }
        folderAction.onTriggered: {
            fileo.openFolderDialog()
            netModel = false
        }

        stopAction.onTriggered: {
            playerv.stop()
            content.visible = true
        }
        playAction.onTriggered: {
            playerv.play()
            content.visible = false
        }
        fastAction.onTriggered: {
            playslider.fastForward()
        }
        backAction.onTriggered: {
            playslider.backOff()
        }
        rateAction.onTriggered: {
            popup.open()
        }
        goNextAction.onTriggered: {
            if (netModel)
                playerv.sour = iv.urllink()
            else
                content.next()
        }
        aboutAction.onTriggered: fileo.openAboutDialog()
        cataAction.onTriggered: {
            content.visible = !content.visible //make a hidden directory
        }
        networkAction.onTriggered: {
            netModel = true
        }
    }
    Popup { //建立倍速弹出窗口
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
    Open {//本地文件选的方式目录打开，文件打开
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
    Content {//视频目录
        id: content
        anchors.fill: parent
        visible: true
        z: playerv.z + 1
    }

    Playerv {//播放器
        id: playerv
        anchors.fill: parent
        sour: netModel ? iv.urllink() : content.fpath
        volume: soundSlider.volume
        muted: soundSlider.muted

        TapHandler {//点击事件
            onDoubleTapped: {//双击全屏
                if (!fullScreen) {
                    showFullScreen()
                    fullScreen = !fullScreen
                } else {
                    showNormal()
                    fullScreen = !fullScreen
                }
            }
        }
        onPlaystatusChanged: {
            if (playerv.playstatus)
               actions.iconname = "media-playback-start"
            else
               actions.iconname = "media-playback-pause"
        }
    }
    TapHandler {//右击弹出菜单
        acceptedButtons: Qt.RightButton
        onTapped: {
            po.open()
        }
    }
    Popup {//建立右击菜单
        id: po
        opacity: 1
        x: parent.width / 2
        y: parent.height / 8

        background: Rectangle {
            implicitWidth: 50
            implicitHeight: 50
            color: "#e0ffff"
        }

        contentItem: ColumnLayout {
            MenuItem {
                action: actions.openAction
            }
            MenuItem {
                action: actions.folderAction
            }
            MenuItem {
                action: actions.aboutAction
            }
            MenuItem {
                action: actions.exitAction
                onTriggered: appWindow.close()
            }



        }
    }
    VInternet {
        //c++组件获取网络视频
        id: iv
    }
}
