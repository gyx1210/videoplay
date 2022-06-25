

/*
  this is the file directory
*/
import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Dialogs
import QtQuick.Controls
import QtMultimedia

ListView {
    id: mulu
    property var fpath
    function setFilesModel() {
        filesModel.clear()
        for (var i = 0; i < arguments[0].length; i++) {
            var data = {
                "filePath": arguments[0][i]
            }
            filesModel.append(data)
        }
        mulu.model = filesModel
    }
    function setFolderModel() {
        folderModel.folder = arguments[0]
        mulu.model = folderModel
        mulu.currentIndex = 0
    }
    spacing: 10
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
                fpath = filePath
                console.log(fpath)
            }
        }
    }
}
