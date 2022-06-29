

/*
  this is video
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    property string sour: ""
    property bool playstatus: true
    property alias mediaplayer: mediaplayer
    property alias rate: mediaplayer.playbackRate
    property alias muted: audioOutput.muted
    property alias volume: audioOutput.volume

    function play() {
        if (playstatus)
            mediaplayer.pause()
        else
            mediaplayer.play()
        playstatus = !playstatus
    }
    function stop() {
        mediaplayer.stop()
    }

    MediaPlayer {
        id: mediaplayer
        source: sour
        audioOutput: audioOutput
        videoOutput: videoOutput
        playbackRate: 1
        onSourceChanged: {
            mediaplayer.play()
        }
    }
    AudioOutput {
        id: audioOutput
        muted: false
        volume: 1
    }
    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
}
