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
        for(var i = 0;i<5;i++)
            listModel.append({thename: "rolando",thepass:"abcdef",theroute: "/home/rolandoandrade",type:"data"})
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
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}
