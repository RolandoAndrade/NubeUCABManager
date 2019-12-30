import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.3
import com.nubeucab.srmanager 1.0

import "components" as UIObjects


ApplicationWindow
{
    id: mainWindow
    objectName: "WindowUserManager"
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
        property string route: headerItem.route
        header: Rectangle
        {
            id: rectHed
            property string route: generalData.route
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

        anchors.topMargin: 125
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

    UIObjects.PopupModal
    {
        id:popupadd
    }

    UIObjects.RadiusButton
    {
        icon: "\uf07b"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 20

        function select()
        {
            serverRoute.setRoute(listData.route);
            serverRoute.goToFileManager();
        }
    }

    ServerRouteManager
    {
        id: serverRoute
    }


}
