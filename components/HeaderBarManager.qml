import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4

Pane
{
    FontLoader
    {
        id: fontname
        source: "qrc:///fonts/font.ttf"
        name: "FontAwesome"
    }



    id: header
    y: 25
    width: parent.width
    height: 100
    Material.background: Material.LightBlue
    z: 20
    Material.elevation: 2

    MouseArea
    {
        anchors.fill: parent
        onClicked: focus = true
    }
    Image
    {
        x: 50
        width: 80
        height: 80
        source: "qrc:///img/ucab.png"
    }
    layer.enabled: true
    layer.effect: DropShadow
    {

        anchors.fill: header
        horizontalOffset: 0
        verticalOffset: 1
        radius: 10.0
        samples: 15
        color: "#80000000"
        source: header
    }


    Rectangle
    {
        id: buscarect
        radius: 50
        color: "white"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 200
        anchors.rightMargin: 75
        height: 40

        TextField {
            id: buscar
            x: 300
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 2
            leftPadding: 30
            rightPadding: 50
            color: "#555"
            selectByMouse: true
            Material.accent: Material.Blue
            selectionColor: Material.color(Material.Blue)
            background: Rectangle {color:"transparent"}
            onTextChanged:
            {
                fileManager.search(buscar.text.toUpperCase());
            }
         }
        ToolButton
        {
            font.family: "FontAwesome"
            text: "\uf002"
            anchors.verticalCenter: parent.verticalCenter
            hoverEnabled: true
            font.pointSize: 10
            onClicked:
            {
                focus = true
                clientManager.search(buscar.text.toUpperCase());
            }

            Material.foreground: Material.color(Material.Blue)
            height: 50
            width: 50
            anchors.right: parent.right
        }

    }



}
