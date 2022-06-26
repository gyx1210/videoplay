

/*
  this is video
*/
import QtQuick
import QtMultimedia

Item {
    property var sour
    MediaPlayer {
        id: mediaplayer
        source: sour
        audioOutput: AudioOutput {}
        videoOutput: videoOutput
        onSourceChanged: {
            mediaplayer.play()
        }
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
    function play() {
        if (mediaplayer.playbackState != mediaplayer.PlayingState)
            mediaplayer.play()
    }
    function stop() {
        if (mediaplayer.playbackState != mediaplayer.StoppedState)
            mediaplayer.stop()
    }
    function pause() {
        if (mediaplayer.playbackState != mediaplayer.PausedState)
            mediaplayer.pause()
    }
}
