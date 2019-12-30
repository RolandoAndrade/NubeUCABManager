#ifndef FILEMANAGER_H
#define FILEMANAGER_H


#include <QObject>
#include <QQmlApplicationEngine>
#include "../server/NubeUCAB-servidor/commands.h"

using namespace std;

class FileManager : public QObject
{
    Q_OBJECT

    private:
        string getNameOfFile(string);
        string getTypeOfFile(string);
        void insertNewDirectory(vector<map<string,string>> &v,map<string,string>map);
        vector<map<string,string>> listOfFiles();


    public:
        explicit FileManager(QObject *parent = nullptr);

    public slots:

        void enterToFolder(QString folderName);

        QVariantList getFiles();

        QString getActualDir();

        void copyFile(QString src, QString dest);

        void deleteFile(QString fileName);

        void createFolder(QString folderName);

        void moveFile(QString file, QString route);
};

#endif // FILEMANAGER_H
