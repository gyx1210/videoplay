
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
    FileDialog {
        id: fileOpen
        title: "Select some video files"
        currentFolder: StandardPaths.writableLocation(
                           StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFiles
        nameFilters: ["Video files (*.mp4)"]
    }
    FolderDialog {
        id: folderOpen
        currentFolder: StandardPaths.writableLocation(
                           StandardPaths.DocumentsLocation)
        title: "Select an video folder"
    }
}
