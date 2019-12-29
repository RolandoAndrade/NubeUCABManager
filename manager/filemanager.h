#ifndef FILEMANAGER_H
#define FILEMANAGER_H
#include "../server/NubeUCAB-servidor/commands.h"

#include <QObject>

class FileManager : public QObject
{
    Q_OBJECT
public:
    explicit FileManager(QObject *parent = nullptr);
    FileManager(){}

public slots:

    void enterToFolder(QString folderName);

    QVariantList getFiles();

    QString getActualDir();

    void upLoadFile(QString fileName);

    void downLoadFile(QString fileName, QString path);

    void deleteFile(QString fileName);

    void createFolder(QString folderName);

    void moveFile(QString file, QString route);
};

#endif // FILEMANAGER_H
