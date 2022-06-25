

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
    }

    VideoOutput {
        id: videoOutput
//        anchors.fill: parent
        width: 500
        height: 300
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
