import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

Rectangle
{
    property string path
    property string cdRoute

    color: Material.color(Material.LightBlue,Material.Shade300)
    width: childrenRect.width
    height: childrenRect.height
    radius: 5
    Text
    {
        id: ruta
        text: parent.path?parent.path:"Lorem ipsum sit ammet";
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        font.pointSize: 8
        padding: 5
    }

    opacity:  pathArea.containsMouse ? 0.8 : 1.0

    MouseArea
    {
        id: pathArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked:
        {
            if(headerLabels.count>index+1)
            {
                headerLabels.model.remove(index+1,headerLabels.model.count-1-index);
                fileManager.cdRoute(cdRoute);
            }


        }
    }

}
