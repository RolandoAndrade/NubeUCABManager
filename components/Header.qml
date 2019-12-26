import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2
Rectangle
{
    id: rectangle
    width: parent.width
    height: 25
    color: Material.color(Material.Blue)
    z: 30
    FontLoader
    {
        id: fontname
        source: "qrc:///fonts/font.ttf"
        name: "FontAwesome"
    }


    anchors.top: parent.top

    Text
    {
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 8
        text: mainWindow.title
        font.weight: Font.Bold
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
        fontSizeMode: Text.HorizontalFit
        textFormat: Text.AutoText
        width: parent.width
        color: "white"
    }

    MouseArea
    {
        anchors.fill: parent

        onPressed:
        {
            previousX = mouseX
            previousY = mouseY
        }

        onMouseXChanged:
        {
            var dx = mouseX - previousX
            mainWindow.setX(mainWindow.x + dx)
        }

        onMouseYChanged:
        {
            var dy = mouseY - previousY
            mainWindow.setY(mainWindow.y + dy)
        }
    }

    ToolButton
    {
        font.family: "FontAwesome"
        text: "\uf011"
        anchors.left: parent.left
        anchors.leftMargin: 0
        hoverEnabled: true
        font.pointSize: 10
        onClicked: Qt.quit()
        Material.foreground: "white"
        height: 25
        width: 25
    }

    property bool showMaximize: true

    ToolButton
    {
        font.family: "FontAwesome"
        text: "\uf066"
        anchors.right: parent.right
        anchors.rightMargin: 0
        hoverEnabled: true
        font.pointSize: 8
        height: 25
        width: 25
        onClicked: (mainWindow.isMaximized=!mainWindow.isMaximized)?mainWindow.setGeometry(0,0,screen.width,screen.height):mainWindow.setGeometry(screen.width / 2 - 700 / 2,screen.height / 2 - 500 / 2,700,500)
        Material.foreground: "white"
        visible: parent.showMaximize
    }
}
