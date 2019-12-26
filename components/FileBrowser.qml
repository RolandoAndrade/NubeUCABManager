import QtQuick 2.9
import QtQuick.Dialogs 1.0

FileDialog {
    id: fileDialog
    title: "Escoge un archivo"

    folder: shortcuts.home
    sidebarVisible: false
    selectFolder: true

    onAccepted:
    {
        directoryRoute.text = fileDialog.fileUrls[0].substr(7);
    }
    onRejected:
    {

    }
    Component.onCompleted: visible = false
}
