

/*
  this is video
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    property string sour: ""
    property MediaPlayer mediaplayer: mediaplayer
    property alias rate: mediaplayer.playbackRate
    property alias muted: audioOutput.muted
    property alias volume: audioOutput.volume

    function play() {
        if (mediaplayer.playbackState != mediaplayer.PlayingState)
            mediaplayer.play()
    }
    function stop() {
        if (mediaplayer.playbackState != mediaplayer.StoppedState)
            mediaplayer.stop()
    }
    function pause() {
        if (mediaplayer.playbackState != mediaplayer.PausedState) {
            mediaplayer.pause()
        }
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
