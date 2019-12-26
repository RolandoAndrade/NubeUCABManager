import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2

Rectangle
{
    property string name: "Lorem ipsum"
    property string password: "123456"
    property string route: "/home/NubeUCAB"
    width: Math.min(mainWindow.width - 200,800)
    color: "red"
    height: 200
}
