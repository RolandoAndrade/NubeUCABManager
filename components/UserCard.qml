import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import com.nubeucab.usermanager 1.0

Rectangle
{
    id: userCard
    property string name: "Lorem ipsum"
    property string password: "123456"
    property string route: "/home/NubeUCAB"
    property string labelColor: Material.color(Material.Blue)
    width: Math.min(mainWindow.width - 200,800)
    height: 100
    radius: 10
    border.color: "#eee"
    clip: true



    Rectangle
    {
        id: rectangle1
        width: 80
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.top: parent.top
        anchors.topMargin: 1
        color: {

            switch(userCard.labelColor)
            {
                case "blue":
                    return Material.color(Material.Blue)
                case "green":
                    return Material.color(Material.Green, Material.Shade600)
                case "red":
                    return Material.color(Material.Red)
                case "yellow":
                    return Material.color(Material.Yellow, Material.Shade600)
            }
        }
        radius: 10
        Text
        {
            text: "\uf007"
            horizontalAlignment: Text.AlignHCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pointSize: 20
        }
    }

    Rectangle
    {
        anchors.right: parent.right
        anchors.rightMargin: 70
        anchors.left: parent.left
        anchors.leftMargin: 70
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.top: parent.top
        anchors.topMargin: 1
        ColumnLayout
        {
            id: dataContainer
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            anchors.fill: parent
            GridLayout
            {
                columnSpacing: 50
                columns: 2
                rows: 1

                Text
                {
                    text: "Nombre:"
                    font.pointSize: 7
                    color: Material.color(Material.Grey, Material.Shade400)
                }

                Text
                {
                    text: "Contraseña:"
                    font.pointSize: 7
                    color: Material.color(Material.Grey, Material.Shade400)
                }

                Text
                {
                    id: usernameCard
                    text: userCard.name
                    color: Material.color(Material.Grey, Material.Shade600)
                }



                Text
                {
                    text: userCard.password
                    color: Material.color(Material.Grey, Material.Shade600)
                    width: dataContainer.width/2.5
                }
            }


            Text
            {
                text: "Ubicación:"
                font.pointSize: 7
                color: Material.color(Material.Grey, Material.Shade400)
            }

            Text
            {
                text: userCard.route
                color: Material.color(Material.Grey, Material.Shade600)
                font.pointSize: 9
            }
        }


    }

    Rectangle
    {
        id: rectangle2
        property string icon: "\uf1f8"
        width: 50
        height: 50
        radius: 25
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
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
            userManager.removeUser(usernameCard.text);
            userManager.reset();
        }

        MouseArea
        {
            id: stopArea
            anchors.fill: parent
            hoverEnabled: true

            onClicked: parent.select()
        }
    }

    UserManager
    {
        id: userManager
        function reset()
        {
            var users = userManager.readUsers();
            listModel.clear();
            for(var i = 0; i<users.length;i++)
            {
                listModel.append(users[i]);
            }
        }
    }

}
