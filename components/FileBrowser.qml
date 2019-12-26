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
        console.log("You chose: " + fileDialog.fileUrls[0])
        directoryRoute.text = fileDialog.fileUrls[0].substr(7)
        //Qt.quit()
    }
    onRejected:
    {
        console.log("Canceled")
        //Qt.quit()
    }
    Component.onCompleted: visible = false
}
