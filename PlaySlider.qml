//this is the slider
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    id: root

    required property MediaPlayer mediaPlayer

    implicitHeight: 20


    RowLayout {
        anchors.fill: parent

//        Text {
//            id: mediaTime
//            Layout.minimumWidth: 50
//            Layout.minimumHeight: 18
//            horizontalAlignment: Text.AlignRight
//            text: {
////                var m = Math.floor(mediaPlayer.position / 60000)
////                var ms = (mediaPlayer.position / 1000 - m * 60).toFixed(1)
////                return `${m}:${ms.padStart(4, 0)}`
//                var milliseconds = mediaPlayer.position
//                var minutes = Math.floor(milliseconds / 60000)
//                milliseconds -= minutes * 60000
//                var seconds = milliseconds / 1000
//                seconds = Math.round(seconds)
//                if (seconds < 10)
//                    return minutes + ":0" + seconds
//                else
//                    return minutes + ":" + seconds
//            }
//        }

        Slider {
            id: mediaSlider
            Layout.fillWidth: true
            enabled: mediaPlayer.seekable
            to: 1.0
            value: mediaPlayer.position / mediaPlayer.duration

            onMoved: mediaPlayer.setPosition(value * mediaPlayer.duration)
//            property real index: 0
//            property bool changed: false
//            onMoved: {
//                if (pressed) {
//                    index = position
//                }
//            }
//            onPressedChanged: {
//                if (pressed === true) {
//                    changed = true
//                } else if (changed === true) {
//                    mediaPlayer.seek(index * mediaPlayer.duration)
//                    changed = false
//                }
//            }
        }
    }

}

