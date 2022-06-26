

/*
  this is the file directory
*/
import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Dialogs
import QtQuick.Controls
import QtMultimedia

Item {
    id: fileMulu
    property var fpath
    function setVedioFillMode() {
        mulu.fillMode = arguments[0]
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
        mulu.currentIndex = 0
    }
    function setFolderModel() {
        folderModel.folder = arguments[0]
        mulu.model = folderModel
        mulu.currentIndex = 0
    }
    ListView {
        id: mulu
        spacing: 10
        anchors.fill: parent
        ListModel {
            id: filesModel
        }

        FolderListModel {
            id: folderModel
            nameFilters: ["*.mp4"]
            showDirs: false
        }
        delegate: Text {
            id: filePath
            text: filePath
            font.pointSize: 10
            color: index % 2 == 0 ? "black" : "grey"
            TapHandler {
                onTapped: {
                    fpath = filePath
                    fileMulu.visible = false
                    //                    console.log(fpath)
                }
            }
        }
    }
}
