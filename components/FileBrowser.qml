import QtQuick 2.9
import QtQuick.Dialogs 1.0

FileDialog {
    id: fileDialog
    title: "Escoge un archivo"

    folder: shortcuts.home
    sidebarVisible: false
    selectFolder: true

    width:400
    height: 400

    function done()
    {

    }

    onAccepted:
    {
        done();
    }
    onRejected:
    {

    }
    Component.onCompleted: visible = false
}
