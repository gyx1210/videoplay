

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
    property var namehead
    //用于控制路径名，folder打开路径名有问题，视频播放不了
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
        namehead = ""
    }
    function setFolderModel() {
        folderModel.folder = arguments[0]
        mulu.model = folderModel
        mulu.currentIndex = 0
        namehead = "file://"
    }
    function nameRe(path) {
        var name = namehead + path
        name = name.split("/")
        return name[name.length - 1]
    } //处理目录文件显示的名字

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
            showDirs: false //禁止显示目录文件
        }
        delegate: Text {
            text: nameRe(filePath)
            font.pointSize: 10
            color: index % 2 == 0 ? "black" : "grey"
            TapHandler {
                onTapped: {
                    fpath = namehead + filePath
                    fileMulu.visible = false
                    //                    console.log(fpath)
                }
            }
        }
    }
}
