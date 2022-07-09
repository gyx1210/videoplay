

/*
  this is video
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    property string sour: ""//播放文件的路径
    property bool playstatus: true//播放状态
    property alias mediaplayer: mediaplayer
    property alias rate: mediaplayer.playbackRate//播放速率
    property alias muted: audioOutput.muted//是否静音
    property alias volume: audioOutput.volume//声音大小

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
            playstatus=true
            console.log(mediaplayer.source)
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
