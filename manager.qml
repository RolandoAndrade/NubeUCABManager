import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.3

import "components" as UIObjects
import com.nubeucab.filemanager 1.0


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

    Component.onCompleted:
    {
        fileManager.startUrl();
        fileManager.retrieveFiles();
    }

    UIObjects.Header
    {

    }


    UIObjects.HeaderBarManager
    {
        id: header
        z: 20

        ListView {
            id: headerLabels
            orientation: ListView.Horizontal
            spacing: 5
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 200
            anchors.bottomMargin: 25
            anchors.right: parent.right
            anchors.rightMargin: 0

            model: ListModel
            {

            }
            delegate: UIObjects.PathLabels
            {
                path: patha
                cdRoute: cd
            }
        }

    }
    UIObjects.SideBar
    {
        id: drawer
    }



    UIObjects.FileContainer
    {
        id: filesContainer
    }

    UIObjects.PopupModal
    {
        id: popup
        x: mainWindow.width/2 - width/2
        y: mainWindow.height/2 - height/2
    }

   UIObjects.FileBrowser
   {
       id: fileBrowser
       function done()
       {
           try
           {
               var a = fileBrowser.fileUrls[0].substr(7);
               loadingIndicator.message = "Subiendo archivo...";
               fileManager.upLoadFile(a);
           }
           catch(e)
           {
                popup.message = "No se ha seleccionado ningún archivo";
                popup.open();
           }



       }
   }

    UIObjects.RadiusButton
    {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 20

        function select()
        {
            fileBrowser.open()
        }
    }


    UIObjects.RadiusButton
    {
        id: backButton
        property string route;
        icon: "\uf060"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        visible: false

        function select()
        {
            fileManager.cdRoute(route);
            headerLabels.model.remove(headerLabels.model.count-1);
        }

        SequentialAnimation
        {
            running: backButton.visible
            NumberAnimation { target: backButton; property: "scale"; from:0; to: 1.2; duration: 100}
            NumberAnimation { target: backButton; property: "scale"; to: 0.8; duration: 100}
            NumberAnimation { target: backButton; property: "scale"; to: 1.0; duration: 100}
        }
    }

    Popup
    {
        id: createFolder
        width: 400
        height: 300
        x: mainWindow.width/2-width/2
        y: mainWindow.height/2-height/2
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        ColumnLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Text
            {
                text: "\uf07b"
                color: Material.color(Material.Orange)
                Layout.alignment: Qt.AlignHCenter
                opacity: 0.8
                font.pointSize: 50
            }

            Text
            {
                text: "Crear directorio";
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: 20
                color: Material.color(Material.Grey)

            }


            TextField
            {
                id: newFolderName
                placeholderText: "Nueva carpeta"
                Layout.fillWidth: true
                Material.accent: Material.Blue
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAnywhere
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: 10
                color: Material.color(Material.Grey)
                selectByMouse: true
                selectionColor: Material.color(Material.Blue, Material.Shade300)
            }

            Button
            {
                text: "Crear"
                flat: true
                Material.background: Material.color(Material.Blue)
                Layout.alignment: Qt.AlignHCenter
                Material.foreground: "#fff"
                padding: 20
                onPressed:
                {
                    if(newFolderName.text.length>0)
                    {
                        fileManager.createFolder(newFolderName.text);
                        fileManager.retrieveFiles();
                        newFolderName.text = "";
                        createFolder.close();
                    }
                    else
                    {
                        popup.message = "No se pudo crear el directorio";
                        popup.open();
                    }
                }

                font.pointSize: 10
            }
        }
    }

    UIObjects.RadiusButton
    {
        id: addButton
        icon: "\uf067"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 90
        color: Material.color(Material.Orange)

        function select()
        {
            createFolder.open()
        }

        SequentialAnimation
        {
            running: backButton.visible
            NumberAnimation { target: backButton; property: "scale"; from:0; to: 1.2; duration: 100}
            NumberAnimation { target: backButton; property: "scale"; to: 0.8; duration: 100}
            NumberAnimation { target: backButton; property: "scale"; to: 1.0; duration: 100}
        }
    }



    UIObjects.RadiusButton
    {
        id: pasteManager
        property string fileName
        property string originalRoute
        visible: fileName.length>0
        icon: "\uf0ea"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 160
        color: Material.color(Material.Pink)

        function cutFile(name)
        {
            originalRoute = fileManager.primaryRoute;
            fileName = name;
        }

        function select()
        {
            fileManager.moveIntoRoute(originalRoute, fileName);
            clear();
        }

        function clear()
        {
            fileName = "";
            originalRoute = "";
        }

        SequentialAnimation
        {
            running: pasteManager.visible
            NumberAnimation { target: pasteManager; property: "scale"; from:0; to: 1.2; duration: 100}
            NumberAnimation { target: pasteManager; property: "scale"; to: 0.8; duration: 100}
            NumberAnimation { target: pasteManager; property: "scale"; to: 1.0; duration: 100}
        }
    }

    FileManager
    {
        id: fileManager
        property string primaryRoute;
        property string originalRoute;
        property variant files;

        function startUrl()
        {
            var a = fileManager.getActualDir();
            primaryRoute = a.substr(1,a.lastIndexOf("\"")-1);
            originalRoute = primaryRoute;
            a = a.substr(a.lastIndexOf("/")+1,a.lastIndexOf("\"")-a.lastIndexOf("/")-1);
            headerLabels.model.append({patha: a, cd: primaryRoute});
            console.log(originalRoute)
        }

        function retrieveFiles()
        {
            filesContainer.model.clear();
            files = fileManager.getFiles();
            for(var i = 0;i<files.length;i++)
            {
                filesContainer.model.append(files[i])
            }
        }

        function cdRoute(route)
        {
            console.log(route)
            fileManager.enterToFolder(route);
            primaryRoute = route;
            backButton.route = route.substr(0,route.lastIndexOf("/"));
            backButton.visible = backButton.route.length>=originalRoute.length;
            fileManager.retrieveFiles();
        }

        function cdFolder(folder)
        {
            console.log(folder)
            fileManager.enterToFolder(folder);
            backButton.route = primaryRoute;
            backButton.visible = true;
            primaryRoute+="/"+folder;
            headerLabels.model.append({patha: folder, cd: primaryRoute});
            fileManager.retrieveFiles();
        }


        function search(filter)
        {
            filesContainer.model.clear();
            for(var i = 0;i<files.length;i++)
            {
                if(files[i]["thename"].toUpperCase().indexOf(filter)>-1)
                {
                    filesContainer.model.append(files[i]);
                }
            }
        }

        function moveIntoFolder(file, route)
        {
            /*route = route+"/"+file;
            fileManager.moveFile(file, route);
            fileManager.retrieveFiles();*/
        }

        function moveIntoRoute(original, file)
        {
            /*var route = primaryRoute+"/"+file;
            original = original + "/"+file;
            fileManager.moveFile(original, route);
            fileManager.retrieveFiles();*/
        }

        function rename(originalName, newName)
        {
            /*fileManager.moveFile(originalName, newName);
            fileManager.retrieveFiles();
            pasteManager.clear();*/
        }

    }
}


