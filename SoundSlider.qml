//this is the SoundSlider
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    id: root
    property real volume: soundSlider.value / 100
    property bool muted: false

    Button {
        id: sound
        width: 20
        height: 20
        onClicked: {
            muted = !muted
        }
        background: Image {
            id: im
            width: 20
            height: 20
            source: muted ? "qrc:/SoundTurnoff.webp" : "qrc:/SoundOn.webp"
        }
    }
    Slider {
        id: soundSlider
        enabled: true
        from: 0
        to: 100
        value: 100
        anchors.left: sound.right
    }
}
