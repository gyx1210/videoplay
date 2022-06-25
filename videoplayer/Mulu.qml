

/*
  this is the file directory
*/
import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Dialogs
import QtQuick.Controls
import QtMultimedia

Item {
    property var fpath
    function setVedioFillMode(){
         mulu.fillMode =  arguments[0]
    }
    function setFilesModel() {
        filesModel.clear()
        for (var i = 0; i < arguments[0].length; i++) {
            var data = {
                "filePath": arguments[0][i]
            }
            filesModel.append(data)
        }
        mulu.model = filesModel
        mulu.currentIndex = 0;
    }
    function setFolderModel() {
        folderModel.folder = arguments[0]
        mulu.model = folderModel
        mulu.currentIndex = 0
    }
    ListView{
        id: mulu
        spacing: 10
        anchors.fill: parent
        ListModel {
            id: filesModel
        }

        FolderListModel {
            id: folderModel
            nameFilters: ["*.mp4"]
        }
        delegate: Text {
            text: filePath //name can c++
            font.pointSize: 10
            TapHandler {
                onTapped: {
                    mulu.currentIndex=index
                    fpath = filePath
                    console.log(fpath)
                    playm.source=fpath
                    playm.play()
                }
            }
            MediaPlayer{
                id:playm
                audioOutput: AudioOutput{}
                videoOutput: playv
            }
            VideoOutput{
                id:playv
                width: 600
                height: 300
            }
        }
    }


}
