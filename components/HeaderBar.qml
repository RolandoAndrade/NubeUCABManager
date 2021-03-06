import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

import com.nubeucab.servermanager 1.0

Rectangle
{
    id: sidebar
    height: 100
    y: 25
    color: Material.color(Material.LightBlue)
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0
    z:20

    layer.enabled: true
    layer.effect: DropShadow
    {

        anchors.fill: sidebar
        horizontalOffset: 0
        verticalOffset: 1
        radius: 10.0
        samples: 15
        color: "#80000000"
    }

    Image
    {
        x: 50
        width: 80
        height: 80
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:///img/ucab.png"
    }

    TextField
    {
        id: hostArea
        color: "white"
        background: null
        selectByMouse: true
        selectionColor: Material.color(Material.Blue, Material.Shade300)
        width: 60
        validator: IntValidator {bottom: 2048; top: 65536}
        font.pointSize: 10
        text: "3000"
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 50
        Rectangle
        {
            anchors.fill: parent
            border.color: parent.focus?"white":Material.color(Material.Blue)
            color: "transparent"
            radius: 1
            width: 70
            height: 15
            anchors.topMargin: -10


            Rectangle
            {
                width: passLabel.width+5
                height: 8
                color: Material.color(Material.LightBlue)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                Label
                {
                    font.pointSize: 6
                    id: passLabel
                    color: "white"
                    text: "Puerto"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                }

            }

        }
    }
    RowLayout
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 30
        Rectangle
        {
            property string icon: "\uf04b"
            enabled: !serverManager.isStarted
            width: 50
            height: 50
            radius: 25
            color: buttonArea.containsMouse?Material.color(Material.LightBlue, Material.Shade300):Material.color(Material.LightBlue, Material.Shade400)
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
                serverManager.isStarted = true;
                serverManager.startServer(parseInt(hostArea.text));
            }

            MouseArea
            {
                id: buttonArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: parent.select()
            }
        }
        Rectangle
        {
            id: rectangle
            width: 100
            height: 100
            color: "transparent"
            ColumnLayout
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10
                Rectangle
                {
                    id: statusViewer
                    width: 20
                    height: 20
                    radius: 20
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    color: serverManager.isStarted?Material.color(Material.Blue, Material.Shade200):Material.color(Material.Red)
                }
                SequentialAnimation
                {
                    loops: Animation.Infinite
                    running: serverManager.isStarted
                    NumberAnimation { target: statusViewer; property: "scale"; from: 1; to: 0.7; duration: 1000 }
                    NumberAnimation { target: statusViewer; property: "scale"; to: 1; duration: 1000 }
                }
                Text
                {
                    text: serverManager.isStarted?"CORRIENDO":"DETENIDO"
                    font.pointSize: 8
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    color: "white"
                }
            }
        }




        Rectangle
        {
            property string icon: "\uf04d"
            enabled: serverManager.isStarted
            width: 50
            height: 50
            radius: 25
            color: stopArea.containsMouse?Material.color(Material.Red, Material.Shade300):Material.color(Material.Red, Material.Shade400)
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
                serverManager.isStarted = false;
                serverManager.stopServer();
            }

            MouseArea
            {
                id: stopArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: parent.select()
            }
        }
    }

    Text
    {
        color: "#ffffff"
        text: serverManager.ip

        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        font.pointSize: 8
    }

    Component.onCompleted:
    {
        serverManager.ip = serverManager.getIP();
    }

    ServerManager
    {
        id: serverManager
        property bool isStarted: false
        property string ip
    }

}
