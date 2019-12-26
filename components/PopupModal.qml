import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.3

Popup
{
    id: popupadd
    width: 300
    height: 300
    modal: true
    focus: true
    x: mainWindow.width/2 - 150
    y: mainWindow.height/2 - 150
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    property string icon: "\uf00c"
    property string title: "Éxito"
    property string message: "Se ha creado un usuario de manera exitosa"
    property color colorIcon: Material.color(Material.Green)

    ColumnLayout
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        Text
        {
            text: popupadd.icon
            color: popupadd.colorIcon
            Layout.alignment: Qt.AlignHCenter
            opacity: 0.8
            font.pointSize: 50
        }

        Text
        {
            text: popupadd.title
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 20
            color: Material.color(Material.Grey)

        }


        Text
        {
            text: popupadd.message
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAnywhere
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 10
            color: Material.color(Material.Grey)
            width: 100
        }

        Button
        {
            text: "Ok"
            flat: true
            Material.background: Material.color(Material.Blue)
            Layout.alignment: Qt.AlignHCenter
            Material.foreground: "#fff"
            padding: 20
            onPressed: popupadd.close()
            font.pointSize: 10
        }
    }

    function openModal(icon, title, message, color)
    {
        popupadd.icon = icon;
        popupadd.title = title;
        popupadd.message = message;
        popupadd.colorIcon = color;
        popupadd.open();
    }


}
