import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import com.nubeucab.usermanager 1.0

Rectangle
{
    id: generalData

    property string route: "/home/rolandoandrade/NubeUCAB"
    height: 300
    Layout.alignment: Qt.AlignHCenter
    radius: 10
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
            text: "Crear usuario"
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
                id: directoryRoute
                text: route
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

            MouseArea
            {
                anchors.fill: parent
                onClicked: fileBrowser.open()
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
                    id: usernameField

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
                    id: passwordField
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

        RadiusButton
        {
            Layout.alignment: Qt.AlignHCenter
            icon: "\uf067"


            function select()
            {

                if(usernameField.text.length==0||passwordField.text.length==0)
                {
                    popupadd.openModal("error","Error","Hay campos vacíos",Material.color(Material.Red));

                }
                else
                {
                    var x = usernameField.text.toLowerCase().replace(/ /g,'');
                    userManager.addUser(x, passwordField.text,directoryRoute.text);
                    popupadd.openModal("success","Éxito","Se ha creado un usuario de manera exitosa",Material.color(Material.Green));
                    userManager.reset();
                    usernameField.text = "";
                    passwordField.text = "";
                }

            }
        }
    }


    FileBrowser
    {
        id: fileBrowser
        function done()
        {
            directoryRoute.text = fileBrowser.fileUrls[0].substr(7);
            route = directoryRoute.text;
        }
    }

    UserManager
    {
        id: userManager
        Component.onCompleted:
        {
            reset();
        }

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
