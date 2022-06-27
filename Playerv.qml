

/*
  this is video
*/
import QtQuick
import QtMultimedia

Item {
    property var sour
    property alias rate: mediaplayer.playbackRate
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
        audioOutput: AudioOutput {}
        videoOutput: videoOutput
        onSourceChanged: {
            mediaplayer.play()
            console.log(MediaMetaData)
        }
        onPositionChanged: {
            console.log(position)
        } //视频播放时间
    }
    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
}
