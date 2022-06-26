
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
    Dialog {
        id: about
        width: 700
        height: 270
        title: qsTr("About")
        Label {
            anchors.fill: parent
            text: qsTr("A QML Videos Viewer\n")
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
