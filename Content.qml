

/*
  this is the file directory
*/
import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Dialogs
import QtQuick.Controls
import QtMultimedia

Item {
    id: fileContent
    property var fpath
    property var namehead
    //用于控制路径名，folder打开路径名有问题，视频播放不了
    function setVedioFillMode() {
        content.fillMode = arguments[0]
    }
    function setFilesModel() {
        filesModel.clear()
        for (var i = 0; i < arguments[0].length; i++) {
            var data = {
                "filePath": arguments[0][i]
            }
            filesModel.append(data)
        }
        content.model = filesModel
        content.currentIndex = 0
        namehead = ""
    }
    function setFolderModel() {
        folderModel.folder = arguments[0]
        content.model = folderModel
        content.currentIndex = 0
        namehead = "file://"
    }
    function nameRe(path) {
        var name = namehead + path
        name = name.split("/")
        return name[name.length - 1]
    } //处理目录文件显示的名字

//    Rectangle{
//        id:rec
//        anchors.fill: parent
//        focus:true
//        Keys.onPressed: (event)=>{
//            if(event.key===Qt.Key_Escape){
//                showNormal()
//                event.accepted = true;
//            }
//        }
//    }

//    Playerv {
//        id: playerv
//        anchors.fill: parent
//        sour: content.fpath
//    }

    ListView {
        id: content
        anchors.fill: parent
        ListModel {
            id: filesModel
        }

        FolderListModel {
            id: folderModel
            nameFilters: ["*.mp4"]
            showDirs: false //禁止显示目录文件
        }
        delegate:Rectangle{
                id:re
                width:1/3*parent.width
                height:50
                anchors.right: parent.right
                Text {
                    id:text
                    anchors.centerIn: parent
                    text: nameRe(filePath)
                    font.pointSize: 15
                    }
                color: index % 2 == 0 ? "lightcyan" : "white"

            TapHandler {
                onTapped: {
                    fpath = namehead + filePath
                    fileMulu.visible = false
                    console.log(fpath);
//                    color:index===currentIndex?"red":"grey"//点击的视频名字变红，未实现
                }
            }
        }
    }
}
