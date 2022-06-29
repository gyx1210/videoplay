
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
    property bool addFile: false //用多选文件添加文件，不是目录打开
    //用于控制路径名，folder打开路径名有问题，视频播放不了
    function setVedioFillMode() {
        content.fillMode = arguments[0]
    }
    function setFilesModel() {

        for (var i = 0; i < arguments[0].length; i++) {
            var data = {
                "filePath": arguments[0][i]
            }
            if (!addFile)
                filesModel.append(data)
            else
                filesModel.insert(0, data)
        }
        content.model = filesModel
        content.currentIndex = 0
        namehead = ""
    }
    function setFolderModel() {
        filesModel.clear()
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
    function next(){             //将当前项设置为当前项的下一项
        if(content.currentItem!=null)
        {
             var temp  =namehead+filesModel.get(++content.currentIndex).filePath
             console.log(temp)
             fpath=temp
         }
        else console.log("The currentItem is null")
    }
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
        delegate: Rectangle {
            id: re
            width: 1 / 3 * parent.width
            height: 50
            anchors.right: parent.right
            Text {
                id: te
                anchors.centerIn: parent
                text: nameRe(filePath)
                font.pointSize: 15
                color: mouse.hovered ? "red" : "black" ////当鼠标停留在当前项时，字体颜色变化
                HoverHandler {
                    id: textMouse
                    acceptedDevices: PointerDevice.Mouse
                }
            }
            color: index % 2 == 0 ? "lightcyan" : "white"
            opacity: 0.4
            scale: mouse.hovered ? 1.35 : 1 //当鼠标停留在当前项时，当前项变大

            HoverHandler {
                id: mouse
                acceptedDevices: PointerDevice.Mouse
            }

            TapHandler {
                onTapped: {
                    fpath = namehead + filePath
                    fileContent.visible = false
                    content.currentIndex=index
                    console.log(fpath)
                }
            }
        }
        ScrollBar.vertical: ScrollBar{//滚动
            width: 10
            policy: ScrollBar.AsNeeded
        }
    }
}
