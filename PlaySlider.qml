//this is the slider
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Particles

Item {
    id: root

    required property MediaPlayer mediaPlayer



    Text {
        id: startime
        anchors.left: parent.left
        color: "grey"
        text: {
            var minute = Math.floor(mediaPlayer.position / 60000)
            var second = Math.round(
                        (mediaPlayer.position - minute * 60000) / 1000)
            if (second < 10)
                return minute + ":0" + second
            else
                return minute + ":" + second
        }
    }

    Text {
        id: endTime

        anchors.right: parent.right
        color: "grey"
        text: //mediaPlayer.duration
        {
            var minute = Math.floor(mediaPlayer.duration.valueOf() / 60000)
            var second = Math.round((mediaPlayer.duration.valueOf(
                                         ) - minute * 60000) / 1000)
            if (second < 10)
                return minute + ":0" + second
            else
                return minute + ":" + second
        }
    }
    Slider {
        id: mediaSlider
        anchors.left: startime.right //将进度条的左边定位到开始的左边
        anchors.right: endTime.left //将进度条的右边定位到开始的右边
        enabled: mediaPlayer.seekable
        value: mediaPlayer.position / mediaPlayer.duration
        snapMode: Slider.SnapAlways
        onMoved: mediaPlayer.setPosition(value * mediaPlayer.duration)

        background: Rectangle {
            id: rect1
            width: mediaSlider.availableWidth
            height: 10
            radius: 7
            color: "#87cefa"

            Rectangle {
                id: rect2
                width: handleV.x
                height: rect1.height
                color: "#9370db"
                radius: 7
            }
        }
        handle: Rectangle {
            id: handleV
            x: mediaSlider.visualPosition * (mediaSlider.availableWidth - implicitWidth)
            y: mediaSlider.availableHeight / 2 - implicitHeight / 2
            Image {
                anchors.fill: parent
                source: "qrc:/image/Bear.png"
            }
            implicitWidth: 25
            implicitHeight: 25
            radius: 13
            color: "#e0ffff"
        }
    }
    function fastForward(){//实现快进
         mediaPlayer.position+=5000
    }
    function backOff(){//实现快退
        mediaPlayer.position-=5000
    }
}

