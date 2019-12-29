import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2

Rectangle
{
    property string icon: "\uf093"
    width: 50
    height: 50
    radius: 25
    color: Material.color(Material.Blue)
    Text
    {
        color: "white"
        text: parent.icon
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: 50
        height: 50
    }

    opacity: buttonArea.containsMouse ? 0.8: 1

    function select()
    {

    }

    MouseArea
    {
        id: buttonArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: parent.select()
    }
}
