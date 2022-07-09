
/*
  this is the file open
  */
import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    property alias fileOpenDialog: fileOpen
    property alias folderOpenDialog: folderOpen

    function openFileDialog() {
        fileOpen.open()
    }
    function openFolderDialog() {
        folderOpen.open()
    }
    function openAboutDialog() {
        about.open()
    }
    FileDialog {//文件打开
        id: fileOpen
        title: "Select some video files"
        currentFolder: StandardPaths.writableLocation(
                           StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFiles
        nameFilters: ["Video files (*.mp4)"]
    }
    FolderDialog {//目录打开
        id: folderOpen
        currentFolder: StandardPaths.writableLocation(
                           StandardPaths.DocumentsLocation)
        title: "Select an video folder"
    }
    Dialog {
        id: about
        width: 700
        height: 270
        title: qsTr("About")
        Label {
            anchors.fill: parent
            text: qsTr("A QML Videos Viewer\n 作者：龚颜鲜 吴雪莲 魏美玉")
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
