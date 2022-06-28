//this is the SoundSlider
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    id:root
    implicitHeight: 1

   // required property MediaPlayer mediaPlayer
    property real volume:soundSlider.value/100
    property bool muted:false

    RowLayout{
        anchors.centerIn: parent
        Button{
            id:sound
            width: 20;height: 20;
            onClicked: {
                muted=!muted
            }
            Image{
                id:im
                width: 20;height: 20;
                source: muted ? "qrc:/SoundTurnoff.webp" : "qrc:/SoundOn.webp"
            }
        }

        Slider{
            id:soundSlider
            enabled: true
            from:0
            to:100
            value: 100
            //onMoved: mediaPlayer.audioOutput.volume=volume
        }

    }
}
