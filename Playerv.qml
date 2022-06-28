

/*
  this is video
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    property var sour
    property alias rate: mediaplayer.playbackRate
    property MediaPlayer mediaplayer:mediaplayer
    property alias muted: /*mediaplayer.*/audioOutput.muted
    property alias volume: /*mediaplayer.*/audioOutput.volume

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
        audioOutput:audioOutput



        videoOutput: videoOutput
        onSourceChanged: {
            mediaplayer.play()
        }
    }
   AudioOutput {
       id:audioOutput
    /*onMutedChanged: {
        console.log("change muted")
    }
    onVolumeChanged: {
        console.log("change volume")
    }*/}
    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }


}
