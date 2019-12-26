import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.3

import "components" as UIObjects


ApplicationWindow
{
    id: mainWindow
    width: 700
    height: 500
    title: qsTr('NubeUCAB')
    flags: Qt.Window | Qt.FramelessWindowHint
    x: screen.width / 2 - 700 / 2
    y: screen.height / 2 - 500 / 2
    property int previousX
    property int previousY
    property bool isMaximized: false
    visible: true
    Material.accent: Material.LightBlue

    MouseArea {
            anchors.fill: parent

            onClicked: {
                focus = true
            }
    }

    UIObjects.Header
    {

    }

    UIObjects.HeaderBar
    {

    }

    Component.onCompleted:
    {
    }

    ListView
    {
        id: listData
        highlightRangeMode: ListView.NoHighlightRange
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        spacing: 25
        header: Rectangle
        {
            anchors.horizontalCenter: parent.horizontalCenter
            width: generalData.width
            height: 350
            color: "transparent"
            UIObjects.CreateUserForm
            {
                anchors.verticalCenter: parent.verticalCenter
                id: generalData
            }
        }

        anchors.topMargin: 126
        clip: true

        model: ListModel{
            id: listModel
        }
        delegate: UIObjects.UserCard
        {
            name: thename
            password: thepass
            route: theroute
            labelColor: thecolor
            anchors.horizontalCenter: parent.horizontalCenter
        }

        footer: Rectangle
        {
            height: 25
            Layout.fillWidth: true
            color: "transparent"
        }
    }

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

        ColumnLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Text
            {
                text: "\uf00c"
                color: Material.color(Material.Green)
                Layout.alignment: Qt.AlignHCenter
                opacity: 0.8
                font.pointSize: 50
            }

            Text
            {
                text: "Éxito";
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: 20
                color: Material.color(Material.Grey)

            }


            Text
            {
                text: "Se ha creado un usuario de manera exitosa";
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


    }

}
