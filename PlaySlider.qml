//this is the slider
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    id: root
    implicitHeight: 1

    required property MediaPlayer mediaPlayer

    RowLayout{
        anchors.fill: parent
        Text{
            id:time
            //anchors.left: parent.left
            color: "grey"
            text: {
                var minute=Math.floor(mediaPlayer.position/60000)
                var second=Math.round((mediaPlayer.position-minute*60000)/1000)
                if(second<10)
                    return minute+":0"+second
                else
                    return minute+":"+second
            }

        }
        Slider{
            id:mediaSlider
            Layout.fillWidth: true

            enabled: mediaPlayer.seekable
            value: mediaPlayer.position/mediaPlayer.duration
            snapMode:Slider.SnapAlways
            onMoved: mediaPlayer.setPosition(value*mediaPlayer.duration)
        }
        Text{
            id:allTime
            //anchors.right: parent.right
            color: "grey"
            text: //mediaPlayer.duration
                {
                var minute=Math.floor(mediaPlayer.duration.valueOf()/60000)
                var second=Math.round((mediaPlayer.duration.valueOf()-minute*60000)/1000)
                if(second<10)
                    return minute+":0"+second
                else
                    return minute+":"+second
            }
        }
    }
}


