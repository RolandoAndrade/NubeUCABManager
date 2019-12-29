import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.3

GridView
{
    id: filesContainer
    property int themargin: (mainWindow.width - parseInt((mainWindow.width)/320)*320)/2
    Layout.alignment: Qt.AlignCenter
    anchors.fill: parent
    anchors.topMargin: 125
    anchors.leftMargin: themargin
    cellWidth: 320
    cellHeight: 70


    header: Rectangle{
        height:30
        width: parent.width
        color: "transparent"
    }

    ScrollBar.vertical: ScrollBar
    {
        width: 5
    }

    model: ListModel{
        id: listModel
    }
    delegate: Folder{
        name: thename
        type: thetype
        route: fileManager.primaryRoute
    }

    property int fromIndex: -1
    property int toIndex: -1

    DropArea
    {
        id: dropArea
        anchors.fill: parent
        property int startx
        property int starty
        property int endx
        property int endy

        onDropped:
        {

            var ax = listModel.get(filesContainer.fromIndex);
            var card = {};
            for(var k in ax)
            {
                card[k]=ax[k];
            }

            filesContainer.toIndex = filesContainer.indexAt(dropArea.endx, dropArea.endy);

            if(filesContainer.toIndex==-1)
            {
                filesContainer.toIndex = filesContainer.fromIndex;
            }

            if(filesContainer.fromIndex!=filesContainer.toIndex)
            {
                var itema = listModel.get(filesContainer.toIndex);
                if(itema["thetype"]=="folder")
                {
                    fileManager.moveIntoFolder(card["thename"], itema["thename"]);
                }
                else
                {
                    listModel.remove(filesContainer.fromIndex);
                    listModel.insert(filesContainer.toIndex,card);
                }


            }
            filesContainer.fromIndex = -1;
            filesContainer.toIndex = -1;

        }


    }

}
