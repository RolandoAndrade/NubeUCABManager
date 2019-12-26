import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

Rectangle
{
    id: generalData
    height: 300
    Layout.alignment: Qt.AlignHCenter
    radius: 5
    width: Math.min(mainWindow.width - 200,800)
    Layout.topMargin: 25
    border.color: "#eee"


    ColumnLayout
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 25
        anchors.rightMargin: 25
        anchors.topMargin: 25
        spacing: 30
        Text
        {
            text: "Administrar servidor"
            color: Material.color(Material.Grey)
            font.pointSize: 15
        }

        Rectangle
        {
            id: rectangle
            height: 50
            Layout.fillWidth: true
            border.color: Material.color(Material.Grey, Material.Shade400)
            radius: 5

            Text
            {
                text: "/home/rolandoandrade/NubeUCAB"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: Material.color(Material.Grey, Material.Shade400)
            }

            Rectangle
            {
                id: rectangle1
                width: 100
                height: 30
                anchors.top: parent.top
                anchors.topMargin: -15
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                Text
                {
                    text: "Ruta del servidor"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: Material.color(Material.Grey, Material.Shade400)
                    font.pointSize: 8
                }
            }
        }
        GridLayout
        {
            rowSpacing: 10
            columnSpacing: 30
            columns: 2
            rows: 1
            Rectangle
            {
                id: rectangle2
                height: 50
                Layout.fillWidth: true
                border.color: Material.color(Material.Grey, Material.Shade400)
                radius: 5

                TextField
                {

                    color: Material.color(Material.Grey, Material.Shade600)
                    anchors.top: parent.top
                    anchors.topMargin: 7
                    horizontalAlignment: Text.AlignHCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    background: null
                    selectByMouse: true
                    selectionColor: Material.color(Material.Blue, Material.Shade300)
                }

                Rectangle
                {

                    width: 45
                    height: 20
                    anchors.top: parent.top
                    anchors.topMargin: -10
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text
                    {
                        text: "Nombre"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        color: Material.color(Material.Grey, Material.Shade400)
                        font.pointSize: 8
                    }
                }
            }
            Rectangle
            {
                height: 50
                Layout.fillWidth: true
                border.color: Material.color(Material.Grey, Material.Shade400)
                radius: 5

                TextField
                {
                    color: Material.color(Material.Grey, Material.Shade600)
                    anchors.top: parent.top
                    anchors.topMargin: 7
                    horizontalAlignment: Text.AlignHCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    background: null
                    selectByMouse: true
                    selectionColor: Material.color(Material.Blue, Material.Shade300)
                }

                Rectangle
                {

                    width: 60
                    height: 20
                    anchors.top: parent.top
                    anchors.topMargin: -10
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text
                    {
                        text: "Contraseña"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        color: Material.color(Material.Grey, Material.Shade400)
                        font.pointSize: 8
                    }
                }
            }




        }

        Rectangle
        {
            Layout.alignment: Qt.AlignHCenter
            property string icon: "\uf067"
            width: 50
            height: 50
            radius: 25
            color: addUserArea.containsMouse?Material.color(Material.LightBlue, Material.Shade300):Material.color(Material.LightBlue, Material.Shade400)
            Text
            {
                color: "white"
                text: parent.icon
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: 50
                height: 50
            }


            function select()
            {

            }

            MouseArea
            {
                id: addUserArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: parent.select()
            }
        }
    }




}
